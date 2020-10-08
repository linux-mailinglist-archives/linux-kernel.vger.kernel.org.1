Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EEE287291
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbgJHKa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJHKa3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:30:29 -0400
Received: from mail.kernel.org (ip5f5ad5d8.dynamic.kabel-deutschland.de [95.90.213.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CB72076B;
        Thu,  8 Oct 2020 10:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602153028;
        bh=mGcl0+UEOKcaJrhyVy9Nci998WtvNfv06Hf8G2COFPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F0mIzbLDP2CXmvxQCddTdj4WO6hhKiF/4e6jDn2lPf2+zvrGRjtgbUaUvR+JiAKQ7
         T0uDc81uUMKPrxCENqstIOPjy+Yehk22Fmn/b5fVu2iXwiq3Tq0Gxo1YdBCEmqtUSD
         /rUHoAcRL1wwoGvq8MheIccp1T0PvwtECxmVcCgs=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kQTBp-002WMs-W2; Thu, 08 Oct 2020 12:30:26 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     "Jonathan Corbet" <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scripts: check_docs_external_symbols: speed up its execution
Date:   Thu,  8 Oct 2020 12:30:24 +0200
Message-Id: <73387e5c0c4fd99c37303dee184ad09e505c81bb.1602152989.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008122931.369b628d@coco.lan>
References: <20201008122931.369b628d@coco.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This script is slow. Speed it up by using one thread per CPU.

On my desktop with 4 cores (8 threads) and SSD disks, before
this change, it takes:

	$ time scripts/check_docs_external_symbols drivers/media/v4l2-core/
	...
	real	0m11,044s
	user	0m13,860s
	sys	0m2,048s

After it:

	$ time scripts/check_docs_external_symbols drivers/media/v4l2-core/
	...
	real	0m3,153s
	user	0m19,322s
	sys	0m2,738s

So, it is now almost 4 times faster.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/check_docs_external_symbols | 46 +++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 5 deletions(-)

diff --git a/scripts/check_docs_external_symbols b/scripts/check_docs_external_symbols
index e04af5f03a1d..d312e1973530 100755
--- a/scripts/check_docs_external_symbols
+++ b/scripts/check_docs_external_symbols
@@ -23,6 +23,8 @@ use warnings;
 use strict;
 use File::Find;
 use Cwd 'abs_path';
+use threads;
+use Thread::Queue;
 
 sub check_kerneldoc_symbols($$$$) {
 	my $file = shift;
@@ -131,14 +133,15 @@ sub check_kerneldoc_symbols($$$$) {
 	return %hash;
 }
 
-sub check_file($) {
+sub do_check_file($) {
 	my $file = shift;
 	my (@files, @exports, @doc, @doc_refs, %file_exports);
 	my $content = "\n";
 
-	$file =~ s/\s+$//;
-
-	return 0 if (!($file =~ /\.[ch]$/));
+	local $SIG{'KILL'} = sub {
+		print "$$ aborted.\n";
+		exit(1);
+	};
 
 	my $dir = $file;
 	$dir =~ s,[^\/]+$,,;
@@ -262,6 +265,20 @@ sub check_file($) {
 	return 1;
 }
 
+my $queue;
+
+sub check_file($) {
+	my $file = shift;
+
+	$file =~ s/\s+$//;
+
+	return if (!($file =~ /\.[ch]$/));
+
+#printf "queuing $file\n";
+
+	$queue->enqueue($file);
+}
+
 sub parse_dir {
 	check_file $File::Find::name;
 }
@@ -270,6 +287,20 @@ sub parse_dir {
 # main
 #
 
+my $cpus = qx(nproc);
+
+$queue = Thread::Queue->new();
+
+for (my $i = 0; $i < $cpus; $i++) {
+	threads->create(
+		sub {
+			while (defined(my $file = $queue->dequeue())) {
+				do_check_file($file);
+			}
+		}
+	);
+};
+
 if (@ARGV) {
 	while (@ARGV) {
 		my $file = shift;
@@ -280,10 +311,15 @@ if (@ARGV) {
 			check_file $file;
 		}
 	}
-	exit;
 } else {
 	my @files = qx(git grep -l EXPORT_SYMBOL);
 	foreach my $file (@files) {
 		check_file $file;
 	}
 }
+
+$queue->end();
+
+foreach my $thr(threads->list()) {
+	$thr->join();
+}
-- 
2.26.2


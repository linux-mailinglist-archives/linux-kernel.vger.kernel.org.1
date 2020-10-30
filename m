Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E067E29FEF9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgJ3Hnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:43:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3HlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:04 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B0022241;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=HsQrvMBX9g/P57FAc200KohyjAOyDkJuLSjGrLD/nt0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y7O16yBoirOEcmh5N9y39zIab9pa/8tymPab3WFVw8fTb7Y5Z1EYKg5xeWPg471RG
         cueG03neEHze3+rIdHs18ucusjPikqGWFjJQ90LpS9F6Rf7cBniKE6jBbiiLr+3s/V
         KinUq410zdQSxRRppOzw2RajjNY9EnP3r1ggvrTE=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004Ofc-Hw; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/39] scripts: get_abi.pl: auto-generate cross references
Date:   Fri, 30 Oct 2020 08:40:29 +0100
Message-Id: <abe756d4f94fb6ffcc3dd3902a766c7c3990ea89.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several cross-references that can be automatically
generated:

	- References to .rst files inside Documentation/
	- References to other ABI files;
	- References to ABI symbols at /sys/*.

Add a logic to automatically parse them and convert into
cross references.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index 12a23f9a2f86..ff4f9f82ecad 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -3,6 +3,7 @@
 
 use strict;
 use warnings;
+use utf8;
 use Pod::Usage;
 use Getopt::Long;
 use File::Find;
@@ -272,6 +273,9 @@ sub create_labels {
 # Outputs the book on ReST format
 #
 
+# \b doesn't work well with paths. So, we need to define something else
+my $bondary = qr { (?<![\w\/\`\{])(?=[\w\/\`\{])|(?<=[\w\/\`\{])(?![\w\/\`\{]) }x;
+
 sub output_rest {
 	create_labels();
 
@@ -342,6 +346,33 @@ sub output_rest {
 
 		if (!($desc =~ /^\s*$/)) {
 			if ($description_is_rst) {
+				# Enrich text by creating cross-references
+
+				$desc =~ s,Documentation/(?!devicetree)(\S+)\.rst,:doc:`/$1`,g;
+
+				my @matches = $desc =~ m,Documentation/ABI/([\w\/\-]+),;
+				foreach my $f (@matches) {
+					my $xref = $f;
+					my $path = $f;
+					$path =~ s,.*/(.*/.*),$1,;;
+					$path =~ s,[/\-],_,g;;
+					$xref .= " <abi_file_" . $path . ">";
+					$desc =~ s,\bDocumentation/ABI/$f\b,:ref:`$xref`,g;
+				}
+
+				@matches = $desc =~ m,$bondary(/sys/[^\s\.\,\;\:\*\s\`\'\(\)]+)$bondary,;
+
+				foreach my $s (@matches) {
+					if (defined($data{$s}) && defined($data{$s}->{label})) {
+						my $xref = $s;
+
+						$xref =~ s/([\x00-\x1f\x21-\x2f\x3a-\x40\x7b-\xff])/\\$1/g;
+						$xref = ":ref:`$xref <" . $data{$s}->{label} . ">`";
+
+						$desc =~ s,$bondary$s$bondary,$xref,g;
+					}
+				}
+
 				print "$desc\n\n";
 			} else {
 				$desc =~ s/^\s+//;
-- 
2.26.2


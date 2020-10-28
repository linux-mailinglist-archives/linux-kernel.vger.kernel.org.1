Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C005529D747
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732670AbgJ1WW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:22:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732652AbgJ1WWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:22:23 -0400
Received: from mail.kernel.org (ip5f5ad5b2.dynamic.kabel-deutschland.de [95.90.213.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EF6524765;
        Wed, 28 Oct 2020 14:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895014;
        bh=GiCl/xUCfPVPDTVlB/3S4Hm7u8cSqBu7i7gChQK+gmk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1w/aQy1ZX0+KiUDleMPOtKxirCT00oiaifrnMHx1xcEUzZR8ZSuK7UG83FxEClzBi
         N1YGuRfBB+S6QmcXnSDSNC+6/MO39HSx70DdIYJ/EOMSfsR8UKX347YDUMN0aHjFZy
         obzyH6xB8XcW6rI6ZIhwqU2B66fwOQJfrTJzAOqY=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kXmMO-003hl9-Fh; Wed, 28 Oct 2020 15:23:32 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/33] scripts: get_abi.pl: auto-generate cross references
Date:   Wed, 28 Oct 2020 15:23:08 +0100
Message-Id: <ee0997cbf70c60df9f861d4c1b9db8b32c8ac6cd.1603893146.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603893146.git.mchehab+huawei@kernel.org>
References: <cover.1603893146.git.mchehab+huawei@kernel.org>
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
index b4868ee8e955..3cff7cdf1397 100755
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


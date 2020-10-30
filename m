Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7597729FEC5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 08:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726110AbgJ3HlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 03:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:51426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725933AbgJ3HlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 03:41:03 -0400
Received: from mail.kernel.org (ip5f5ad5bb.dynamic.kabel-deutschland.de [95.90.213.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7903D221EB;
        Fri, 30 Oct 2020 07:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604043662;
        bh=12b0aTvv2o71y42fIZIMv68yxDHDKeFNYBl4enXZe7o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T5U7Q5Q4fjuafi3SkB8cg+BmY6n5bSWT1nwU1A6YhY8gAI1BAM4Hn6Th9wT2UBZY5
         lICulJeSJFwhpyZ/72KJJe3T0IIB5MJczJyc8LYOEj278uuD+/WmiRCVXM48yNyKMW
         D1L2kKoUaJc3qn/5GLMofMfBbfOhfzBMWUW0oink=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kYP1w-004OfW-FY; Fri, 30 Oct 2020 08:41:00 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, Tom Rix <trix@redhat.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/39] scripts: get_abi.pl: prevent duplicated file names
Date:   Fri, 30 Oct 2020 08:40:27 +0100
Message-Id: <ef760f68f54e132c4be52f0027189b4ba31554ec.1604042072.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1604042072.git.mchehab+huawei@kernel.org>
References: <cover.1604042072.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The same filename may exist on multiple directories within
ABI. Create separate entries at the internal database for
each of them.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 scripts/get_abi.pl | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/scripts/get_abi.pl b/scripts/get_abi.pl
index e5a5588a8639..5612f019fae0 100755
--- a/scripts/get_abi.pl
+++ b/scripts/get_abi.pl
@@ -65,7 +65,10 @@ sub parse_abi {
 	my $name = $file;
 	$name =~ s,.*/,,;
 
-	my $nametag = "File $name";
+	my $fn = $file;
+	$fn =~ s,Documentation/ABI/,,;
+
+	my $nametag = "File $fn";
 	$data{$nametag}->{what} = "File $name";
 	$data{$nametag}->{type} = "File";
 	$data{$nametag}->{file} = $name;
@@ -320,16 +323,18 @@ sub output_rest {
 			my $fileref = "abi_file_".$path;
 
 			if ($type eq "File") {
-				my $bar = $w;
-				$bar =~ s/./-/g;
-
 				print ".. _$fileref:\n\n";
-				print "$w\n$bar\n\n";
 			} else {
 				print "Defined on file :ref:`$f <$fileref>`\n\n";
 			}
 		}
 
+		if ($type eq "File") {
+			my $bar = $w;
+			$bar =~ s/./-/g;
+			print "$w\n$bar\n\n";
+		}
+
 		my $desc = "";
 		$desc = $data{$what}->{description} if (defined($data{$what}->{description}));
 		$desc =~ s/\s+$/\n/;
-- 
2.26.2


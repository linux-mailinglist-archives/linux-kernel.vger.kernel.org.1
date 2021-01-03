Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF362E8B4B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbhACHvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:39 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:45577 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbhACHvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:38 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rXw1FwVzPk2d;
        Sun,  3 Jan 2021 08:50:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660256; bh=5QRHc2Sw47HzgUDWeZxXN/qTNZoMIMSS+KZ7sS2oyTg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Uadmv7cbu0V1TEWgT+fzu3wyx5lVRkPD0NckshFQBjS8vNLtNy/DdPa5lVSORoXaF
         WKMrsye4A8/P+F1ZlDuqLgUTtHV914gmWlwZRZlEbbl7dLbnX6xrnUgaiBlf4f+GAq
         t1dbUspTiViv4wkyWNclXUpdCnbNWlRcQId69w9PSoXzHsEVT+BDf66ZKZ/slVKS3X
         RZs70RYCdRF+ekjhEsTbQMVCP8t5kdlSGCHM8WVWZGSH4cwYwsUUcPUkBICscSjIvV
         N6KGnNl/HMGHdQG38bqOT/rO88udti83K1Oud5PcF05yBpaWkdZQIZB2gm/sVPibhy
         FF6Ju1sjxz6xA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX19WQEe3i4pEt43jevnk39sBGbphlaxXjyM=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXs6RJmzPk0d;
        Sun,  3 Jan 2021 08:50:53 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 3/5] checkpatch: kconfig: enforce help text indentation
Date:   Sun,  3 Jan 2021 08:50:13 +0100
Message-Id: <20210103075015.23946-4-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103075015.23946-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new warning in case the indentation level of the
first line of a Kconfig help message is not at least two spaces
higher than the keyword itself.
Blank lines between the message and the help keyword
are ignored.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---

Now matches indentation of two or more spaces, instead of exactly two.


 scripts/checkpatch.pl | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c86a971a3205..209880810aaa 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3313,6 +3313,8 @@ sub process {
 			my $f;
 			my $is_start = 0;
 			my $is_end = 0;
+			my $help_indent;
+			my $help_stat_real;
 			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
 				$f = $lines[$ln - 1];
 				$cnt-- if ($lines[$ln - 1] !~ /^-/);
@@ -3323,8 +3325,10 @@ sub process {
 
 				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*(?:["'].*)?$/) {
 					$is_start = 1;
-				} elsif ($lines[$ln - 1] =~ /^\+\s*help$/) {
-					$length = -1;
+				} elsif ($lines[$ln - 1] =~ /^\+(\s*)help$/) {
+					$help_indent = $1;
+					$length = 0;
+					next;
 				}
 
 				$f =~ s/^.//;
@@ -3332,6 +3336,13 @@ sub process {
 				$f =~ s/^\s+//;
 				next if ($f =~ /^$/);
 
+				if (defined $help_indent) {
+					if ($lines[$ln - 1] !~ /^\+$help_indent\ {2,}\S*/) {
+						$help_stat_real = get_stat_real($ln - 1, $ln);
+					}
+					undef $help_indent;
+				}
+
 				# This only checks context lines in the patch
 				# and so hopefully shouldn't trigger false
 				# positives, even though some of these are
@@ -3347,6 +3358,10 @@ sub process {
 				WARN("CONFIG_DESCRIPTION",
 				     "please write a paragraph that describes the config symbol fully\n" . $herecurr);
 			}
+			if ($is_start && $is_end && defined $help_stat_real) {
+				WARN("CONFIG_DESCRIPTION",
+				     "please indent the help text two spaces more than the keyword\n" . "$here\n$help_stat_real\n");
+			}
 			#print "is_start<$is_start> is_end<$is_end> length<$length>\n";
 		}
 
-- 
2.29.2


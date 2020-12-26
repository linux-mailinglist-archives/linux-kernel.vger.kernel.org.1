Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC12A2E2E50
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 15:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbgLZOHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 09:07:30 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:37895 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgLZOH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 09:07:29 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D35GJ1LWwz8spV;
        Sat, 26 Dec 2020 15:06:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608991608; bh=5KO1Na/LPpniEoj74Lnc5Qc1cr7AP6ScKLq8SKoBalE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=HT2QwR8ge+YNcAZMrAtM+QFadHgP35BoeJ4QGBzDvLGn20tPwzqMmkD56XJvKzU8/
         VcqjfRO8LPCzYP+/EkDOMd02XB4BzX/5bxb+7HMqT6pwbMpewAEiFt9PwW5ZKp5zCK
         INEtqYl+i7vtNq3CrWJzlZ+v0MFwLGg/hVQkUN7c943luITWLYXZZBP1RzlVDtIfhk
         YkiJ4O08yRt9SkFNq2cU8k2uy8vyASzyea/DnVfbuBvLTkTx2kexE5JMcutBlbL1Lm
         wr1S1QSnMKNKtocW/W1KZV4qVi/4rVbxzmKwKL4X9cEAhQJqEysu1EJnC0v19tVOhp
         1PeJPwnfVxxOg==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1276
Received: from x1.nicolai.tech (unknown [IPv6:2a02:810d:8080:2d9f::1276])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18vbsXthQc2taIbxUxQP+fV8bP+HJHnfPk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D35GF5bv2z8v53;
        Sat, 26 Dec 2020 15:06:45 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, joe@perches.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 3/4] checkpatch: kconfig: enforce help text indentation
Date:   Sat, 26 Dec 2020 15:05:10 +0100
Message-Id: <20201226140511.662368-4-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201226140511.662368-1-nicolai.fischer@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
 <20201226140511.662368-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new warning in case the indentation level of the
first line of a Kconfig help message is not two spaces
higher than the keyword itself.
Blank lines between the message and the help keyword
are ignored.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 scripts/checkpatch.pl | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c86a971a3205..aa2205ee9ab8 100755
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
+					if ($lines[$ln - 1] !~ /^\+$help_indent\ {2}\S*/) {
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


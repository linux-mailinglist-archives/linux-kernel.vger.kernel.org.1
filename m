Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8596E2E8B4D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726699AbhACHvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:48 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:51769 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726485AbhACHvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:47 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rY52XgJzPjlR;
        Sun,  3 Jan 2021 08:51:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660265; bh=QzvSaay1vpBL4uNH05Tptc9ZyPGke0vS50orSu+D3Q4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=nN86xNYf26eIZDbbRPKHuX5a0jHZ915tQn1KpZll7aV0xpHU5UvxRWI9ZXLCX0yZD
         BS51rvHYMQQ/wsEvmu5avr+WYw3NDUFSZojRGfn+t1V3Mq/gdyLzOCFeiiize0PfXY
         Sr77cMeFhFUQcRFlsFtra/CFI0oybn016E1p0mKBMyMNruXSf6NZ5CrW3zz5qGtGeG
         G5BqqhT7RkIlENEwiTeKEJg24F2rrg0XJ7oPt1mcp6VacCtS/o6yUV+WGs3qDIKYQN
         F+KGoSyLKnQPqULcLbYVVqwHqzJkeA86Fmq5fFuo1ozZZ2FRL8OACBDySPA3HitDS+
         ghecvoijKiqAg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/QjcoyQGWNye7Tyj5c5+djQEmW9gyJkNM=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXy1pz1zPjhV;
        Sun,  3 Jan 2021 08:50:58 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 5/5] checkpatch: kconfig: enforce block indentation
Date:   Sun,  3 Jan 2021 08:50:15 +0100
Message-Id: <20210103075015.23946-6-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210103075015.23946-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
 <20210103075015.23946-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new warning to checkpatch in case a new Kconfig block
is not indented one sigle tab more than the keyword which
starts it.

Co-developed-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Johannes Czekay <johannes.czekay@fau.de>
Signed-off-by: Nicolai Fischer <nicolai.fischer@fau.de>
---
 scripts/checkpatch.pl | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 805b5870803f..8a82ea5c2eb3 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3306,7 +3306,8 @@ sub process {
 		    # 'choice' is usually the last thing on the line (though
 		    # Kconfig supports named choices), so use a word boundary
 		    # (\b) rather than a whitespace character (\s)
-		    $line =~ /^\+\s*(?:config|menuconfig|choice)\b/) {
+		    $line =~ /^\+(\s*)(?:config|menuconfig|choice)\b/) {
+			my $base_indent = $1;
 			my $length = 0;
 			my $cnt = $realcnt;
 			my $ln = $linenr + 1;
@@ -3315,6 +3316,7 @@ sub process {
 			my $is_end = 0;
 			my $help_indent;
 			my $help_stat_real;
+			my $block_stat_real;
 			for (; $cnt > 0 && defined $lines[$ln - 1]; $ln++) {
 				$f = $lines[$ln - 1];
 				$cnt-- if ($lines[$ln - 1] !~ /^-/);
@@ -3323,7 +3325,10 @@ sub process {
 				next if ($f =~ /^-/);
 				last if (!$file && $f =~ /^\@\@/);
 
-				if ($lines[$ln - 1] =~ /^\+\s*(?:bool|tristate|int|hex|string|prompt)\s*(?:["'].*)?$/) {
+				if ($lines[$ln - 1] =~ /^\+(\s*)(?:bool|tristate|int|hex|string|prompt)\s*(?:["'].*)?$/) {
+					if ($1 !~ /^$base_indent\t$/) {
+						$block_stat_real = get_stat_real($linenr, $ln);
+					}
 					$is_start = 1;
 				} elsif ($lines[$ln - 1] =~ /^\+(\s*)help$/) {
 					$help_indent = $1;
@@ -3358,6 +3363,10 @@ sub process {
 				WARN("CONFIG_DESCRIPTION",
 				     "please write a paragraph ($length/$min_conf_desc_length lines) that describes the config symbol fully\n" . $herecurr);
 			}
+			if ($is_start && $is_end && defined $block_stat_real) {
+				WARN("CONFIG_DESCRIPTION",
+				     "please indent the block a single tab more than the start\n" . "$here\n$block_stat_real\n");
+			}
 			if ($is_start && $is_end && defined $help_stat_real) {
 				WARN("CONFIG_DESCRIPTION",
 				     "please indent the help text two spaces more than the keyword\n" . "$here\n$help_stat_real\n");
-- 
2.29.2


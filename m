Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E272224759B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 21:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732074AbgHQTZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 15:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbgHQPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:34:03 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A9BC061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:34:03 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c80so13589734wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 08:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkyJvFo7augCojl61Q0zymUP0Ht/IG05CwGmKWgnw7I=;
        b=jQUbm+aDN0MdB3JYq5Uo3qf3Afi1FkHMEd7fydzqTKYw4083p8ld4z2oJYzMw8D0o2
         Bya1FUtZL+s44ZC2zQbBDoxjR8xTPoTBcUrFeGEXKcVYqE6upHAmm+02diU5NYuq2guT
         8d0X/XS4G/YwwP8lubisAFShXzM5acJ03I9396Nf38hRutL/hU8y+YQz5B1UHfd3cTwP
         xsoEsCA8aqltMpsqxOG3ZpZsyXc8ijGf21yQoalBBE2fkrqOSVHtL0vquJVmfB8mDj0u
         dP/56lycEq0EG0mV2WB8fg29P44deRTxDYj7BWEZbYrKEgT9cm21MimStc4yxcxr+/pm
         UpoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkyJvFo7augCojl61Q0zymUP0Ht/IG05CwGmKWgnw7I=;
        b=a7gCGKc2EdXf4bUKFWGnuzwHHpyU46iCQD2XPocoNZsHmrjvNYRBBDMo8A9pVuG+Wy
         tKEXRs6aQg2cYiQT2k36RrbIj/UDiWSJGd9Wu88OwpRUHb2Ul6wb7RnashVW02e5lKwC
         s6iWbgjh98/36COYt3NzQYpDUiQSHzUEWpH7bzBsSpD52CvVE2Nyv72LnfvDOZg14oAF
         uix3IHNQ0SQBL9DSG7I1h7xgjUFmf1lt8DKyllBftsuw/+7+DpP9/19iXVA3wJpdmoDv
         qoW1ghBSr8KQj7IOnl/5ToNCMza0A4nKts8X8NGcVAzyv2u4KguY4qUcLL9xO0Ka6xLN
         rjWQ==
X-Gm-Message-State: AOAM532LlpVAMu5KSejKvRNRcb1UUSNyKPMOZ4jb+2syJCQF+SaTh/YF
        UWoRbJF2z+dVr+WC+6mi4kE/hg==
X-Google-Smtp-Source: ABdhPJwikVGbCij+DSLvyYZ4g6Huh788KiCjBgWKz9IrSZrR1f5WNKHTDCMsB8/QPxKLwnzVC37LwA==
X-Received: by 2002:a7b:cb4d:: with SMTP id v13mr15838782wmj.56.1597678441351;
        Mon, 17 Aug 2020 08:34:01 -0700 (PDT)
Received: from matebook.home ([2a01:e0a:3cb:7bb0:3009:af69:3d13:4910])
        by smtp.gmail.com with ESMTPSA id i4sm31733892wrw.26.2020.08.17.08.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 08:34:00 -0700 (PDT)
From:   Jerome Forissier <jerome@forissier.org>
To:     Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
        linux-kernel@vger.kernel.org
Cc:     Jerome Forissier <jerome@forissier.org>
Subject: [PATCH v2] checkpatch: add --kconfig-prefix
Date:   Mon, 17 Aug 2020 17:33:20 +0200
Message-Id: <20200817153320.102777-1-jerome@forissier.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200817095056.31001-1-jerome@forissier.org>
References: <20200817095056.31001-1-jerome@forissier.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kconfig allows to customize the CONFIG_ prefix via the $CONFIG_
environment variable. Out-of-tree projects may therefore use Kconfig
with a different prefix, or they may use a custom configuration tool
which does not use the CONFIG_ prefix at all. Such projects may still
want to adhere to the Linux kernel coding style and run checkpatch.pl.
To make this possible, add the --kconfig-prefix command line option.

Signed-off-by: Jerome Forissier <jerome@forissier.org>
---
 scripts/checkpatch.pl | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

v2:
- Use a command-line/.checkpatch.conf option instead of the _CONFIG
  environment variable.
- Changed the patch subject (was: "checkpatch: get CONFIG_ prefix from
  the environment").

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 2cbeae6d9aee..150dfbc04b4b 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -65,6 +65,7 @@ my $allow_c99_comments = 1; # Can be overridden by --ignore C99_COMMENT_TOLERANC
 # git output parsing needs US English output, so first set backtick child process LANGUAGE
 my $git_command ='export LANGUAGE=en_US.UTF-8; git';
 my $tabsize = 8;
+my $CONFIG_ = "CONFIG_";
 
 sub help {
 	my ($exitcode) = @_;
@@ -127,6 +128,8 @@ Options:
   --typedefsfile             Read additional types from this file
   --color[=WHEN]             Use colors 'always', 'never', or only when output
                              is a terminal ('auto'). Default is 'auto'.
+  --kconfig-prefix=WORD      use WORD as a prefix for Kconfig symbols (default
+                             $CONFIG_)
   -h, --help, --version      display this help and exit
 
 When FILE is - read standard input.
@@ -235,6 +238,7 @@ GetOptions(
 	'color=s'	=> \$color,
 	'no-color'	=> \$color,	#keep old behaviors of -nocolor
 	'nocolor'	=> \$color,	#keep old behaviors of -nocolor
+	'kconfig-prefix=s'	=> \$CONFIG_,
 	'h|help'	=> \$help,
 	'version'	=> \$help
 ) or help(1);
@@ -6528,16 +6532,16 @@ sub process {
 		}
 
 # check for IS_ENABLED() without CONFIG_<FOO> ($rawline for comments too)
-		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^CONFIG_/) {
+		if ($rawline =~ /\bIS_ENABLED\s*\(\s*(\w+)\s*\)/ && $1 !~ /^$CONFIG_/) {
 			WARN("IS_ENABLED_CONFIG",
-			     "IS_ENABLED($1) is normally used as IS_ENABLED(CONFIG_$1)\n" . $herecurr);
+			     "IS_ENABLED($1) is normally used as IS_ENABLED($CONFIG_$1)\n" . $herecurr);
 		}
 
 # check for #if defined CONFIG_<FOO> || defined CONFIG_<FOO>_MODULE
-		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)(CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
+		if ($line =~ /^\+\s*#\s*if\s+defined(?:\s*\(?\s*|\s+)($CONFIG_[A-Z_]+)\s*\)?\s*\|\|\s*defined(?:\s*\(?\s*|\s+)\1_MODULE\s*\)?\s*$/) {
 			my $config = $1;
 			if (WARN("PREFER_IS_ENABLED",
-				 "Prefer IS_ENABLED(<FOO>) to CONFIG_<FOO> || CONFIG_<FOO>_MODULE\n" . $herecurr) &&
+				 "Prefer IS_ENABLED(<FOO>) to $CONFIG_<FOO> || $CONFIG_<FOO>_MODULE\n" . $herecurr) &&
 			    $fix) {
 				$fixed[$fixlinenr] = "\+#if IS_ENABLED($config)";
 			}
-- 
2.25.1


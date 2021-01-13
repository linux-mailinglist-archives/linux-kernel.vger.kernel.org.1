Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 597602F5370
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:37:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728744AbhAMTfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:35:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbhAMTfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:35:46 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB1CC06179F
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:35:06 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id h16so1314243qvu.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:mime-version:date:message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=Jr/LwR+1aBDOGFxCZ796ZMpHwB8wKSDYuhL7seCwNspDhSQugiUqevDcJfW/4f4mtp
         bFHuif7MvM8PiTUbw0OQQa/QYiIhY1NUnkl+/CxkG6fxIG60Iud71VWOOaTZOdS+Gizg
         RMOlBb25K26TC5UsWrI/Fbx+1GC5oM21SwBItOC4WaujLs8yXam1uP86YsO/+7i7Tre3
         p0DH3Hq9JvR8elvRujilHYUM8bS3BDx1BikLSWLHdU9oc8sXOEKvaRCgPCTfciuekSH1
         DVSvzqk1LXKQbD++imblHTLsqxq4HRMWeXfTmC5uex5peZNHKhiKz+N82G6goDm9yZHK
         I/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:mime-version:date
         :message-id;
        bh=x5rG9aYCLmGpPdT1gIS00tPAzki6U9cSpND2lD2WOlM=;
        b=LlqcfjsyMaRFBOIQ8vYmmdChyrGLz77uNOuU6+cRJKGNTN9cIOTZSk3kZHB/eSeMg9
         H+RhxS6kr4skWSJxpOdUyRMfQHzbZcfm79Xq5sMqyVP0LA9ThIOR3BDlyH+f2SVyB74H
         xAAnWrgMXY/CG4/7hc/UbRIaZTiCfy6vc8Su7jiqXJysg+ch9mXvW1LLlsUivW/b6SsJ
         uvngnKysAutRXm++oMJXbfDLxoUR2ErkbJO5o6edC3fuEbaZqWSXVCecpY27QsYMrGwI
         VTP3MLHQr+IqYJyQosd4eGhTfiq2uYaf1v9gLVs16eZtOYDxIiC6mimjQhlXfKpME4m1
         +00Q==
X-Gm-Message-State: AOAM53337Nogo8b/J01yAiG2CVjw409MIymTvEcS1VlzvfC8sfAfvsVH
        BgpigK9HwP7x2+s6kfQ0VbjwXg==
X-Google-Smtp-Source: ABdhPJxQyZfyGrOPr+YfUhrteGln7/R3+FdNZBJMHxk99/iZLVgwDCkdctwL7+SHr2YfPBGQkdBzPw==
X-Received: by 2002:a05:6214:321:: with SMTP id j1mr4095127qvu.32.1610566505433;
        Wed, 13 Jan 2021 11:35:05 -0800 (PST)
Received: from turing-police ([2601:5c0:c380:d61::359])
        by smtp.gmail.com with ESMTPSA id h22sm1479815qth.55.2021.01.13.11.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 11:35:04 -0800 (PST)
Sender: Valdis Kletnieks <valdis@vt.edu>
From:   "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis =?utf-8?Q?Kl=c4=93tnieks?=" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
cc:     linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] gcc-plugins: avoid errors with -std=gnu++11 on old gcc
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date:   Wed, 13 Jan 2021 14:35:03 -0500
Message-ID: <104383.1610566503@turing-police>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It turns out that older gcc (4.9 and 5.4) have gnu++11 support, but
due to a gcc bug fixed in gcc6, throw errors during the build.
The relevant gcc bug is https://gcc.gnu.org/bugzilla/show_bug.cgi?id=69959

Version the option based on what gcc we're using.

Signed-off-by: Valdis Kletnieks <valdis.kletnieks@vt.edu>
Fixes: 27c287b41659 ("gcc-plugins: fix gcc 11 indigestion with plugins...")
---
diff --git a/scripts/gcc-plugins/Makefile b/scripts/gcc-plugins/Makefile
index b5487cce69e8..cc779973724a 100644
--- a/scripts/gcc-plugins/Makefile
+++ b/scripts/gcc-plugins/Makefile
@@ -21,8 +21,11 @@ always-y += $(GCC_PLUGIN)
 
 GCC_PLUGINS_DIR = $(shell $(CC) -print-file-name=plugin)
 
+# need gnu++11 for gcc 11, but 4.9 and 5.4 need gnu++98
+GCC_FLAVOR = $(call cc-ifversion, -ge, 1100, 11, 98)
+
 plugin_cxxflags	= -Wp,-MMD,$(depfile) $(KBUILD_HOSTCXXFLAGS) -fPIC \
-		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++11 \
+		   -I $(GCC_PLUGINS_DIR)/include -I $(obj) -std=gnu++$(GCC_FLAVOR) \
 		   -fno-rtti -fno-exceptions -fasynchronous-unwind-tables \
 		   -ggdb -Wno-narrowing -Wno-unused-variable \
 		   -Wno-format-diag


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7A52B4007
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 10:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgKPJma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 04:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726598AbgKPJm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 04:42:29 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFB4C0613CF;
        Mon, 16 Nov 2020 01:42:28 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 10so23076575wml.2;
        Mon, 16 Nov 2020 01:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=kKG1HRiuJd2eHUG0i5gcYG0tFSdbRsxnGh+YMhzlOSs=;
        b=L03qTevaBV+hnadsGTp9btsDWXmXv1zj9/Bnsqz5qoGYr/UF88fSih/Ovu2RrRWZaP
         bqzaux9bbZdHDF6Mw7vEAtCtElazbW02JPWP7JP558sSpNPXcSfYhsWoL+Sr6lvsVPWm
         7ygTHbs963gpZw4xrXUzz63lxYd6F2KviT95uY56StApkwlEKNRA19hrLQSiV8upu10d
         31qLElFx+akp2335otEh5hkDN2JiDh3ldlCVjyAY473+zA0GZBFCcTLL5f9FQ6ylUP8a
         iCHr9uwHP0D2FhmX54ZBiWM8mUaPmtqcVoJBA0SJpJJcbV7vLgqPusvqoft8fD/6tvkK
         XHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kKG1HRiuJd2eHUG0i5gcYG0tFSdbRsxnGh+YMhzlOSs=;
        b=sWwOKuoozsmDS7lgMD6KIw8X1th9rtay9f/64zhacIms4S2nmiZwiWM62THc+bJ7tB
         Wua7506wIVhkDM/RIVbf+zVUQeGE3RE/1MvhbdO7wwIesE2xB+MVd+iyGtLJp1sYlGcE
         eIMYhQ89jpXiU249tJC/wOrfTPgL0W22par8vHr4drVA3nrcqOWjcQjDZ319kXgMCXky
         YoAb0DGkJEAHbX2s1GFAbnRq0PR24R08ybjp/b733TfRimwNIA8P2akqbMLMr0wu9Ndn
         FCmRjUdN3JzC9gJ1NlwvsLdJlQ41zjjLuNr4OjDjt9BVtNwoPZ4NXQovK6jioYJVLpQk
         F7HA==
X-Gm-Message-State: AOAM530x+pX8kcYV1n6eD/OMEWAqwhMxtKhLophgxwwLbkcUVWGz/1Tx
        4tpksiv2zzbTbxgRnf6yt98=
X-Google-Smtp-Source: ABdhPJx3l7Ona/5935EASzFzHzIfE0qZloLjmL/5tJPnPYBplPt6j4U68Ih6cUCmibwP9KQK3BnmDg==
X-Received: by 2002:a7b:c0c2:: with SMTP id s2mr10943085wmh.78.1605519747654;
        Mon, 16 Nov 2020 01:42:27 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2de6:ad00:939:47a9:70b9:fe5b])
        by smtp.gmail.com with ESMTPSA id m3sm17917169wrv.6.2020.11.16.01.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 01:42:26 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     "H . Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/cpu: remove needless definition for !CONFIG_X86_32
Date:   Mon, 16 Nov 2020 10:42:18 +0100
Message-Id: <20201116094218.10508-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function flag_is_changeable_p() is used in:

  - have_cpuid_p() for its CONFIG_X86_32 definition
  - identify_cpu_without_cpuid() within its CONFIG_X86_32 ifdef-block

So, there is no need to define flag_is_changeable_p() if !CONFIG_X86_32.
Simply remove this needless definition.

This was discovered with make CC=clang W=1:

  arch/x86/kernel/cpu/common.c:283:19:
    warning: unused function 'flag_is_changeable_p' [-Wunused-function]

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on current master and next-20201116

Thomas, Boris, please pick this minor non-urgent patch.

 arch/x86/kernel/cpu/common.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..b89dbc7ccb0c 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -280,10 +280,6 @@ static int __init x86_serial_nr_setup(char *s)
 }
 __setup("serialnumber", x86_serial_nr_setup);
 #else
-static inline int flag_is_changeable_p(u32 flag)
-{
-	return 1;
-}
 static inline void squash_the_stupid_serial_number(struct cpuinfo_x86 *c)
 {
 }
-- 
2.17.1


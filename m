Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F9E2AB81C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 13:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgKIMXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 07:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgKIMXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 07:23:02 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA85C0613CF;
        Mon,  9 Nov 2020 04:23:02 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id s13so7748009wmh.4;
        Mon, 09 Nov 2020 04:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fvrOV1Xbp2rPir897uIVRy41PUv/On9Mb5UR70E8ZN0=;
        b=n1pkBzsb3gjrt2q7nMtXtiR++q3d1ceKq5g1jc6iARM6zIn9/5gceylshIADOqMlFZ
         OI95Ac2KqRte1jpw5IghCigg79Fgmv8sBtexrG3Ik6zV5MxhgA1muyMjpUAtz4Ek86bT
         G99vstDWT1cRxCERKJbc+Pms9XkDgNc04DOkTPQfm0xZKR5Blng1uxSreGGlRAQiq+mz
         rRmBN7r0eBE93AqLuGMjaRb8AZfzUfXHNSEcEwyjIdAst2Ko0oLReBrUYDfnXsmKA3B5
         Ffh+u0eRCHR498eUHGj4jYDGAdD3ofBcv5cfjKHGPYsN47qumpYxh71zhqgkZxw88cCC
         3/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fvrOV1Xbp2rPir897uIVRy41PUv/On9Mb5UR70E8ZN0=;
        b=A3lklfawHsiVQrqJqX+jOeziUs7Nm3DZNkOQiaADakbyis1c057ul8hvUENc4dINit
         sTEjFT4vr6jjV2F26k4daujfqHcUXaW0ewhu02yuh38+EwhGdFg0lWdkk4Ycc+oSLcWC
         Ac0uNC28Tph518UG5r6ODIT8NqwYUwoBZxKttiZcMc8TEAYUQU/++Gpqat7Opuu+YOAd
         NR+sT2QBZbZWV6GuOmMRJblb2+LHCKenLNUg5RF9zsnZEm5X4sjLtLKW6Ix2+3Q+yVL8
         NIoRFjfqWjbwOCG8l1dyaOBDEBIvyC+ISVgEP2BxMZx86tUbMre9grYmM/OoqGIVlAld
         PO/w==
X-Gm-Message-State: AOAM533rL98yi/isBRYc2xYO4bMpSi7jDMsncSV/4OF7c0X6e5uRAwoo
        bTaWPApu6CmRLAIHWLyFWPY=
X-Google-Smtp-Source: ABdhPJx5F8ZtqrMomxcLVPqrYaU1USlQyhVoFN3qloSIV+AwYlZ02SksvPUAPwEh1/meALhBZZP3vw==
X-Received: by 2002:a1c:98cd:: with SMTP id a196mr13735928wme.42.1604924581047;
        Mon, 09 Nov 2020 04:23:01 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dd6:1d00:b0a6:ce79:896e:ea57])
        by smtp.gmail.com with ESMTPSA id y200sm13828404wmc.23.2020.11.09.04.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 04:23:00 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Pia Eichinger <pia.eichinger@st.oth-regensburg.de>,
        Joe Perches <joe@perches.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] MAINTAINERS: assign ./fs/tracefs to TRACING
Date:   Mon,  9 Nov 2020 13:22:50 +0100
Message-Id: <20201109122250.31915-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A check with ./scripts/get_maintainer.pl --letters -f fs/tracefs/ shows
that the tracefs is not assigned to the TRACING section in MAINTAINERS.

Add the file pattern for the TRACING section to rectify that.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on v5.10-rc3 and next-20201109

Steven, Ingo, please pick this minor non-urgent clean-up patch.


By the way, I am wondering if the git tree is still up to date?

It says for TRACING:
  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core

But I assume commits now actually travel through:
  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cba8ddf87a08..f0ba51f2c759 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17823,6 +17823,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
 F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/ftrace.h
 F:	arch/*/kernel/ftrace.c
+F:	fs/tracefs/
 F:	include/*/ftrace.h
 F:	include/linux/trace*.h
 F:	include/trace/
-- 
2.17.1


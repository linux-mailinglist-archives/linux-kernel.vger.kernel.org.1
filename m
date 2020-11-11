Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBF2AFA4E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 22:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgKKVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgKKVYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 16:24:42 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDE9C0613D1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:24:42 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id q10so2513898pfn.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 13:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZdzFgqA8sxrUpX7gVn9r2eV7QfWMvgZImm8xeBJjNw=;
        b=jmWSHXtvnQBRxFR48lEfks49M80O3/lExClIB567MFfaBYF2hw42dycH9nYEtFrg2V
         WM6jB/IQLWgER0ffeYQurXQVukkzhSB2I9yo+oD72x69I39wQoUiGp4KbGTakKfpc6eK
         zio4YqVvpfYAgJYmyXhM9tHM8uWs8c0NhORaWyBPB7S1abIMBq1QKBJVy1PvxhiSnkF7
         IkhOkIaP8w45K29ei5E/zPbIY2U4zrL4V8SFz1ijs52W5mwXlS8XvInWT96XGzO5xosX
         YAN9KOybrhkbf810Ppm8Qr3hN133XuCuSv/z0ug7vaE9J1oNGH6qBL735Czv7zV/2sB8
         sZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+ZdzFgqA8sxrUpX7gVn9r2eV7QfWMvgZImm8xeBJjNw=;
        b=j54GVvCbz7qbC4rFjGBSFi0yv4ZoqYxQxAkMIo5KLkVesinwvGINO/28KVnV78PPIb
         N/8L2XaGFVuX6XtXL0mk3LJNFVoG2XOJe3AGDFIjfIFMFsFEhx3sk7L89xXjP/QR/BRb
         BMBflzrDiAkHywJzgI8AVPSaGaM3T44CDKdGgRUag3+A7o7HLoL2whs0q7by4Nx5K6HW
         y3d3WUcxMIp26jwhliVLg1zmvI11jnOPWusanJvpxig6q2xyddPe17VGdWr6CG/4JpOV
         eikxGFV/aRzbd68pyksiVpy+EYgtaHHWKcVQHnFDkqpqSo97aBjtSgK2b2pZRrFBnAGO
         kp6w==
X-Gm-Message-State: AOAM530XFo+dCq9aC4If5CnRsEEM6aG7SNLp0H+xDSdq11vrW6+q7z4w
        0xQwTX+HWtciQOzB4miuoZTo98V3rtM=
X-Google-Smtp-Source: ABdhPJxzXEmB0RyBRXWyO6HWPLWB9xHslpmICFp+qhbgCq1mW25wGQEbvbFfZ7eTgubqS/hXXwUbpw==
X-Received: by 2002:a17:90b:310e:: with SMTP id gc14mr5844194pjb.147.1605129881791;
        Wed, 11 Nov 2020 13:24:41 -0800 (PST)
Received: from localhost (g133.220-213-56.ppp.wakwak.ne.jp. [220.213.56.133])
        by smtp.gmail.com with ESMTPSA id v24sm3286986pjh.19.2020.11.11.13.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 13:24:40 -0800 (PST)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Mike Rapoport <rppt@kernel.org>, openrisc@lists.librecores.org
Subject: [PATCH] openrisc: fix trap for debugger breakpoint signalling
Date:   Thu, 12 Nov 2020 06:23:46 +0900
Message-Id: <20201111212347.1504298-1-shorne@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on getting native Linux GDB support working for the
OpenRISC port.  The trap signal handler here was wrong in a few ways.
During trap handling address (from the EEAR register) is not set by the
CPU, so it is not correct to use here.  We want to use trap as a
break-point so use TRAP_BRKPT.  Adding 4 to the pc was incorrect and
causing GDB to think the breakpoint was not hit.

Fixing these allows GDB to work now.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/traps.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/openrisc/kernel/traps.c b/arch/openrisc/kernel/traps.c
index 206e5325e61b..4d61333c2623 100644
--- a/arch/openrisc/kernel/traps.c
+++ b/arch/openrisc/kernel/traps.c
@@ -238,9 +238,7 @@ void __init trap_init(void)
 
 asmlinkage void do_trap(struct pt_regs *regs, unsigned long address)
 {
-	force_sig_fault(SIGTRAP, TRAP_TRACE, (void __user *)address);
-
-	regs->pc += 4;
+	force_sig_fault(SIGTRAP, TRAP_BRKPT, (void __user *)regs->pc);
 }
 
 asmlinkage void do_unaligned_access(struct pt_regs *regs, unsigned long address)
-- 
2.26.2


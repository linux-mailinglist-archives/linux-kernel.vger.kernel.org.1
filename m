Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B86FD2D3450
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 21:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731471AbgLHUgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 15:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731464AbgLHUgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 15:36:18 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0E0BC061793
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 12:35:37 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id d2so11129908pfq.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 12:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fZWRBqMLt3ZPZkgUIc9kLPx8f58u7U8yzXzM7lkor2A=;
        b=O624UBNYJNZKB/KZZJNSkEJA1L+wVMQdO7lVR1NfDRxmNLx93SxXKhdPDKbLgGV2T9
         /7Ab9E3VOBjRWT3z5WJQ4+ZhxVulPJfiM2eMUJ1Hwwhql11qEbteaRPYK8nRgn3ME1kV
         VsR//YMPIgDfJ90LMDfhhSpZte8M4m1AOP21j3UBWyqsGJ+4chOfh3FBdOR4OTVp6AQo
         vY1wTe6jJe5syZ0vkHg3yAtK3U3oA6psrDf8RzOdgOIW8IjWuRf1j5BPo7iyIFByv7U1
         ka/6ql4v04MmsZ5hbtPOq08LudzjIXthtXlgBRI0CnNAuOGPNidN13pIZM2dIrf4qv3L
         ukuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fZWRBqMLt3ZPZkgUIc9kLPx8f58u7U8yzXzM7lkor2A=;
        b=Ia1Q/xu1KMKLoVDbD66prDJvZH4mL/om3YdqoHkHOqhH4Axwz059N65uuksZEErlEO
         tbEwqThSkWVC1zmNntsM67JLYw504xzoClfHkxeW6qkH3jHwuHB5deW9AgcefZoCCN0M
         MyXpnT1Z8CWBIqSly0Mx82XDEd631Og+jdEkiWxA99tkdq7JXYmpsvNGI2UUaUAzUFyh
         ypCLY/cD4a9CFsPYLZ14dgm6jWbgHu/Ebjmk/1xAxOEn65HbQdV13qQhOqcs06P/Zrkx
         VqObHiqT6iKuzoabuoRONfsF2E+fUQJLa0ag/T/Rpf+kF6q4RQEiGq3BZTchqm7lh0G+
         FxNQ==
X-Gm-Message-State: AOAM53074uNFsIBTzZc8QC9HrkCA1vT5htSw/f/UkHoJoUGDTMzp3kZq
        TWg1EK+N92EEXt3jGWqO8rFshOp1mRqgfA==
X-Google-Smtp-Source: ABdhPJxD/Pd8ltpyet/A6OhPKlKdpTnc3xRBFQu8XHiYAaCMZb+LHhtH1XsRZNbOXMxynNQEuhB8mA==
X-Received: by 2002:a63:3714:: with SMTP id e20mr10365494pga.410.1607455626970;
        Tue, 08 Dec 2020 11:27:06 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC.domain.name ([122.179.87.107])
        by smtp.gmail.com with ESMTPSA id z17sm4121825pjn.46.2020.12.08.11.27.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Dec 2020 11:27:06 -0800 (PST)
From:   Souptick Joarder <jrdr.linux@gmail.com>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, guoren@linux.alibaba.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] riscv: Fixed kernel test robot warning
Date:   Wed,  9 Dec 2020 00:57:18 +0530
Message-Id: <1607455638-4436-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot throws below warning -

   arch/riscv/kernel/asm-offsets.c:14:6: warning: no previous prototype
for 'asm_offsets' [-Wmissing-prototypes]
      14 | void asm_offsets(void)
         |      ^~~~~~~~~~~

This patch should fixed it.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 arch/riscv/kernel/asm-offsets.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index db20344..b79ffa3 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -11,6 +11,8 @@
 #include <asm/thread_info.h>
 #include <asm/ptrace.h>
 
+void asm_offsets(void);
+
 void asm_offsets(void)
 {
 	OFFSET(TASK_THREAD_RA, task_struct, thread.ra);
-- 
1.9.1


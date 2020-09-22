Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77AC2273E4D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 11:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgIVJPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726461AbgIVJPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 05:15:37 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25EEC061755;
        Tue, 22 Sep 2020 02:15:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id k8so11879510pfk.2;
        Tue, 22 Sep 2020 02:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAzz9wCPNiKsIxAXKe9YW6gsB3DywLSF0wrFer09R9Q=;
        b=IBo6T8tY47d8BJf1b3BsihWQO8RrG+qSVR3etvIcgVpVmcJhZ3ucoIJe2/WRgsG7ji
         B4u5IhOKaUcZPoptZIa8qdGhTOd5tV8dds/7RVSpzRZ0LOjlD3yg1e6TF1jokjiFBPOX
         UtuI/6TKD8VKU/kVDQRSJvGR2Lgpjpn82r1gbYvzaqTONJaGfEnJv5Pic8ikZfn3vvGD
         vjQKYi/GGasehHavGQyZz2kzEgPSdojk+wgw+jGVB9+y9Zh1MCkvPQxQx0P1UaGTlBqo
         vgFsXA3BjLNsiesmOnS7MPHyw8U3d3tOSdR2Jstr8nRf8TMF19uRpIcNmkCWFaDlclOT
         lYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KAzz9wCPNiKsIxAXKe9YW6gsB3DywLSF0wrFer09R9Q=;
        b=sO9St/NuohHZwHihIT8XB6jZJCk0xNMblnrXVF9xMkB82WWE1vUsnoKQ2r25c+Fz73
         WF+hp5E3Z5CKm+O03F8T7kRBG55o9NlbrQgQS9e2U+WWv62jwhVGvoXXkrYTTtJCOdqu
         nwmK/hX+7q6aYxspScz4hYRkx1RKSkH196c3enCveeNvCIdO1dQaznkGXomPlj+skzG9
         OFU4xthyZiU/WKnrv5AtMNNc0AGFyiowZgqRqhELcMWjHPtCw9s3oo1t5u3tsWNuovz6
         8xbdMQhbIdDxy0pCszuq5/H/TDOILrJxEgJCyuW7a34ha5FjVAAMTB1Qh4FhG8YqIRfW
         ZC1g==
X-Gm-Message-State: AOAM530izhplyXRsGEL5uPx5/EyNnSmRqxb2q8pyq44dJJHjQQmwyDUh
        8bNwiSLuSvVxPnejNoFZg3cUz5pHhLI=
X-Google-Smtp-Source: ABdhPJwFZ12LqJISI1U67/Y/6xwQyXsdD5bQX3kE929lB1rXeQJVZQokT2zdmK3sKs5tLpuK9pSobw==
X-Received: by 2002:a63:eb58:: with SMTP id b24mr2759337pgk.178.1600766136159;
        Tue, 22 Sep 2020 02:15:36 -0700 (PDT)
Received: from ZB-PF0YQ8ZU.360buyad.local (f.a4.5177.ip4.static.sl-reverse.com. [119.81.164.15])
        by smtp.gmail.com with ESMTPSA id q21sm13625859pgt.48.2020.09.22.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 02:15:35 -0700 (PDT)
From:   Zhenzhong Duan <zhenzhong.duan@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org
Cc:     oleg@redhat.com, guoren@kernel.org, viro@zeniv.linux.org.uk,
        Zhenzhong Duan <zhenzhong.duan@gmail.com>
Subject: [PATCH] csky: Fix a size determination in gpr_get()
Date:   Tue, 22 Sep 2020 17:15:05 +0800
Message-Id: <20200922091505.471-1-zhenzhong.duan@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"*" is missed  in size determination as we are passing register set
rather than a pointer.

Fixes: dcad7854fcce ("sky: switch to ->regset_get()")
Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
---
 arch/csky/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index d822144906ac..a4cf2e2ac15a 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -83,7 +83,7 @@ static int gpr_get(struct task_struct *target,
 	/* Abiv1 regs->tls is fake and we need sync here. */
 	regs->tls = task_thread_info(target)->tp_value;
 
-	return membuf_write(&to, regs, sizeof(regs));
+	return membuf_write(&to, regs, sizeof(*regs));
 }
 
 static int gpr_set(struct task_struct *target,
-- 
2.25.1


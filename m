Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF372B55B9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 01:32:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgKQAbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 19:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730225AbgKQAbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 19:31:49 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784B0C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:31:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id k7so22647781ybm.13
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 16:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=/F7w+vb22YMCAFptcIy+T9pUaxmxgKXAvRqmmGGMEyY=;
        b=XE37lkXmGnbIC41bsMg5gq9u13ujQKAMi0yg4xC01BPU0fh8JS07Tj7LOaP1oqLskc
         n+WQQ4bIP+DtgzO/nSstoETioU//WAsUdrkkulQcC30Hc+wWD2hNj2jpy05PMCP0W3VW
         JsLFJRAyKfkITfaBl1tmIxWBhMMlHtBNROQoJ3zMmWjjbmoabRw29PWw4t7VpH92lvsE
         bOmP3JVK88dbOHQnlWgyxc07cyuGfMioTsSyPm5UVAXSZkuAJzgSDU8RnCqixPBnLN8F
         dL0fY+JoZGzSbcav4Hp3sITWL3XcT5Siaqi3LUwKCyUyEykYLmU5wviiaCIZ4sn1qv5y
         pbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=/F7w+vb22YMCAFptcIy+T9pUaxmxgKXAvRqmmGGMEyY=;
        b=TTCD4WdPJWxjJ6mNFvL0zB+iL1KhV53diQEOD6Pd3xLO2Z1GJmVxky2FGOeH3A7z0W
         7DNyQFmyq51mxXIeIdahuADxdXyPJAc4+raOjBAmINn/lEEPmi0SrGvjK835or/G2YVT
         ojvL/mLfKqI7+wtPCqGHNPO6cAX5BHf6tWcdr7I9/cABu1vQ66vI/GN/26kLwGbqBsKq
         529kIjEvkVc5sUsVSnSpMrOYJwojvWK1R1aYN4jz4PAZBeJGPq/zBs4+fxN0/S17Gssu
         ZOlf2EmS+nPLqwD9AtJe5/1j9eXbTsh2GODuI7UznyKOoYPN0GmTGBk6QJGX9jnNwSFG
         nzbA==
X-Gm-Message-State: AOAM531hiRNPBZhF/AOkVy1+Ivc3Y/Ovo88Fmk36SQZcKL24/VoGLrIe
        tnlDWXoW+nGUs8VMl0xkFf2bDBO/
X-Google-Smtp-Source: ABdhPJxztGCTgLmrFalOw7Kt9rPH3urXnoOQqU2lJjKicsnN7lWRzHIsztY8geP6uZAPYEC+3SDGsn0Z
Sender: "rkir via sendgmr" <rkir@rkir.kir.corp.google.com>
X-Received: from rkir.kir.corp.google.com ([2620:15c:29:200:3e52:82ff:fe5f:f95])
 (user=rkir job=sendgmr) by 2002:a25:774c:: with SMTP id s73mr35964638ybc.262.1605573108770;
 Mon, 16 Nov 2020 16:31:48 -0800 (PST)
Date:   Mon, 16 Nov 2020 16:31:35 -0800
Message-Id: <20201117003135.1749391-1-rkir@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.29.2.299.gdc1121823c-goog
Subject: [PATCH] Update MAINTAINERS for goldfish-rtc
From:   rkir@google.com
To:     jiaxun.yang@flygoat.com, chenhc@lemote.com, robh@kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        lfy@google.com, Roman Kiryanov <rkir@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Roman Kiryanov <rkir@google.com>

We (Android Studio Emulator, aka goldfish) do not
support MIPS anymore but goldfish-rtc is still used
by MIPS/RISCV QEMU.

Signed-off-by: Roman Kiryanov <rkir@google.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4a34b25ecc1f..7f9216407ace 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1168,7 +1168,9 @@ F:	Documentation/devicetree/bindings/interrupt-controller/google,goldfish-pic.tx
 F:	drivers/irqchip/irq-goldfish-pic.c
 
 ANDROID GOLDFISH RTC DRIVER
-M:	Miodrag Dinic <miodrag.dinic@mips.com>
+M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
+M:	Huacai Chen <chenhc@lemote.com>
+L:	qemu-riscv@nongnu.org
 S:	Supported
 F:	Documentation/devicetree/bindings/rtc/google,goldfish-rtc.txt
 F:	drivers/rtc/rtc-goldfish.c
-- 
2.29.2.299.gdc1121823c-goog


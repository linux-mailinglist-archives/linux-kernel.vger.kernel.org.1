Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17F22C2324
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:44:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbgKXKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730434AbgKXKmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:42:11 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C400C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:42:11 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id t8so18093056pfg.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1kOaVnPExA4M2Zzl84TgvJHbt1G8dPnuMY/gL7lkGq4=;
        b=AMaHKXe8OyYHc/Ujz0tHLlL7TRTprhzPGfAvtxK9zHnBhk0LLRqp3E/ehOmcvEaU31
         wonnNLS7O/zvfITc21SCaKQnCyZLmo7luT+mXpfK3wlLQwFXI8AN302jtaX51HR4Ios0
         6QoLWC4hIw9aQFc3AYDnHY89jn7Uix1wj2uHCathIZVtewRiOJ2xH8Kb9zYgW4do0DDV
         LRfyFbn670qqhnvBP5Vm20eu6S3SciIKbZXEAZWh5K7OB9JebVIDNdr3FaDMYEn3Tb1o
         lNKqrZogU79Yl4ID2raIhyBrjaWs78xcGeTmboEGAqjkNBxYDxXc0tIVMmiz1nf1mNfD
         7Zmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1kOaVnPExA4M2Zzl84TgvJHbt1G8dPnuMY/gL7lkGq4=;
        b=pBVk/IVmyPrpURhjyjGBVr3YK5el6eESx14XBt7tdqoiZ9yH8dkcmwe+PEsT5QdBgu
         d10WD6Q/BuMyov0JvrAqkyvd2fbnu48uWVbgCTwAwzEkxGf3yyohIauX22HAtRMvDvT5
         vsEOjoZYNUbMuxWYVjyjgxNSKHescuU4hfiTQ1/73piplGFbe4BhSDxfNKA3O36bpKi7
         zawGSJkzz3DCmq0de96rPpgP6Rm77nKg1+8/ogwEQ1pM5UDOLsKJBjO6dzciIQEicuhU
         5R86v8iilrNbx/KuQ/QJh/nwe1HGHdlEPJoVJWR3TZuxbLlQZGLiD6wKF5Qzlw4T0dcl
         6TPA==
X-Gm-Message-State: AOAM530yD3EBsr8Ce8ptUtLKdKRO2oRa078/DlmVnFfYs4qyFiZIuAtP
        k1XHTDpJJajUdZWT4Z21fNo=
X-Google-Smtp-Source: ABdhPJxwkmTmEa7B4IWyBnH5jr4mMCVKn+noA491i+ezS9kzr6gT7KRWTJgHpiML+3d5RZvReZqTXA==
X-Received: by 2002:a63:f14c:: with SMTP id o12mr3285229pgk.450.1606214531220;
        Tue, 24 Nov 2020 02:42:11 -0800 (PST)
Received: from wyqt-MI.mioffice.cn ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id z17sm2664237pjn.46.2020.11.24.02.42.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 02:42:10 -0800 (PST)
From:   tangjianqiang <wyqt1985@gmail.com>
X-Google-Original-From: tangjianqiang <tangjianqiang@xiaomi.com>
To:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     liommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tangjianqiang <tangjianqiang@xiaomi.com>
Subject: [PATCH] dma-contiguous: fix a typo error in cma comment.
Date:   Tue, 24 Nov 2020 18:40:19 +0800
Message-Id: <1606214419-7725-1-git-send-email-tangjianqiang@xiaomi.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix a typo error in cma description comment.

"then" -> "than"

Signed-off-by: tangjianqiang <tangjianqiang@xiaomi.com>
---
 kernel/dma/contiguous.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
index 16b95ff..3d63d91 100644
--- a/kernel/dma/contiguous.c
+++ b/kernel/dma/contiguous.c
@@ -20,7 +20,7 @@
  *   coders, etc.
  *
  *   Such devices often require big memory buffers (a full HD frame
- *   is, for instance, more then 2 mega pixels large, i.e. more than 6
+ *   is, for instance, more than 2 mega pixels large, i.e. more than 6
  *   MB of memory), which makes mechanisms such as kmalloc() or
  *   alloc_page() ineffective.
  *
-- 
2.7.4


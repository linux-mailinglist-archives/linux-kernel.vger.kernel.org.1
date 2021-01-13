Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BAF72F44C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbhAMHBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 02:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbhAMHBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:01:18 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD3B5C061575;
        Tue, 12 Jan 2021 23:00:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n16so3048878wmc.0;
        Tue, 12 Jan 2021 23:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cnbwALSILRtg0eF1OI+3vhojF1BxoTr6PT0p0tQxqiA=;
        b=P45pb8uNoHZpyPmaYHpqZ6hAWBx+88nzcuz95v+M1E/N89iUQ9tOujzhoLafVdNbyk
         7VJkBdTOJ+eVyA6o72XGZRWJ3N+Hk/0p8VHSe373+C+s7I5gcK4SNeC8wmkFLgZkQ367
         d/sb+xPRKwp7pRDx1eOt/zqpLB77lY3j8fyFtoH+Bhs67AH2H3w0wBrmkIWga7iezMG9
         u/MRdo0HwIFIyZLADOqyE9fSCBeFHUgMVNT5N9YtV8sOBViIKMMw1m9ZZj9xD6FOqYT4
         qtGG9wbN0bD49ZEi1tK2qn6cDJ90aaJas9hgnbtw8RC1nZVpXjbLPw0e3IYKqO0StMAZ
         Ursw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cnbwALSILRtg0eF1OI+3vhojF1BxoTr6PT0p0tQxqiA=;
        b=ePDYPLGzB1SERNNUdblaq5EvtGG9WXPfyg3/qas/P1t3GgF9H0MspPUoBr5nbFHhu/
         E0Ozrz+E86sYsJD+XH538b08jmSxN+TNH/1jhi2BeBFaWlCWs/xHhPBVKO3zcIDWEpjY
         3VjSNGh7yl3wNWvFNAptu4sE1xvq3pACT1LVzS46LFkO+Q4+fW8AFaJtElwUnusOjhoB
         dE67h4s3fsLorrDh201QyGKiljPlDndgh9nydD0HRomUMQSWfo1aMFISRG5hlStzYV2K
         J4K8MOlRtftmkUK64WYhpfL/J+QNsVcesdNOWKfkGo5/DSnpObPWM6j4nf614PPdQsQ+
         pqyQ==
X-Gm-Message-State: AOAM5317PD5HbLWE5VZvM7/eu+RDMx1v/DbSKCG5s7rC7ITKPVKVTs1D
        Ck2Coro9bYdGlKMAgTYSc/sly2tUxzEdDw==
X-Google-Smtp-Source: ABdhPJxAMBLccw8apCe53op225/20bd1u8Q4ruDZQiOqP6LgX8TDM8D8RqKXkcqe362eQ/Y7XhXHHQ==
X-Received: by 2002:a1c:5644:: with SMTP id k65mr695379wmb.62.1610521236450;
        Tue, 12 Jan 2021 23:00:36 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2dc9:b100:30ef:8b8a:711:895d])
        by smtp.gmail.com with ESMTPSA id v4sm1598126wrw.42.2021.01.12.23.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 23:00:35 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        Yanteng Si <siyanteng@loongson.cn>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH for doc-next] doc/zh_CN: adjust table markup in mips/ingenic-tcu.rst
Date:   Wed, 13 Jan 2021 08:00:23 +0100
Message-Id: <20210113070023.25064-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 419b1d4ed1cb ("doc/zh_CN: add mips ingenic-tcu.rst translation")
introduces a warning with make htmldocs:

  ./Documentation/translations/zh_CN/mips/ingenic-tcu.rst:
    61: WARNING: Malformed table. Text in column margin in table line 6.

Adjust the table markup to address this warning.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210113

Yanteng, please ack.

Jonathan, please pick this doc warning fixup on your -next tree. 

 Documentation/translations/zh_CN/mips/ingenic-tcu.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
index 72b5d409ed89..9324a0a26430 100644
--- a/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
+++ b/Documentation/translations/zh_CN/mips/ingenic-tcu.rst
@@ -53,14 +53,14 @@
 
 TCU硬件的功能分布在多个驱动程序：
 
-===========         =====
+==============      ===================================
 时钟                drivers/clk/ingenic/tcu.c
 中断                drivers/irqchip/irq-ingenic-tcu.c
 定时器              drivers/clocksource/ingenic-timer.c
 OST                 drivers/clocksource/ingenic-ost.c
 脉冲宽度调制器      drivers/pwm/pwm-jz4740.c
 看门狗              drivers/watchdog/jz4740_wdt.c
-===========         =====
+==============      ===================================
 
 因为可以从相同的寄存器控制属于不同驱动程序和框架的TCU的各种功能，所以
 所有这些驱动程序都通过相同的控制总线通用接口访问它们的寄存器。
-- 
2.17.1


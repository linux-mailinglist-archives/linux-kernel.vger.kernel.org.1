Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C88AE216A4A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 12:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbgGGKbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 06:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727058AbgGGKbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:31:06 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A766C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 03:31:06 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k5so8777181pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 03:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zxuPhyQPrCkY8RwKHf/iDbaI7cQGRWG/m4jeg+A9cWM=;
        b=DYVMc/rvsWjerLh9VJFN6BzYe22rkBMpf7ZdmAztCeUNLETBwUYxFzGO6xCpkvxrOa
         O8OhThpyu/Ir/ldtsTqi0kyc++7tgODibrHl1wxW2WEnNcSoCUzw1Tx5FhmF/0poNuYt
         62D/iekrlWzhHQmWKzE57RYSjQ5fvidbYlIxuP5wwDP+z7m0DSUfS+hzVcT46CKUeJaA
         SwkxUreVzJAJpd7OqbQt4g+GKCkRHk+YzVTR9IG4n8TXOlzhD5fIggL5j9f25SyLOSkJ
         kHtpPgJha1ykSnOka38RSIXpp6pDbO81goPYQkpOo6D1rXt4Yf8UJq+2xCvLUpW3StFp
         kcHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zxuPhyQPrCkY8RwKHf/iDbaI7cQGRWG/m4jeg+A9cWM=;
        b=dbp6CnX0psCVeQhMVNNkkTnSka5IX4VjRJcpCdbCbIXRofH7x1rzvvcpJoIpUVEN3m
         OQyoD/H9JYpMK/xPdK83oOXpbADzxfi/6sWZ0ONBwymi0Xoz2iZvyCvJhm1BPG7Axh5+
         2iYxXq9Q+lVx15qLOwEhxQtkImmRMxcjAIctNvQNsrvJAlwzz09MDZwhva/fGRueylDW
         Gr+ValqqWb9xIm8VPPZ2YAO54mPdyk59V5cOp8hDwxgUHaYhm5BlNJgjQOzfv8pLAUaW
         FC079qP/wnzYarqbmjHu6SC2XLt48oE6uQqu6XvhJfPP565Pd822zRtFsPN7cWYghIIN
         S0Hg==
X-Gm-Message-State: AOAM531tvpTs6lzrIcU4EYB5bYBVlKOAu3wHCQuxqDJ13HUFyF19ag+/
        6LXBpXmmJwgo0VjZ+oVCLM8=
X-Google-Smtp-Source: ABdhPJzv/iLusFv6xB1Tt1gxb/Ilgghzb4kN3WHzskvQ60oL02q24bqSXYCsHoneyioFcIeX4VyMug==
X-Received: by 2002:a17:90a:c290:: with SMTP id f16mr3676405pjt.143.1594117865675;
        Tue, 07 Jul 2020 03:31:05 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:549:1a30:cc80:8285:be58:d37a])
        by smtp.gmail.com with ESMTPSA id io3sm2159014pjb.22.2020.07.07.03.31.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 03:31:05 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, shufan_lee@richtek.com,
        cy_huang@richtek.com, benjamin.chao@mediatek.com
Subject: [PATCH 0/4] mfd: mt6360: Merge different sub-devices i2c read/write
Date:   Tue,  7 Jul 2020 18:30:52 +0800
Message-Id: <1594117856-14343-1-git-send-email-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: 

Gene Chen (4)
  mfd: mt6360: Refactor and fix code style
  mfd: mt6360: Remove handle_post_irq callback function
  mfd: mt6360: Fix flow which is used to check ic exist
  mfd: mt6360: Merge different sub-devices i2c read/write

 b/drivers/mfd/Kconfig       |    1 
 b/drivers/mfd/mt6360-core.c |  541 ++++++++++++++++++++++++++++----------------
 include/linux/mfd/mt6360.h  |  240 -------------------
 3 files changed, 357 insertions(+), 425 deletions(-)


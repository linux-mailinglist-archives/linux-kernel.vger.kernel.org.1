Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85AC7272079
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbgIUKWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgIUKVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:21:12 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391E1C0613D4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:12 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z4so12126235wrr.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:21:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/tLZJac8Ffn37A7WxCGBPX2NFTEQpF30SJ7IB/uL5Ro=;
        b=Lw9bQeNtWzONKIvulMFjqZHVSIBJ+YzkdscnghB6hFyde4iXLIzLYP1EH06krH95mx
         qWKW+RACGF499CYTQYQltWRp5KikOm05rdE4iWUWESguLaMIbqIQVQ/hXQffI+c887uJ
         e80o9Du+VecLUlF7azvUsuv5ZIMhZagcb+sN4uzNxipodcf4W+pHvU20pU86nrJRrV45
         +glL7EqH15veYuWY1d9TCz/Mkt3vlXIAbsBf05s1sqgIUC7BsamzrMUrYbN2lagI0idX
         +qOabI1hNMHz3JKC1YSr6GsuMrlqbhrpHJFszkVbVpPvX+Aa2wOp8/gxmk8UGYk7Im/f
         jpeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/tLZJac8Ffn37A7WxCGBPX2NFTEQpF30SJ7IB/uL5Ro=;
        b=dHRW9ki85kMaKMIn+O1gCeD3dWuYuLuDQTfbONAhSHtyjt77jam0C8sqpXGJU133Bo
         m+FZ3excm41LRxqtCAeLJ8k7oUkHbQ0HMbfAmS4VBxfOtOG4DwLaUGj+7v/seDJruDVo
         7A9S7g7YA+I3Cv85hkE9D8TPrNkdwB4zGI2terXGMvbvNNRxT/j1RM0mXdPhgF/DmCmX
         GNIukidGlmVNvsO4l7Mggbo0Vk1sah88Ab0eQB23zaeCcROMW0ny/fHBx5Z8scjpmCAF
         SQ2b6gwjEiYGQNkcpb6uihTxXGOZYjva+fvNgMdryXX9R5CJtu1D/dcFEhgfcxOl/y7h
         9Q4A==
X-Gm-Message-State: AOAM532vGt0zjLy8lrJAi3IDQabkMYdwVJWhRWnx9O/hr8rGpcWfewtX
        mBBLlHw0y5xVMOjm/ckKLaQZAw==
X-Google-Smtp-Source: ABdhPJwSumtffxKSLF97N4tc6ojqM+H7kM2XB8Kv/SA4FWEXUIxHjZRiLLW+NqoyuVtvuhn1JfNBQA==
X-Received: by 2002:a5d:668b:: with SMTP id l11mr50275532wru.89.1600683670944;
        Mon, 21 Sep 2020 03:21:10 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.21.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:21:10 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 41/49] staging: media: zoran: enable makefile
Date:   Mon, 21 Sep 2020 10:20:16 +0000
Message-Id: <1600683624-5863-42-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch enables compilation of the zoran driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/Makefile b/drivers/staging/media/Makefile
index 25910221b100..965a8b0e6cf2 100644
--- a/drivers/staging/media/Makefile
+++ b/drivers/staging/media/Makefile
@@ -12,3 +12,4 @@ obj-$(CONFIG_VIDEO_HANTRO)	+= hantro/
 obj-$(CONFIG_VIDEO_IPU3_IMGU)	+= ipu3/
 obj-$(CONFIG_PHY_ROCKCHIP_DPHY_RX0)	+= phy-rockchip-dphy-rx0/
 obj-$(CONFIG_VIDEO_ROCKCHIP_ISP1)	+= rkisp1/
+obj-$(CONFIG_VIDEO_ZORAN)	+= zoran/
-- 
2.26.2


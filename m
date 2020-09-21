Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB382734D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbgIUVWx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgIUVWx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:22:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240D4C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:22:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z1so14445717wrt.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WNsktcDavZk4ZN1zKc7CPJyK42SGX8N25x4feTg0UE=;
        b=XkgmdEJ+ZWBqAyrUX/UlytyqOCzWbAX69CbEIOzsrZZ9gIv1v8iPo8919WVbMwWZNg
         hdS33nOjokN0MUUOEEWlWrGOwLyD9ek2rvond8QD4NEwWFtyzUMwZ+eqqpTohtytwzyu
         loQ09JmDFFqOVaODKOJ2g97uSYuafKDFVIBs0EQspcNHiN8QHapQQGdbePiG+mTalid4
         8pmgfAGRFYy6emdBOQ7qe3QAJ785ZTTBzqOeQMXEv4Ti7p3xyq6LSTchkzJAmrwVzYlA
         xDtedEl/aHcKmZCvFG509y5rcZtv0GiW0+5szVH2vOjMiPdBPVzZNZiTi3UchvIsKJC0
         2BBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WNsktcDavZk4ZN1zKc7CPJyK42SGX8N25x4feTg0UE=;
        b=QGu5ROaco1jp7EWtybnlHyY/Bp0HsucPBW+Bt2F1msuQ1koZW3Srv8+1Ic4+TLNSRv
         oboka5U5TCl2HnJkFp/2CBReu0GTu1k2iNzuWxM3GZ1CgHAPk8YAqGbvDtalhGjAdn4F
         gT+2Him7M9yC+NdMX3poPe9h8MVMKlXgiFDzmpMMPo9Veg6Nfk2V51n+mgem7dEXvY8O
         OECE204wqeM6b9pv0T8XB8otJUdnRTVNRz8ZfxPYkAV1ZbdYdo+VdE/K+2xFHkA27yEu
         FaFIJ2xJrzSf7R8/tvU6Zp8u/AfmK9JfWgJuI+rTWv2snMO9afkFmVcSiXkeux0hqV6N
         rwqA==
X-Gm-Message-State: AOAM530qP8JF0sbjdhqZ6Dp2TL121UsasXonHkxm90ltsAOEIm6+E+qU
        PeIBQtDOQGGC1o5T8ptd0O9o0j9hGYDg76nl
X-Google-Smtp-Source: ABdhPJwqp8PBd7JmvKVR7T/Rn4pZpfROSAjO67YtAc+kLyiStHUwHpb/5tmZLjMmJYyYfT9LMrIO5Q==
X-Received: by 2002:a5d:554c:: with SMTP id g12mr1741476wrw.294.1600723371849;
        Mon, 21 Sep 2020 14:22:51 -0700 (PDT)
Received: from localhost.localdomain (cpc83661-brig20-2-0-cust443.3-3.cable.virginm.net. [82.28.105.188])
        by smtp.gmail.com with ESMTPSA id n4sm22623562wrp.61.2020.09.21.14.22.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 14:22:51 -0700 (PDT)
From:   Alex Dewar <alex.dewar90@gmail.com>
Cc:     Alex Dewar <alex.dewar90@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yu Chen <chenyu56@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] staging: hikey9xx: Fix incorrect assignment
Date:   Mon, 21 Sep 2020 22:21:47 +0100
Message-Id: <20200921212146.34662-1-alex.dewar90@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200921174113.19566-1-a.dewar@sussex.ac.uk>
References: <20200921174113.19566-1-a.dewar@sussex.ac.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In hi3670_phy_probe(), when reading property tx-vboost-lvl fails, its
default value is assigned to priv->eye_diagram_param, rather than to
priv->tx_vboost_lvl. Fix this.

Fixes: 8971a3b880b2 ("staging: hikey9xx: add USB physical layer for Kirin 3670")
Addresses-Coverity: CID 1497107: Incorrect expression (COPY_PASTE_ERROR)
Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
---
v2: Fix my email address and a typo in title

 drivers/staging/hikey9xx/phy-hi3670-usb3.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/hikey9xx/phy-hi3670-usb3.c b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
index 42dbc20a0b9a..4fc013911a78 100644
--- a/drivers/staging/hikey9xx/phy-hi3670-usb3.c
+++ b/drivers/staging/hikey9xx/phy-hi3670-usb3.c
@@ -640,7 +640,7 @@ static int hi3670_phy_probe(struct platform_device *pdev)
 
 	if (of_property_read_u32(dev->of_node, "hisilicon,tx-vboost-lvl",
 				 &priv->tx_vboost_lvl))
-		priv->eye_diagram_param = KIRIN970_USB_DEFAULT_PHY_VBOOST;
+		priv->tx_vboost_lvl = KIRIN970_USB_DEFAULT_PHY_VBOOST;
 
 	phy = devm_phy_create(dev, NULL, &hi3670_phy_ops);
 	if (IS_ERR(phy))
-- 
2.28.0


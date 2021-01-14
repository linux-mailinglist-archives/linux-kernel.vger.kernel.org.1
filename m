Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6C42F62FF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 15:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbhANOXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 09:23:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbhANOXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 09:23:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B8AC061575
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:22:51 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i5so3900508pgo.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 06:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=XCkrYWoe/EDhhrXT2w0od5wYE+gjn97ezYkPBm+ukcM=;
        b=ebIHMxRoG6Lw6Qnnz194cWulVJ7CtdgwPORoBI0MUI/Bjh+CaA1EvTwcTrUKR7l/Or
         P7c62cN+XXpUhrhIXm4LEPH3P/XDJBZ6e81d8hu2wO4OZwZ4vVYX7oEzolC/JDbLAonB
         hOPPTb0LlRcxoBcHH8BvvasxXRbE5lpaINX76S1OXvU1xaYlB7jRg5a2CXx4lVNKj+in
         ugWjcWODpZq+a5zEwnq7aBDTJPFb5iIWYLdf7881E3DJ0JWU/MkGXdBLW7j/Y/S/Qi20
         QTJmFajIUJPeL0UY7Wx1xO6L6kQAeh/mam9h/SgyENbFVHzP2bzWylU6/8UTYFgQiOLO
         1TJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=XCkrYWoe/EDhhrXT2w0od5wYE+gjn97ezYkPBm+ukcM=;
        b=onL0aYwuqibZcruxVtnp9uPKM6/Xt4tl6ZZYCcgmiQitbRXGTn6vVEDPHwL4OkxtEq
         h6p8JQw+oLewA6qawNVcP6POJo/VWM00hQPdmy6buURLpfAB5C1FnhULDswcKGoAL/JW
         2mEKotmgmbyFrLBwBIBPX/zjFiLWlwP4/kSKrdE5SAXIePhUPxqRkt+iTs5rYGr75UHx
         c1Vr/SeYPKw0/O6nVWS8/Fju6ncujLkxA5nH/Im5u52+aXJ4/bMp0YvS1QAdWWp7IFRP
         Y9sMV06D2xmFSbMBv+4LLpSW9Lksho2KX+O2z9mWkRvOs4LXHLVwSu/kPFILdJBFPWGs
         gGZg==
X-Gm-Message-State: AOAM533TbbrhV/3ModNTfMCh93+62WlTOyR56XT1mkYDZVhS+oF/yFia
        BxL/JdyoRSp6Kg4zSZqCZb4=
X-Google-Smtp-Source: ABdhPJw4LchfsuTQIaiDfd10NoFHz9inHbHookIrfvLa/tt7v2jFq5AdBQtjlzwjbZPnKwz2ldkKCQ==
X-Received: by 2002:a63:d601:: with SMTP id q1mr7650939pgg.417.1610634171161;
        Thu, 14 Jan 2021 06:22:51 -0800 (PST)
Received: from adolin ([49.207.193.3])
        by smtp.gmail.com with ESMTPSA id c11sm5924498pjv.3.2021.01.14.06.22.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 06:22:50 -0800 (PST)
Date:   Thu, 14 Jan 2021 19:52:45 +0530
From:   Sumera Priyadarsini <sylphrenadin@gmail.com>
To:     daniel@ffwll.ch
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/vblank: Fix typo in docs
Message-ID: <20210114142245.udr7v2aa43ho56xs@adolin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix typo in intro chapter in drm_vblank.c.
Change 'sacn' to 'scan'.

Signed-off-by: Sumera Priyadarsini <sylphrenadin@gmail.com>
---
 drivers/gpu/drm/drm_vblank.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_vblank.c b/drivers/gpu/drm/drm_vblank.c
index d30e2f2b8f3c..30912d8f82a5 100644
--- a/drivers/gpu/drm/drm_vblank.c
+++ b/drivers/gpu/drm/drm_vblank.c
@@ -74,7 +74,7 @@
  *                |↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓|   updates the
  *                |                                        |   frame as it
  *                |                                        |   travels down
- *                |                                        |   ("sacn out")
+ *                |                                        |   ("scan out")
  *                |               Old frame                |
  *                |                                        |
  *                |                                        |
-- 
2.25.1


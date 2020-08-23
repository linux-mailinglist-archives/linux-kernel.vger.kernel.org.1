Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84E7224EFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 00:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbgHWWBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Aug 2020 18:01:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbgHWWAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 18:00:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B553C061755
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id g6so7443788ljn.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 15:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dgUUXxG2qw0/AzpIOnX5I7nR6oDetQlhoFTeFIT/cgQ=;
        b=Yu5yAhEB8n3eicOirM2vKYWPo9+r95YwdukywCOId/3B6XRf6x5SDdnvoaD+7vI20E
         7rZGdJcExYomyjtBr8TZEb7fzPpqZODfahsiWNuHstU+/5rXjOqbyfvKFj6qBDcNjF6Z
         Fs72y25T8QpYDQZ943j5oy63Shiyps29OAJrLWiwDKeJNOuFspPh4nOvEkX95lY8aT8K
         2infE8G92NV23QfJGeuEgmJgQJ7j/3Sari9on38n+SZCHDkfDCD6VRZb7oEXxVaAV5TC
         ZDveI8am5gMOawIVI8sj2mb7wrBEENYfJpq0SChMIAGawclkaIhVM0qRc0m6TTIDcoQJ
         VrSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dgUUXxG2qw0/AzpIOnX5I7nR6oDetQlhoFTeFIT/cgQ=;
        b=rMIExEw99/+5q/z0nj8put5nFIKGWhlN4XgJQa54Nr2LAyfkhd7KMmTZJKu/rDBaiI
         FXURNB/bhCyWckA64gFkydHtXe0K6HfncZDnVp/7CKwURWDf3/Bn+Su6omlhvEmb82ql
         O1tp9oMHgLTjQm4E3sHxC1QO0mPREq9hI1NeTyfAKJENr7Lzd43/Ffek2ncDa0wcqlKa
         zek52oexg9PZNV3cmzPrAvu6Bbm9JBbQxNimQQCEEWUpxXA9suJEfG93yxbjTSx1+gCT
         9SrIgSA/uNgo1tlG58XLSRxBk+8ELX5BwDQnWdIhnWtjeTkSJMV27bRIwBu0uyuisFCr
         KJug==
X-Gm-Message-State: AOAM533tOtVNcl7qO5VYutPKK56UMNFjTQo7q1mpAzqe9EyH3SmleRnv
        dHqpi9tdribMt9BL0aNjl+Y=
X-Google-Smtp-Source: ABdhPJw4xx+q/+/mDVhVHTECrqFGL/dJhLk0xQnlu0MZi6wfI1NGG1Z4IFDATzDxv/9VKfXRzdWS6g==
X-Received: by 2002:a05:651c:1069:: with SMTP id y9mr1308755ljm.438.1598220042880;
        Sun, 23 Aug 2020 15:00:42 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id g11sm1825097lfc.46.2020.08.23.15.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2020 15:00:42 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH 6/8] phy: ralink-usb: Constify ralink_usb_phy_ops
Date:   Mon, 24 Aug 2020 00:00:23 +0200
Message-Id: <20200823220025.17588-7-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
References: <20200823220025.17588-1-rikard.falkeborn@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only usage is to pass its address to devm_phy_create() which takes a
const pointer. Make it const to allow the compiler to put it in
read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
 drivers/phy/ralink/phy-ralink-usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/phy/ralink/phy-ralink-usb.c b/drivers/phy/ralink/phy-ralink-usb.c
index ba3c197fc5b0..95dfa9fd284d 100644
--- a/drivers/phy/ralink/phy-ralink-usb.c
+++ b/drivers/phy/ralink/phy-ralink-usb.c
@@ -142,7 +142,7 @@ static int ralink_usb_phy_power_off(struct phy *_phy)
 	return 0;
 }
 
-static struct phy_ops ralink_usb_phy_ops = {
+static const struct phy_ops ralink_usb_phy_ops = {
 	.power_on	= ralink_usb_phy_power_on,
 	.power_off	= ralink_usb_phy_power_off,
 	.owner		= THIS_MODULE,
-- 
2.28.0


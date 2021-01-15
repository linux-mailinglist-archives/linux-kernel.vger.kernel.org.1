Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD752F83F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388349AbhAOSTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbhAOSRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:17:42 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62600C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:32 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d26so10194873wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FGPhURrdAfrcr7PbpwjcxwF7QYiZtJ0ThRqyiooaDBM=;
        b=e7nYyY2nViynQVTw0qCPH1uZMBKoFpKPnEbk0loJLIxWeIm19aIa6t4zpZJUQ76qbH
         sETMQNR8y68prpyoYG+MZGgwksMFqvJ8Tk+6+qAKoECjWM5GBXHFkT4xG/f5UcF26YDY
         dM29Plji930ezBILTG/C9mpVQs4PekZWEwhawyZ4KAzqU7PQbuQHosuXLVQcxsccezFY
         TEab+zsqKdNhDBV5tfUW7KDA+Knmcw8e0nkRgMsdiK6f4d8893cp/8Bxl6rfjAfgIKs2
         mpkefoeDaPbx+trLknAyGsJDIYEO2UUT04giz3JiS/QDsAYsoTvrAidVP1gYX/9sxFrw
         bLZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FGPhURrdAfrcr7PbpwjcxwF7QYiZtJ0ThRqyiooaDBM=;
        b=H5+6hdAm0VfHLTfQp395wpHoaiJFeuyuqrti1lazfLhI1K9fIPpAx4bIw8ZYFzD3dh
         I4o54XlT60F8Fdx6sGOyuNN025aOd4Zll+jdZbYvumN5TbAkkz0Tn/RuR5d4ORIPlI+e
         LVN8vm57epd6Y6IXfD1L0CVEHnKiyUr9SXujp7TJer5GsFu/FhkNtUEBNaCHBohibIwm
         CM3iq/3BdJ0+CUG/XZTAdx6cxWfI5imGdNiJMKNF1pJ5oULduXf/RHygBCvoMT3ilD7h
         /sPYdlZHTy2cqMK7KcSBiNBeQnRjppyf1rX0Ej97X4e88br8Q6BcER9j+GL0srwaaNZT
         5qvA==
X-Gm-Message-State: AOAM531l81TnPROpPcKD4EHUdLzivyP8dslOD/ywJHYQyjcnf3cg5VmE
        bSlxND1+BxBUHbVFYx7rJY44AnPPzgytnyjn
X-Google-Smtp-Source: ABdhPJylJzUx60Mk4XLdT6I+iRaNomlyZqBNDJ+ZueJbh+Hos/sho8zalnVjR4hbAg+aDtTutRVoSQ==
X-Received: by 2002:a05:6000:1088:: with SMTP id y8mr10266247wrw.380.1610734591117;
        Fri, 15 Jan 2021 10:16:31 -0800 (PST)
Received: from dell.default ([91.110.221.158])
        by smtp.gmail.com with ESMTPSA id b133sm14405979wme.33.2021.01.15.10.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jan 2021 10:16:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jan Safrata <jan.nikitenko@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH 18/29] drm/gma500/oaktrail_lvds_i2c: Remove unused variables 'tmp'
Date:   Fri, 15 Jan 2021 18:15:50 +0000
Message-Id: <20210115181601.3432599-19-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210115181601.3432599-1-lee.jones@linaro.org>
References: <20210115181601.3432599-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c: In function ‘get_clock’:
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c:69:11: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c: In function ‘get_data’:
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c:83:11: warning: variable ‘tmp’ set but not used [-Wunused-but-set-variable]

Cc: Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Jan Safrata <jan.nikitenko@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
index d64aedc69845f..1d2dd6ea1c717 100644
--- a/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
+++ b/drivers/gpu/drm/gma500/oaktrail_lvds_i2c.c
@@ -66,12 +66,12 @@
 static int get_clock(void *data)
 {
 	struct psb_intel_i2c_chan *chan = data;
-	u32 val, tmp;
+	u32 val;
 
 	val = LPC_READ_REG(chan, RGIO);
 	val |= GPIO_CLOCK;
 	LPC_WRITE_REG(chan, RGIO, val);
-	tmp = LPC_READ_REG(chan, RGLVL);
+	LPC_READ_REG(chan, RGLVL);
 	val = (LPC_READ_REG(chan, RGLVL) & GPIO_CLOCK) ? 1 : 0;
 
 	return val;
@@ -80,12 +80,12 @@ static int get_clock(void *data)
 static int get_data(void *data)
 {
 	struct psb_intel_i2c_chan *chan = data;
-	u32 val, tmp;
+	u32 val;
 
 	val = LPC_READ_REG(chan, RGIO);
 	val |= GPIO_DATA;
 	LPC_WRITE_REG(chan, RGIO, val);
-	tmp = LPC_READ_REG(chan, RGLVL);
+	LPC_READ_REG(chan, RGLVL);
 	val = (LPC_READ_REG(chan, RGLVL) & GPIO_DATA) ? 1 : 0;
 
 	return val;
-- 
2.25.1


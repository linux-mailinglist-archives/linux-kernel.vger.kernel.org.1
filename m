Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABF22A6974
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbgKDQZB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:25:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730918AbgKDQYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:24:53 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1BC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:24:53 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id c16so2881007wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yOqqwbhs3ZFnypFgr81+FVo0+Ncb1joEEk3R1wcSBm8=;
        b=JGNHio/tzPkDy+/FyTCMGY/ssW2w/GQpFbLgWgw4NR8QApR1GggM30uCUKOV4eEZXp
         rILOPGM3qh9JetWxdtLK60SbE0JWyGkvi10rYTktKNMoePcY0aIYt3kQ0LeljkOSSx+A
         Exq53HV2ZKL2svrB4L98uT1ajW521U/Cv6TY8RHYdNwDUaTgcqh8VYJcVs5xfYHlFTzK
         cp3dqY6G4b8jU/EO7WWkOM9NzEbqKl6qlk+IDD2AqQWLrppkhC16HsoLDaNtq8CEYrqa
         XYXnZkvH0mMM+Nrn+WhFcZZ6HenlRsCM386vJmeGLUYhf75VgEEHlFrL1hJ7m5KsP9Wi
         Pb9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yOqqwbhs3ZFnypFgr81+FVo0+Ncb1joEEk3R1wcSBm8=;
        b=AwsHRa+WkXtEi6vf4s8N4cWYYmbzRoTU1lcroDDNTOLSinKqFLwBOuJJ3tuulJcWoi
         D8nVFcAta1s9bf8bXq4NRrKforRcHSuEWM+7DctlQFL8EdElkoq9Ol5O1tM6ykI+J84W
         v+EcxA9sh05+HZ/dF446l+cCj72fJnURLiz3iPzKLRYN4w7JzQqTmHx69ZNc88hdWFm+
         0+ChO3Rf3LiTd0HbP5RTYwOoidHwyFsFL2v6srAgBxntcOncNEozTda83KFiPrBkTAK9
         7Br1ZLgqeO5YGP4KSZXasKTv6KUg+loVY0zkTNcTZ90wi3mee8rvFo6sm7G0DN7QXdNF
         iKgw==
X-Gm-Message-State: AOAM530r9W+/Vq+57qNIqxmCyXVC/YSezw3XzhfV3dxD1w7AE96t2dWU
        4NhZXvRBEZ55PSftdVdB7mWqnA==
X-Google-Smtp-Source: ABdhPJxjdksOfjG9itW3gMfgTXD935vSw7Mn9Npcixc/CseYuLHAQnNW+iYB0LibrjKy5joIoxc4WQ==
X-Received: by 2002:a1c:3d44:: with SMTP id k65mr5155183wma.147.1604507091818;
        Wed, 04 Nov 2020 08:24:51 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:51 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Andrew Duggan <aduggan@synaptics.com>,
        linux-input@vger.kernel.org
Subject: [PATCH 08/20] input: rmi4: rmi_f11: Struct headers are expected to start with 'struct <name>'
Date:   Wed,  4 Nov 2020 16:24:15 +0000
Message-Id: <20201104162427.2984742-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/rmi4/rmi_f11.c:66: warning: Cannot understand  * @rezero - writing this to the F11 command register will cause the sensor to
 drivers/input/rmi4/rmi_f11.c:311: warning: cannot understand function prototype: 'struct f11_2d_sensor_queries '

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: Andrew Duggan <aduggan@synaptics.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/rmi4/rmi_f11.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/input/rmi4/rmi_f11.c b/drivers/input/rmi4/rmi_f11.c
index ffa39ab153f2a..38baf39ce0916 100644
--- a/drivers/input/rmi4/rmi_f11.c
+++ b/drivers/input/rmi4/rmi_f11.c
@@ -62,7 +62,7 @@
 /* maximum ABS_MT_POSITION displacement (in mm) */
 #define DMAX 10
 
-/**
+/*
  * @rezero - writing this to the F11 command register will cause the sensor to
  * calibrate to the current capacitive state.
  */
@@ -178,7 +178,8 @@
 #define F11_UNIFORM_CLICKPAD 0x02
 
 /**
- * Query registers 1 through 4 are always present.
+ * struct f11_2d_sensor_queries - Query registers 1 through 4 are always
+ *				  present.
  *
  * @nr_fingers - describes the maximum number of fingers the 2-D sensor
  * supports.
-- 
2.25.1


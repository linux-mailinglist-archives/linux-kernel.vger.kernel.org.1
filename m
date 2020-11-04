Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B41C42A696D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:25:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbgKDQYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgKDQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:24:46 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44942C061A4A
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 08:24:46 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id p1so3540923wrf.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 08:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/pehohWmuys5loht7+WPpBg1h/OEijt9BJT+2ot7pfE=;
        b=dVxYiVWaB+e22PzDGjiCKLziltetH04dfjkI+LnDpCbnMDbROwELo9sbj6ZmUz7I4L
         X4bkKlWYlir2FkUNvuvrelWNtkT80hFmcvtwjO2e0fmYFwsZZDyHxjLxgA47LR+CU0Ln
         7GH+BbJ5K8r4m6dbmAT/hn6wKTCy5YA49tU7VvMNCayhNufnEp+1DNvZaAElf7AdJokj
         wbus3avuX0tzWICtlHvx/hqwOiXYreKlPghHbyrkoTWPnbONJ5XN4LED9zbglKVcz0hd
         xNJzEGTwBT1n0i43ax7hPLy9oCq0pY706p+uDeSATC4s1Kg+UgDAVH/DnJ49HhbY09dn
         BjLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/pehohWmuys5loht7+WPpBg1h/OEijt9BJT+2ot7pfE=;
        b=taTZNYE5gmdkHU1iyrN4xpk6p6hJu1ahU+av4l1NU9qsp29wTBjcWUXh7czdLEbKkL
         0sMyqDCG8cujrE3W461ryLQz5sLrgpfK3/NKJILHnE5m+o+Sb3p5vlaq11/FETwnYKow
         nc2UVngl6TeDsNJ67BtEiqiYAqe7Xft3a3rNEdgc+V33ri/9phXY3EFOrz6VDne6t9hM
         o29x17GHszR39FsxzLZm3aBVZ51PJi4AvinvDmWjvpbCb5Bod2NXSEsGoR1w0Mt2tARr
         yX95wLxKX1ewMvWryM6jixKTPDTTKdbp7SfzN48FRTG1BvKmtqR7aIMMx8wJWRj+JSre
         eF4g==
X-Gm-Message-State: AOAM532TaFJS5i5Cd+5dgluHnpP/z3PpjyYrJCoBhockMmQURzmmPRjA
        3+c+ckKXGlyPXRrvJWNAqZ50Sg==
X-Google-Smtp-Source: ABdhPJynzGjvNfjtDsR1OdF+T/RCHr9NwfmXJKx5i8AjRSc0LoIT5yzEJwy09a3I4ZDlVEwovymnrg==
X-Received: by 2002:adf:e610:: with SMTP id p16mr27404083wrm.302.1604507085026;
        Wed, 04 Nov 2020 08:24:45 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id o129sm3008564wmb.25.2020.11.04.08.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 08:24:44 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Dudley Du <dudl@cypress.com>, linux-input@vger.kernel.org
Subject: [PATCH 03/20] input: mouse: cyapa_gen5: Fix obvious abuse of kernel-doc format
Date:   Wed,  4 Nov 2020 16:24:10 +0000
Message-Id: <20201104162427.2984742-4-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104162427.2984742-1-lee.jones@linaro.org>
References: <20201104162427.2984742-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/input/mouse/cyapa_gen5.c:392: warning: Function parameter or member 'cyapa' not described in 'cyapa_i2c_pip_write'
 drivers/input/mouse/cyapa_gen5.c:392: warning: Function parameter or member 'buf' not described in 'cyapa_i2c_pip_write'
 drivers/input/mouse/cyapa_gen5.c:392: warning: Function parameter or member 'size' not described in 'cyapa_i2c_pip_write'
 drivers/input/mouse/cyapa_gen5.c:444: warning: Function parameter or member 'cyapa' not described in 'cyapa_empty_pip_output_data'
 drivers/input/mouse/cyapa_gen5.c:444: warning: Function parameter or member 'buf' not described in 'cyapa_empty_pip_output_data'
 drivers/input/mouse/cyapa_gen5.c:444: warning: Function parameter or member 'len' not described in 'cyapa_empty_pip_output_data'
 drivers/input/mouse/cyapa_gen5.c:444: warning: Function parameter or member 'func' not described in 'cyapa_empty_pip_output_data'

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Henrik Rydberg <rydberg@bitmath.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Dudley Du <dudl@cypress.com>
Cc: linux-input@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/input/mouse/cyapa_gen5.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/cyapa_gen5.c b/drivers/input/mouse/cyapa_gen5.c
index bb3a63d1268d1..5c37af994b5b5 100644
--- a/drivers/input/mouse/cyapa_gen5.c
+++ b/drivers/input/mouse/cyapa_gen5.c
@@ -385,7 +385,7 @@ ssize_t cyapa_i2c_pip_read(struct cyapa *cyapa, u8 *buf, size_t size)
 	return size;
 }
 
-/**
+/*
  * Return a negative errno code else zero on success.
  */
 ssize_t cyapa_i2c_pip_write(struct cyapa *cyapa, u8 *buf, size_t size)
@@ -435,7 +435,7 @@ static enum cyapa_pm_stage cyapa_get_pip_pm_state(struct cyapa *cyapa)
 	return pm_stage;
 }
 
-/**
+/*
  * This function is aimed to dump all not read data in Gen5 trackpad
  * before send any command, otherwise, the interrupt line will be blocked.
  */
-- 
2.25.1


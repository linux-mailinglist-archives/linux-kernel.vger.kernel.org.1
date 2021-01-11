Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24392F1190
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 12:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbhAKLgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 06:36:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbhAKLgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 06:36:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3125C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:35:32 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id g24so18383338edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 03:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXOWeR9801FrisPggQzBoR4P1LZC0ogSzc7qiclRxzA=;
        b=Mf2f7LJM9bPXCaZWpu+DA3F8zjBC3NYdKnghIBztANh6OSOVMK4LbhwONJlFeqAU6H
         pPSrTCV6Jx9bvjcyGbOIGMOKxmMwu/jHp1FqUYKRJnRF7aa8ssiiz/i2Ojgla86zeC67
         RFZq1mjsHkMRdKKz0w0brsi7WTIhAR8EMNdFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lXOWeR9801FrisPggQzBoR4P1LZC0ogSzc7qiclRxzA=;
        b=l3bZMLSPrN06TsZ9GsgYNxDk+kqHqJf9FFtWn3dKOyWu8Mi1n0BNhll1cdsZrqx/ZL
         XYGFwvPJiSnyymsEOQblUUQdTSHvU1ZVLtxvXlUqGs7jeA36VYwCP0/IRvSAYlgsjQl6
         9azxrkyTEYdvfPF4KyfGbfUx8eSOI09LU09Zrd5TxtyTBwDYuwhzHOWDm+yhGM/Nlvxh
         Z/bdZe9GSiuv01zjsp/H5D5hpDjgk1iQd6BRE0K/fFQPNiYSKoGNak0JgVPdP17gDVpp
         TWvtZuGFKsttNWn+DiqUYTIZ5l3RRVyvdpPTogF2X14x9zGlB0LD3FUENAu1C3G3RJ4j
         BJDA==
X-Gm-Message-State: AOAM53095cWVHj8dtzWx0IEX8uSu4JO1LKr6B7IHhNsoSF8u/vT9Ul3A
        v+VXvkQRkhJj1sSLuKUaAwo28g==
X-Google-Smtp-Source: ABdhPJzwxJwfY2vvKcY/y88PUCnedWNHcDU/ytPX64NcJqeDQDiDRVSjMIYqBwltXgDOoc01CDFlTw==
X-Received: by 2002:a05:6402:307c:: with SMTP id bs28mr13865398edb.186.1610364931540;
        Mon, 11 Jan 2021 03:35:31 -0800 (PST)
Received: from alco.lan ([80.71.134.83])
        by smtp.gmail.com with ESMTPSA id rs27sm6982564ejb.21.2021.01.11.03.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 03:35:30 -0800 (PST)
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Cc:     Ricardo Ribalda <ribalda@chromium.org>
Subject: [PATCH] hantro: Format IOCTLs compliance fixes
Date:   Mon, 11 Jan 2021 12:35:29 +0100
Message-Id: <20210111113529.45488-1-ribalda@chromium.org>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear the reserved fields.

Fixes:
  fail: v4l2-test-formats.cpp(482): pix_mp.plane_fmt[0].reserved not zeroed
test VIDIOC_TRY_FMT: FAIL
  fail: v4l2-test-formats.cpp(482): pix_mp.plane_fmt[0].reserved not zeroed
test VIDIOC_S_FMT: FAIL

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 drivers/staging/media/hantro/hantro_v4l2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/media/hantro/hantro_v4l2.c b/drivers/staging/media/hantro/hantro_v4l2.c
index b668a82d40ad..9b384fbffc93 100644
--- a/drivers/staging/media/hantro/hantro_v4l2.c
+++ b/drivers/staging/media/hantro/hantro_v4l2.c
@@ -239,6 +239,7 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 	const struct hantro_fmt *fmt, *vpu_fmt;
 	bool capture = V4L2_TYPE_IS_CAPTURE(type);
 	bool coded;
+	int i;
 
 	coded = capture == ctx->is_encoder;
 
@@ -293,6 +294,10 @@ static int hantro_try_fmt(const struct hantro_ctx *ctx,
 			pix_mp->width * pix_mp->height * fmt->max_depth;
 	}
 
+	for (i = 0; i < pix_mp->num_planes; i++)
+		memset(pix_mp->plane_fmt[i].reserved, 0,
+		       sizeof(pix_mp->plane_fmt[i].reserved));
+
 	return 0;
 }
 
-- 
2.30.0.284.gd98b1dd5eaa7-goog


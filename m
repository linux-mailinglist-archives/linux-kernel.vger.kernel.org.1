Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B437D27204D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 12:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgIUKUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 06:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726827AbgIUKUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 06:20:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5547EC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:48 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id e17so11564475wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 03:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7hg4hkt0xKc+u3OMG6BJG4ab1Qlz/YPXWuTo+eYO1gA=;
        b=I9A+ozHbjj5JIKiaEWlISCq0H27Pvji2tPH9MWl/bJlBO/XHBY+M9xbil5zUFwme8r
         RopHc97gNGKXhpYPb2FtNbXH6YJVWex7q8flecpw+CgjEZoGmYW2dFWs3e28zn2RcW8W
         u0BqgrDL6rfkc5QCTixqui4vUZ9hvKw6oCy5eL5XvLxrzk7xqLe0X3DgrPbLTJ3OyJJu
         Da7lRhMZXm50cMBW5GS5yE2f5MzK/dNRVh8YnNwIuk8Zh2oa2OGELlicuASRb1HUGg1H
         xEiveZMZmDXPoJsly6mRcaMfuDoNyFsBP+Bft/kd1lhQArcgu6n7mKb+Ar0zuFmIopv+
         vMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7hg4hkt0xKc+u3OMG6BJG4ab1Qlz/YPXWuTo+eYO1gA=;
        b=YFYdUiu1QfItdu9g02k1+mDItFhHv+3nUpmvg5ItwRtLx8IFB8oJuVu0PEJSKgzjz2
         sQYA0MCgWEjwNFoyBjTNTzcR4Mrg+7QJzoxjzkswck9lx9ln/bQCJhF93jdBUZwnq/SQ
         8eVROmoVgMjtVuxOoCN2fGawhgr8d7fDh+eLRe6KO6EYTnSaEuSN78iej2Dt71XyATKy
         /jEM5PMz+LGej8p1WGi5qvCjcizBhTcal0mFgT3HXCWjboi7iyGmNtz+w/GDXUd/x0wB
         y3NkvBnXBPZIuZqrTsW6E/hTP7txSzfnhOR0Y9TIzVDTPGGXu0xCWMoi7SDfC8IiIvdO
         Ygjg==
X-Gm-Message-State: AOAM531QhuS4PeVC58woR9PBiribzmIP1/hvtJAuIDZsgiXDFIMvjMWI
        S71ibSggENeFDslny3CZRvinsA==
X-Google-Smtp-Source: ABdhPJwJJAhkkByBZiA+u9aw9ZaL1S/4JSy8xlyXdLg6vqMKmmptWk2OW3Tnk20GbyYqMkxkQjAz+w==
X-Received: by 2002:a7b:c4d9:: with SMTP id g25mr29201004wmk.15.1600683647080;
        Mon, 21 Sep 2020 03:20:47 -0700 (PDT)
Received: from localhost.localdomain ([51.15.160.169])
        by smtp.googlemail.com with ESMTPSA id l17sm18804629wme.11.2020.09.21.03.20.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2020 03:20:46 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, laurent.pinchart@skynet.be,
        mchehab@kernel.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH RFT/RFC 15/49] staging: media: zoran: use v4l2_buffer_set_timestamp
Date:   Mon, 21 Sep 2020 10:19:50 +0000
Message-Id: <1600683624-5863-16-git-send-email-clabbe@baylibre.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
References: <1600683624-5863-1-git-send-email-clabbe@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ns_to_timeval function is removed, so replace it with
v4l2_buffer_set_timestamp().

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/staging/media/zoran/zoran_driver.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/zoran/zoran_driver.c b/drivers/staging/media/zoran/zoran_driver.c
index 31ed36906204..a996161cb276 100644
--- a/drivers/staging/media/zoran/zoran_driver.c
+++ b/drivers/staging/media/zoran/zoran_driver.c
@@ -1197,7 +1197,7 @@ static int zoran_v4l2_buffer_status(struct zoran_fh *fh,
 		    fh->buffers.buffer[num].state == BUZ_STATE_USER) {
 			buf->sequence = fh->buffers.buffer[num].bs.seq;
 			buf->flags |= V4L2_BUF_FLAG_DONE;
-			buf->timestamp = ns_to_timeval(fh->buffers.buffer[num].bs.ts);
+			v4l2_buffer_set_timestamp(buf, fh->buffers.buffer[num].bs.ts);
 		} else {
 			buf->flags |= V4L2_BUF_FLAG_QUEUED;
 		}
@@ -1228,7 +1228,7 @@ static int zoran_v4l2_buffer_status(struct zoran_fh *fh,
 		if (fh->buffers.buffer[num].state == BUZ_STATE_DONE ||
 		    fh->buffers.buffer[num].state == BUZ_STATE_USER) {
 			buf->sequence = fh->buffers.buffer[num].bs.seq;
-			buf->timestamp = ns_to_timeval(fh->buffers.buffer[num].bs.ts);
+			v4l2_buffer_set_timestamp(buf, fh->buffers.buffer[num].bs.ts);
 			buf->bytesused = fh->buffers.buffer[num].bs.length;
 			buf->flags |= V4L2_BUF_FLAG_DONE;
 		} else {
-- 
2.26.2


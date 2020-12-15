Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 536792DAED5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 15:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729420AbgLOOWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 09:22:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49337 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729423AbgLOOWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 09:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608042069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nNAN1vGyAciYBO+ou4+cqD2HBxuVIVg3uWlbifmOtUY=;
        b=a5FPX6Q6LF6HXkK/T+OMjpljgc9fGMgpBJYtysSjaOkvgrqsmnIOBEzlgYDaNxPUjB1kw9
        IIfK/KpV27wI9zvJw+s9qur+RiuztiuSXfofqNWzPd0276wlRSvBJBc6UyNh4Vms/p6ce5
        hc8Mb7+2PoZyM0bhseHuAVqw6jrTEwY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-ON3AQFA-PkKXK_aIuQBs9g-1; Tue, 15 Dec 2020 09:21:05 -0500
X-MC-Unique: ON3AQFA-PkKXK_aIuQBs9g-1
Received: by mail-qv1-f72.google.com with SMTP id 12so14348002qvk.23
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 06:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nNAN1vGyAciYBO+ou4+cqD2HBxuVIVg3uWlbifmOtUY=;
        b=IK1ZbafgIypd7DDcWtlBzj28V4cdxh3PmlhMTlu4WD2gy+LtDjw5YLHdM3gafBlg0o
         dVVJYQz8sXwLB9I/UhTgd2k8jlqw7LSbOxmyPQjEXAfjk12a/3W1k9XW/LTO259zUjG0
         8b68uJAF+h3wDGQzGOMxoU6HRjAbbBlmI0f5Nb2EekLiMI08yF61+qoG16ZzzCGvXQos
         kcGfyQYGPbl8IAxGHpLY8w2C0EVbRQGnuEqMUEAu7FpZJzf9VUjTGE0bp6H5sMe39MMW
         Fn/I2iSm1zJ0gPLoU4C2mkbkXLxbS5dGgSxOavkwbQAQCXZgCjRzQo56w9rK/7X2MfTl
         3HmA==
X-Gm-Message-State: AOAM5314R9z7uo1Wx3NNXiVOqqVqUMvKU1OhgXvTDOA/zlPpSUIUpv9g
        GuDgufsI2EIoKN1Edk3rT4QkqLqg1fw2Muw7epU1a9jLsAwiK5kLmiusqugkKWSgk3kFquVVV2r
        ry/q9AbZB0kiqIA3Sa3yokFSC
X-Received: by 2002:ac8:e06:: with SMTP id a6mr39343274qti.384.1608042064915;
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfH8vkI0rTKDiu924mjDigF3TrXfgqa/9f5ICyqT9e1uYrAA4AN2xEOCl8WNNMfItb+n2UAw==
X-Received: by 2002:ac8:e06:: with SMTP id a6mr39343254qti.384.1608042064747;
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x65sm15959059qkc.130.2020.12.15.06.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 06:21:04 -0800 (PST)
From:   trix@redhat.com
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] block: remove h from printk format specifier
Date:   Tue, 15 Dec 2020 06:20:58 -0800
Message-Id: <20201215142058.1844696-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

See Documentation/core-api/printk-formats.rst.
h should no longer be used in the format specifier for printk.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 block/blk-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 7663a9b94b80..7c839e396f24 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1181,7 +1181,7 @@ static blk_status_t blk_cloned_rq_check_limits(struct request_queue *q,
 	 */
 	rq->nr_phys_segments = blk_recalc_rq_segments(rq);
 	if (rq->nr_phys_segments > queue_max_segments(q)) {
-		printk(KERN_ERR "%s: over max segments limit. (%hu > %hu)\n",
+		printk(KERN_ERR "%s: over max segments limit. (%u > %u)\n",
 			__func__, rq->nr_phys_segments, queue_max_segments(q));
 		return BLK_STS_IOERR;
 	}
-- 
2.27.0


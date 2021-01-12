Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131E22F342B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 16:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391167AbhALPao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 10:30:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388929AbhALPao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 10:30:44 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFF1C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:30:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id x126so1578143pfc.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 07:30:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9nbRvwo7ac2ToiSLQSsfVzaqM5k2WvPOWvIf0XdbxA=;
        b=eM5ISxhZoCLEIGOwGetHhmmIPqAc56Qu0T8jpNBgasOwpZuIpmVYO1/o3tQF4L9TKf
         PejjotnzCIeDiOadl/7mp0/mC4naBqEeKjLSAzq5CTe1HEta0/k6DAgbZpr0ddwHvYjx
         RCwO2mO/OA5GlYOkH5WGg8YkIbbUkxNQU+Sf/cYW0ZU5v6l3MAE6skyV/bTzVg8VU8RA
         IrT6VB+p7d7pbhgNTurKa9uVbUFHYRWTk/0JApYylURP8jRNRkqAzj4R9ch+9Ka6qRFx
         rYQnfF1EQeWZ7hPFp5epVqs5O7SaKqxwdQkqgELzSs1Kyh9xI2kP0HhRCYL/i2gwucjK
         ZbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q9nbRvwo7ac2ToiSLQSsfVzaqM5k2WvPOWvIf0XdbxA=;
        b=JSmNywII0Tod0+5x6X7fPOS/eWNQqevERNHOZSAdc5xoD7pBqzFViu+2BPGR9w4b2D
         bv5dq1nzkBnOODFVurSdgQ0KbV8FePhKuZPuu2XAW/Oajt5WCDShWrkGDYxfwAyyyQTI
         LQvDui4Zcy/7JnDtZTA99P1WJigEpSmoZCZYcN/iBHm9pd4Ig7uHXjfU9FfjkG1OcEd6
         Y+fvqlwo6HHsrrRUJLijXtEzXIo6Rz2vSGkviW5XoTqleO86TAMmEZYw+HqL53mlZoUF
         jhX6Vf0qXwF1cOMVhK9TdjjsCLYrDzKSWHI5r1d2fCthRyVVksrV9T8Ahk6FTwfc24Tz
         95ng==
X-Gm-Message-State: AOAM531dIkubyK1bxSPGZEOSG3wIzjwcCTYHZYh6hwN/t9kqK8vgyap1
        UmNay8Z18CWMCDCxJmZq7FYFrD4GIyDIGWENgls=
X-Google-Smtp-Source: ABdhPJyALuNVv1wvI+DDRekgkGo8NXfLozpA9HiGJxZ7KWqh/VVuh24KQ5EaDmvO2ic4y/u1/3k/Fg==
X-Received: by 2002:a63:3ec9:: with SMTP id l192mr5316862pga.104.1610465403297;
        Tue, 12 Jan 2021 07:30:03 -0800 (PST)
Received: from localhost.localdomain (ec2-18-163-103-0.ap-east-1.compute.amazonaws.com. [18.163.103.0])
        by smtp.gmail.com with ESMTPSA id n1sm3486878pfu.28.2021.01.12.07.30.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 07:30:02 -0800 (PST)
From:   Li Feng <fengli@smartx.com>
To:     Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org (open list:BLOCK LAYER),
        linux-kernel@vger.kernel.org (open list)
Cc:     lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Subject: [PATCH] blk: avoid divide-by-zero with zero granularity
Date:   Tue, 12 Jan 2021 23:29:51 +0800
Message-Id: <20210112152951.154024-1-fengli@smartx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the physical_block_size and io_min is less than a sector, the
'granularity >> SECTOR_SHIFT' will be zero.

Signed-off-by: Li Feng <fengli@smartx.com>
---
 include/linux/blkdev.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index f94ee3089e01..4d029e95adb4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1485,6 +1485,10 @@ static inline int queue_alignment_offset(const struct request_queue *q)
 static inline int queue_limit_alignment_offset(struct queue_limits *lim, sector_t sector)
 {
 	unsigned int granularity = max(lim->physical_block_size, lim->io_min);
+	granularity = granularity >> SECTOR_SHIFT;
+	if (!granularity)
+		return 0;
+
 	unsigned int alignment = sector_div(sector, granularity >> SECTOR_SHIFT)
 		<< SECTOR_SHIFT;
 
-- 
2.29.2


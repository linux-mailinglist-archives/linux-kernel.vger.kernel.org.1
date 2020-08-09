Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1ED23FF26
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 18:00:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHIQAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 12:00:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:51174 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726200AbgHIP7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 11:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596988784;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=xG+8uieNrMAP0UGTh1w832zRGIBKTtCxlShJe5RBqBY=;
        b=dxBNrcTa6ohjcTdxtSU3u/KqS2oh4TwuGdGJ4BaHXyBNURZQ9XBny0isOVWIIRNGc1jTqW
        C+hB+dBip1+mXlW326TKj9GKlQwT1phAo+o7k8vUeDzze85ely+8hAR//INedhLTQWPSM8
        vNDDS8Andd1gsdEtKnYnkrDsoW5kl+0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-9QuKDFC6NAqav10xHGktiw-1; Sun, 09 Aug 2020 11:59:42 -0400
X-MC-Unique: 9QuKDFC6NAqav10xHGktiw-1
Received: by mail-qk1-f200.google.com with SMTP id 195so5425506qke.14
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=xG+8uieNrMAP0UGTh1w832zRGIBKTtCxlShJe5RBqBY=;
        b=rtZOSgo8a8ewxGWeKZyNND3VjRvqSnk+ANsNM548KnDuKGcFoHCcz3jUu+o7yBM0Lz
         aVM3JnnrJalU0xiZxynK7lulsvH62lbXTWfOZ2fb7hYCG5riMHesr4wm7BloCK/FCW2I
         yko3XlvwcG+4HH/2rDhhEsMHjTJmPAAS53EI9wIIIaL1cTZFWcpQS5WphzZC8xiDZBOS
         xcw0E/ap3z2txYV8DarVDGRhYVgE1xtssZ5q9Lo0BYOL43WkFvDeeePA3giZWehzQ7YX
         2XKM3PHZDRky2X5TLgJiBzAEB/A1tAtFwLeQvuQeiTcbAKDGFkBEL8hVvquWOXRYPG7i
         eBdA==
X-Gm-Message-State: AOAM533yOWS5lf6Y9gYlWZpJKbxE5xyAFZa3P0+g1RsgiIGtLZ1NfQuc
        WGg07yH7k6baDWrAEeGUAY2ij0izzfkn4Z/zrBYOZbT0zxJ1xzGAL3Hvo7t7RVLWuf8T3JYKLzx
        kINnwo9YmCVu4E5FOvUqwedh7
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr22806364qkh.8.1596988782402;
        Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzek1KpoZ0Rpa2MTqiHLJFcD8g4Cwdl2ExzIA00XyXHgllNcIpXqt/H9tlORP5vMgXoeqUj/w==
X-Received: by 2002:a05:620a:676:: with SMTP id a22mr22806349qkh.8.1596988782146;
        Sun, 09 Aug 2020 08:59:42 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id k48sm14978268qtk.44.2020.08.09.08.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 08:59:41 -0700 (PDT)
From:   trix@redhat.com
To:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, jmaneyrol@invensense.com,
        mirq-linux@rere.qmqm.pl, lee.jones@linaro.org
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] iio: imu: inv_mpu6050: check for temp_fifo_enable
Date:   Sun,  9 Aug 2020 08:59:36 -0700
Message-Id: <20200809155936.16898-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analysis reports this problem

inv_mpu_ring.c:181:18: warning: Division by zero
        nb = fifo_count / bytes_per_datum;
             ~~~~~~~~~~~^~~~~~~~~~~~~~~~~

This is a false positive.
Dividing by 0 is protected by this check

	if (!(st->chip_config.accl_fifo_enable |
		st->chip_config.gyro_fifo_enable |
		st->chip_config.magn_fifo_enable))
		goto end_session;
	bytes_per_datum = 0;

But there is another fifo, temp_fifo

	if (st->chip_config.temp_fifo_enable)
		bytes_per_datum += INV_MPU6050_BYTES_PER_TEMP_SENSOR;

Which would be skipped if it was the only enabled fifo.
So add to the check.

Fixes: 2e4c0a5e2576 ("iio: imu: inv_mpu6050: add fifo temperature data support")

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
index b533fa2dad0a..5240a400dcb4 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
@@ -141,6 +141,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
 
 	if (!(st->chip_config.accl_fifo_enable |
 		st->chip_config.gyro_fifo_enable |
+		st->chip_config.temp_fifo_enable |
 		st->chip_config.magn_fifo_enable))
 		goto end_session;
 	bytes_per_datum = 0;
-- 
2.18.1


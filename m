Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D54E5291804
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 17:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgJRPRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 11:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbgJRPRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 11:17:33 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A9C0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:17:33 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 144so4481985pfb.4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 08:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=TKhi0Y+b/JoDtYReYISOZrk9LHF70X4eVbWQlM2Wsc4=;
        b=wo4bvHi7mYRfXrilILRU5/DvNHpwqxLxTNLBfWZs81sd+9NokCkEZMm9ODyc5z5TL3
         msJOVlAPLik7BBRydvHK0rI7iuBqt5g15/40R3ozDHLyW7LcTCsn2scv9IApGfSO7wgl
         CusCz1EdyxraQxdAep+mRZJwXTaxzc+TxMakBHjevAKo0CHe054Y8KWkr+DPe9xa6JC+
         OsXtfy7kqaK9XDFzIsV1Cd/ypGP2InQgFzdSyXlsXh+TF5YJ2ro1Si4SPD77X//fMSXZ
         ib4iFfy/G5FW5LxeVlx6XAHK7ecGJuHvS6rWok88PvLr+9KfX0xccT8S5c9bteHGox0d
         99Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=TKhi0Y+b/JoDtYReYISOZrk9LHF70X4eVbWQlM2Wsc4=;
        b=XT4TQq7xHbDNDShYhSwFIK8gpAgpN3S6W27gQFzt2InTIEtWWqn9EZjoN7MCg616zh
         YQ8bnbYJeobuaQz30c94PFoBSOINT0Y1uqmMG48ngzb+ZM9KgBQba8cnWR5Lz8TM1cKC
         f1zGB466y1zT+WT5Xgmmdylw7y6031r3DBK1oW2G9Dg2xDJIGJ3t0ol9p5wIZB1vcP+z
         q1p2vQuLcmswatCIPBEvBi0O4JbYXUq1NBU/k9EASmYbE//MnUz6qNwKRoKmKvWztNm1
         FCEEdb9cAVp/Y5L+tzUl5IcOw+N0//WnE7LjynYoRny3LRvSLdu0cEZrahYjjyTt+BJI
         DKzQ==
X-Gm-Message-State: AOAM532AHVcoMdrCcp0ymWWuDGpWGxD9h6hjvuPt+m9HI+ocxcvfiSew
        6bILCgj16ol7a6nR/c6lUfBx
X-Google-Smtp-Source: ABdhPJyMEHz0Jy+GD7TT844zzyZxt9mKuV13O3F52FgvEQlK5/WiLPGhmyA4ym6B5OVGSNFaICJFhg==
X-Received: by 2002:a65:4787:: with SMTP id e7mr10821635pgs.169.1603034252506;
        Sun, 18 Oct 2020 08:17:32 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id y22sm9366733pfr.62.2020.10.18.08.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 08:17:31 -0700 (PDT)
Date:   Sun, 18 Oct 2020 20:47:26 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     jic23@kernel.org, wsa@kernel.org, songqiang1304521@gmail.com,
        knaack.h@gmx.de, lars@metafoo.de, alexandru.ardelean@analog.com,
        matt.ranostay@konsulko.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com,
        vaishnav@beagleboard.org
Subject: [PATCH v3] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201018151726.GA219649@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add i2c_device_id table for the vl53l0x-i2c driver,
helps in device instantiation using i2c_new_client_device
or from userspace in cases where device-tree based description
is not possible now (Example: device on a gbphy i2c adapter
created by greybus)

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
 v3:
	-modify commit message for readability
	 as suggested by Jonathan Cameron
 v2:
	-fix commit message
 drivers/iio/proximity/vl53l0x-i2c.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/iio/proximity/vl53l0x-i2c.c b/drivers/iio/proximity/vl53l0x-i2c.c
index 5fbda9475ba9..7c29d4cae24a 100644
--- a/drivers/iio/proximity/vl53l0x-i2c.c
+++ b/drivers/iio/proximity/vl53l0x-i2c.c
@@ -143,6 +143,12 @@ static int vl53l0x_probe(struct i2c_client *client)
 	return devm_iio_device_register(&client->dev, indio_dev);
 }
 
+static const struct i2c_device_id vl53l0x_id[] = {
+	{ "vl53l0x", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, vl53l0x_id);
+
 static const struct of_device_id st_vl53l0x_dt_match[] = {
 	{ .compatible = "st,vl53l0x", },
 	{ }
@@ -155,6 +161,7 @@ static struct i2c_driver vl53l0x_driver = {
 		.of_match_table = st_vl53l0x_dt_match,
 	},
 	.probe_new = vl53l0x_probe,
+	.id_table = vl53l0x_id,
 };
 module_i2c_driver(vl53l0x_driver);
 
-- 
2.25.1


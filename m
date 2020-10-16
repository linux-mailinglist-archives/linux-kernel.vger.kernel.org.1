Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A41CD290BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 20:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403990AbgJPSwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 14:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403978AbgJPSwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 14:52:10 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F1EC0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id n14so2004603pff.6
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bZS0PkIumMewJqO0zzmmpVDk7qnPinNXzuHyH6TMs80=;
        b=JHuDxzjbKaRY0U52JMzbJvyxhCDlFz5UIpmzyrSse45hHa4tKEisXs3IpiQXj4OQ2i
         RtHNq+nSKkn+rsVGB0qisd7gn9g1VW6djG0ygkCCGSAgwHrqipxphy8Cv8a5DvKxSuj3
         YGr3bWm4pNZI67YehANTagkyiOhISZP4EKVA/c0FGiuGA/eAYLY/bX/BkiX4AiXqzIWs
         JQLX/FCsGEhez209yGORXFG6aHpKYONCiYhRWmOE5OLMk/q3tRTTEA0gkgawsYsQrnL4
         EMpoMMcrG/fcCBARW0Ahw28ljfwp9ptXvEOViQSVVGGVI6UWzp6ROlWHuMeuN45QX9zA
         qyuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bZS0PkIumMewJqO0zzmmpVDk7qnPinNXzuHyH6TMs80=;
        b=paT4WB8d642HC8/GXciatEffnnF6mMJ7ZSh2bbGD/0Fi8/q+yY+pEif//63ZgIMSmj
         AOQoxFjLVIBc2utsVccNV3bT2us6zauuiziHjYanzmNf78rU5DTOGmgZZqrgzj9uaj4Y
         PiCqJFsW3ERW75x+COwu+sbRhqDnTIDbqTY2hrZhh3bAEAUxtSEB1LplngKnflChqC/0
         FqiIScD762Q2t5o2jBkG0bbE8yeAeFm2uYPGRurCCE6WyPGLu+6TI14LEbY1BCtpH5W4
         f/TfoRAEZEbDm8XZg9cBwNR1QmMwT9FmzcH/2xRRx2Mk00Zi4ovhDHUySx3JfZunrHij
         ra8g==
X-Gm-Message-State: AOAM533zyVU8xSzVj654kEwI/KT6xJvMvL0h0c9rHXT3aD5NSk47i093
        Lx4/mUP9/xyx3lkd7cVEs1La
X-Google-Smtp-Source: ABdhPJx1vg0jakP/HgcVd2AUX5oE49QIzSMsLLNaJtLktA9SIx3N/u+9NULPdSzr8fuc/uFrkZP/lA==
X-Received: by 2002:a63:1f0f:: with SMTP id f15mr4182497pgf.312.1602874329165;
        Fri, 16 Oct 2020 11:52:09 -0700 (PDT)
Received: from ubuntu ([116.68.78.80])
        by smtp.gmail.com with ESMTPSA id 92sm3865188pjv.32.2020.10.16.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 11:52:08 -0700 (PDT)
Date:   Sat, 17 Oct 2020 00:21:25 +0530
From:   Vaishnav M A <vaishnav@beagleboard.org>
To:     songqiang1304521@gmail.com, jic23@kernel.org, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jkridner@beagleboard.org, drew@beagleboard.org,
        robertcnelson@beagleboard.org, rajkovic@mikroe.com
Subject: [PATCH] iio: proximity: vl53l0x-i2c add i2c_device_id
Message-ID: <20201016185046.GA16022@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch aims to add i2c_device_id for the vl53l0x-i2c driver.
will it be possible to consider this patch add the i2c_device_id,
so that the device can be instantiated using i2c_new_client_device
or say from the userspace?.This will be really helpful in cases
where the device tree based description is not possible now(Eg. 
a device on a gbphy i2c adapter created by greybus).

The particular usecase here is described over this RFC Patch
for the mikroBUS driver:
https://lore.kernel.org/patchwork/patch/1290148/

Thanks and Regards,

Vaishnav M A

Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
---
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


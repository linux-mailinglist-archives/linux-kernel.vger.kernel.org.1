Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 845C72DE88D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 18:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbgLRRyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 12:54:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbgLRRx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 12:53:59 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D0AC0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:53:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id y17so3172851wrr.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 09:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=adVH/5jvy/v2pQEZnES4ohjLSuw1Po3Eac/Um3HvWm0=;
        b=hBSDM/a6FGaIKzbik2Z4UUU38Vf+n1GmqTFQGefcLhKV5KrtZ1N+GNM+IdzdU0CsMv
         wyyRiEhKJgMghuI0UAddWg/ljqwNs/hwK/Q//dz3k9tkMJWTY/GMuhOt8ngEbpe7RkE2
         Pz0QgKe6wpdVJL7RvlOq7pThoUmc73anbGmQ/MgLlebwJ7ZuGSjMKkGRfRl5h3EBoF2V
         /Hx0FwaP+ny2VP3Y2XUq+EO6oFPpIAfwQzfzxbU3hLN8R3yWRri7tqO/InOvHT1pwb3C
         884W72N1rcGAMbMyqTQqu5VvE2vDMfOUXnP8YlBPGqXa0xYaqqYYZB21j9UVyrB8jHUF
         5t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=adVH/5jvy/v2pQEZnES4ohjLSuw1Po3Eac/Um3HvWm0=;
        b=c0ndgMGy1lE6qHP+ttwzhv9jDBirswC9oJHZgzsLcjhJ1ApiAGERllbsZlonbsSiZe
         Df6nzTSOX1vLdgZwAsbyRs21fQ1vkavA/UQmnJyZjFh8x6FZxIwrcFPzaLNJqCcU6aun
         JezwAajaJeEjs9TdB/yjIMKH4gvrzeUgkqys115m7wInkiLvcM4e+S5D3oKwSQRyynyl
         e1gJJZZqN1ZQSB5+cST9GQiU7Hj45rQmU0YAZ8pRbAPPZqKmlHObXKjAOmoKwjhxysk9
         4n7uZpUqYK/N/ix7Xrmbj7kOsl1A5Bx0yJ4dx6UjI8YlajMWqecr+4lrcAEs0bCoeJIX
         ZclA==
X-Gm-Message-State: AOAM531JC+V+7IYvoBkowF6ObzwjO7JTXkpPtdEhtnbH1UL5L69VxeGr
        c0yw1OL9jJK/rWKV0nfcfn6EX8IyzFtbcR6bfy0geQ==
X-Google-Smtp-Source: ABdhPJy28rtXk0nB9tPVV80zSk0vQn9bZcSx+NjM2EpRJ0o1VJ4IKO7ebd9zKZvycv2iFXAeAzrZBvTqdUShFhRvIgc=
X-Received: by 2002:a5d:6cad:: with SMTP id a13mr5604347wra.275.1608313997704;
 Fri, 18 Dec 2020 09:53:17 -0800 (PST)
MIME-Version: 1.0
From:   Kevin Herbert <kph@platinasystems.com>
Date:   Fri, 18 Dec 2020 09:53:06 -0800
Message-ID: <CABP=6zaXWU8OLxzvn0YJ-K+07Jju+LW-VE3isrnzDnAi5YN7Pw@mail.gmail.com>
Subject: [PATCH] i2c-imx.c: Synthesize end of transaction events without idle interrupts
To:     Biwen Li <biwen.li@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        linux@rempel-privat.de, kernel@pengutronix.de,
        Wolfram Sang <wsa@the-dreams.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>, o.rempel@pengutronix.de,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From feaf638fb9b9a483c0d6090b277f34db21160885 Mon Sep 17 00:00:00 2001
From: Kevin Paul Herbert <kph@platinasystems.com>
Date: Tue, 15 Dec 2020 16:50:34 -0800
Subject: [PATCH] i2c-imx.c: Synthesize end of transaction events without idle
 interrupts

Only the Layerscape SoCs have interrupts on bus idle, which facilitate
sending events which complete slave bus transactions.

Add support for synthesizing missing events. If we see a master request,
or a newly addressed slave request, if the last event sent to the backend
was I2C_SLAVE_READ_REQUESTED, send the backend a I2C_SLAVE_READ_PROCESSED
followed by I2C_SLAVE_STOP. For all other events, send an I2C_SLAVE_STOP.

Signed-off-by: Kevin Paul Herbert <kph@platinasystems.com>
---
 drivers/i2c/busses/i2c-imx.c | 59 +++++++++++++++++++++++++++++++-----
 1 file changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
index 7137bae770ea..7255e1dabde4 100644
--- a/drivers/i2c/busses/i2c-imx.c
+++ b/drivers/i2c/busses/i2c-imx.c
@@ -211,6 +211,7 @@ struct imx_i2c_struct {

  struct imx_i2c_dma *dma;
  struct i2c_client *slave;
+ enum i2c_slave_event last_slave_event;
 };

 static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
@@ -637,6 +638,36 @@ static void i2c_imx_enable_bus_idle(struct
imx_i2c_struct *i2c_imx)
  }
 }

+static void i2c_imx_slave_event(struct imx_i2c_struct *i2c_imx,
+ enum i2c_slave_event event, u8 *val)
+{
+ i2c_slave_event(i2c_imx->slave, event, val);
+ i2c_imx->last_slave_event = event;
+}
+
+static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx)
+{
+ u8 val;
+
+ while (i2c_imx->last_slave_event != I2C_SLAVE_STOP) {
+ switch (i2c_imx->last_slave_event) {
+ case I2C_SLAVE_READ_REQUESTED:
+ i2c_imx_slave_event(i2c_imx, I2C_SLAVE_READ_PROCESSED,
+     &val);
+ break;
+
+ case I2C_SLAVE_WRITE_REQUESTED:
+ case I2C_SLAVE_READ_PROCESSED:
+ case I2C_SLAVE_WRITE_RECEIVED:
+ i2c_imx_slave_event(i2c_imx, I2C_SLAVE_STOP, &val);
+ break;
+
+ case I2C_SLAVE_STOP:
+ break;
+ }
+ }
+}
+
 static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
       unsigned int status, unsigned int ctl)
 {
@@ -649,9 +680,11 @@ static irqreturn_t i2c_imx_slave_isr(struct
imx_i2c_struct *i2c_imx,
  }

  if (status & I2SR_IAAS) { /* Addressed as a slave */
+ i2c_imx_slave_finish_op(i2c_imx);
  if (status & I2SR_SRW) { /* Master wants to read from us*/
  dev_dbg(&i2c_imx->adapter.dev, "read requested");
- i2c_slave_event(i2c_imx->slave, I2C_SLAVE_READ_REQUESTED, &value);
+ i2c_imx_slave_event(i2c_imx,
+     I2C_SLAVE_READ_REQUESTED, &value);

  /* Slave transmit */
  ctl |= I2CR_MTX;
@@ -661,7 +694,8 @@ static irqreturn_t i2c_imx_slave_isr(struct
imx_i2c_struct *i2c_imx,
  imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
  } else { /* Master wants to write to us */
  dev_dbg(&i2c_imx->adapter.dev, "write requested");
- i2c_slave_event(i2c_imx->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
+ i2c_imx_slave_event(i2c_imx,
+     I2C_SLAVE_WRITE_REQUESTED, &value);

  /* Slave receive */
  ctl &= ~I2CR_MTX;
@@ -672,17 +706,20 @@ static irqreturn_t i2c_imx_slave_isr(struct
imx_i2c_struct *i2c_imx,
  } else if (!(ctl & I2CR_MTX)) { /* Receive mode */
  if (status & I2SR_IBB) { /* No STOP signal detected */
  value = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
- i2c_slave_event(i2c_imx->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
+ i2c_imx_slave_event(i2c_imx,
+     I2C_SLAVE_WRITE_RECEIVED, &value);
  } else { /* STOP signal is detected */
  dev_dbg(&i2c_imx->adapter.dev,
  "STOP signal detected");
- i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &value);
+ i2c_imx_slave_event(i2c_imx,
+     I2C_SLAVE_STOP, &value);
  }
  } else if (!(status & I2SR_RXAK)) { /* Transmit mode received ACK */
  ctl |= I2CR_MTX;
  imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);

- i2c_slave_event(i2c_imx->slave, I2C_SLAVE_READ_PROCESSED, &value);
+ i2c_imx_slave_event(i2c_imx,
+     I2C_SLAVE_READ_PROCESSED, &value);

  imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
  } else { /* Transmit mode received NAK */
@@ -723,6 +760,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
  return -EBUSY;

  i2c_imx->slave = client;
+ i2c_imx->last_slave_event = I2C_SLAVE_STOP;

  /* Resume */
  ret = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
@@ -775,10 +813,17 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)

  status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
  ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
+
  if (status & I2SR_IIF) {
  i2c_imx_clear_irq(i2c_imx, I2SR_IIF);
- if (i2c_imx->slave && !(ctl & I2CR_MSTA))
- return i2c_imx_slave_isr(i2c_imx, status, ctl);
+ if (i2c_imx->slave) {
+ if (!(ctl & I2CR_MSTA)) {
+ return i2c_imx_slave_isr(i2c_imx, status, ctl);
+ } else if (i2c_imx->last_slave_event !=
+    I2C_SLAVE_STOP) {
+ i2c_imx_slave_finish_op(i2c_imx);
+ }
+ }
  return i2c_imx_master_isr(i2c_imx, status);
  }

-- 
2.25.1

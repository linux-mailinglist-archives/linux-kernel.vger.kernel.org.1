Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D7BF2F6FFA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 02:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731505AbhAOB2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 20:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbhAOB2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 20:28:04 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D12C061757
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:27:23 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id o10so981135wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jan 2021 17:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=platinasystems-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vMRE9dark7EQERP0zC22aGoB0MAlzAtMnbpzdeZrTqM=;
        b=tdtielL9L7YauN+KMgX93cwiX75fqljQvK5hdQAvEJlf5B7rgC0Kz8WYz37mXpUGbh
         yXLmpZqO+2HYEah1lbpL9xKoFXvA4bR7554d76weZ/D5RdpBbkUQAZjJBRNetsbdDYH/
         W0j0DBlvzo8J4Uibi9kt5D+BC0y9U2kA81BSMGMJr0bI0+BYSqwpwHHOCHqDRQbpkK1T
         JHrxan11lLup7Q6kqgPqnpkBwWZ45y7rV1Oa/aIKdtHYVKadzETKblwA2lmO0gOYMaAr
         Adl8vSl5OxSChIRJrqCuOzsYWA/Ru+N5rHNwV53wNBtYkzkpllqvi0ON6HBSixzM834X
         h2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vMRE9dark7EQERP0zC22aGoB0MAlzAtMnbpzdeZrTqM=;
        b=E5swrqKaD+4QgwwILLwUbA4svjJpQp2xGlizjBkMiOGg2kF/FsILBjUBrCCMO3KhKO
         GGwhtl5JiOB//HLioORjlsK0AWJzc122Vo+VeTWlriAb2FvALKXo282pzcAa8CQ4zcZR
         xLkyvTueTh+Asgmlx7xkL85dtlqOcKSyRwDo8Gd0LNQVFFNe4/nmqmKKM3jksurEBnGN
         bpfq1sye2dShRUR1T/QisuOQDtuwox21XKYuzwtHX/qfxMH7bmfqYWxauJrZb1uSXy6c
         4BU8IInbrsHzwGVal76gaTVV9PVd9aKtmZGAcFnrdRSfeGVIcmEv52BVYCJyg7sQx1U/
         2c7w==
X-Gm-Message-State: AOAM533DnthrslvbAtTOzFaPXEOGY4ZXawCS9lorIynwqvLCkfFmlLVm
        wRa/ZuqF68nKS9B0odbpItsX4ECmm9EtYhjgpPMFrw==
X-Google-Smtp-Source: ABdhPJy5czBTdS3JkSnzyFQAC5CJnVs2oGeD5Z0My4rvHwy3Ea9KuUyIwvSzwMbVSkl43UcU6WVaNU8S2Ea7JjsX4r0=
X-Received: by 2002:a1c:b742:: with SMTP id h63mr6263599wmf.122.1610674042366;
 Thu, 14 Jan 2021 17:27:22 -0800 (PST)
MIME-Version: 1.0
References: <20201222194850.2274527-1-kph@platinasystems.com> <20210108080521.dzm2gczd3d2ygb5y@pengutronix.de>
In-Reply-To: <20210108080521.dzm2gczd3d2ygb5y@pengutronix.de>
From:   Kevin Herbert <kph@platinasystems.com>
Date:   Thu, 14 Jan 2021 17:27:11 -0800
Message-ID: <CABP=6zY0xV3dLE5t7qad6TauQsaLmQtYi73BS9XBHwZ2FrgM8g@mail.gmail.com>
Subject: Re: [PATCH] i2c-imx.c: Synthesize end of transaction events without
 idle interrupts
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Biwen Li <biwen.li@nxp.com>, Leo Li <leoyang.li@nxp.com>,
        linux@rempel-privat.de, kernel@pengutronix.de,
        Wolfram Sang <wsa@the-dreams.de>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com,
        Aisheng Dong <aisheng.dong@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Biwen Li <biwen.li@oss.nxp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The loop sends either one or two events to the slave driver. If the
state is I2C_SLAVE_READ_REQUESTED, we synthesize the
I2C_SLAVE_READ_PROCESSED event, and then our state becomes
I2C_SLAVE_READ_PROCESSED. In all other states, we transition to
I2C_SLAVE_STOP and exit the loop.

It is not a busy loop at all. It is calling the callback handler (that
already expects to be in IRQ context) one or two times, and then it
exits the loop.

Kevin


On Fri, Jan 8, 2021 at 12:05 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> Hi Kevin Paul,
>
> On Tue, Dec 22, 2020 at 11:48:50AM -0800, Kevin Paul Herbert wrote:
> > Only the Layerscape SoCs have interrupts on bus idle, which facilitate
> > sending events which complete slave bus transactions.
> >
> > Add support for synthesizing missing events. If we see a master request,
> > or a newly addressed slave request, if the last event sent to the backend
> > was I2C_SLAVE_READ_REQUESTED, send the backend a I2C_SLAVE_READ_PROCESSED
> > followed by I2C_SLAVE_STOP. For all other events, send an I2C_SLAVE_STOP.
> >
> > Signed-off-by: Kevin Paul Herbert <kph@platinasystems.com>
> > ---
> >  drivers/i2c/busses/i2c-imx.c | 59 +++++++++++++++++++++++++++++++-----
> >  1 file changed, 52 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
> > index b444fbf1a262..b3e2a6a7fc19 100644
> > --- a/drivers/i2c/busses/i2c-imx.c
> > +++ b/drivers/i2c/busses/i2c-imx.c
> > @@ -209,6 +209,7 @@ struct imx_i2c_struct {
> >
> >       struct imx_i2c_dma      *dma;
> >       struct i2c_client       *slave;
> > +     enum i2c_slave_event last_slave_event;
> >  };
> >
> >  static const struct imx_i2c_hwdata imx1_i2c_hwdata = {
> > @@ -662,6 +663,36 @@ static void i2c_imx_enable_bus_idle(struct imx_i2c_struct *i2c_imx)
> >       }
> >  }
> >
> > +static void i2c_imx_slave_event(struct imx_i2c_struct *i2c_imx,
> > +                             enum i2c_slave_event event, u8 *val)
> > +{
> > +     i2c_slave_event(i2c_imx->slave, event, val);
> > +     i2c_imx->last_slave_event = event;
> > +}
> > +
> > +static void i2c_imx_slave_finish_op(struct imx_i2c_struct *i2c_imx)
> > +{
> > +     u8 val;
> > +
> > +     while (i2c_imx->last_slave_event != I2C_SLAVE_STOP) {
> > +             switch (i2c_imx->last_slave_event) {
> > +             case I2C_SLAVE_READ_REQUESTED:
> > +                     i2c_imx_slave_event(i2c_imx, I2C_SLAVE_READ_PROCESSED,
> > +                                         &val);
> > +                     break;
> > +
> > +             case I2C_SLAVE_WRITE_REQUESTED:
> > +             case I2C_SLAVE_READ_PROCESSED:
> > +             case I2C_SLAVE_WRITE_RECEIVED:
> > +                     i2c_imx_slave_event(i2c_imx, I2C_SLAVE_STOP, &val);
> > +                     break;
> > +
> > +             case I2C_SLAVE_STOP:
> > +                     break;
> > +             }
> > +     }
> > +}
>
> Is it really working code?
>
> The i2c_imx_slave_finish_op() is a waiting busy loop withing an IRQ! And
> it is waiting for an event, which is updated in the same IRQ callback.
> Or am i missing some thing?
>
> Regards,
> Oleksij
>
> >  static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
> >                                    unsigned int status, unsigned int ctl)
> >  {
> > @@ -674,9 +705,11 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
> >       }
> >
> >       if (status & I2SR_IAAS) { /* Addressed as a slave */
> > +             i2c_imx_slave_finish_op(i2c_imx);
> >               if (status & I2SR_SRW) { /* Master wants to read from us*/
> >                       dev_dbg(&i2c_imx->adapter.dev, "read requested");
> > -                     i2c_slave_event(i2c_imx->slave, I2C_SLAVE_READ_REQUESTED, &value);
> > +                     i2c_imx_slave_event(i2c_imx,
> > +                                         I2C_SLAVE_READ_REQUESTED, &value);
> >
> >                       /* Slave transmit */
> >                       ctl |= I2CR_MTX;
> > @@ -686,7 +719,8 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
> >                       imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> >               } else { /* Master wants to write to us */
> >                       dev_dbg(&i2c_imx->adapter.dev, "write requested");
> > -                     i2c_slave_event(i2c_imx->slave, I2C_SLAVE_WRITE_REQUESTED, &value);
> > +                     i2c_imx_slave_event(i2c_imx,
> > +                                         I2C_SLAVE_WRITE_REQUESTED, &value);
> >
> >                       /* Slave receive */
> >                       ctl &= ~I2CR_MTX;
> > @@ -697,17 +731,20 @@ static irqreturn_t i2c_imx_slave_isr(struct imx_i2c_struct *i2c_imx,
> >       } else if (!(ctl & I2CR_MTX)) { /* Receive mode */
> >               if (status & I2SR_IBB) { /* No STOP signal detected */
> >                       value = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2DR);
> > -                     i2c_slave_event(i2c_imx->slave, I2C_SLAVE_WRITE_RECEIVED, &value);
> > +                     i2c_imx_slave_event(i2c_imx,
> > +                                         I2C_SLAVE_WRITE_RECEIVED, &value);
> >               } else { /* STOP signal is detected */
> >                       dev_dbg(&i2c_imx->adapter.dev,
> >                               "STOP signal detected");
> > -                     i2c_slave_event(i2c_imx->slave, I2C_SLAVE_STOP, &value);
> > +                     i2c_imx_slave_event(i2c_imx,
> > +                                         I2C_SLAVE_STOP, &value);
> >               }
> >       } else if (!(status & I2SR_RXAK)) { /* Transmit mode received ACK */
> >               ctl |= I2CR_MTX;
> >               imx_i2c_write_reg(ctl, i2c_imx, IMX_I2C_I2CR);
> >
> > -             i2c_slave_event(i2c_imx->slave, I2C_SLAVE_READ_PROCESSED, &value);
> > +             i2c_imx_slave_event(i2c_imx,
> > +                                 I2C_SLAVE_READ_PROCESSED, &value);
> >
> >               imx_i2c_write_reg(value, i2c_imx, IMX_I2C_I2DR);
> >       } else { /* Transmit mode received NAK */
> > @@ -748,6 +785,7 @@ static int i2c_imx_reg_slave(struct i2c_client *client)
> >               return -EBUSY;
> >
> >       i2c_imx->slave = client;
> > +     i2c_imx->last_slave_event = I2C_SLAVE_STOP;
> >
> >       /* Resume */
> >       ret = pm_runtime_get_sync(i2c_imx->adapter.dev.parent);
> > @@ -800,10 +838,17 @@ static irqreturn_t i2c_imx_isr(int irq, void *dev_id)
> >
> >       status = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2SR);
> >       ctl = imx_i2c_read_reg(i2c_imx, IMX_I2C_I2CR);
> > +
> >       if (status & I2SR_IIF) {
> >               i2c_imx_clear_irq(i2c_imx, I2SR_IIF);
> > -             if (i2c_imx->slave && !(ctl & I2CR_MSTA))
> > -                     return i2c_imx_slave_isr(i2c_imx, status, ctl);
> > +             if (i2c_imx->slave) {
> > +                     if (!(ctl & I2CR_MSTA)) {
> > +                             return i2c_imx_slave_isr(i2c_imx, status, ctl);
> > +                     } else if (i2c_imx->last_slave_event !=
> > +                                I2C_SLAVE_STOP) {
> > +                             i2c_imx_slave_finish_op(i2c_imx);
> > +                     }
> > +             }
> >               return i2c_imx_master_isr(i2c_imx, status);
> >       }
> >
> > --
> > 2.25.1
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

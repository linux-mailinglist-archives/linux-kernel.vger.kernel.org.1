Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9148F3039D9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403758AbhAZKIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbhAYS7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 13:59:20 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38682C061574;
        Mon, 25 Jan 2021 10:58:40 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id d13so28730232ioy.4;
        Mon, 25 Jan 2021 10:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kt98Zxjxdvda9nU7+qQ/tPa7beqCWkYKQe0yE/YifyY=;
        b=pF76wnnsMaKZmNMe0201KazhKfLUbXGJLXVVmGNAMZ1a+n7j2rVXQrqT3B/LLnXahk
         TVr7+yWaIuz0/zlCbADANejcDOHgarZMlGeLeqL5CoblxDGFhNO5AEbpWt8lZKpReO8z
         /hCGjZy/TtLddi22Yl4R44E3DpmdKPiPrkx2Yy1jv2EcqrEidqrJk80JnUgElfREs1ZR
         CnRdbjhp1CPSBbMBQtfWsSYKqljUydpFC2s6Eq3wKZiBSAFAXdLt3kEHJAfir9hZ5ENy
         ZR39HVQPUA/iKSpNxgZyeGeeVMjay1nXwgt7CmxnRIPCtY7hmpYCjdUf5lOa7p1trVfM
         Sh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kt98Zxjxdvda9nU7+qQ/tPa7beqCWkYKQe0yE/YifyY=;
        b=E88iKjFqGunk9At6dC0nHWBwMddfvZr11NYWdR4a5uJd11Bs45PVTIJdphSi9bY1IU
         yEKMOiPlVUO4RTFxKWCD64vQnaf1b2rJcP1Jjn7eTZ9t50PbnFvSK6RAxFfKJdY+b6Wf
         rmrhXvsqiKKMWzM/J70y5tCLTL0jSmGkNP+YilXcjXj8tDoFHpXxmZ2KlgdlJUAWSjQv
         PM51OlU7FmLmsBo+zz5jxJL8iMB2mMxjzmSSSy1DQSPK+1MpxR7xyCkPPU5VYb4VOTfe
         erNa6AMbWg8jIPJRm3nsrseKbAx5GkX/vSWOXCZrhUaYzlYk/cb6BQnCWWQJIdy+W3Fr
         KoUA==
X-Gm-Message-State: AOAM530cN20fExQuCieddpbTfOyQvJiwwhDOzMbRq5GsCxT3M1Uo1cwW
        uaR8EVkJaM+KBEcZbSgxXaIYHd0J3caSzdyYnho=
X-Google-Smtp-Source: ABdhPJwLtSQSvljhK2mwsZg969JS1snshVUrlhbgWGmgri95sZkvD7r2mQLv3UA6Rb51+P231ud/aspXgJS5mCpHafA=
X-Received: by 2002:a6b:2d7:: with SMTP id 206mr1503462ioc.197.1611601119564;
 Mon, 25 Jan 2021 10:58:39 -0800 (PST)
MIME-Version: 1.0
References: <20210125125458.1302525-1-mark.jonas@de.bosch.com> <20210125125458.1302525-2-mark.jonas@de.bosch.com>
In-Reply-To: <20210125125458.1302525-2-mark.jonas@de.bosch.com>
From:   Mark Jonas <toertel@gmail.com>
Date:   Mon, 25 Jan 2021 19:58:28 +0100
Message-ID: <CAEE5dN34ywfT9DUqwzrog_ujEANYioYxJbJ8M=8Om_-=7uJHcg@mail.gmail.com>
Subject: Re: [PATCH 1/1] mfd: da9063: Support SMBus and I2C mode
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Support Opensource <support.opensource@diasemi.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Adam.Thomson.Opensource@diasemi.com, stwiss.opensource@diasemi.com,
        marek.vasut@gmail.com,
        "RUAN Tingquan (BT-FIR/ENG1-Zhu)" <Tingquan.Ruan@cn.bosch.com>,
        "Streidl Hubert (BT-FIR/ENG1-Grb)" <Hubert.Streidl@de.bosch.com>,
        "Jonas Mark (BT-FIR/ENG1-Grb)" <Mark.Jonas@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I also intended to send a cover-letter but it was somehow lost on the
way. Here it is:

On an NXP i.MX6 Solo processor we are running an application which
makes use of real-time threads (SCHED_RR). In combination with a
DA9063 we experienced (rare) random shut-downs and reboots. We found
that the issue was caused by a combination of the (default) DA9063
SMBus mode and non-atomic I2C transactions of the i.MX6 I2C driver.
Because a transaction could be idle for longer than the SMBus clock
time-out due to a real-time thread the DA9063 would time-out and
receive the second half of the transaction as an unintended message.

The solution we are giving to review in this patch is to allow using
the I2C mode of the DA9063. We kindly ask for feedback and eventually
hope for an integration to the mainline.

Because we are on a vendor kernel we were not able to test this patch
on the current mainline kernel. Though, we tested a (very similar)
patch on our (close to mainline) Linux 4.14 and 5.4 vendor kernels.

Cheers,
Mark

On Mon, Jan 25, 2021 at 2:16 PM Mark Jonas <mark.jonas@de.bosch.com> wrote:
>
> From: Hubert Streidl <hubert.streidl@de.bosch.com>
>
> By default the PMIC DA9063 2-wire interface is SMBus compliant. This
> means the PMIC will automatically reset the interface when the clock
> signal ceases for more than the SMBus timeout of 35 ms.
>
> If the I2C driver / device is not capable of creating atomic I2C
> transactions, a context change can cause a ceasing of the the clock
> signal. This can happen if for example a real-time thread is scheduled.
> Then the DA9063 in SMBus mode will reset the 2-wire interface.
> Subsequently a write message could end up in the wrong register. This
> could cause unpredictable system behavior.
>
> The DA9063 PMIC also supports an I2C compliant mode for the 2-wire
> interface. This mode does not reset the interface when the clock
> signal ceases. Thus the problem depicted above does not occur.
>
> This patch makes the I2C mode configurable by device tree. The SMBus
> compliant mode is kept as the default.
>
> Signed-off-by: Hubert Streidl <hubert.streidl@de.bosch.com>
> Signed-off-by: Mark Jonas <mark.jonas@de.bosch.com>
> ---
>  Documentation/devicetree/bindings/mfd/da9063.txt |  7 +++++++
>  drivers/mfd/da9063-core.c                        |  9 +++++++++
>  drivers/mfd/da9063-i2c.c                         | 13 +++++++++++++
>  include/linux/mfd/da9063/core.h                  |  1 +
>  include/linux/mfd/da9063/registers.h             |  3 +++
>  5 files changed, 33 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mfd/da9063.txt b/Documentation/devicetree/bindings/mfd/da9063.txt
> index 8da879935c59..256f2a25fe0a 100644
> --- a/Documentation/devicetree/bindings/mfd/da9063.txt
> +++ b/Documentation/devicetree/bindings/mfd/da9063.txt
> @@ -19,6 +19,12 @@ Required properties:
>  - interrupts : IRQ line information.
>  - interrupt-controller
>
> +Optional properties:
> +
> +- i2c-mode : Switch serial 2-wire interface into I2C mode. Without this
> +  property the PMIC uses the SMBus mode (resets the interface if the clock
> +  ceases for a longer time than the SMBus timeout).
> +
>  Sub-nodes:
>
>  - regulators : This node defines the settings for the LDOs and BUCKs.
> @@ -77,6 +83,7 @@ Example:
>                 interrupt-parent = <&gpio6>;
>                 interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
>                 interrupt-controller;
> +               i2c-mode;
>
>                 rtc {
>                         compatible = "dlg,da9063-rtc";
> diff --git a/drivers/mfd/da9063-core.c b/drivers/mfd/da9063-core.c
> index df407c3afce3..baa1e4310c8c 100644
> --- a/drivers/mfd/da9063-core.c
> +++ b/drivers/mfd/da9063-core.c
> @@ -162,6 +162,15 @@ int da9063_device_init(struct da9063 *da9063, unsigned int irq)
>  {
>         int ret;
>
> +       if (da9063->i2cmode) {
> +               ret = regmap_update_bits(da9063->regmap, DA9063_REG_CONFIG_J,
> +                               DA9063_TWOWIRE_TO, 0);
> +               if (ret < 0) {
> +                       dev_err(da9063->dev, "Cannot enable I2C mode.\n");
> +                       return -EIO;
> +               }
> +       }
> +
>         ret = da9063_clear_fault_log(da9063);
>         if (ret < 0)
>                 dev_err(da9063->dev, "Cannot clear fault log\n");
> diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> index 3781d0bb7786..af0bf13ab43e 100644
> --- a/drivers/mfd/da9063-i2c.c
> +++ b/drivers/mfd/da9063-i2c.c
> @@ -351,6 +351,17 @@ static const struct of_device_id da9063_dt_ids[] = {
>         { }
>  };
>  MODULE_DEVICE_TABLE(of, da9063_dt_ids);
> +
> +static void da9063_i2c_parse_dt(struct i2c_client *client, struct da9063 *da9063)
> +{
> +       struct device_node *np = client->dev.of_node;
> +
> +       if (of_property_read_bool(np, "i2c-mode"))
> +               da9063->i2cmode = true;
> +       else
> +               da9063->i2cmode = false;
> +}
> +
>  static int da9063_i2c_probe(struct i2c_client *i2c,
>                             const struct i2c_device_id *id)
>  {
> @@ -366,6 +377,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
>         da9063->chip_irq = i2c->irq;
>         da9063->type = id->driver_data;
>
> +       da9063_i2c_parse_dt(i2c, da9063);
> +
>         ret = da9063_get_device_type(i2c, da9063);
>         if (ret)
>                 return ret;
> diff --git a/include/linux/mfd/da9063/core.h b/include/linux/mfd/da9063/core.h
> index fa7a43f02f27..866864c50f78 100644
> --- a/include/linux/mfd/da9063/core.h
> +++ b/include/linux/mfd/da9063/core.h
> @@ -77,6 +77,7 @@ struct da9063 {
>         enum da9063_type type;
>         unsigned char   variant_code;
>         unsigned int    flags;
> +       bool    i2cmode;
>
>         /* Control interface */
>         struct regmap   *regmap;
> diff --git a/include/linux/mfd/da9063/registers.h b/include/linux/mfd/da9063/registers.h
> index 1dbabf1b3cb8..6e0f66a2e727 100644
> --- a/include/linux/mfd/da9063/registers.h
> +++ b/include/linux/mfd/da9063/registers.h
> @@ -1037,6 +1037,9 @@
>  #define                DA9063_NONKEY_PIN_AUTODOWN      0x02
>  #define                DA9063_NONKEY_PIN_AUTOFLPRT     0x03
>
> +/* DA9063_REG_CONFIG_J (addr=0x10F) */
> +#define DA9063_TWOWIRE_TO                      0x40
> +
>  /* DA9063_REG_MON_REG_5 (addr=0x116) */
>  #define DA9063_MON_A8_IDX_MASK                 0x07
>  #define                DA9063_MON_A8_IDX_NONE          0x00
> --
> 2.25.1
>

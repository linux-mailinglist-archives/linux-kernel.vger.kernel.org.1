Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819C81C7346
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 16:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbgEFOsT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 10:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729108AbgEFOsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 10:48:19 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C94C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 07:48:18 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id 19so1946473oiy.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 07:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wDj5+tuZkrR7oNrhFt9atUhp/2FopkJwEnSLs3/dRt8=;
        b=NL61s/IE8eFnPePLN3nuUAK4eaP6MM3y2w4CzNYIdhGhoUmj5C8bunqphDdpHaouVa
         lqnpq/4XtxVVO+mzUickCYq9BEd1L+5zd2wDuxtw3mLZecF7jxGruEn1VXTQSJvH/esc
         ozZqVMVWm66x7U9TCr+2oJ3Rcat7yJFgS3GMQeuXl5vtO0nmJGTtqj+JYiZASXBG0M4v
         qqWtNiDDyVCpTFmWcHt59IikbanIVLl7mYsG0X021wQ39a9kfQUvqr40lbY7IIO+0NOP
         LwawsK2TTi6/SuDQcBF/bo4WGt9GfnkpF7msRIKBU0IGMKTOCaTqZmnB8bdsTRLYE7rf
         pWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wDj5+tuZkrR7oNrhFt9atUhp/2FopkJwEnSLs3/dRt8=;
        b=hzLOjdlHNo627XXwTGRjRMIuOsfAnu5QK1nckH/px56L0gWG+nKRNj4ZbrzwZoFe8M
         fgSYd91NOUTOvpCJhe3mqhfeI9pWvDwvRN7bPgW4Ha1l9Q2R6NazDpNY4NbyiaeqgNvx
         nlM7iYh8zdgBS5baENQeHiC0C76XfwJugaloRkvKumJ1svrgiIFFLJhYQR443PUT8dJu
         gRe2q1f7AQb8OU4CLN6cUqy2LPwSbYCWVJwRbbHcX+Gt1eSg3jqsgMbXlsdw49OYg6i1
         Ew6Xd1KU5ar75PNAYODcYNP1I+qwAbojmmz8l5ckPJ6o4NtmeMuTM0K38h1dFyeNU5wS
         gggQ==
X-Gm-Message-State: AGi0PubVWlRsTQEEIxym84Sxlv4RWERO0YF5tYLo5JnnpINFKDl44Az6
        n3NWylc7L8rhFgs7MwElWaIpzoI13YXDvt0uWKA7SA==
X-Google-Smtp-Source: APiQypLNUtStA5nMDnbX6HOFM0LGQaCEcidSi5vAAWVsLC9SK3lN1UJfYxfdDKcoZRx18eT3Y5ExcVKLSk6kP1N3Arw=
X-Received: by 2002:aca:1812:: with SMTP id h18mr2665993oih.133.1588776497531;
 Wed, 06 May 2020 07:48:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200505100129.104673-1-robert.foss@linaro.org>
 <20200505100129.104673-4-robert.foss@linaro.org> <20200505101729.GF18755@pengutronix.de>
In-Reply-To: <20200505101729.GF18755@pengutronix.de>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Wed, 6 May 2020 16:48:06 +0200
Message-ID: <CAG3jFyvvzk8n1+fkfS5h6TPpqMQ3sGXuJ1_yot1MKFRTcDkhnQ@mail.gmail.com>
Subject: Re: [PATCH v7 3/3] media: ov8856: Implement sensor module revision identification
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Maxime Ripard <maxime@cerno.tech>,
        linux-media <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Dongchun Zhu <dongchun.zhu@mediatek.com>,
        Fabio Estevam <festevam@gmail.com>,
        Tomasz Figa <tfiga@chromium.org>, Ben Kao <ben.kao@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Marco,

On Tue, 5 May 2020 at 12:17, Marco Felsch <m.felsch@pengutronix.de> wrote:
>
> Hi Robert,
>
> On 20-05-05 12:01, Robert Foss wrote:
> > Query the sensor for its module revision, and compare it
> > to known revisions.
> >
> > Currently 2A and 1B revision indentification is supported.
> >
> > Signed-off-by: Robert Foss <robert.foss@linaro.org>
> > ---
> >
> > - Changes since v3:
> >   * Actually add module revision 2A
> >
> > - Changes since v2:
> >   * Add module revision 2A
> >   * Sakari: Remove ov8856_check_revision()
> >   * Sakari: Stop EEPROM streaming mode
> >
> >  drivers/media/i2c/ov8856.c | 53 ++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 53 insertions(+)
> >
> > diff --git a/drivers/media/i2c/ov8856.c b/drivers/media/i2c/ov8856.c
> > index e6418a79801e..3c82c3e588d7 100644
> > --- a/drivers/media/i2c/ov8856.c
> > +++ b/drivers/media/i2c/ov8856.c
> > @@ -32,6 +32,19 @@
> >  #define OV8856_MODE_STANDBY          0x00
> >  #define OV8856_MODE_STREAMING                0x01
> >
> > +/* module revisions */
> > +#define OV8856_2A_MODULE             0x01
> > +#define OV8856_1B_MODULE             0x02
> > +
> > +/* the OTP read-out buffer is at 0x7000 and 0xf is the offset
> > + * of the byte in the OTP that means the module revision
> > + */
> > +#define OV8856_MODULE_REVISION               0x700f
> > +#define OV8856_OTP_MODE_CTRL         0x3d84
> > +#define OV8856_OTP_LOAD_CTRL         0x3d81
> > +#define OV8856_OTP_MODE_AUTO         0x00
> > +#define OV8856_OTP_LOAD_CTRL_ENABLE  BIT(0)
> > +
> >  /* vertical-timings from sensor */
> >  #define OV8856_REG_VTS                       0x380e
> >  #define OV8856_VTS_MAX                       0x7fff
> > @@ -1152,6 +1165,46 @@ static int ov8856_identify_module(struct ov8856 *ov8856)
> >               return -ENXIO;
> >       }
> >
> > +     ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
> > +                            OV8856_REG_VALUE_08BIT, OV8856_MODE_STREAMING);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret = ov8856_write_reg(ov8856, OV8856_OTP_MODE_CTRL,
> > +                            OV8856_REG_VALUE_08BIT, OV8856_OTP_MODE_AUTO);
> > +     if (ret) {
> > +             dev_err(&client->dev, "failed to set otp mode");
> > +             return ret;
> > +     }
> > +
> > +     ret = ov8856_write_reg(ov8856, OV8856_OTP_LOAD_CTRL,
> > +                            OV8856_REG_VALUE_08BIT,
> > +                            OV8856_OTP_LOAD_CTRL_ENABLE);
> > +     if (ret) {
> > +             dev_err(&client->dev, "failed to enable load control");
> > +             return ret;
> > +     }
> > +
> > +     ret = ov8856_read_reg(ov8856, OV8856_MODULE_REVISION,
> > +                           OV8856_REG_VALUE_08BIT, &val);
> > +     if (ret) {
> > +             dev_err(&client->dev, "failed to read module revision");
> > +             return ret;
> > +     }
> > +
> > +     dev_info(&client->dev, "OV8856 revision %x (%s) at address 0x%02x\n",
> > +             val,
> > +             val == OV8856_2A_MODULE ? "2A" :
> > +             val == OV8856_1B_MODULE ? "1B" : "unknown revision",
> > +             client->addr);
>
> Pls check the alignment here too.

Ack.

>
> Regards,
>   Marco
>
> > +
> > +     ret = ov8856_write_reg(ov8856, OV8856_REG_MODE_SELECT,
> > +                            OV8856_REG_VALUE_08BIT, OV8856_MODE_STANDBY);
> > +     if (ret) {
> > +             dev_err(&client->dev, "failed to exit streaming mode");
> > +             return ret;
> > +     }
> > +
> >       return 0;
> >  }
> >
> > --
> > 2.25.1

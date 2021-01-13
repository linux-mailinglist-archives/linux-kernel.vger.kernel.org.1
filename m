Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82F2F44C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 08:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbhAMG7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 01:59:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbhAMG7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 01:59:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B08C061575
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:58:53 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id g25so3043683wmh.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 22:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HwL4VtEmHEKSYqG0Wvuo3dQa7ufy0vjsTEWXXFOnu14=;
        b=CnqsXl9UR6w85yvNdQL0vLBU7n+ka9WgCSzhuPnh63gS7svyKH9TbaWEdN008kdcgm
         nEhgm615vMhPE76ZyPVOrwE1graAlb0iSk8+QF2z9FoyUOnNSZvm4A5M7eqEtPSFu0nO
         tYbs95sfEvBTrTQ9QrnG4FegciWkcfnaCaa1U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HwL4VtEmHEKSYqG0Wvuo3dQa7ufy0vjsTEWXXFOnu14=;
        b=F7KmvhBFQwqgUI5q4czz5yLq1sfHchrHSImTIL97UMnGrw8RVvpO+W0Z5XFqWPdT/7
         suigc1FZX6+piQYv7iQLs0tdL8EhZF+bW3X6bIrODR9fyBLyYmp6ZtuVc66EQNs1rg0/
         D9xYtiqRVfIic5dbeStTIi85rh/uCzPsTzHSUx27QwUOTe7IWyk5qrK4qOo5vul8oS/C
         KerxFxNvDqc/dfv92PAbeBhp19Bsj+EVFBF/uXVSLiHtw9JMIvMbMzpjEP7HDEklwza8
         28BAdB7pfvW485PP3ZAyCkmo+RIjv5QD47vAzRpy6h9NB63wWKvuqtPkKGfYMr6W0kBf
         uGBw==
X-Gm-Message-State: AOAM533PYGOb9ln9sPc5BKQk3nuqLYkw+h3DoJYNJLoKZesOcG8Ngaft
        Y+0lDeYvajTTCVOqYA1C77/7GutPTmGDVt1j1G0e4w==
X-Google-Smtp-Source: ABdhPJxJ2zKxWypWcN01Y4eovqmIhyQQ3G4CzLNK/AUV76xJBTd5zeoVZVdAEIhClMuvvC9i5OrUSe+LmtrXR8YHkck=
X-Received: by 2002:a1c:a145:: with SMTP id k66mr694572wme.18.1610521131935;
 Tue, 12 Jan 2021 22:58:51 -0800 (PST)
MIME-Version: 1.0
References: <20210107085942.2891525-1-yuhsuan@chromium.org>
 <20210107085942.2891525-2-yuhsuan@chromium.org> <e6c33a5f-1765-7cb6-8479-ff049992f2b7@collabora.com>
In-Reply-To: <e6c33a5f-1765-7cb6-8479-ff049992f2b7@collabora.com>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Wed, 13 Jan 2021 14:58:41 +0800
Message-ID: <CAGvk5Ppm_+twECMf2x6P4U24vkcwn7WPOCZtnjwNHG=CtmOenA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enric Balletbo i Serra <enric.balletbo@collabora.com> =E6=96=BC 2021=E5=B9=
=B41=E6=9C=8813=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8A=E5=8D=8812:34=E5=AF=
=AB=E9=81=93=EF=BC=9A
>
> Hi Yu-Hsuan,
>
> Thank you for the patch.
>
> On 7/1/21 9:59, Yu-Hsuan Hsu wrote:
> > It is not guaranteed that I2S RX is disabled when the kernel booting.
> > For example, if the kernel crashes while it is enabled, it will keep
> > enabled until the next time EC reboots. Reset I2S RX when probing to
> > fix this issue.
> >
> > Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>
> If I am not mistaken this is the four version of this patchset (see [1]).=
 Please
> prefix your patches with the proper version and maintain a changelog for =
them,
> otherwise makes difficult to follow all the discussions already done.
>
> [1]
> v1: https://lkml.org/lkml/2020/7/8/173
> v2: https://mailman.alsa-project.org/pipermail/alsa-devel/2020-July/17093=
3.html
> v3:
> https://patchwork.kernel.org/project/alsa-devel/patch/20210106050559.1459=
027-1-yuhsuan@chromium.org/
> v4: https://patchwork.kernel.org/project/alsa-devel/list/?series=3D410441
Sorry that I forgot to add version. Will add v5 in the next patch. Thanks!
>
> > ---
> >  sound/soc/codecs/cros_ec_codec.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_e=
c_codec.c
> > index f33a2a9654e7..28b3e2c48c86 100644
> > --- a/sound/soc/codecs/cros_ec_codec.c
> > +++ b/sound/soc/codecs/cros_ec_codec.c
> > @@ -1011,6 +1011,13 @@ static int cros_ec_codec_platform_probe(struct p=
latform_device *pdev)
> >       }
> >       priv->ec_capabilities =3D r.capabilities;
> >
> > +     /* Reset EC codec i2s rx. */
> > +     p.cmd =3D EC_CODEC_I2S_RX_RESET;
> > +     ret =3D send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S=
_RX,
> > +                                (uint8_t *)&p, sizeof(p), NULL, 0);
> > +     if (ret)
> > +             dev_warn(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
> > +
>
> My comment in the first version is still valid, I guess. This command was
> introduced later and with an old firmware I suspect this message will app=
ear on
> every boot, right? So, to solve the issue and get rid of this warn you're=
 forced
> to upgrade the firmware. Would make sense to handle returned error value =
to warn
> when the firmware needs to be updated and error and break when is really =
an error?
>
> We have mapped ec error codes to linux error codes. So, it should be poss=
ible now.
Oh, I didn't notice it. Thanks for the remind. I will work on it.
>
> Thanks,
>  Enric
>
> >       platform_set_drvdata(pdev, priv);
> >
> >       ret =3D devm_snd_soc_register_component(dev, &i2s_rx_component_dr=
iver,
> >

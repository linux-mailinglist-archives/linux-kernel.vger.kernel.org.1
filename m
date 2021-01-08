Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3572EECBD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 06:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbhAHE6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 23:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726793AbhAHE6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 23:58:44 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2C07C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 20:58:03 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id b23so4891113vsp.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 20:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W4rdGLSTxKDPfw75JgfkaBzk5kk79wjjJ9VA6MTDa2Q=;
        b=EBMZa6kBZYBFUvIxtYUIFiOOXtkDLs6tu3Tvx5QATngETYkJghg2EliH4XTOPu6Bt+
         0t0NHpFnagN3TCzOA5+FLEHim1DI7PQ+X692eSQBbEHYYGOPWws48yRbHkqKQ7+yhTug
         QUhLjTjv8/eAlumFy41A9Hy1hZxx9jD7xPBb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W4rdGLSTxKDPfw75JgfkaBzk5kk79wjjJ9VA6MTDa2Q=;
        b=uOc1NgatSRSP8w0m8jUdzYLDkC3/jYiFYq5eedFBCzYElb/eu+cLRPKSzG6BdYKalF
         l5+CkldDE4/v4gRsEMxt0NaGnWvjMCqwxhR6uadprbAv0J95BwIlIxuJzBIjFLrxpLTH
         G47LoAzcvMO37domfBNZIT6UaMcrn5EJN5bFsUynFVbv0C+iyUsG3Ptud0OqdHGsuvfZ
         2DxyC7B4qvUO81yVr04zkD/02rZ8Ij6yF3nvnKuNx1tgm1Fg7fimgv8WBe0b7ol4kb8N
         85nbY/MvG8QOoCZiHxicNn/XDEkZ8/rK5+9A3YsY/XlBJArTntWy3A9h83WaojW5l2VY
         mdGw==
X-Gm-Message-State: AOAM533WKPU+2ovvKxyJNcnb528fy1asCJAQ7bI+64fATI+0JiLT0kMk
        AimdCwCk6SWq3Zc6DhbQACuu39SpMMrG04PqIwA4Aw==
X-Google-Smtp-Source: ABdhPJyUCYN4dVE7lrXmBC6FacDWh+fEpOGViWqsFYTO/SaNqRzaLv9WnGjUVFdcO3x4xtbcyaLZOpuEZ4UuFIMfrG0=
X-Received: by 2002:a67:2287:: with SMTP id i129mr1529947vsi.15.1610081882763;
 Thu, 07 Jan 2021 20:58:02 -0800 (PST)
MIME-Version: 1.0
References: <20210107085942.2891525-1-yuhsuan@chromium.org> <20210107135459.GB4726@sirena.org.uk>
In-Reply-To: <20210107135459.GB4726@sirena.org.uk>
From:   Yu-Hsuan Hsu <yuhsuan@chromium.org>
Date:   Fri, 8 Jan 2021 12:57:51 +0800
Message-ID: <CAGvk5PqMCEib8Yr=V4SxT0BBMoC1+yGXm0y+52+LwC5dPQUVnA@mail.gmail.com>
Subject: Re: [PATCH 1/2] cros_ec_commands: Add EC_CODEC_I2S_RX_RESET
To:     Mark Brown <broonie@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Prashant Malani <pmalani@chromium.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        ALSA development <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown <broonie@kernel.org> =E6=96=BC 2021=E5=B9=B41=E6=9C=887=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:55=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Thu, Jan 07, 2021 at 04:59:41PM +0800, Yu-Hsuan Hsu wrote:
> > Add the new command EC_CODEC_I2S_RX_RESET in ec_codec_i2s_rx_subcmd,
> > which is used for resetting the EC codec.
>
> I think the request was to sync over all the commands that are supported
> in the EC rather than just split this one addition into a separate
> patch.
Got it. However, after running make_linux_ec_commands_h.sh to create
the new cros_ec_commands.h, I found there are lots of difference (1092
insertions(+), 66 deletions(-)). In addition, there are also some
redefined variables(most are in ./include/linux/usb/pd.h) causing the
compile error.

It seems not easy to sync cros_ec_commands.h. I'm afraid of breaking
something. Does anyone have any suggestion? Thanks.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1804329F61D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 21:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgJ2UYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 16:24:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgJ2UYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 16:24:22 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1499BC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:24:21 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id b12so1859572plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 13:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ACjSzpbrKtSuPAejOOu3PL/YyWi3MpWIsWw+F6TKD04=;
        b=QRzkEWXp/3RkpqhLZt/ufcjhIMlU42FOAduQF+sya7GKWTSOvDcvF+sSGgPWwRur7K
         apaGjzZOlXaZVyvvDlu/z4X3XlmtvjwRlWpFgkUb07/rAtNYQdjETqfehEf270n6kANi
         WzEzEzwn8aCEJaAR1HfsLKtnB/XRoIzEPcp1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ACjSzpbrKtSuPAejOOu3PL/YyWi3MpWIsWw+F6TKD04=;
        b=agOnNdHWNYZutZ30KcBeq5mIhQrqM9JatJqSnqdtPpZUFtBh2rIhhKhEe9vA5Je21/
         t8UTEDjyqPgki9ANPaZoypH97H5FK+3uXJrSkmO1OJm0+pp6CE2MxlavMULcPZMk4FPd
         r7bmPJfTTyKBGIsHtIKOGArcAfeG5FeYt2K0MiLQaECSG0QjcjO/KVW54X0JsG2/52Rl
         2JlaHxZiWUZpRNcGDSC2hhT1ICymJeD135yI8V0eUO5Sif50fMZQ8UC+I7XpqaRpXYCm
         AEG2CBe+h0Lq+bSwCcVdKhaR21SSjmHvBvs5venP0dwFWdnfg9P0z5c2+nULuBJSW7zy
         5Imw==
X-Gm-Message-State: AOAM533BNg7w0svp3mU72LgIaSnFp0v5PNSSIqYWKO/ejwy4s49uvnjL
        DqUZYJ2gMchAwVuw6r5hHYE/0g==
X-Google-Smtp-Source: ABdhPJwUT/Ff7p4k+wseDOBzd3E9yVEzssK3vFub2SSuP4NA2W/RLjj4gDG5AE2vx/QnEUwNoqq9nQ==
X-Received: by 2002:a17:902:b70f:b029:d6:5bcb:1b24 with SMTP id d15-20020a170902b70fb02900d65bcb1b24mr5646759pls.82.1604003060613;
        Thu, 29 Oct 2020 13:24:20 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id o15sm3900924pfd.16.2020.10.29.13.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 13:24:20 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAD=FV=U93bfZv_uLG0XFXtBBMrD7gg=L3ijnpPnOCgeeo=CqAg@mail.gmail.com>
References: <20201029011154.1515687-1-swboyd@chromium.org> <20201029011154.1515687-5-swboyd@chromium.org> <CAD=FV=U93bfZv_uLG0XFXtBBMrD7gg=L3ijnpPnOCgeeo=CqAg@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/bridge: ti-sn65dsi86: Update reply on aux failures
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Sean Paul <seanpaul@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>
To:     Doug Anderson <dianders@chromium.org>
Date:   Thu, 29 Oct 2020 13:24:18 -0700
Message-ID: <160400305868.884498.15370248590957087613@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2020-10-29 09:22:55)
> Hi,
>=20
> On Wed, Oct 28, 2020 at 6:12 PM Stephen Boyd <swboyd@chromium.org> wrote:
> >
> > We should be setting the drm_dp_aux_msg::reply field if a NACK or a
> > SHORT reply happens.
>=20
> I don't think you update the "reply" field for SHORT, right?  You just
> return a different size?

Correct.

>=20
>=20
> > diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/br=
idge/ti-sn65dsi86.c
> > index 6b6e98ca2881..19737bc01b8f 100644
> > --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> > @@ -909,10 +910,32 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_a=
ux *aux,
> >         ret =3D regmap_read(pdata->regmap, SN_AUX_CMD_STATUS_REG, &val);
> >         if (ret)
> >                 return ret;
> > -       else if ((val & AUX_IRQ_STATUS_NAT_I2C_FAIL)
> > -                || (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT)
> > -                || (val & AUX_IRQ_STATUS_AUX_SHORT))
> > -               return -ENXIO;
> > +
> > +       if (val & AUX_IRQ_STATUS_AUX_RPLY_TOUT) {
> > +               /*
> > +                * The hardware tried the message seven times per the D=
P spec
> > +                * but it hit a timeout. We ignore defers here because =
they're
> > +                * handled in hardware.
> > +                */
> > +               return -ETIMEDOUT;
> > +       }
> > +       if (val & AUX_IRQ_STATUS_AUX_SHORT) {
> > +               ret =3D regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &=
len);
> > +               if (ret)
> > +                       return ret;
>=20
> IIUC, your digging through the code showed that in order to fully
> handle the "SHORT" case you also needed to add support for
> "DP_AUX_I2C_WRITE_STATUS_UPDATE", right?

Oh yeah. If a short reply happens and it is aux over i2c then
drm_dp_i2c_msg_write_status_update() is called and
DP_AUX_I2C_WRITE_STATUS_UPDATE is set and then we try a transfer again.
We need to handle that type of request in this ti_sn_aux_transfer()
function.

>=20
> Even without handling "DP_AUX_I2C_WRITE_STATUS_UPDATE" though, this
> patch seems to be an improvement and I'd support landing it.
>=20
> Oh, I guess one other thing: I think this is all from code inspection,
> right?  You didn't manage to reproduce anything that would tickle one
> of these code paths?  Might be worth mentioning, even if "after the
> cut"?
>=20

Yes, just code inspection. I can add that detail to the commit text.

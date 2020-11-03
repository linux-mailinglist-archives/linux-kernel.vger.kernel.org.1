Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 767E22A3A82
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 03:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgKCCia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 21:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgKCCia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 21:38:30 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03474C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 18:38:30 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id t14so12518795pgg.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 18:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=z264cDYFI+SeiJ6z3FLe1vCBTpX+RvX219w85MXClXA=;
        b=VM5f6vS9Ds5kmcV7IbntoguOWe/gsnaaQQjAjT6piE/k16K/ngQwroHHuoNaiD5evP
         VRnDJDwgzXfscDZKJjaCyVUfNYfOMftRLj1N2u3zsu4b2U0NS03vZL5wu7aYHIpSsjQa
         +Z5YdGlpEXW/PauK5gcOtBrwihSxmRB8ydzNI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=z264cDYFI+SeiJ6z3FLe1vCBTpX+RvX219w85MXClXA=;
        b=Kzu/kg5XLi+V0iafKWEgrS9/YQxSVXYNbGJO5aIwDH1jyayeNX7HVj8B9WR7dOHmHt
         7VAEbweZls9FhJEra3pZFKsa9vl7iXC0BoMTwxbinoGkB0HSSApTqtwRt7o07YkuXO/U
         c/3hx+9fNOGnXB/vnWeuHb+Db1OQDXUmy6z+iL2fkmC5w58HiaVJAKdYYlNqvr91xzwd
         Wfpd5aMiFN2c6lHOqyWr0BSbsR9HTpmUbGH5TaKi50zPa3Vn0RYC/3cyZcCiSk0NG6Ey
         M1LIfpPO4QajIFRstqoE9xyVz7FdVYt8V8pzksF6VMOAbCCR4pVujGnujV6VmiivebNT
         6sMQ==
X-Gm-Message-State: AOAM5302q5j5kGglo8gjkUTsTD3VRe2kqsiJgyKoqjr5W+NXkH5w1cr4
        JNGgT1PTx+0k8yGEJXOm2cJG6g==
X-Google-Smtp-Source: ABdhPJxOkOF5LQQksAJsl+ExcPzpUCm/vLzwF2VQVdQNsL4wQRTYjH5fTzhbyNC1beTHBYjsxkR6sQ==
X-Received: by 2002:a17:90a:d584:: with SMTP id v4mr1422083pju.194.1604371109495;
        Mon, 02 Nov 2020 18:38:29 -0800 (PST)
Received: from chromium.org ([2620:15c:202:201:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id b67sm15041810pfa.151.2020.11.02.18.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 18:38:28 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <160436612483.884498.883110130131457033@swboyd.mtv.corp.google.com>
References: <20201030011738.2028313-1-swboyd@chromium.org> <20201101173741.GA1293305@ravnborg.org> <160436612483.884498.883110130131457033@swboyd.mtv.corp.google.com>
Subject: Re: [PATCH v2 0/4] drm/bridge: ti-sn65dsi86: Support EDID reading
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Douglas Anderson <dianders@chromium.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Date:   Mon, 02 Nov 2020 18:38:27 -0800
Message-ID: <160437110703.3965362.4640756202560708316@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2020-11-02 17:15:24)
> Quoting Sam Ravnborg (2020-11-01 09:37:41)
> > Hi Stephen.
> >=20
> > On Thu, Oct 29, 2020 at 06:17:34PM -0700, Stephen Boyd wrote:
> > > This patch series cleans up the DDC code a little bit so that
> > > it is more efficient time wise and supports grabbing the EDID
> > > of the eDP panel over the aux channel. I timed this on a board
> > > I have on my desk and it takes about 20ms to grab the EDID out
> > > of the panel and make sure it is valid.
> > >=20
> > > The first two patches seem less controversial so I stuck them at
> > > the beginning. The third patch does the EDID reading and caches
> > > it so we don't have to keep grabbing it over and over again. And
> > > finally the last patch updates the reply field so that short
> > > reads and nacks over the channel are reflected properly instead of
> > > treating them as some sort of error that can't be discerned.
> > >=20
> > > Stephen Boyd (4):
> > >   drm/bridge: ti-sn65dsi86: Combine register accesses in
> > >     ti_sn_aux_transfer()
> > >   drm/bridge: ti-sn65dsi86: Make polling a busy loop
> > >   drm/bridge: ti-sn65dsi86: Read EDID blob over DDC
> > >   drm/bridge: ti-sn65dsi86: Update reply on aux failures
> >=20
> > Series looks good. You can add my a-b on the full series.
> > Acked-by: Sam Ravnborg <sam@ravnborg.org>
> >=20
> > I can apply after Douglas have had a look at the patches he did not r-b
> > yet.
> >=20
> > Any chance we can convince you to prepare this bridge driver for use in
> > a chained bridge setup where the connector is created by the display
> > driver and uses drm_bridge_funcs?
> >=20
> > First step wuld be to introduce the use of a panel_bridge.
> > Then add get_edid to drm_bridge_funcs and maybe more helpers.
> >=20
> > Then natural final step would be to move connector creation to the
> > display driver - see how other uses drm_bridge_connector_init() to do so
> > - it is relatively simple.
> >=20
> > Should be doable - and reach out if you need some help.
> >=20
>=20
> I started to look at this and got stuck at ti_sn_bridge_get_bpp(). Where
> can I get the details of the bpc for the downstream bridge or panel? Is
> there some function that can tell this bridge what the bpc is for the
> attached connector? I see that td_mode_valid() in
> drivers/gpu/drm/bridge/tc358775.c stores away the bpc from the incoming
> drm_display_info pointer but I'm not sure that is correct because can't
> that be called for various and not necessarily the one we're using?

Looking closer I see that tc358775 doesn't store away the incoming
value, it derives a bpc from what comes in. I guess it isn't really a
good example for this problem.

I tried to hack around this and convert this driver to use bridge funcs
with Vinod's msm patch underneath but now the encoder is invalid. I
wonder if something is wrong with how the msm display driver drives the
bridge and connector? That TODO in ti_sn_bridge_attach() makes me think
something else needs fixing. I'll send another patch series tomorrow on
top of this one that kicks off the conversion to bridge connector so we
can discuss there.

[    4.577814] [drm:dpu_core_perf_crtc_update:397] [dpu error]crtc-49: fail=
ed to update bus bw vote
[    4.603697] panel-simple panel: error waiting for hpd GPIO: -6
[    4.613106] dsi_calc_pclk: forcing mdss_dsi lanes to 1
[    4.619070] dsi_link_clk_set_rate_6g: Failed to set rate pixel clk, -22
[    4.625883] msm_dsi_host_power_on: failed to enable link clocks. ret=3D-=
22
[    4.632784] dsi_mgr_bridge_pre_enable: power on host 0 failed, -22
[    4.646235] Unable to handle kernel NULL pointer dereference at virtual =
address 0000000000000370
[    4.655279] Mem abort info:
[    4.658249]   ESR =3D 0x96000006
[    4.661456]   EC =3D 0x25: DABT (current EL), IL =3D 32 bits
[    4.667047]   SET =3D 0, FnV =3D 0
[    4.670195]   EA =3D 0, S1PTW =3D 0
[    4.673430] Data abort info:
[    4.676401]   ISV =3D 0, ISS =3D 0x00000006
[    4.680347]   CM =3D 0, WnR =3D 0
[    4.683413] user pgtable: 4k pages, 39-bit VAs, pgdp=3D0000000104f18000
[    4.690033] [0000000000000370] pgd=3D0000000104f21003, p4d=3D0000000104f=
21003, pud=3D0000000104f21003, pmd=3D0000000000000000
[    4.700941] Internal error: Oops: 96000006 [#1] PREEMPT SMP
[    4.706672] Modules linked in: cdc_ether usbnet r8152 joydev mii
[    4.712866] CPU: 6 PID: 376 Comm: frecon Not tainted 5.10.0-rc2+ #5
[    4.719302] Hardware name: Google Lazor (rev1+) with LTE (DT)
[    4.725201] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=3D--)
[    4.731390] pc : ti_sn_bridge_enable+0xa4/0x7ec
[    4.736047] lr : ti_sn_bridge_enable+0x54/0x7ec
[    4.740704] sp : ffffffc0109db960
[    4.744119] x29: ffffffc0109db990 x28: ffffffd216acb000=20
[    4.749586] x27: ffffffd216854000 x26: ffffffd216acb000=20
[    4.755046] x25: ffffffd2164e89d0 x24: 0000000000000000=20
[    4.760508] x23: 0000000000000000 x22: ffffff8281de5080=20
[    4.765970] x21: ffffff8281de56f0 x20: ffffff8281de5670=20
[    4.771431] x19: ffffff8281de5090 x18: 0000000000000484=20
[    4.776893] x17: 0000000000000000 x16: 0000000000000001=20
[    4.782355] x15: 0000000000000010 x14: 0000000000000000=20
[    4.787816] x13: 00000000000013a8 x12: ffffff828208f950=20
[    4.793277] x11: ffffff82818e1d80 x10: 0000000000000000=20
[    4.798738] x9 : 0000000000000002 x8 : 0000000000000002=20
[    4.804200] x7 : ffffffc0109db978 x6 : 0000000000000001=20
[    4.809660] x5 : 0000000000000001 x4 : ffffffd2166b6388=20
[    4.815122] x3 : 0000000000000001 x2 : ffffffd216680dab=20
[    4.820584] x1 : 0000000000000010 x0 : ffffff8280ceac00=20
[    4.826046] Call trace:
[    4.828568]  ti_sn_bridge_enable+0xa4/0x7ec
[    4.832886]  drm_atomic_bridge_chain_enable+0x7c/0xa4
[    4.838095]  drm_atomic_helper_commit_modeset_enables+0x19c/0x23c
[    4.844360]  msm_atomic_commit_tail+0x308/0x6e8
[    4.849017]  commit_tail+0xa8/0x140
[    4.852608]  drm_atomic_helper_commit+0xf8/0x100
[    4.857354]  drm_atomic_commit+0x50/0x5c
[    4.861385]  drm_atomic_helper_set_config+0xcc/0xd4
[    4.866398]  drm_mode_setcrtc+0x280/0x5c0
[    4.870519]  drm_ioctl_kernel+0xa0/0x118
[    4.874549]  drm_ioctl+0x240/0x3dc

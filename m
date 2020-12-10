Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 762E02D6359
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 18:21:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404199AbgLJRUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 12:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390049AbgLJRTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 12:19:43 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA680C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:19:02 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id qw4so8372726ejb.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 09:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JPw5q0QI1aslQ3S5j3NtFm4xZxUibk26wUh96CSsLc8=;
        b=s+8tWdBz+59RGszYZqXNGR6JG75lGbwefdafKTzvL/ucnloGDh7JFpHV5fOpt2p3on
         O29MtV+2aIYrULwKkPeIBDdvCXc/PdjApJdnTen6g/h+3I52AAgWokVE9fGPT240SFvI
         g3C9wd1+4lGZvtra1FQybGk4y3/jsq9nITCmuDldvgRhYnYRdXG9cfa3wsXWpRrKMJAQ
         uqtLzQj8J11uR0Y4kdTZ8sK8G3HAU85C3gpKXQ3p2hHOTg+140rk8VvqXbsbqfPepGx8
         lSUmt39V2kQPxShTi8peP4nImOl3RwXAByLMbKVEP5A16dcAzkyv24nzV0q8RIzikVD0
         +3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JPw5q0QI1aslQ3S5j3NtFm4xZxUibk26wUh96CSsLc8=;
        b=Anzgx9sSvVFoZormDYwj8jO0DKKqac0KReFgBM8RXq1RGwjAlFyP73TwdiDTtH6L+n
         xeIADJIuZ5aU0TiV72hSM8oKcvqLNp60TtngXcmJTKSUrQzNIHIKU6bHm0Daw4lB+I7U
         /r2y7/u+AhTy52NCPXh/4QCqMoRPJiVhlm4DafdxhGf5xrBL6WW5XTxJLZHhTZLzy6Lz
         x5U688y7f3jATlIr1y+T112R2Z9TDlvZtCVNSY7d2dSbGSE8up08kEXLdjBymWDUpBDA
         8uCeWyxZXz+a1rOniqPk/MHO34Q4HOMq9aBsyeYH7EVgRTbIb07ZkLA0p02oCMO8pHNP
         N4Kg==
X-Gm-Message-State: AOAM532QsoPfpLbVKaJFhAuWqIn5EYym9e6f7lRAIGmLHSuVaLwzHBS4
        YjI1/7viTOqEwUtfgljGXXA=
X-Google-Smtp-Source: ABdhPJwsaVUGRPZPBcr6pTplSj7Iz+lWunLZqwjl4bZc07zU2TukkGM/PIPoqw69yst1jYYOWDTaFw==
X-Received: by 2002:a17:906:7146:: with SMTP id z6mr7279195ejj.379.1607620741295;
        Thu, 10 Dec 2020 09:19:01 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id b19sm5320797edx.47.2020.12.10.09.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 09:18:59 -0800 (PST)
Date:   Thu, 10 Dec 2020 18:18:59 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <X9JYgyKkCUWYPQuK@ulmo>
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <X891/LvEJT1bLtjH@ulmo>
 <X8/36HXL1IYPXA0J@builder.lan>
 <20201208235249.GD401619@phenom.ffwll.local>
 <X9EzYtuR+EwliYrv@builder.lan>
 <20201210101538.GD401619@phenom.ffwll.local>
 <X9JQeYim6TQIPD1P@ulmo>
 <CAKMK7uGGnt6A89OohW8mi4pSvjvemW-=_oAOFUVye+qxnO5W=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GwPEQ0dJ+CRTLRQk"
Content-Disposition: inline
In-Reply-To: <CAKMK7uGGnt6A89OohW8mi4pSvjvemW-=_oAOFUVye+qxnO5W=g@mail.gmail.com>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GwPEQ0dJ+CRTLRQk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 05:50:00PM +0100, Daniel Vetter wrote:
> On Thu, Dec 10, 2020 at 5:44 PM Thierry Reding <thierry.reding@gmail.com>=
 wrote:
> >
> > On Thu, Dec 10, 2020 at 11:15:38AM +0100, Daniel Vetter wrote:
> > > On Wed, Dec 09, 2020 at 02:28:18PM -0600, Bjorn Andersson wrote:
> > > > On Tue 08 Dec 17:52 CST 2020, Daniel Vetter wrote:
> > > >
> > > > > On Tue, Dec 08, 2020 at 04:02:16PM -0600, Bjorn Andersson wrote:
> > > > > > On Tue 08 Dec 06:47 CST 2020, Thierry Reding wrote:
> > > > > >
> > > > > > > On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wro=
te:
> > > > > > > > Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge,=
 provides
> > > > > > > > means of generating a PWM signal for backlight control of t=
he attached
> > > > > > > > panel. The provided PWM chip is typically controlled by the
> > > > > > > > pwm-backlight driver, which if tied to the panel will provi=
de DPMS.
> > > > > > > >
> > > > > > > > But with the current implementation the panel will refuse t=
o probe
> > > > > > > > because the bridge driver has yet to probe and register the=
 PWM chip,
> > > > > > > > and the bridge driver will refuse to probe because it's una=
ble to find
> > > > > > > > the panel.
> > > > > > >
> > > > > > > What you're describing is basically a circular dependency. Ca=
n't we get
> > > > > > > rid of that in some other way? Why exactly does the bridge dr=
iver refuse
> > > > > > > to probe if the panel can't be found?
> > > > > > >
> > > > > > > In other words, I see how the bridge would /use/ the panel in=
 that it
> > > > > > > forward a video stream to it. But how does the panel /use/ th=
e bridge?
> > > > > > >
> > > > > >
> > > > > > Yes, this is indeed a circular dependency between the component=
s.
> > > > > >
> > > > > > The involved parts are:
> > > > > > * the bridge driver that implements the PWM chip probe defers on
> > > > > >   drm_of_find_panel_or_bridge() failing to find the panel.
> > > > > > * the pwm-backlight driver that consumes the PWM channel probe =
defer
> > > > > >   because the pwm_chip was not registered by the bridge.
> > > > > > * the panel that uses the backlight for DPMS purposes probe def=
er
> > > > > >   because drm_panel_of_backlight() fails to find the pwm-backli=
ght.
> > > > > >
> > > > > > I looked at means of postponing drm_of_find_panel_or_bridge() to
> > > > > > drm_bridge_funcs->attach(), but at that time "deferral" would b=
e fatal.
> > > > > > I looked at registering the pwm_chip earlier, but that would de=
pend on a
> > > > > > guarantee of the pwm-backlight and panel driver to probe concur=
rently.
> > > > > > And the current solution of not tying the backlight to the pane=
l means
> > > > > > that when userspace decides to DPMS the display the backlight s=
tays on.
> > > > > >
> > > > > >
> > > > > > The proposed solution (hack?) means that DPMS operations happen=
ing
> > > > > > before the pwm-backlight has probed will be missed, so it's not=
 perfect.
> > > > > > It does however allow the backlight on my laptop to turn off, w=
hich is a
> > > > > > big improvement.
> > > > > >
> > > > > > But I'm certainly welcome to suggestions.
> > > > >
> > > > > Entirely hand-waving, why doesn't the following work:
> > > > >
> > > > > 1. driver for the platform device which is the bridge loads
> > > > > 2. that platform driver registers the pwm
> > > > > 3. it registers some magic for later on (more below)
> > > > > 4. panel driver has deferred loading until step 2 happened
> > > > > 5. panel driver registers drm_panel
> > > > > 6. the magic from step 3 picks up (after having been deferred for=
 a few
> > > > > times probably) grabs the panel, and sets up the actual drm_bridg=
e driver
> > > > >
> > > > > Everyone happy, or not? From the description it looks like the pr=
oblem
> > > > > that the pwm that we need for the backlight is tied to the same d=
river as
> > > > > the drm_bridge, and always torn down too if the drm_bridge setup =
fails
> > > > > somehow for a reason. And that reason is the circular dependency =
this
> > > > > creates.
> > > > >
> > > > > Now for the magic in step 3, there's options:
> > > > > - change DT to split out that pwm as a separate platform_device, =
that way
> > > > >   bridge and panel can load indepedently (hopefully)
> > > > >
> > > >
> > > > This is an i2c device, so describing it multiple times would mean we
> > > > have multiple devices with the same address...
> > > >
> > > > > - convert bridge to a multi-function device (mfd), essentially a =
way to
> > > > >   instantiate more devices with their drivers at runtime. Then th=
e actual
> > > > >   pwm and drm_bridge parts of your bridge driver bind against tho=
se
> > > > >   sub-functions, and can defer indepedently
> > > > >
> > > >
> > > > But, this sounds reasonable and would rely on the existing probe
> > > > deferral logic and if there's ever any improvements in this area we
> > > > would directly benefit from it.
> > > >
> > > > > - we could create a callback/wait function for "pls wait for any =
panel to
> > > > >   show up". Then your bridge driver could launch a work_struct wi=
th that
> > > > >   wait function, which will do the bridge setup once the panel ha=
s shown
> > > > >   up. The pwm will be registered right away. It's essentially han=
d-rolling
> > > > >   EPROBE_DEFERRED for work_struct in drm/panel. Maybe we might ev=
en have
> > > > >   that exported from the driver core, e.g.
> > > > >
> > > > > register_bridge_fn(struct work *)
> > > > > {
> > > > >   do_wait_probe_defer();
> > > > >   panel =3D drm_of_find_panel_or_bridge();
> > > > >   if (!panel) {
> > > > >           schedule_work(); /* want to restart the work so it can =
be stopped on driver unload */
> > > > >           return;
> > > > >   }
> > > > >
> > > > >   /* we have the panel now, register drm_bridge */
> > > > > }
> > > > >
> > > > > - cobble something together with component.c, but that's more for
> > > > >   collecting unrelated struct device into a logical one than spli=
tting it
> > > > >   up more.
> > > > >
> > > > > tldr; I think you can split this loop here at the bridge by untan=
gling the
> > > > > pwm from the drm_bridge part sufficiently.
> > > >
> > > > Yes, it seems like a reasonable path forward. But I wanted some inp=
ut
> > > > before refactoring the whole thing.
> > >
> > > Yeah it's unfortunately a bit of work. But I think it's the proper
> > > approach since EPROBE_DEFERRED is fundamentally linked to struct devi=
ce
> > > and bound drivers. So we do need a struct device for every part in our
> > > dependency graph to make sure we can resolve the dependencies all
> > > correctly with reprobing.
> >
> > Can we not turn things around and make the bridge driver independent of
> > the panel? To me it sounds like these loosely follow a hierarchy where
> > it makes sense to probe the bridge first, without any dependency on the
> > panel that's being used. I think this makes sense because this example
> > shows that panels may depend on resources provided by the bridge. In
> > this case it's a backlight, but I could also imagine the bridge
> > providing some sort of I2C bus that the panel driver may need to use in
> > order to query the panel's EDID.
> >
> > The way I imagine that this would work is that the panel would probe
> > separately from the bridge driver but use the OF graph to look up the
> > bridge that has the resources (backlight, I2C bus, ...) that it needs to
> > proceed. As long as that bridge has not been probed, the panel would
> > need to defer, which is the standard way that provider/consumer pairs
> > work. Once the bridge has probed, the panel can also proceed to probe
> > because it can now find the necessary resources.
>=20
> Yeah that might be the other option, treat the panel as a bridge (we
> have the panel bridge already), then build up the entire thing as a
> bridge chain. Not sure how much this is "just works" territory or not.
>=20
> > The only missing thing that I don't think we have right now is a way for
> > the panel to then register with its parent bridge, but that should be
> > fairly easy to add. I suspect this might get a bit tricky around the
> > connector state paths because we can now get into a situation where the
> > connector can have a complete bridge path set up but may be missing the
> > panel (which I think in the current model can't happen because the
> > bridge always relies on the panel being there, although it sounds like
> > it could happen with Daniel's proposal as well). But that ultimately is
> > not very different from how we deal with monitors on more standard
> > interfaces like HDMI or DP where we emit a hotplug event when the
> > monitor becomes available, so perhaps that infrastructure could be
> > reused for this.
>=20
> Generally we try really hard to make sure panels are always there and
> never hotplug in/out. Not sure whether there's even userspace/desktops
> relying on this. So hotplugging the panel later on does not sound
> good. Bjorn's patch here does a light version of that with the
> backlight, and we're having this sprawling thread because that's bit
> suboptimal - userspace could boot real fast, see there's no backlight,
> and then not expose backlight adjusters if we're unlucky.

Yeah, hotplugging a panel would certainly be unusual. But I have never
come across userspace that distinguishes by connector type in how it
deals with hotplug events, so this might just work.

Irrespective of that, it shouldn't be necessary to hotplug panels. We
could always have the connector driver defer probe as long as the
bridge/panel chain has not been fully established. That way the whole
DRM device wouldn't show up until the panel has been connected, so it
should never be necessary to hotplug the panel in that case.

Thierry

--GwPEQ0dJ+CRTLRQk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SWIIACgkQ3SOs138+
s6Gz/w/6AiShb8lYpodbkvXqf37Rt0QFid/mSeJuolgkk54A8wche6INGnc2SIjO
wK6LPJa2cf4rj3VeYF1K9GBbqnO88HZZrq0wd/xUCy/dB+kiX7EgzeUWqKmyXAtE
9WSC+/WVkO47NmRx8LBCLbAMyVFzkfO5p2qnHKDp271ZXQPnQPt0R4WbWlpmiSGv
vAafOjhd2KY6l2DGm2OX/xr7ChfgbsL2GIArIFuMP+sFXmUBADpBckVwQRoDb0ro
cNKfM4F67Ms5pG1fXHpMhGvSnmc0/7kmQKBoD6M+k0HzR577EVMrAWP6GXjtFJTG
UDUTL/mysG3MDwIE6r9nCCO8DKuecGE1975t305IbS/dpG2U11R5nPVPUUMVKN5s
4gyDnHXd1lFpvxY4J8y2CueRR91l4UUf9krYgOu7q0TEABJyoBoX5ruy2IZU0vyv
TRPVBDMojIfZNyWh46bMk2COuyppg8AAdTQzL9zTTgvodLmZ7LNSiYjNVRZlYBoH
2S4UPUDzNvGMzmGntDSvJNP/vXNwYcLdyVszNRfgdCmh17i89lLLhnd5oCZ+ARvg
X7EccEc2biJ237YIrVxJ9UJONtwBMJmkBGJU9wFheTKX6ymKi5w/apRKU7dkWwFK
Wg5oPeFeOIPM/ATpFK3doZWyZd69Hbt4bnRRdjR+cnnTvD/lU6c=
=EGWI
-----END PGP SIGNATURE-----

--GwPEQ0dJ+CRTLRQk--

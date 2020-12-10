Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 001592D625E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392022AbgLJQpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730966AbgLJQp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:45:27 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85B2C0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:44:46 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id i24so6196311edj.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=D7qGOy5sRaDyW/18Lu+hSWavvFfxmpu3mSmxH5/lQ2E=;
        b=cj7L89ACcIesxLFLM3wRgziyhfvY57tBTtsTYgyNtpKHZKHkAY4qgV2fgFHCYYrxeT
         s4RLZo0aGDdh+f+haodrkqJMb7KEIhq5yHm3GtwT8oc7RSQ90+6nn509iKi1a/7Kki5B
         qHbd6zeRvHg0F44Lc8iB6163dVqc8ZkzFrIeC/yG5WTIy+pUvGPW0YuQty7ozDJzZMCA
         QCPx/1MvF4zttEl8YPQNVzy2HiQ6qIfwwLdWs6r/XewTWeZgnQeH/Ir2UMruh47euy9K
         soeUOXqnHgWrvqI9xbedCMDVAaCQETeiq/8/0ll05mq9w3nmVC5aAjYQvU56y1GeYlyU
         cWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D7qGOy5sRaDyW/18Lu+hSWavvFfxmpu3mSmxH5/lQ2E=;
        b=PjmfotHfsfV6IkwUEp7LBxE7ujhze6r8R7B8wozzfAGn0Y/SbC5jfv/bqnaqhAb32g
         Y8DISCmz+XGYump7moruuy08FMyf4p/92t3aafazLOofsrQlHys+BgzGxCe6aYZ4J2S0
         QPV74uf7egVPzDecLksIVn7l2Y9sUTxp8YFr1AXL21Q8EaRU53psqKQxpeZV0sTws/aw
         zApRpdcU04NKYbTW27TIAms1EcwPXU4u2ngiXAydkjBhvC97tr/pDHsD1LC7IOGdTAH9
         CTuAR7zELbv+M8q2tssUJX+XTDSK9Y5FB3CUIPVjUQdof42XP0LScQIdhsUJ3VE93yFM
         qW+A==
X-Gm-Message-State: AOAM532+sYQQ+GONloBnaJdGH0qBgNjlautTWGUZ1Tz5LMZ2HMzRVTVx
        24y60Ac65ZAdnofrnJX+I9o=
X-Google-Smtp-Source: ABdhPJxd19hsZ9tkkIYTKl4OSSiBCbLIF44tka5hYsAsUQmkRkmIUDrNyZdUMCsLh5PIz/vXPI/7bA==
X-Received: by 2002:aa7:c388:: with SMTP id k8mr7589950edq.36.1607618685326;
        Thu, 10 Dec 2020 08:44:45 -0800 (PST)
Received: from localhost ([62.96.65.119])
        by smtp.gmail.com with ESMTPSA id j5sm5348727edl.42.2020.12.10.08.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:44:42 -0800 (PST)
Date:   Thu, 10 Dec 2020 17:44:41 +0100
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/panel: Make backlight attachment lazy
Message-ID: <X9JQeYim6TQIPD1P@ulmo>
References: <20201208044446.973238-1-bjorn.andersson@linaro.org>
 <X891/LvEJT1bLtjH@ulmo>
 <X8/36HXL1IYPXA0J@builder.lan>
 <20201208235249.GD401619@phenom.ffwll.local>
 <X9EzYtuR+EwliYrv@builder.lan>
 <20201210101538.GD401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="t0ueH6HsCTZAt5GB"
Content-Disposition: inline
In-Reply-To: <20201210101538.GD401619@phenom.ffwll.local>
User-Agent: Mutt/2.0.3 (a51f058f) (2020-12-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--t0ueH6HsCTZAt5GB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 10, 2020 at 11:15:38AM +0100, Daniel Vetter wrote:
> On Wed, Dec 09, 2020 at 02:28:18PM -0600, Bjorn Andersson wrote:
> > On Tue 08 Dec 17:52 CST 2020, Daniel Vetter wrote:
> >=20
> > > On Tue, Dec 08, 2020 at 04:02:16PM -0600, Bjorn Andersson wrote:
> > > > On Tue 08 Dec 06:47 CST 2020, Thierry Reding wrote:
> > > >=20
> > > > > On Mon, Dec 07, 2020 at 10:44:46PM -0600, Bjorn Andersson wrote:
> > > > > > Some bridge chips, such as the TI SN65DSI86 DSI/eDP bridge, pro=
vides
> > > > > > means of generating a PWM signal for backlight control of the a=
ttached
> > > > > > panel. The provided PWM chip is typically controlled by the
> > > > > > pwm-backlight driver, which if tied to the panel will provide D=
PMS.
> > > > > >=20
> > > > > > But with the current implementation the panel will refuse to pr=
obe
> > > > > > because the bridge driver has yet to probe and register the PWM=
 chip,
> > > > > > and the bridge driver will refuse to probe because it's unable =
to find
> > > > > > the panel.
> > > > >=20
> > > > > What you're describing is basically a circular dependency. Can't =
we get
> > > > > rid of that in some other way? Why exactly does the bridge driver=
 refuse
> > > > > to probe if the panel can't be found?
> > > > >=20
> > > > > In other words, I see how the bridge would /use/ the panel in tha=
t it
> > > > > forward a video stream to it. But how does the panel /use/ the br=
idge?
> > > > >=20
> > > >=20
> > > > Yes, this is indeed a circular dependency between the components.
> > > >=20
> > > > The involved parts are:
> > > > * the bridge driver that implements the PWM chip probe defers on
> > > >   drm_of_find_panel_or_bridge() failing to find the panel.
> > > > * the pwm-backlight driver that consumes the PWM channel probe defer
> > > >   because the pwm_chip was not registered by the bridge.
> > > > * the panel that uses the backlight for DPMS purposes probe defer
> > > >   because drm_panel_of_backlight() fails to find the pwm-backlight.
> > > >=20
> > > > I looked at means of postponing drm_of_find_panel_or_bridge() to
> > > > drm_bridge_funcs->attach(), but at that time "deferral" would be fa=
tal.
> > > > I looked at registering the pwm_chip earlier, but that would depend=
 on a
> > > > guarantee of the pwm-backlight and panel driver to probe concurrent=
ly.
> > > > And the current solution of not tying the backlight to the panel me=
ans
> > > > that when userspace decides to DPMS the display the backlight stays=
 on.
> > > >=20
> > > >=20
> > > > The proposed solution (hack?) means that DPMS operations happening
> > > > before the pwm-backlight has probed will be missed, so it's not per=
fect.
> > > > It does however allow the backlight on my laptop to turn off, which=
 is a
> > > > big improvement.
> > > >=20
> > > > But I'm certainly welcome to suggestions.
> > >=20
> > > Entirely hand-waving, why doesn't the following work:
> > >=20
> > > 1. driver for the platform device which is the bridge loads
> > > 2. that platform driver registers the pwm
> > > 3. it registers some magic for later on (more below)
> > > 4. panel driver has deferred loading until step 2 happened
> > > 5. panel driver registers drm_panel
> > > 6. the magic from step 3 picks up (after having been deferred for a f=
ew
> > > times probably) grabs the panel, and sets up the actual drm_bridge dr=
iver
> > >=20
> > > Everyone happy, or not? From the description it looks like the problem
> > > that the pwm that we need for the backlight is tied to the same drive=
r as
> > > the drm_bridge, and always torn down too if the drm_bridge setup fails
> > > somehow for a reason. And that reason is the circular dependency this
> > > creates.
> > >=20
> > > Now for the magic in step 3, there's options:
> > > - change DT to split out that pwm as a separate platform_device, that=
 way
> > >   bridge and panel can load indepedently (hopefully)
> > >=20
> >=20
> > This is an i2c device, so describing it multiple times would mean we
> > have multiple devices with the same address...
> >=20
> > > - convert bridge to a multi-function device (mfd), essentially a way =
to
> > >   instantiate more devices with their drivers at runtime. Then the ac=
tual
> > >   pwm and drm_bridge parts of your bridge driver bind against those
> > >   sub-functions, and can defer indepedently
> > >=20
> >=20
> > But, this sounds reasonable and would rely on the existing probe
> > deferral logic and if there's ever any improvements in this area we
> > would directly benefit from it.
> >=20
> > > - we could create a callback/wait function for "pls wait for any pane=
l to
> > >   show up". Then your bridge driver could launch a work_struct with t=
hat
> > >   wait function, which will do the bridge setup once the panel has sh=
own
> > >   up. The pwm will be registered right away. It's essentially hand-ro=
lling
> > >   EPROBE_DEFERRED for work_struct in drm/panel. Maybe we might even h=
ave
> > >   that exported from the driver core, e.g.
> > >=20
> > > register_bridge_fn(struct work *)
> > > {
> > > 	do_wait_probe_defer();
> > > 	panel =3D drm_of_find_panel_or_bridge();
> > > 	if (!panel) {
> > > 		schedule_work(); /* want to restart the work so it can be stopped o=
n driver unload */
> > > 		return;
> > > 	}
> > >=20
> > > 	/* we have the panel now, register drm_bridge */
> > > }
> > >=20
> > > - cobble something together with component.c, but that's more for
> > >   collecting unrelated struct device into a logical one than splittin=
g it
> > >   up more.
> > >=20
> > > tldr; I think you can split this loop here at the bridge by untanglin=
g the
> > > pwm from the drm_bridge part sufficiently.
> >=20
> > Yes, it seems like a reasonable path forward. But I wanted some input
> > before refactoring the whole thing.
>=20
> Yeah it's unfortunately a bit of work. But I think it's the proper
> approach since EPROBE_DEFERRED is fundamentally linked to struct device
> and bound drivers. So we do need a struct device for every part in our
> dependency graph to make sure we can resolve the dependencies all
> correctly with reprobing.

Can we not turn things around and make the bridge driver independent of
the panel? To me it sounds like these loosely follow a hierarchy where
it makes sense to probe the bridge first, without any dependency on the
panel that's being used. I think this makes sense because this example
shows that panels may depend on resources provided by the bridge. In
this case it's a backlight, but I could also imagine the bridge
providing some sort of I2C bus that the panel driver may need to use in
order to query the panel's EDID.

The way I imagine that this would work is that the panel would probe
separately from the bridge driver but use the OF graph to look up the
bridge that has the resources (backlight, I2C bus, ...) that it needs to
proceed. As long as that bridge has not been probed, the panel would
need to defer, which is the standard way that provider/consumer pairs
work. Once the bridge has probed, the panel can also proceed to probe
because it can now find the necessary resources.

The only missing thing that I don't think we have right now is a way for
the panel to then register with its parent bridge, but that should be
fairly easy to add. I suspect this might get a bit tricky around the
connector state paths because we can now get into a situation where the
connector can have a complete bridge path set up but may be missing the
panel (which I think in the current model can't happen because the
bridge always relies on the panel being there, although it sounds like
it could happen with Daniel's proposal as well). But that ultimately is
not very different from how we deal with monitors on more standard
interfaces like HDMI or DP where we emit a hotplug event when the
monitor becomes available, so perhaps that infrastructure could be
reused for this.

Thierry

--t0ueH6HsCTZAt5GB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl/SUHUACgkQ3SOs138+
s6Hq8hAAvtBfhwQ0WT163p0Ift7Mgv9TJ2XRlCWEG/TZtezzE3pKP/JtnwRd7g94
CIRNOTYzoQGyc+Kne0FOAvAQzOLSZsPqzQcpiVJZqwgBcP529VmwY2HaWBIL6TGP
nZToU5BIIwdTKWg8MkI/iV0r4YVoZTv0eflzRpyDANPVWlk40kCftf69RXDvn19K
obmdmSha3QlA1Mx4zwwYBGeSAvi95GFr7sQ8r2bpGKij0fkPbynF6W2Os/JRDVwM
PAMeZ4yjdXyqPEs2WmBkqOvcfnG7Wq2I/TWCj3P/QaPRKke4I/TBtWABI2ViyfKr
/i+icwPV2b16FQOFXRUacs7ALJAm698aDN+ukda1Cvfqt5JYF1X3UTNRCU1EwHB7
X0Q9KJQJ1BT+T1FkZrjd4tOjZI1ONYJ4YE8cBz4OaIZjEzSr4fYuYmgGhxG3NTpv
qENnGRHXRYtJIwX7Ld7mON8rWZFMzKeh8jtHEJl+I06MQ8cgtr+VxF3vt96SocWG
3yjJhaxkm5+ohmgMxmtZNAXajof8iUDTIzur/Vnn2wHcaU5X3sbvLwvWjXFyi0RT
nAr+T0d0/I3VKcWRdAxQ/10BCGz+hBPNtNdejer5fZZ2ZqBweoIyZzpPCMpxIwp6
1rwv1+8jnC8udc7INeDA5PJXwicFR7bKHmiUYyyrSNntOdQlZYM=
=b6Ms
-----END PGP SIGNATURE-----

--t0ueH6HsCTZAt5GB--

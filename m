Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEB2B28D6ED
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 01:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388661AbgJMXR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 19:17:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727344AbgJMXR5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 19:17:57 -0400
Received: from kernel.org (unknown [104.132.1.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A7520B1F;
        Tue, 13 Oct 2020 23:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602631077;
        bh=UQ1kTWTCvomm7q0TZd9VPzHpHgnguOcIZu5JIN7IRpY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=DFcN8qVOV4J2yI4znV6kmlilndnh2Ne6YdgO13yzegnqrxHEX1N40a2B2r1ZtCVu0
         cBmQBzxX9ApPMcKW2Yygot3ZUIgCN5Io0+IqvUeEWBD31eENWsRuWbwYrPJeNPNmGF
         c/SIgXvCS5TFk63eACfY14qL/LqPVkf8QcXTwA3Y=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <O0S7HQ.34QHSNHJ7JWJ2@crapouillou.net>
References: <20200915123818.13272-1-paul@crapouillou.net> <20200915123818.13272-3-paul@crapouillou.net> <20200924202237.GJ1223313@ravnborg.org> <O0S7HQ.34QHSNHJ7JWJ2@crapouillou.net>
Subject: Re: [PATCH 2/3] drm/ingenic: Reset pixclock rate when parent clock rate changes
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        od@zcrc.me, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Sam Ravnborg <sam@ravnborg.org>
Date:   Tue, 13 Oct 2020 16:17:55 -0700
Message-ID: <160263107570.310579.5439811142598502777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Paul Cercueil (2020-09-25 05:29:12)
> >>  +static int ingenic_drm_update_pixclk(struct notifier_block *nb,
> >>  +                                unsigned long action,
> >>  +                                void *data)
> >>  +{
> >>  +   struct ingenic_drm *priv =3D drm_nb_get_priv(nb);
> >>  +
> >>  +   switch (action) {
> >>  +   case PRE_RATE_CHANGE:
> >>  +           mutex_lock(&priv->clk_mutex);
> >>  +           priv->update_clk_rate =3D true;
> >>  +           drm_crtc_wait_one_vblank(&priv->crtc);
> >>  +           return NOTIFY_OK;
> >>  +   default:
> >>  +           mutex_unlock(&priv->clk_mutex);
> > Any risk the POST_RATE_CHANGE or ABORT_RATE_CHANGE may go missing so=20
> > we
> > fail to unlock the mutex?
> > I think not but wanted to make sure you had thought about it.
>=20
> My assumption was that you always get POST_RATE_CHANGE or=20
> ABORT_RATE_CHANGE. But I am not 100% sure about that.
>=20
> Michael, Stephen: is it safe to assume that I will always get notified=20
> with POST_RATE_CHANGE or ABORT_RATE_CHANGE, after I got notified with=20
> PRE_RATE_CHANGE?
>=20

I think one or the other will happen. Of course, the notifiers are sort
of shunned so if you can avoid using notifiers entirely it would be
better.

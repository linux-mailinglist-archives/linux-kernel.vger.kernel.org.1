Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0B2B5E14
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 12:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgKQLNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 06:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:42680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbgKQLNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:13:40 -0500
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B4E4A221FD
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605611620;
        bh=V0x+1pEXNBlvGUPnKAReGNwIfbkuR60mZL6nJ7gbrnQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=dv0evZp0cTeljFd/OiTsuDTJEZxffLbMi1q++hlVJwJe8P/rJ9MyRD7mYisMeI2pN
         2Cabpf7UjyeGWM5UaQEnsn9EIG+83vLeFylFZSYEgvrpWT/hkfXOwbLzgpQfw/w+2Y
         UmOFA7EIONfb1VILj3n4OXFQrM/7/k/uBL+fqbn8=
Received: by mail-ej1-f49.google.com with SMTP id gj5so1364022ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 03:13:39 -0800 (PST)
X-Gm-Message-State: AOAM531lfU4JrigfFrzw8e5ITwk1NThOJMGGHi5NE85A2rxdxXTbKubf
        XjTTDAdo2f/NtT3yCPNCpl3OyryFgpvT5t2yxYg=
X-Google-Smtp-Source: ABdhPJymrgfvDJlgkyYhZ5Wb8RW+1mCW3euZsQjWepsg9t0L4FnHN9gM+xXqCtB9tgGllPRjsB6hbrWMq4BPBPwvF+E=
X-Received: by 2002:a17:906:491a:: with SMTP id b26mr19730991ejq.385.1605611618119;
 Tue, 17 Nov 2020 03:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20201116181400.543718-1-krzk@kernel.org> <3e91fe4dd8437ffbb02bdae85c7028dafc356df8.camel@pengutronix.de>
In-Reply-To: <3e91fe4dd8437ffbb02bdae85c7028dafc356df8.camel@pengutronix.de>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 17 Nov 2020 12:13:26 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeHAGF8iu8=D=n9Zrqurc7KWumw+d3bL2GoBWVJC7wsUw@mail.gmail.com>
Message-ID: <CAJKOXPeHAGF8iu8=D=n9Zrqurc7KWumw+d3bL2GoBWVJC7wsUw@mail.gmail.com>
Subject: Re: [PATCH] drm/imx: depend on COMMON_CLK to fix compile tests
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Nov 2020 at 11:56, Philipp Zabel <p.zabel@pengutronix.de> wrote:
>
> On Mon, 2020-11-16 at 19:14 +0100, Krzysztof Kozlowski wrote:
> > The iMX DRM drivers use Common Clock Framework thus they cannot be built
> > on platforms without it (e.g. compile test on MIPS with RALINK and
> > SOC_RT305X):
> >
> >     /usr/bin/mips-linux-gnu-ld: drivers/gpu/drm/imx/imx-ldb.o: in function `imx_ldb_encoder_disable':
> >     imx-ldb.c:(.text+0x400): undefined reference to `clk_set_parent'
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Thank you, but could this be added to
>
> config DRM_IMX_LDB
>
> instead?
>
> The core DRM_IMX code does not use the Common Clock Framework directly.
> DRM_IMX_TVE already depends on COMMON_CLK because it implements a clock.

You're right, I even wanted to add it there but somehow it landed in
the main entry... Thanks, I'll send a v2.

Best regards,
Krzysztof

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF828D247
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 18:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgJMQbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 12:31:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:49456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726120AbgJMQbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 12:31:15 -0400
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FB4252A3;
        Tue, 13 Oct 2020 16:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602606675;
        bh=dRijSgEyBy6ZAp9cCvHlNIDpK5rlfDlo0Lv/jtqaFVU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=iNB0OcKQmhvjrF55BmI6Kvk4p0CQoGA2yiu+tVndqvEVCnGukwrmoXLyAalb1FMsD
         mSV+vBje8anL7KySSfEB3XXYXVed7XOB2nTkf1fFYnKnD7yECwEooWlZXKAnrqdEz2
         3KBeuRLZNtfxDH/78N0UN4qKatyYAFD/4PDloiPg=
Received: by mail-ej1-f46.google.com with SMTP id e22so684997ejr.4;
        Tue, 13 Oct 2020 09:31:14 -0700 (PDT)
X-Gm-Message-State: AOAM531E8HoO0Vi0UC8OgMyNydXFEoXBD0KQWJOuU82i2imdbKNpev2a
        Vzr48Prz+q7kHrSMVmwt8T4KH4l8JhZd20F/aH8=
X-Google-Smtp-Source: ABdhPJwz7juX7IdTZi8kPH/dHOM6/REimE/2i4AbT2oe4ZTSOV3ZaikFqaE5bl34hKql+van/iUfFD7dl/Ily66bxLE=
X-Received: by 2002:a17:906:1a11:: with SMTP id i17mr530289ejf.381.1602606672676;
 Tue, 13 Oct 2020 09:31:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200920195749.26952-1-krzk@kernel.org> <20200920195749.26952-2-krzk@kernel.org>
 <20200922065154.GH25109@dragon> <CAJKOXPemE-mHdp-OAOMi5xQvTcW4k-f1aMcmX10zFLFFTRMv2Q@mail.gmail.com>
In-Reply-To: <CAJKOXPemE-mHdp-OAOMi5xQvTcW4k-f1aMcmX10zFLFFTRMv2Q@mail.gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 13 Oct 2020 18:31:00 +0200
X-Gmail-Original-Message-ID: <CAJKOXPc8CU1FCA1DuHeJBOgbCeD5Wj-OcLdECWy=4ZUF5igFdg@mail.gmail.com>
Message-ID: <CAJKOXPc8CU1FCA1DuHeJBOgbCeD5Wj-OcLdECWy=4ZUF5igFdg@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] arm64: dts: imx8mq-librem5: align GPIO hog names
 with dtschema
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Sep 2020 at 16:24, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 22 Sep 2020 at 08:52, Shawn Guo <shawnguo@kernel.org> wrote:
> >
> > On Sun, Sep 20, 2020 at 09:57:48PM +0200, Krzysztof Kozlowski wrote:
> > > dtschema expects GPIO hogs to end with 'hog' suffix.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > Ping me after dtschema gets accepted.
>
> Hi Shawn,
>
> Happened just now, in dt-schema repo:
> https://github.com/devicetree-org/dt-schema/pull/47

The dtschema was accepted in September. Can you pick up this patch?

Best regards,
Krzysztof

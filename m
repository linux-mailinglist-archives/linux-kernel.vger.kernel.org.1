Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8264727E2E8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725873AbgI3HuR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725535AbgI3HuR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:50:17 -0400
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 187C8207F7;
        Wed, 30 Sep 2020 07:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601452216;
        bh=XMkG4CRcSUmqrUkqWbqF30W5YmNW2OrB0+Qepd8DgkA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ezIfisKv6W2CuL3d1P6dUrGxSfaaZ77FNyLgngc/wgfBnBHUp4z17ymWQqLbb2RFo
         yady0QyoiSFBjL/Kk5zpqKPWJhVtL0vQDMOCakmOeCkakOu8N1Jp3G1Fpr6lymgyEy
         l68H5s4ghX2qOA8r2Ki6tzj4/jXvx40k66tCs2ds=
Received: by mail-ej1-f41.google.com with SMTP id u21so1419378eja.2;
        Wed, 30 Sep 2020 00:50:16 -0700 (PDT)
X-Gm-Message-State: AOAM532BiByiBqyOu3eOJMmZPDzH6lJ/WTGheB8zvGKFghAILGGfe2XG
        FpZ13XcmqfVToen2ELPrVJQOnhh54pzZADeGThw=
X-Google-Smtp-Source: ABdhPJwHhACx43/+PmnGhf5MTFazuCpDBORXLcYkJ0K6Hty3Vz1pREf6ZJc9SBid/dw0iuTNb9zXDzoSqTHETpY9e9A=
X-Received: by 2002:a17:906:491:: with SMTP id f17mr1507972eja.454.1601452214499;
 Wed, 30 Sep 2020 00:50:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com> <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
 <20200930072542.GC13876@Asurada-Nvidia>
In-Reply-To: <20200930072542.GC13876@Asurada-Nvidia>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 30 Sep 2020 09:50:03 +0200
X-Gmail-Original-Message-ID: <CAJKOXPeV6+CW1jX_55yXAS=uANPGm9oup_NoYkobuQenuoddzw@mail.gmail.com>
Message-ID: <CAJKOXPeV6+CW1jX_55yXAS=uANPGm9oup_NoYkobuQenuoddzw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function tegra_get_memory_controller
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, digetx@gmail.com,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Sep 2020 at 09:31, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
>
> Hi Krzysztof,
>
> On Wed, Sep 30, 2020 at 09:21:39AM +0200, Krzysztof Kozlowski wrote:
> > On Wed, 30 Sep 2020 at 02:35, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> > >
> > > This can be used by both tegra-smmu and tegra20-devfreq drivers.
> > >
> > > Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> > > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > > ---
> > >
> > > Changelog
> > > v1->v2
> > >  * N/A
> > >
> > >  drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
> > >  include/soc/tegra/mc.h    |  1 +
> > >  2 files changed, 24 insertions(+)
> > >
> > > diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > > index ec8403557ed4..09352ad66dcc 100644
> > > --- a/drivers/memory/tegra/mc.c
> > > +++ b/drivers/memory/tegra/mc.c
> > > @@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> >
> > > +struct tegra_mc *tegra_get_memory_controller(void)
> > > +{
> >
> > Add kerneldoc and mention dropping of reference to the device after use.
>
> I am abort to use Dmitry's devm_ one in my next version:
> https://github.com/grate-driver/linux/commit/2105e7664063772d72fefe9696bdab0b688b9de2
>
> Could I just skip the kerneldoc part? Otherwise, would you please
> tell me which kerneldoc file I should update?

His version is almost the same as yours so it does not matter - you
declare an exported function, so you need to document it. kerneldoc
goes to the C file.
https://elixir.bootlin.com/linux/latest/source/Documentation/doc-guide/kernel-doc.rst

Best regards,
Krzysztof

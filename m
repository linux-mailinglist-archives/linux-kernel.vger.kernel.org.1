Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC9627E2A0
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgI3HbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3HbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:31:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CA5C061755;
        Wed, 30 Sep 2020 00:31:15 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id j7so487664plk.11;
        Wed, 30 Sep 2020 00:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bwOTOwH4axl9LqPJmEo0RmLkZED4KKjttxbY58nlHVU=;
        b=ekxIJCZIESz5WSSsGf4/UfvtntXZpRaljNG8C88ia6EAPRAFmIhV+DTBBhuzHywGcI
         lbwQCkdhE6oB6NBNUaVy3F3Fnx/iYQUvqnQYXRFhlJS3fqeJgTaa/GtmBG7rO4c7qszV
         ZXpwT9F7D059JXWsKS3rDyxvB2rqeCltH1/ULMohSMyocoZHBajSxiR4ekNysVM6UPwh
         TA/U6o7KL3qJYlmtBK1ZkhoBJG1r4nnMmmR9R4Jg+myiIZWWn94ydCcZiPGTSzyFPtLG
         UwAuh4bPvS4FBkpwpACWcOWzD+NcR6Zfv3QwY8D/9XXbOD0nqYfhspMf6Z1sLQXqvh/x
         k7CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bwOTOwH4axl9LqPJmEo0RmLkZED4KKjttxbY58nlHVU=;
        b=ljfQKp2D5iKqXHM93H01V81VkhRlalspGClJwSKPSAp+hKzG/pfZFRLv7Xw2e8+GMR
         QeIHogek2h0fNS/kbrmykDGbAdqCLIOT/wG78Lv21lWr/M+JAAxA+oDzu48agWdQ8TXZ
         zPDE0mQ6YVprX0tN6wN4X45n4DM/S8OWa42nkayaI7Hzsf1Y2+P8uer37oc+luFNgrC6
         oHOyW7sRUMaE7IoGXGJszwgJoDmrIWJTDmy7G2E48FnLuK7teI1BGh80yYTB6+wzVKJv
         X1B0gKop2pVlHT/n8Fe9t52Y06+QfdiAgy4ifkYsKC1RuLZQld7zMMCnhPZv5/4hX+Qj
         qcCg==
X-Gm-Message-State: AOAM5302ZTF8M25iv5e8/x2XGxPXK50Vo7MjKu3V3J8QPmOnFF9R5H93
        ItG7H1XW+VdMxRzVKuLS9TA=
X-Google-Smtp-Source: ABdhPJwXuia3lh7dWuGxNLtu/8GKrMOmIAmVZsKyyiPZgKjMbUATljSUXVN3+rgD+15l0PNAx7d6mw==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr1410705pjb.162.1601451074777;
        Wed, 30 Sep 2020 00:31:14 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id y16sm1370254pfb.154.2020.09.30.00.31.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Sep 2020 00:31:14 -0700 (PDT)
Date:   Wed, 30 Sep 2020 00:25:43 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, digetx@gmail.com,
        vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] memory: tegra: Add helper function
 tegra_get_memory_controller
Message-ID: <20200930072542.GC13876@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-2-nicoleotsuka@gmail.com>
 <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJKOXPeye7b0j1oB21JmBwc277_1RYWQ0SC0Otf+F62HK=sjjA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Wed, Sep 30, 2020 at 09:21:39AM +0200, Krzysztof Kozlowski wrote:
> On Wed, 30 Sep 2020 at 02:35, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> >
> > This can be used by both tegra-smmu and tegra20-devfreq drivers.
> >
> > Suggested-by: Dmitry Osipenko <digetx@gmail.com>
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > ---
> >
> > Changelog
> > v1->v2
> >  * N/A
> >
> >  drivers/memory/tegra/mc.c | 23 +++++++++++++++++++++++
> >  include/soc/tegra/mc.h    |  1 +
> >  2 files changed, 24 insertions(+)
> >
> > diff --git a/drivers/memory/tegra/mc.c b/drivers/memory/tegra/mc.c
> > index ec8403557ed4..09352ad66dcc 100644
> > --- a/drivers/memory/tegra/mc.c
> > +++ b/drivers/memory/tegra/mc.c
> > @@ -42,6 +42,29 @@ static const struct of_device_id tegra_mc_of_match[] = {
> >  };
> >  MODULE_DEVICE_TABLE(of, tegra_mc_of_match);
> 
> > +struct tegra_mc *tegra_get_memory_controller(void)
> > +{
> 
> Add kerneldoc and mention dropping of reference to the device after use.

I am abort to use Dmitry's devm_ one in my next version:
https://github.com/grate-driver/linux/commit/2105e7664063772d72fefe9696bdab0b688b9de2

Could I just skip the kerneldoc part? Otherwise, would you please
tell me which kerneldoc file I should update?

Thanks

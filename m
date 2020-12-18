Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DB032DDEEF
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 08:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732934AbgLRHPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 02:15:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726851AbgLRHPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 02:15:39 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1DEC06138C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:14:58 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id iq13so819777pjb.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 23:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5uBH5KsWopbV7FffwP9cu3qwTCPbWsa/gpWuvPcUSsg=;
        b=QAa+QgBNWGXQOzLHcEttslyMX7yfVRFnmsie63URsvH5GVYmCfqLASAvZuwYX9MIET
         eDmE1hBXyewXRMKiWj91RDHrjpb/kMVBkEeGid+6WGS4/m50KcVQrRCW8T8QrPc/NQ/n
         xkFA8qANdUY/ZMDZ1U10ACf2taGB60mF9xbpsuylhp3HoF/iXl+pGW94NzxojOGrxEL+
         jbM/5E7N+gPH/W3t8wPwMcbtn6s1VbaU8LAIXwc8wN+nbdu3UYGXyxVvioFI2s3fGdha
         qUWYb/n/DIAy3pLKM/lOTXvtnloCMYB9AUwFndWYRMY4bs1NSawqpvTYjUnjhU9MTH8e
         72jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5uBH5KsWopbV7FffwP9cu3qwTCPbWsa/gpWuvPcUSsg=;
        b=ZRmhjCR/15hU6CuOXlXn5487xGVBux4hV8LR2SqYWFoaGTHvM9lS87mnFNyPPf5IbG
         RNZJIDuLH5TIeQLUERPYVF/AF19mkMJ8FBFUrlKDzEO5HnD/6etCzzpCwBLY+aMKejvr
         gGzze8JSfftJwK1Sve2GDC3cjExuF3nIOfLZSqKe7Pq8Fpr8rb1Z816m1LekoQt3J68G
         00L9aWZsPnrgAIkuDFLI4nclheFgazTUfVeuFikhL//Y+T3QHHhoFigjK32960UrqMzJ
         JAZEi1J8Te5C0kK0CQJTseH5/1Jdm7gdXPWv8r8HUP6MRc1FK6/VCq/dn7oV2MzltZMm
         UytQ==
X-Gm-Message-State: AOAM530MhchVGvec07522yfIY9REQmCEkoUzaRVQAIvzG5iuFiH3C3/u
        yuH40Cxo+P0TPDoBSgbQ9gGKtw==
X-Google-Smtp-Source: ABdhPJxh6Vc+BoEp2nvhSj4YmNHb7ku5mMkwmUaQUKeZHUbZ9rzCY6oJyHfeJDwsJp2g/i5HDfSMhg==
X-Received: by 2002:a17:902:8f94:b029:da:d168:4443 with SMTP id z20-20020a1709028f94b02900dad1684443mr3091172plo.57.1608275697958;
        Thu, 17 Dec 2020 23:14:57 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id j20sm7721737pfd.106.2020.12.17.23.14.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 23:14:57 -0800 (PST)
Date:   Fri, 18 Dec 2020 12:44:55 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 00/48] Introduce core voltage scaling for NVIDIA
 Tegra20/30 SoCs
Message-ID: <20201218071455.vdeozvvnmkjtrejt@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217180638.22748-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-20, 21:05, Dmitry Osipenko wrote:
> Introduce core voltage scaling for NVIDIA Tegra20/30 SoCs, which reduces
> power consumption and heating of the Tegra chips. Tegra SoC has multiple
> hardware units which belong to a core power domain of the SoC and share
> the core voltage. The voltage must be selected in accordance to a minimum
> requirement of every core hardware unit.

Please submit the OPP changes separately (alone), it will never get
merged this way. Send fixes at the top, any features you want later in
the series. It is fine for you to base your series of patches which
are under review, you just need to mention that in your cover letter
for your platform's patchset.

-- 
viresh

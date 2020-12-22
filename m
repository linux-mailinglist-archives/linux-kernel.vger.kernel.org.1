Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 900DA2E07DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgLVJQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726072AbgLVJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:16:41 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F17C0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:16:00 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id h186so8132965pfe.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 01:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=l8QALzA4i8zX7B1di+fsQ9pXz5BTZwpSgw/mRJC9G3I=;
        b=iNpi5UGBLQA73+p7sshoUk2MKXQ6+B7bN+nLc+PLyRS7Qzc6JQHE5LPyrHGQxOzXY1
         uOtxbpfxB2whAININqJ4SNPQdP/iqcNVaDMTfpwi6jlirHg+TpXFAk8EUfaM+f2LThpO
         ITwA/t+QLxo/gtfFoU6Y1t6N7t+IeYiN4NQyBRuiWeJo1VWI5Wqkou8CGRhI3Ddi6WMb
         hnbtCuE/ASxcgiGOFPqWP03O9KQV73qnkGAu5hCruEh7I3wNKYJN03dx+O01l7K/zD/k
         7cuSdAfi+Fx9eHduQ+ALtP2fw1WpzfC4YnQ/pZ7skehvj4ca2ag34R983WJCOmU+lJGf
         g+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l8QALzA4i8zX7B1di+fsQ9pXz5BTZwpSgw/mRJC9G3I=;
        b=UHf3O011DBC5nH6SIRNy8JPNbfkrmh5WLhNpZ6HFE8OpcZ8p95LLdEv39QfX9sMLvB
         dF5kxvG99QaCc17BLo5h/7wuOfV3uHi3leDEYNWLxOltfJq54uLTedR27CVcH0T30UmO
         hW+DpvGqWq1Y0cZKlJVRGp3xdb4vyHZPTr6w7lGX/NadPIYTcakSF1CCZdRt8YRvi5jC
         D9LI8kmAK9ycHb570DVGSq5FNvToWrD/Eat+wRpAsUUY2tQD5rgkONnXclOOol5gPg8n
         uMIbq4HXjRKstxVqqu4ld+i2wdy41B4OfYhoV4Kq6JfTFYDB5imO6kUwh9wgMT9fNjCa
         WlCg==
X-Gm-Message-State: AOAM532lRgNZh5f1X4Ta23cqH+G/b2yEyvi+IqyT8jCb+nhWe18bhOUx
        cG8DLOsXYzPYi2nNp1ul8+Pf0Q==
X-Google-Smtp-Source: ABdhPJzoRmGGLI8WVPnxM7oud4VBQbrA5PgTbrGlwdy+hH6OXaJYRZjRb0UVH5lYi+efCVdlFZN7eA==
X-Received: by 2002:a62:1d0a:0:b029:1a9:8b33:a1bf with SMTP id d10-20020a621d0a0000b02901a98b33a1bfmr19012878pfd.32.1608628560561;
        Tue, 22 Dec 2020 01:16:00 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id t9sm13088468pgh.41.2020.12.22.01.15.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2020 01:15:59 -0800 (PST)
Date:   Tue, 22 Dec 2020 14:45:58 +0530
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
Message-ID: <20201222091558.mhqf4oytviwc6b3h@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
 <20201218071455.vdeozvvnmkjtrejt@vireshk-i7>
 <c0976db7-ae66-740c-d95f-501d81c99fa0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0976db7-ae66-740c-d95f-501d81c99fa0@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-20, 16:51, Dmitry Osipenko wrote:
> Alright, although I haven't pretended that v2 patches should be merged
> right away since they are fundamentally different from v1, and thus, all
> patches need to be reviewed first.

I agree. I have done some basic review for the stuff.

> If the current OPP changes look good to you, then please give yours r-b
> to the patches. Thanks in advance!

r-b-y isn't required as they will go through my tree itself. So if everyone is
happy with the idea, please submit the patches separately (fixes, improvements,
devm_*, etc).

-- 
viresh

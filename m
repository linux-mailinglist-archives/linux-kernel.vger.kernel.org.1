Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0972E2428
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Dec 2020 05:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727195AbgLXELK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 23:11:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLXELJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 23:11:09 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62CF9C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:10:29 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id v19so822217pgj.12
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 20:10:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ikVtzUE4uXfeBqBtO4dtx3e4Xq8je8+SD0cDc4uZBxs=;
        b=xKGy+n1lH2OICjFJVUJHiGY8JDjFs+zA4vzxAXCrDFU5l1ZTdld+A8Dk+fxxlBFKgV
         E5eTKopVBqQdPsabWi5F9J/MB+2RweNkKJA1c0sbK6mCgzTnGBOjkv+GqmMLoGYyu06a
         ttpiVX3Z/L0LrlZD/4+woKfb/vMPCPF3T1xEccKhgioNE8CzX8igBpfeY1gMcA4Qg9rv
         Ss6rrRCqT7Sk981NvHHGrFAi9IRp2TL7qu6Ba/gO3G7fUcc4yRkVj93tiPezXSd9aNKo
         dnFyrclYl+eyqxmrRvvK1Bya4PdheEaOLJsOwz+YPu0I+RU1N2lZffE0lmArD5KkOuec
         MNVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ikVtzUE4uXfeBqBtO4dtx3e4Xq8je8+SD0cDc4uZBxs=;
        b=otRl4xqszNSnvbBuRd7Kx7Qw9u+WS0VSzolNAUtXYWbgsYSY7q7iZrZKonctW2d9mW
         CKCanT9n8syPLknlR/rn0QblR4v5jkXe0s6n8lSLD7JtFA6KnH6hn7XXaQQM1C2XwmWT
         f/egLU7lI5JeQ/hrip4wDsgdPZ1quc9i7qf5GLNxpqgVdUyuO1hceiHWSydVOrmSVu+v
         xIaziwsk0e+zB59b8NkryCjTtn4qFJHQXeS7ZDDFRdXzMwFg9mVsShrDpmQu5CWfgybG
         RlgJ//D/uwnYlO1mScUaCegBQwVJOGjwmHC+FRM3eYduIRMsozmFCiYXhLVzPsOmOb5x
         Bc/A==
X-Gm-Message-State: AOAM533PC/T20pDGxk+dUOu+9Hw/rnC6aZ9CiA9PIljbYybGRCRJ8Aht
        YeieTqadb1O3sY1BFBoQUR54Mw==
X-Google-Smtp-Source: ABdhPJxF6QsBhYJyHEedTrrFWO0Opl0+2E1UHe5wyQBjNtRXMjwHp5sAJCn6P8PZcaaJH8z8YxT1Gw==
X-Received: by 2002:a62:644c:0:b029:1a1:f568:d2d9 with SMTP id y73-20020a62644c0000b02901a1f568d2d9mr26738163pfb.64.1608783028602;
        Wed, 23 Dec 2020 20:10:28 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id s5sm1012447pju.9.2020.12.23.20.10.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2020 20:10:27 -0800 (PST)
Date:   Thu, 24 Dec 2020 09:40:25 +0530
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
Subject: Re: [PATCH v2 15/48] opp: Support set_opp() customization without
 requiring to use regulators
Message-ID: <20201224041025.mlxsbl2yrxyqt7yh@vireshk-i7>
References: <20201217180638.22748-1-digetx@gmail.com>
 <20201217180638.22748-16-digetx@gmail.com>
 <20201223060101.v2qihvvgsmpahg24@vireshk-i7>
 <ea025b0f-bb2a-d075-4c8e-45831fa9cd93@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea025b0f-bb2a-d075-4c8e-45831fa9cd93@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-12-20, 23:38, Dmitry Osipenko wrote:
> Well, there is no "same structure", the opp_table->set_opp_data is NULL
> there.

Right, I saw that yesterday. What I meant was that we need to start allocating
the structure for this case now.

-- 
viresh

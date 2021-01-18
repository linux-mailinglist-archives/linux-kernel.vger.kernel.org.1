Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75CA92F9EF2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 13:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403790AbhARL77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 06:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390936AbhARLq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 06:46:57 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EE9C061573
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:46:17 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 11so10044661pfu.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 03:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gzlwaPkTlP/ZmJOY5fxJliyLPQaZ8STG1NZSoSJX0e8=;
        b=AMrcT41venp9oOMLrdEMRufFZ13OH9ME5n2x86QPk+pJHIuS38ApYkNDA66+piA1ZE
         gyJglzZ56sTOHHhoCMqkQhuFBbRj6o5Z6R330X1ZBwvlVrg12Vj1VCXbRG5WUz+en+Sm
         ZcNZFE4TcnZi6PkMNFaL/poXIVQd2O7oNVTXDBFeOXYXlbFqUjZyP0HIvwjc/197jQE4
         At3I4s1SBtF19Z8xVdvYn9Znk1CvC0GRfWQaNyCdFp4hTL4MJG+NZrkFBXSP5m8G8IS2
         EsCFtpsuTheyhw5l4K88KP27axqL1IWUaBB2UPxwWc9YAHUpk9ececnBa1yKbszkcVHv
         MiZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gzlwaPkTlP/ZmJOY5fxJliyLPQaZ8STG1NZSoSJX0e8=;
        b=BjZyn2O2X6/5AJJqI0zgSNKzdfGB6GlYElMK97CB2rn/UTd6HEACQBH+4YhXWdrVhT
         GoyFv5BzpuXROEo3uN1SnSCYc0AfPJYBetRMMCH6ooHubr6tQjpg0IeJd0pZa2mHafZ0
         ffR5QV7XJ6Hz0419nTOdifHPFtnE2o9iUDCU+1XbypYFsxl8dk/ZEpKMSaYHqstE27pd
         +t0wKBByM+WY1lH3Ev5L2Bvyh8xPH7UwSp5/FbWqKG1qQkPuaKGjHe5siLQamUSPD2nY
         0P6Rkm0mo1tNggR7+3fefnLSuNJbzpzJx/mxKUISGvY50yJp8t2ohYh1+CiyfI746CxE
         U99w==
X-Gm-Message-State: AOAM532MSnyp+WE51hPssCDapNN/uyvqTuzBEMUufiMYLPvsxGg/Pldq
        ZdCsStxr1KFUbe0QD+9+abnkXQ==
X-Google-Smtp-Source: ABdhPJziOaaMILfmkjkhAuMyBMxzmMtTG6xMcp/+fEGOYCNqSgENDW5xJ+AakPLst9AI0D1btKh8ZA==
X-Received: by 2002:a62:4e12:0:b029:1b6:7eac:c740 with SMTP id c18-20020a624e120000b02901b67eacc740mr8044883pfb.65.1610970376621;
        Mon, 18 Jan 2021 03:46:16 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id d8sm11839722pjm.30.2021.01.18.03.46.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Jan 2021 03:46:15 -0800 (PST)
Date:   Mon, 18 Jan 2021 17:16:13 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Yangtao Li <tiny.windzz@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 00/12] OPP API fixes and improvements
Message-ID: <20210118114613.fzq7nkrdfm53upkr@vireshk-i7>
References: <20210118005524.27787-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118005524.27787-1-digetx@gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-21, 03:55, Dmitry Osipenko wrote:
> Hi,
> 
> This series fixes problems and adds features to OPP API that are required
> for implementation of a power domain driver for NVIDIA Tegra SoCs.
> 
> It is a continuation of [1], where Viresh Kumar asked to factor OPP
> patches into a separate series. I factored out the patches into this
> series, addressed the previous review comments and re-based patches
> on top of [2], which replaced some of my patches that added resource-managed
> helpers.
> 
> [1] https://patchwork.ozlabs.org/project/linux-tegra/list/?series=221130
> [2] https://lore.kernel.org/linux-pm/20210101165507.19486-1-tiny.windzz@gmail.com/

Hi Dmitry,

I have applied 9 out of 12 patches already. Thanks.

-- 
viresh

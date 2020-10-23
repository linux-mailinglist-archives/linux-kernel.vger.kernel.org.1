Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718E4296B35
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375926AbgJWI2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 04:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S375408AbgJWI2V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 04:28:21 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0707DC0613D4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:28:21 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l18so666697pgg.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 01:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k3izNw2v4kNCe5ZYNTvutZlOv2UH0+nHDbicjBlj9uc=;
        b=yHoBttqE8x2QU44UU+LHl0eobVXFlsWymmVm6pqR/fZHusFGBfUaYXrA7WGWL+MLPf
         Dtn6AR4OggQNEJjozxBZPnrYiIw8OgcOJuxm+TmvgzTBw78eO7imUQa+L17yz3kAF7ft
         mI98t1g1ACkbXM0ORjMdJI8v2/FmHd7hHUZnB/l52gEm5OFFCoVqgPI7P/3sKbq4Kn2Y
         52f54SbVZJBz7/90/SQ8EoVDfQ0enXW9cz7cA1QhvfdO0hMd6NQZfOH0ohoJyzFRQl3r
         G+N10wq0zSXYWvqSDLRMU/OP61sz19DOa04Jg3g35J/iRvtKcA1TUgB/YvJyNFzO1GSR
         1KjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k3izNw2v4kNCe5ZYNTvutZlOv2UH0+nHDbicjBlj9uc=;
        b=L1Wt3Du9boA0XlT8o92PeWy6jh8sBQJHxokFb51s7SNRABKFFRAY/6534M4EqO+Dx6
         Dhc7u69Tc+g97EHwt3Fb++beMMQ37DYczN+e5ts5MQ61NS/ccuzgWTSMznr0QVoQSyYZ
         Hm3gQhxLETAn/BaGj7jx5B2GEq9tcna/hdowN2d9uf29Zmgg2SMRJnQV1ZHD2hepZuZ4
         Dri0ZMkcV7nH5qTktk6hhWk0ArNX5krSbMA7hdpoUNuzSszGrvtk/qGkhyV5lF9g4jWZ
         Ey3emq/WdBrFh+37+w109bKCGXpJ88NtSDzDAZuXatk854ep2ykWZ35RdjG/nYf5JsgI
         M9RA==
X-Gm-Message-State: AOAM5300qVbzK6IrKD+bM7uFm0S4ploGTgPjaZQ+tpADcyjTH6Wezm26
        JJXPd61YuZ2dov9AWkvt8nGOUQ==
X-Google-Smtp-Source: ABdhPJwb3LtHbAXZ4Y7kg/mbb8L8VUhbg+LQwboJKeaKfya4Ves9OchlGmy9cpZTCjepfVo+4bxWRw==
X-Received: by 2002:a17:90a:c28d:: with SMTP id f13mr1195647pjt.145.1603441700402;
        Fri, 23 Oct 2020 01:28:20 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id l82sm1266118pfd.102.2020.10.23.01.28.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 01:28:19 -0700 (PDT)
Date:   Fri, 23 Oct 2020 13:58:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Hector Yuan <hector.yuan@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Maxime Ripard <mripard@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH v1] cpufreq: mediatek-hw: Add support for Mediatek
 cpufreq HW driver
Message-ID: <20201023082817.5vp4cvi2lmpaozcn@vireshk-i7>
References: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1603441493-18554-1-git-send-email-hector.yuan@mediatek.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-10-20, 16:24, Hector Yuan wrote:
> This patchset includes 6 patches and depends on the MT6779 DTS patch[1] submitted by Hanks Chen.
> The first 3 patches are for CPUFREQ HW driver and device tree binding, which are already sent before separately [2][3]. For binding part, I add a new patch to add property in cpu schema.
> Besides, we add three more patches including EM power table, SVS CPU initialize, and cooling device.

And even after so many versions of these you chose to name this V1. It
is very difficult for reviewers to find time to review your stuff, and
they expect some sort of summary from you on what exactly changed from
last version and you also need to name the current version currently.

This should have been V8 and you should have added a "V7->V8 diff:"
section here, naming all the changes you did. Please send that as
reply to this email, so I can see what really changed.

-- 
viresh

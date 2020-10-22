Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CE72957B7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 07:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507846AbgJVFO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 01:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507838AbgJVFO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 01:14:58 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108E7C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 22:14:57 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w21so404919pfc.7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 22:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9N4AwJ1uFCW577znU9D4xEwyN9NsDba4VzTyi1307gQ=;
        b=yOA8f8kva3txVhVULf+6KyqMM6X6M5+Xq4kyU1AaaaeiRmVBHtfho0ndnz7P7+ksgb
         W2XD8LnIqe4xOqonit7kehkgF+JZvgSGPfhjNDzWxpcHS646OOK8Oy/L48/DVwIkJuYO
         UgvmCwGCf28d9+rxPSjbDBdwXk3YJ5o3rHKw8gw5dB3lYEv14YjymPgNjCJsTWFB3bOb
         fPWrK3+Q6/dnEzTjIo15k0gfucqhX08ixAMmzbXz7iLoAnG7g2ClLIDG2i4sATiuDCxq
         TRv2Lnax6EY1hdZkDGSJwIiZvtvt7dWcO60+ED8uAgRt3gWh/GBsdSZn196afU1z76WC
         SW2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9N4AwJ1uFCW577znU9D4xEwyN9NsDba4VzTyi1307gQ=;
        b=Fr4Trk3fkOS2el1C506fU2OjMNghyzshy1gTfRMu3NIWaC/PsxfgJ47MEjIzV8bAdH
         Ionjn2PkRCkGGZ0JKLJArYcWOw3GhrvmrhpjHFZ2+Pi5Da1UQ+m9jrgQV8iXTwJqh4XH
         dU2uYCpP4UT7lpVX/lK+izEDiPVuYWGlyGxgtwiIb6QT43Bi3w9si2QzTP2y0uC5S8JB
         lYqOmV75ufWwniDPJh1rqkn1BYrqvJ3tIOhtf2r8TxkHQxboM9D1Ru5VInw5xqeJrEI+
         ceV7bc801PXwDLJKm50tenByEWwBG0cB6Naw8F3ii1OdlGu1EOyg/09YKBGu5MDyVP3Q
         uXng==
X-Gm-Message-State: AOAM5322hVaO+ct3vyUVO4Q6NPDAkasnfVz8ZQfpO8iO0jBXFRR5zzns
        0OKcjKFKzkfTtOtvJuZoqw5d8A==
X-Google-Smtp-Source: ABdhPJy/Aaj8vx5eIZaXacCj6mJYxS7bjf6e3Y9pPqYEIm1OT+kS0t3cdteyul8PjIUtlKAzs3Sbnw==
X-Received: by 2002:a63:3d48:: with SMTP id k69mr880965pga.269.1603343696496;
        Wed, 21 Oct 2020 22:14:56 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id z18sm482300pfn.158.2020.10.21.22.14.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Oct 2020 22:14:55 -0700 (PDT)
Date:   Thu, 22 Oct 2020 10:44:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     rnayak@codeaurora.org, Qiang Yu <yuq825@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Douglas Anderson <dianders@chromium.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        dri-devel@lists.freedesktop.org, lima@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/8] drm/lima: Unconditionally call
 dev_pm_opp_of_remove_table()
Message-ID: <20201022051453.xufcga7icohm74rg@vireshk-i7>
References: <cover.1598594714.git.viresh.kumar@linaro.org>
 <62d944bdac75ec696828daad49fc1ddb6c637bcf.1598594714.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62d944bdac75ec696828daad49fc1ddb6c637bcf.1598594714.git.viresh.kumar@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-08-20, 11:37, Viresh Kumar wrote:
> dev_pm_opp_of_remove_table() doesn't report any errors when it fails to
> find the OPP table with error -ENODEV (i.e. OPP table not present for
> the device). And we can call dev_pm_opp_of_remove_table()
> unconditionally here.
> 
> Reviewed-by: Qiang Yu <yuq825@gmail.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> V2: Applied Reviewed by tag.
> ---
>  drivers/gpu/drm/lima/lima_devfreq.c | 6 +-----
>  drivers/gpu/drm/lima/lima_devfreq.h | 1 -
>  2 files changed, 1 insertion(+), 6 deletions(-)

Qiang, can you please pick it up ?

-- 
viresh

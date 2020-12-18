Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929132DDDB1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 05:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732102AbgLRE0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 23:26:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgLRE0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 23:26:46 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2C8C0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 20:26:06 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id w1so4267884pjc.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 20:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pFkAKUH4O4KFqcWvBfrhKmguKKpDobf2n3bq8OwbPOQ=;
        b=Zp+aQguzo3iQoP5OPze/DdYqhmMum/2ynuH7gUT24VZB34KfYdQf37GTJgJVBNFhrz
         27lklTuJYHjHyvnPnoKoRlPc8THCF78TZfas5xV49rvlNBu5RoRiEZtGNYhe8gv8LlBZ
         smZry8hDH9vINsjejhi0D+NPKn///gyxjBLG2dyxDXkzPWB9k+ttQc2E7i9MLk8NNT70
         sE9yWNeTS1w38TpkALYeOzK0wMEUcrmVV4bxMdpRHljdZbyGKI02u+wBOzeKF4QdoOhz
         WTNQ6c1G7yTwJFlTyYJoaKm6NKvx5rmljwb6z19DilbssKTS2ML6rRf1ZrU+1bgJBC9/
         RJAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pFkAKUH4O4KFqcWvBfrhKmguKKpDobf2n3bq8OwbPOQ=;
        b=c+o3Oc2rarj3Qy6MWTqMvkDAXk1F06oSgyMeStaDa36z2EG4mXTOlodNK3858oifLo
         RW4LZDoscOmZFV0ahUiI223jnK0OrUanjSzaMqOtx+4hZT6zHCZRSNAnAS1+GMG8H8S3
         9hRYUVP0RnsJdPtYiomqNnk6V9IB5+Cxi863Yfsrivec5/yLiqIGZAtwjegLksc0VWZA
         +33IfLvYo88rVa7Lwh7ehAtc5JSa3B9NPds+XFAK1/zNzvE+yTrxqsrtUWVw+jpWFQFx
         eU/BhcIv7d+PTApBZuqXtuJF5QXs78UXDqoH4jxmMj7vfn8mlOdNYg+tRVW0VwPpVucW
         EfRA==
X-Gm-Message-State: AOAM533aMj5Au3aTkW1AWWPlKxszLIwxT7yXFmJCcK0nBQKS8uxxldYx
        ZbfAIoOoX8DXF0FtgfltyZyqAg==
X-Google-Smtp-Source: ABdhPJyrN2W2YWrNbwsJd6s0Wkja/9ZfeXxcDWcpgvssWjuJ1wVIn50Lh1qZYOVpcMLho4COb1d/9w==
X-Received: by 2002:a17:90b:3596:: with SMTP id mm22mr2474871pjb.235.1608265565811;
        Thu, 17 Dec 2020 20:26:05 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id y69sm6955235pfb.64.2020.12.17.20.26.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Dec 2020 20:26:05 -0800 (PST)
Date:   Fri, 18 Dec 2020 09:56:02 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] arm64: topology: Avoid the have_policy check
Message-ID: <20201218042602.4ymy4fg2zxeo6p4n@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <20201217075732.blac5pbca7prmuum@vireshk-i7>
 <20201217105524.GA15336@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217105524.GA15336@gaia>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-12-20, 10:55, Catalin Marinas wrote:
> Hi Viresh,
> 
> On Thu, Dec 17, 2020 at 01:27:32PM +0530, Viresh Kumar wrote:
> > On 15-12-20, 11:04, Viresh Kumar wrote:
> > > Every time I have stumbled upon this routine, I get confused with the
> > > way 'have_policy' is used and I have to dig in to understand why is it
> > > so. Here is an attempt to make it easier to understand, and hopefully it
> > > is an improvement.
> > > 
> > > The 'have_policy' check was just an optimization to avoid writing
> > > to amu_fie_cpus in case we don't have to, but that optimization itself
> > > is creating more confusion than the real work. Lets just do that if all
> > > the CPUs support AMUs. It is much cleaner that way.
> > > 
> > > Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > ---
> > > V3:
> > > - Added Reviewed by tag.
> > 
> > Catalin, please pick the first two patches for 5.11. I will send the
> > last one separately later on.
> 
> I haven't figured out whether these are fixes (a cover letter would
> help ;)). They look like generic improvements to me

Right they are and since the merge window just opened I thought these
don't really need to wait for another full cycle to get in.

> and given that we
> are already in the 5.11 merging window, they would probably need to wait
> until 5.12.

Whatever you decide :)

-- 
viresh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1B12DE1BB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 12:05:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389370AbgLRLFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 06:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733227AbgLRLFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 06:05:06 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCB2C0617B0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:04:26 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id s2so1214612plr.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Dec 2020 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=06IzISd15kJf8c0sRywqlOU/noMqseWAhUJLkwOnXSk=;
        b=Rs05RT8JRyqP61kDoVh3MARnWZa/0rfY9uWwjcVMyutSGwX0MqyK+Y3tENtuEwRfZi
         JVxFpf51+J3uNtFsVQo2DgXr5v6nS6x/Lapd8W0doJyDrVt9IVVSrq/87vdPNLc+WPly
         z1PSZm5/3gBkwzHIGgI+WqZ5vX3osO6GB1YZLVjaRfdoQuL+AYiFWhcs0Cfi60qE5NH1
         6meJnFBShcZ6jckIdQ4LhBGl7/Iv2GzDrex5cN7JBg2Aqql1geA0RUswh+9CQfp0FXET
         g2gUwt+li9rc+iwwkIy6IjMM/Q9OVYJserb0OzcMIqI1/sPrd1R2ACii6cCw/c4hqqwV
         P57Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=06IzISd15kJf8c0sRywqlOU/noMqseWAhUJLkwOnXSk=;
        b=J73NJ4C3hemBehylxcFYV82oW6rKj73HOzG18qGeuaWWqqeU7rvUrszHfDoqFCWWtN
         /BeGaL34kRpWsYTmz3fLKNRDC6V+iOdc8wtESoxFncs7N8IF27jZ0Capa9+EnM2sVy17
         edoE6eGpNrJTT7voU7qIcsSoPKXScbsICXVWoyzwi579Y3Wj/3LvwvT2JeBQgysFOBcR
         avtCp7YdzeqfRFzJr4r/z0T2ikGEOnPZBQM2m5vhMgQ4/Gi+sDbR9GFITBsodfN0kbrB
         Ee8oeC79CaaRFUMzAaVIkf6NV5pQ5dknULUo8fEgcoyI97KYgphVK9iLhjZWSWpn725s
         fKkw==
X-Gm-Message-State: AOAM530O1Z8lqDex9A73xnHjbnEISeLiklTIreqV4rQObiGW2m8UnQOf
        7r3wb3S9wRSQ1Rx7Muldh/YRr6ON3eR4nA==
X-Google-Smtp-Source: ABdhPJz6szkZyhlQiNcncUMNFjc7zrr8yyXEl3UiA+Zi3dCobdXcCDClzZWB+Ni46JeK8nxusd6VIw==
X-Received: by 2002:a17:90a:e2ce:: with SMTP id fr14mr3926867pjb.89.1608289465637;
        Fri, 18 Dec 2020 03:04:25 -0800 (PST)
Received: from localhost ([122.172.20.109])
        by smtp.gmail.com with ESMTPSA id b17sm7160748pjz.44.2020.12.18.03.04.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Dec 2020 03:04:24 -0800 (PST)
Date:   Fri, 18 Dec 2020 16:34:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Ionela Voinescu <ionela.voinescu@arm.com>,
        Will Deacon <will@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/3] arm64: topology: Avoid the have_policy check
Message-ID: <20201218110423.mjfwgdazlaigeged@vireshk-i7>
References: <5ffc7b9ed03c6301ac2f710f609282959491b526.1608010334.git.viresh.kumar@linaro.org>
 <20201217075732.blac5pbca7prmuum@vireshk-i7>
 <20201217105524.GA15336@gaia>
 <20201218042602.4ymy4fg2zxeo6p4n@vireshk-i7>
 <20201218110114.GD5258@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218110114.GD5258@gaia>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-12-20, 11:01, Catalin Marinas wrote:
> On Fri, Dec 18, 2020 at 09:56:02AM +0530, Viresh Kumar wrote:
> > On 17-12-20, 10:55, Catalin Marinas wrote:
> > > Hi Viresh,
> > > 
> > > On Thu, Dec 17, 2020 at 01:27:32PM +0530, Viresh Kumar wrote:
> > > > On 15-12-20, 11:04, Viresh Kumar wrote:
> > > > > Every time I have stumbled upon this routine, I get confused with the
> > > > > way 'have_policy' is used and I have to dig in to understand why is it
> > > > > so. Here is an attempt to make it easier to understand, and hopefully it
> > > > > is an improvement.
> > > > > 
> > > > > The 'have_policy' check was just an optimization to avoid writing
> > > > > to amu_fie_cpus in case we don't have to, but that optimization itself
> > > > > is creating more confusion than the real work. Lets just do that if all
> > > > > the CPUs support AMUs. It is much cleaner that way.
> > > > > 
> > > > > Reviewed-by: Ionela Voinescu <ionela.voinescu@arm.com>
> > > > > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > > > > ---
> > > > > V3:
> > > > > - Added Reviewed by tag.
> > > > 
> > > > Catalin, please pick the first two patches for 5.11. I will send the
> > > > last one separately later on.
> > > 
> > > I haven't figured out whether these are fixes (a cover letter would
> > > help ;)). They look like generic improvements to me
> > 
> > Right they are and since the merge window just opened I thought these
> > don't really need to wait for another full cycle to get in.
> 
> Normally we freeze the arm64 tree around the -rc6 prior to the merging
> window to give the patches a bit of time in linux-next. This time
> around, given the holidays, Linus even stated that if not already in
> -next at 5.10, it won't be pulled: https://lkml.org/lkml/2020/12/13/290.

Okay, sounds good.

> So please re-post at -rc1 with the acks in place.

Sure.

-- 
viresh

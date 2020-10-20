Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E8E29395A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 12:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393304AbgJTKsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 06:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390218AbgJTKsy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 06:48:54 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0FDC061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:48:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id l18so859432pgg.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 03:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h3csrAd1jky9coyQEUbNeul9O9JSQ+GT/yRMQvwVlRM=;
        b=MOvMlkKIsU6yWtu6fAoRdXZqQmwKbFRGPzNPt7EIow+NWzRVTfWnoJMkb4id5xG+9Z
         nJdblopJrWREVTQzC32ssLnNCvh79+bgD+En93s6UUXb+cWsfU0QGVYDeTZokuWfucGM
         qaUkEcjKk9rAaiWSxQqqYAihvB9Q0Q6n3KfgFYr5qX47wDwxf57ddG7wNZIcKo0hgZTD
         FgV5+HWg3Xt5rTso+qIcJQvlWTLoAS7RczcRiyEP0L+Xn57EZ7VWWeY66OL8XSTqC5Zf
         Cjvc7mIId/NUeHFGu19k5Htu63MbgSNOGsL1GZdvCGJzHS4iB/t7g/YP55hjZ2ktX2wk
         2s8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h3csrAd1jky9coyQEUbNeul9O9JSQ+GT/yRMQvwVlRM=;
        b=UEWYc8lsdlpQskq21AQJ/0CIYoXn62lGZR1apKHTcVeGmXi8dDEIsDPApXV3J8P2Hy
         ckqnTBZuIvLz46DRFmUQM5cGhKVJq86UxbNf75rZ6nlHehuEq/kp3SR5LslRGaJ2B187
         IF87iqEJ0q4vi71t1Ucy7x/oXDTcjYFpC9sQqxBfx6jzTi4xqzHQeaJeo1Fw6avHUgrn
         Ur0jMBeiihyO2M5kNJ1V8oM11sblM5LpuFf1+i14IfXn8to7f1AzSuuFb2K3tgvir3Vs
         mTLjL/wI9U45zoxDfeLTcqBjMkW9udLI+pa9zeYLZoK4g0l/1f8OZFLIkPAIk23GfAYd
         y2vw==
X-Gm-Message-State: AOAM5338BZnQ+UijTiPcaXVwy3BwsjHzoIUahyGRocCq2u9qCAxQtiFz
        dE+SqD9+u8g8ZF+fFDKWsCm/7w==
X-Google-Smtp-Source: ABdhPJyYDuvahYkU1IUub/PaLxmkTTPYqoYoyfGPonplDkCIKP9bIbjkkmWOPnvsvKP8u2DD0SQXww==
X-Received: by 2002:a63:504b:: with SMTP id q11mr2076091pgl.17.1603190932800;
        Tue, 20 Oct 2020 03:48:52 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id b5sm1827560pgi.55.2020.10.20.03.48.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Oct 2020 03:48:51 -0700 (PDT)
Date:   Tue, 20 Oct 2020 16:18:49 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Nicola Mazzucato <nicola.mazzucato@arm.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        vireshk@kernel.org, daniel.lezcano@linaro.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        chris.redpath@arm.com, morten.rasmussen@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] [RFC] CPUFreq: Add support for
 cpu-perf-dependencies
Message-ID: <20201020104849.xh4prj4az5islmpt@vireshk-i7>
References: <20201008150317.GB20268@arm.com>
 <56846759-e3a6-9471-827d-27af0c3d410d@arm.com>
 <20201009053921.pkq4pcyrv4r7ylzu@vireshk-i7>
 <20201012154915.GD16519@bogus>
 <20201012165219.GA3573@arm.com>
 <17819d4d-9e7e-9a38-4227-d0d10a0749f1@arm.com>
 <20201014042531.r7iykzygkvmpsqck@vireshk-i7>
 <503af305-77a4-964a-ed17-8df8b4e3a546@arm.com>
 <20201019094633.m3yvxurfm2xwsb6a@vireshk-i7>
 <e3b3a583-5e0f-f512-85e6-81c55a0e6db5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3b3a583-5e0f-f512-85e6-81c55a0e6db5@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19-10-20, 14:36, Nicola Mazzucato wrote:
> Hi Viresh,
> 
> 
> On 10/19/20 10:46 AM, Viresh Kumar wrote:
> > On 19-10-20, 09:50, Nicola Mazzucato wrote:
> >> Hi Viresh,
> >>
> >> thank you for your suggestion on using 'opp-shared'.
> >> I think it could work for most of the cases we explained earlier.
> >>
> >> Summarising, there are two parts of this entire proposal:
> >> 1) where/how to get the information: now we are focusing on taking advantage of
> >> 'opp-shared' within an empty opp table
> >> 2) and how/where this information will be consumed
> >>
> >> Further details below:
> >>
> >> 1) a CPUFreq driver that takes the OPPs from firmware, can call
> >> dev_pm_opp_of_get_sharing_cpus like you suggested. When doing so, a provided
> >> cpumaksk will be populated with the corresponding cpus that share the same
> >> (empty) table opp in DT.
> >> All good so far.
> > 
> > Great.
> > 
> >> The current opp core is not expecting an empty table and therefore some errors
> >> are thrown when this happens.
> >> Since we are now allowing this corner-case, I am presenting below where I think
> >> some minor corrections may be needed:
> >>
> >> --- a/drivers/opp/of.c
> >> +++ b/drivers/opp/of.c
> >> @@ static void _opp_table_alloc_required_tables(struct opp_table *opp_table,
> >>         struct device_node *required_np, *np;
> >>         int count, i;
> >>
> >>         /* Traversing the first OPP node is all we need */
> >>         np = of_get_next_available_child(opp_np, NULL);
> >>         if (!np) {
> >> -               dev_err(dev, "Empty OPP table\n");
> >> +               dev_warn(dev, "Empty OPP table\n");
> >> +
> >> +               /*
> >> +                * With empty table we remove shared_opp. This is to leave the
> >> +                * responsibility to decide which opp are shared to the opp users
> >> +                */
> >> +               opp_table->shared_opp = OPP_TABLE_ACCESS_EXCLUSIVE;
> >> +
> >>                 return;
> >>         }
> >>
> >> @@ int dev_pm_opp_of_find_icc_paths(struct device *dev,
> >>         int ret, i, count, num_paths;
> >>         struct icc_path **paths;
> >>
> >>         ret = _bandwidth_supported(dev, opp_table);
> >> -       if (ret <= 0)
> >> +       if (ret == -EINVAL)
> >> +               return 0; /* Empty OPP table is a valid corner-case, let's not
> >> fail */
> >> +       else if (ret <= 0)
> >>                 return ret;
> >>
> >> The above are not 'strictly' necessary to achieve the intended goal, but they
> >> make clearer that an empty table is now allowed and not an error anymore.
> >> What it is your point of view on this?
> > 
> > Why is this stuff getting called in your case ? We shouldn't be trying
> > to create an OPP table here and it should still be an error in the
> > code if we are asked to parse an empty OPP table.
> 
> A driver that gets a set of opp-points from f/w needs to add them to each
> device. To do so, it will call dev_pm_opp_add(). If an opp_table struct for this
> device is not found, one will be created and the opp-point will be added to it.
> When allocation a new opp_table the opp will try to initialise it by parsing the
> values in DT. It will also try to find_icc_paths.
> 
> Everything happens silently if we don't have a table in DT.

Right, you need something like your patch here.

-- 
viresh

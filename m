Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125E6232ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 06:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgG3EY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbgG3EY1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 00:24:27 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2477C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so13092145pls.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5sgdtYzqTNVnuC7tTThaaFG3wxZ0ZxYzze4AncPyru0=;
        b=GRJbWIVRXQ2chTvOGH7LcET+CS3EqdQ3FE2txXjNJJQd5NhQbwr1Bs1WJV09IAstre
         c7nY+/7bByE/JMUWsVycHako7T8U+8AiWmGitjQiTfsigfC+SrZauFxZd+kdnTKC4o0B
         ctRZULLQjmxvICgTh1WOqrF4pPYw12UCGrqRzCdKTQgBIlmm24e6szM/3PNuK7LqEcpv
         3KhCahzYK/6fpdEyp9hZf65tcY9kSZd/yzFTCljxnTwobIZr05T4p1U6WIFp61VaL9iH
         Cr1FAiKnrYVNWB7omYDjL6h5/REgvSqtYWq2OlLNN0a/DDDciMhCb0NLnRud1FD3iAqs
         c6iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5sgdtYzqTNVnuC7tTThaaFG3wxZ0ZxYzze4AncPyru0=;
        b=CpuBYYgrMVQs06FZdwtaLNMabEW1cwsKJlxSPHOkIJy9Olio1EvzTJJ9evUyTdILW/
         HogebBYrE7ANd/brMtkWmhLJGfXDPoArhcdjNcPddPnU/rI8/DHULIaMODtHTbJfSqIR
         H0qJn1JLw9qottnhW42pyU/VTcj7dV372cfzZ8H9gV9ixGK6JeiMhpPIelTbc/5cC3me
         GMKHFyygsLH9mJvcLCLWxCYM4CS97skhtgX/3Y+wPs5nbCcy9hQh0fx7aCdK+16gae9r
         MrKOT1bBd4MC/wY8VNaIrOKjCrWErFhsOzyTTGNTDl3ZrV9MqdRo9UVNvAzspeQbCXM5
         D7Nw==
X-Gm-Message-State: AOAM533bUXafC+B33wejHrTAErsMSVGQ1rkdEFPFTXvAMCvapJb2Zpof
        Qv+pQyEXkc7cSMB0l+d+mCcOtA==
X-Google-Smtp-Source: ABdhPJx1DHAbdahx3DDZViUcA0KPnnf1c9a/fhDZ4VrpcnC85CChhioBJu+ODR5uSLaHF1eR5NILUA==
X-Received: by 2002:a17:902:a713:: with SMTP id w19mr31748049plq.146.1596083067140;
        Wed, 29 Jul 2020 21:24:27 -0700 (PDT)
Received: from localhost ([106.201.14.19])
        by smtp.gmail.com with ESMTPSA id 9sm4158736pfy.177.2020.07.29.21.24.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 Jul 2020 21:24:26 -0700 (PDT)
Date:   Thu, 30 Jul 2020 09:54:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        linux@armlinux.org.uk, mingo@redhat.com, peterz@infradead.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/7] arch_topology: disable frequency invariance for
 CONFIG_BL_SWITCHER
Message-ID: <20200730042423.4j22udejluis7blw@vireshk-mac-ubuntu>
References: <20200722093732.14297-1-ionela.voinescu@arm.com>
 <20200722093732.14297-4-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722093732.14297-4-ionela.voinescu@arm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-20, 10:37, Ionela Voinescu wrote:
> +++ b/drivers/base/arch_topology.c
> @@ -27,6 +27,7 @@ __weak bool arch_freq_counters_available(struct cpumask *cpus)
>  }
>  DEFINE_PER_CPU(unsigned long, freq_scale) = SCHED_CAPACITY_SCALE;
>  
> +#ifndef CONFIG_BL_SWITCHER
>  void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  			 unsigned long max_freq)
>  {
> @@ -46,6 +47,7 @@ void arch_set_freq_scale(struct cpumask *cpus, unsigned long cur_freq,
>  	for_each_cpu(i, cpus)
>  		per_cpu(freq_scale, i) = scale;
>  }
> +#endif

I don't really like this change, the ifdef hackery is disgusting and
then we are putting that in a completely different part of the kernel.

There are at least these two ways of solving this, maybe more:

- Fix the bl switcher driver and add the complexity in it (which you
  tried to do earlier).

- Add a cpufreq flag to skip arch-set-freq-scale call.

Rafael ?

-- 
viresh

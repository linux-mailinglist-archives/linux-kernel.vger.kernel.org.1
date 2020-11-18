Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 833DF2B7593
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 06:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgKRFGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 00:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgKRFGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 00:06:47 -0500
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6688FC061A4D
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:06:47 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id d3so352178plo.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 21:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c0qL4vBH8zTGG4mkh3IGRxeMcdX6qq8zH18KvFZxFvs=;
        b=Dzra3XoxXUyplUL3TjRtApmtWSyZvzlJQLGqkN5arnoIz4tExmE1Qxnw/038hs6vH2
         vxspj6duZR68RuWlwXFWpWRr4gfu0K7VutDhJnjBv5IC854x3Kf4ynaxtafF9iXl3VZc
         pg2mtXlDyAQq8+RwTAaiha9Lwf9j+3K0+Bkq70bfnvrAQuNzlB/uaTHcvSfbEgXmz3kU
         M/lxXvNsrqGJ9CQ5MlAxq2DR63iPtw7ERu3bKVGMtp3F5+hOo2YL/CUYRwBJAVmv/1vx
         VTW73sYb6/13wuJp/XdiKlKVwvSOPu8Gzy1XF7vPqIYnfx3WS1FdhsoES4rH/GZK07cF
         HRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c0qL4vBH8zTGG4mkh3IGRxeMcdX6qq8zH18KvFZxFvs=;
        b=RuHrRqpvosPCL2D868VwQ5373RwIRA0a5JOuMOw+CQSl2VNstz5eiUNDL8B5sE/x/q
         UynMacrjiE5H3A8n/vI0jjX4KyF3byhLtBdWYbShUdupwWDi7HHvmU+kyyAAS3vQ4OKc
         jcr/a50ndUe/ph58WG+z0DALP+I6DHiJIfNZ/0xk2xZFTZLGKi3ylqGwqG5FnW3JFRtU
         AMCSLYp2BlMtFVW9C6WC3wdi1Xn8lS/ajlg97RjzaeIXJXFh4FNyE+Y2nuwNFEmfko3L
         IIG9JIckQNJzUv/W+pui2Hiije5mpZiMOrzWql++XDhey83V7lbYu82BSMg5Hg/uWVc/
         DiGQ==
X-Gm-Message-State: AOAM531/a8oNmDqrhWZngyBbej8LHMnmeGpujCVU9bJyq/W/HMwiwHqn
        PEkNwQCekwc8lr137cHg78gP
X-Google-Smtp-Source: ABdhPJwH08+rw3vHH531DM44fwVyEKTAiEutJ3VAxPwYx8/3lwnF1uU7wXmoper16pyO1wUViLlgfA==
X-Received: by 2002:a17:90b:e0a:: with SMTP id ge10mr2365776pjb.211.1605676006863;
        Tue, 17 Nov 2020 21:06:46 -0800 (PST)
Received: from work ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id z16sm23909395pfq.179.2020.11.17.21.06.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Nov 2020 21:06:45 -0800 (PST)
Date:   Wed, 18 Nov 2020 10:36:40 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Loic Poulain <loic.poulain@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20201118050640.GA3286@work>
References: <20201117151225.6a50abf8@canb.auug.org.au>
 <20201117042359.GB7787@work>
 <20201118153912.1decf6cf@canb.auug.org.au>
 <20201118154500.127aaba6@canb.auug.org.au>
 <20201118155128.64c97667@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201118155128.64c97667@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Nov 18, 2020 at 03:51:28PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> On Wed, 18 Nov 2020 15:45:00 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 18 Nov 2020 15:39:12 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Why isn't that "fix patch" in the mhi tree (with necessary Acked-bys)?  
> > 
> > Ignore that, I missed its appearance :-)
> 
> Ignore that, my question stands (git confused me a lot :-().
> 
> I have applied the fix patch to the mhi tree merge today.

After discussing with Kalle, we decided to have a single patch which
changes MHI and ath11k (fix patch) to avoid issues. I'll send it today and
get it applied to mhi-next soon (via immutable branch).

Thanks,
Mani

> -- 
> Cheers,
> Stephen Rothwell



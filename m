Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A1327A5FD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 05:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1DpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726396AbgI1DpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 23:45:08 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C2BC0613CE
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:45:08 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 34so7085578pgo.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Sep 2020 20:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+sYbS7EwWqFM5qiEO+nz0uVts4J0a1ndqME5esSXwmI=;
        b=spF1juPvcIHT95yJdQPJgw0rwf6PD7NH0XwQVfiZ4TvGFuacfOXymk7Adv8f+DZkCp
         hajaQILVdqIuyJgoTHAH0I69sj1LRlc5OmxZ4glPaYC/FSG7N/DGv4DALKcLp2V0KQmy
         I0ot7Ne++NA9EGDT22j/3UZ7r2MpW8XpcbkLH9JJVURjwbihWmmpDpPecQdErU7A6K15
         dw2SKY+0tUjDouCEOujpZO6Q0luDiWVO50j+jAfAVF0gJtZrVZ/d/NWQMzPxXaDB2l74
         EVzFU/uwnhQsl1uW5aB4M8IjxemVPn0an9BQU7f+0gWY6dcFArhNUSGIRmozcpuIajqy
         A03A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+sYbS7EwWqFM5qiEO+nz0uVts4J0a1ndqME5esSXwmI=;
        b=IeI3gSDH04MipDCM5mG8t5WDN8NLCTTfiVCIboCYpc0sgCWMO6xkVtILThJkkTMoKp
         WZjhGP1/Ti3abc37e2orRIeVgTLF4uJCraCnRXTpF1WsMPAnRtSxTvSsQAbk74soUyS8
         Vo0nYUnq7lmPz8MLS0Y/cRafLvhy0/UrpKhZ/tqvrlGL8BJDie+TmvoBvmAUc5Vg+Y80
         ZHECLco9QtEMc0JXxd/g7X9+r6NiokW5WGf6O3NewOJYt8M3UTrpUIOwoZcpiSVZxnie
         jWgQ5RevRk/uO1QgKLiPi0UElQCSGPAVHo9zv0M3sH9jphuTjdqUSV0kKxLYMs4o2AMu
         fjxA==
X-Gm-Message-State: AOAM533sKRj8I/ZxXbrsUopG8nwrYzsOlbGXRYonzTmcfqQSwcKURXrf
        /aJ4nB/ySqp9MX5nQdy5YvxL
X-Google-Smtp-Source: ABdhPJz/ektcg0F0w5QQJsofwbKiimEl5cBXP5l4TTbaXyAUUPmEPzBLtDdt2ztBHBpebAe7+uwL8g==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr1579765pgd.209.1601264708301;
        Sun, 27 Sep 2020 20:45:08 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6003:40df:7c40:5a87:eb86:87b0])
        by smtp.gmail.com with ESMTPSA id l141sm9790784pfd.47.2020.09.27.20.45.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Sep 2020 20:45:07 -0700 (PDT)
Date:   Mon, 28 Sep 2020 09:15:03 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/18] bus: mhi: core: Fix the building of MHI module
Message-ID: <20200928034503.GB3605@Mani-XPS-13-9360>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
 <20200921160815.28071-20-manivannan.sadhasivam@linaro.org>
 <20200927102233.GA87283@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200927102233.GA87283@kroah.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 12:22:33PM +0200, Greg KH wrote:
> On Mon, Sep 21, 2020 at 09:38:15PM +0530, Manivannan Sadhasivam wrote:
> > The Kbuild rule to build MHI should use the append operator. This fixes
> > the below warning reported by Kbuild test bot.
> > 
> > WARNING: modpost: missing MODULE_LICENSE() in
> > drivers/bus/mhi/core/main.o
> > WARNING: modpost: missing MODULE_LICENSE() in drivers/bus/mhi/core/pm.o
> > WARNING: modpost: missing MODULE_LICENSE() in
> > drivers/bus/mhi/core/boot.o
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> What commit caused this problem?  Can you add a Fixes: line for it?
> 

Sure, will add the fixes tag!

Thanks,
Mani

> thanks,
> 
> greg k-h

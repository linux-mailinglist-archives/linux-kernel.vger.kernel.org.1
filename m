Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8918E2C12EC
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbgKWSKe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 13:10:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726771AbgKWSKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 13:10:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA86BC061A4E
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:10:33 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id v12so15624684pfm.13
        for <linux-kernel@vger.kernel.org>; Mon, 23 Nov 2020 10:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tRbLdzf7nLLz965yR1ha5WkHs6UoOY/QLZBKsNoJJPw=;
        b=dBR+tZy0iwKF0n70gHF7fsfCdf7eCjAXKFECem0f7+fzYnRqlcFKu2nna8sZxB5fqO
         HQmgb5dGJ1nYydgHUNJ+S60UjWo0s71gwQnUHGcVX3k7+EkDeHVXZxYAW0nun2eplQHZ
         SdU2ZBORtFe5tLv9EqdiEXNxhTLA1a8beMbo70cKjaGCgc+LEFyiwfPLNd6rQwKJCk50
         lEaXAsOZYTaBJR8gnETNpLRrpRFoIKvTsdn4Dt4R8z13KzJWKK6c4ZW6HOP3zq0Td/rT
         25sYuiDGRLJQC3CVHe5xXbCHebr19ml5FCvbwoZduMmu5UYzfIcrcpAv3wAGos7FbcEe
         OpRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tRbLdzf7nLLz965yR1ha5WkHs6UoOY/QLZBKsNoJJPw=;
        b=TUqXPPtb8kFZT590G2R+2mr/GK1ZG389w3ngP5doKDTm3Y0DDF5VG+JPa3f+i2zYBh
         Rev1NSGpeJLH0Jng2/q4SANoS5QxHRV8d4RcuHGtV5tN73RgZ/Za3ryVrjiy16W1nG3K
         iZ9ejr66+iKlLrg1PUMjePfXTINCE5RdpKZYmKE64I+/NrNbAlNihlD5ohPl6aoE2N+m
         O3nSpmpmLhxdwEB01+3VIGUz+GrSaRuf61de8oHBrhU7710RCmmGncRXFzcW/XteyXGW
         Bv6GZmyv0FhoqQcjkm69TnqEDmbb3o4RGsh1iUjDFmTKquaR0DDRPJYJliqhh7awaNkB
         yYog==
X-Gm-Message-State: AOAM530C3RL0ekaZ+IXp8Ns1Y03yZDu4IsiNXMlGFfZQR6o5LKuHq77K
        frrmpVSC9afnA432gNts/kIuKQ==
X-Google-Smtp-Source: ABdhPJym/gHWmBKhfNnY+QXBIt8h3XPbN2i4XuOzwwQ9PQi36roQV7CkKC0mi5sPARxPwudyuwUxEg==
X-Received: by 2002:a62:1686:0:b029:197:5d15:2733 with SMTP id 128-20020a6216860000b02901975d152733mr582322pfw.81.1606155033298;
        Mon, 23 Nov 2020 10:10:33 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id b17sm12688815pfi.61.2020.11.23.10.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 10:10:32 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:10:30 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        Stephen Boyd <swboyd@chromium.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Mao Jinlong <jinlmao@codeaurora.org>, stable@vger.kernel.org
Subject: Re: [PATCH] coresight: tmc-etr: Check if page is valid before
 dma_map_page()
Message-ID: <20201123181030.GC104873@xps15>
References: <20201123102133.18979-1-saiprakash.ranjan@codeaurora.org>
 <ad83c4bd-dc24-c412-c5f7-b51ca1f22588@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad83c4bd-dc24-c412-c5f7-b51ca1f22588@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 23, 2020 at 10:46:56AM +0000, Suzuki K Poulose wrote:
> On 11/23/20 10:21 AM, Sai Prakash Ranjan wrote:
> > From: Mao Jinlong <jinlmao@codeaurora.org>
> > 
> > alloc_pages_node() return should be checked before calling
> > dma_map_page() to make sure that valid page is mapped or
> > else it can lead to aborts as below:
> > 
> >   Unable to handle kernel paging request at virtual address ffffffc008000000
> >   Mem abort info:
> >   <snip>...
> >   pc : __dma_inv_area+0x40/0x58
> >   lr : dma_direct_map_page+0xd8/0x1c8
> > 
> >   Call trace:
> >    __dma_inv_area
> >    tmc_pages_alloc
> >    tmc_alloc_data_pages
> >    tmc_alloc_sg_table
> >    tmc_init_etr_sg_table
> >    tmc_alloc_etr_buf
> >    tmc_enable_etr_sink_sysfs
> >    tmc_enable_etr_sink
> >    coresight_enable_path
> >    coresight_enable
> >    enable_source_store
> >    dev_attr_store
> >    sysfs_kf_write
> > 
> > Fixes: 99443ea19e8b ("coresight: Add generic TMC sg table framework")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Mao Jinlong <jinlmao@codeaurora.org>
> > Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> 

Applied - thanks

Mathieu

> > ---
> >   drivers/hwtracing/coresight/coresight-tmc-etr.c | 2 ++
> >   1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index 525f0ecc129c..a31a4d7ae25e 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -217,6 +217,8 @@ static int tmc_pages_alloc(struct tmc_pages *tmc_pages,
> >   		} else {
> >   			page = alloc_pages_node(node,
> >   						GFP_KERNEL | __GFP_ZERO, 0);
> > +			if (!page)
> > +				goto err;
> >   		}
> >   		paddr = dma_map_page(real_dev, page, 0, PAGE_SIZE, dir);
> >   		if (dma_mapping_error(real_dev, paddr))
> > 
> > base-commit: c04e5d7bbf6f92a346d6b36770705e7f034df42d
> > 
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F32A92CF9F1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 07:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgLEGJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 01:09:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgLEGJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 01:09:21 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1451DC0613D1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Dec 2020 22:08:41 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id t3so4878289pgi.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Dec 2020 22:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KyCltGo5Jh+2iRWxe0Q7oC+kYFctDXgmC6IuBeRcK5k=;
        b=yRdoGg3CcSs/UppaG2EdVs9NHQeHdSZGv4HNg+4XYZF4vRNG2plcNU9F+BsrBcy2Eg
         +aCzwKc3D5wc53CoPzn6j9ujqNu5KVvp+fyBDasjyuDn3GcODGbZB8ugXaE/tlZ8/qXh
         cT8qbYq92aIms6eCIDpp+o+7aQbB6bcy2B12p6BQsOOef8MnptTc01JKCnUqq/ySIOAD
         UqDfs9PnRHPJMf586NPY0Xf0ixadWdsXjOG5jAdAIxpa8t3QBrD572GiiJvMPZAnovBA
         jrNglt54qPeS+IXHLgP6NgbieCF/dcIT3WQTaTF7tvNvJ5Nnjamd15nCnyDNCIYOw7IJ
         lydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KyCltGo5Jh+2iRWxe0Q7oC+kYFctDXgmC6IuBeRcK5k=;
        b=aMslYARy2ZuNWnpEBy/0VuaispAlsgsqlN+4VFkAytz7uqsiWeK/aHpKZPt3Y9wMFj
         jc9MdCmC6YqYEhapmdV6GltX6p01uPAbvU4+agCHckyx25Z31YWd+rM3V/jCIx3/Qbg+
         i50ZJu/qSkCTAFQV0j9xnmHe2zKz7yQuvhBBkU19Ifa8KooVwkLqW6oyWWvpND+bsgOf
         a8VU0e2NC02UvAvcS2saZFxN5qK1/DN4p1aUY0sgDLhAl+eCxOSEo0yLhCabhWXSCzLV
         NRloSARQCzeg2r9fw36VYPJGW//oEXIETvNOAsr6Z4feZ++Hu/YbaBfjElI8X9VVriN5
         5tEg==
X-Gm-Message-State: AOAM531BGA0QAR3MYaH+eB1WvL4w5IQuiwpTAkt5ClZ6JZ2fU5ifdGxv
        qtd8IhdWcP2DpP8m7RRsPRpu
X-Google-Smtp-Source: ABdhPJwgqYSKX9/t+x42f5dD9qUaRlQ86l6l2+sMNxDOx43O7XkVzMyQhapssOtj1pRzRiXvd/IoOg==
X-Received: by 2002:a63:1b11:: with SMTP id b17mr10315665pgb.1.1607148520425;
        Fri, 04 Dec 2020 22:08:40 -0800 (PST)
Received: from thinkpad ([2409:4072:648e:8bd1:74b2:a4d8:e3fe:225b])
        by smtp.gmail.com with ESMTPSA id m18sm7119878pff.144.2020.12.04.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 22:08:39 -0800 (PST)
Date:   Sat, 5 Dec 2020 11:38:31 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 05/18] dmaengine: owl: Add compatible for the Actions
 Semi S500 DMA controller
Message-ID: <20201205060831.GA4068@thinkpad>
References: <cover.1605823502.git.cristian.ciocaltea@gmail.com>
 <f2e9f718eb8c7279127086795a4ef5047fc186d5.1605823502.git.cristian.ciocaltea@gmail.com>
 <20201128073045.GU3077@thinkpad>
 <20201129182421.GD696261@BV030612LT>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201129182421.GD696261@BV030612LT>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 29, 2020 at 08:24:21PM +0200, Cristian Ciocaltea wrote:
> On Sat, Nov 28, 2020 at 01:00:45PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Nov 20, 2020 at 01:55:59AM +0200, Cristian Ciocaltea wrote:
> > > The DMA controller present on the Actions Semi S500 SoC is compatible
> > > with the S900 variant, so add it to the list of devices supported by
> > > the Actions Semi Owl DMA driver.
> > > 
> > > Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> > 
> > I hope that you have verified both Memcpy and Slave transfers...
> 
> I have been using 'dmatest' module as documented in:
> https://www.kernel.org/doc/html/latest/driver-api/dmaengine/dmatest.html
> 
> I tested all the available channels and could not find any signs of
> possible issues. Bellow is an excerpt from the kernel ring buffer:
> 
> [ 2661.884680] dmatest: dma0chan1-copy0: summary 300 tests, 0 failures 1653.48 iops 13249 KB/s (0)
> [ 2661.886567] dmatest: dma0chan2-copy0: summary 300 tests, 0 failures 1684.40 iops 12846 KB/s (0)
> [ 2661.888448] dmatest: dma0chan3-copy0: summary 300 tests, 0 failures 1730.62 iops 13648 KB/s (0)
> 
> Should I perform some additional tests?
> 

Nope, this is sufficient. Since you have tested slave transfer with MMC driver,
running dmatest for memcpy is fine.

Thanks,
Mani

> Thanks,
> Cristi
> 
> > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > Thanks,
> > Mani
> > 
> > > ---
> > >  drivers/dma/owl-dma.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/drivers/dma/owl-dma.c b/drivers/dma/owl-dma.c
> > > index 9fede32641e9..54e509de66e2 100644
> > > --- a/drivers/dma/owl-dma.c
> > > +++ b/drivers/dma/owl-dma.c
> > > @@ -1082,6 +1082,7 @@ static struct dma_chan *owl_dma_of_xlate(struct of_phandle_args *dma_spec,
> > >  static const struct of_device_id owl_dma_match[] = {
> > >  	{ .compatible = "actions,s900-dma", .data = (void *)S900_DMA,},
> > >  	{ .compatible = "actions,s700-dma", .data = (void *)S700_DMA,},
> > > +	{ .compatible = "actions,s500-dma", .data = (void *)S900_DMA,},
> > >  	{ /* sentinel */ },
> > >  };
> > >  MODULE_DEVICE_TABLE(of, owl_dma_match);
> > > -- 
> > > 2.29.2
> > > 

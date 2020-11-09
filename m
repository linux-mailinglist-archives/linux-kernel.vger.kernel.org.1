Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 128F62AC2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729571AbgKIRsv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:48:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgKIRsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:48:51 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAA35C0613CF
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 09:48:50 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id j5so5094934plk.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:48:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iBtVCBUVX6Q4UG1cOB/qk/xTi7I9Qt4Z3MLExYw4xx8=;
        b=Pqq5Kxgwwee1RLIr+6CjL22+ZE2LW9fOl5E9jsJijII/aLTuiXABi1AZQT7VMH6xHa
         CGTKkEy4o4Ke5ND8wVYvcGdQQemqlQhc6fFqrY1bwmnonMFot+VIxwCWg9Nw35L/ty+0
         7sUogqAX9me895E4Xg37pd73oxX39KKEkhQZIDSWsV4RqMndnD0Qv6BryiCUZSOLfiCy
         Q109eIW4kGvNMOZENsnWMAcEsYrDGdCPfwNBIiDA7B5lHND3P/yyFVf0lcyEDUnn+H5u
         T2c4BY+VFlUppmqsxajdD6jxQHJHYN1sRq0spcrm1zQesIpaDGBDHzcw/3DYDCghb6Qm
         NPdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iBtVCBUVX6Q4UG1cOB/qk/xTi7I9Qt4Z3MLExYw4xx8=;
        b=M4oFOEQjZwsl/t3qsmTmMn1f0KlbxrgOg+TP3LGcZzUTWYo2zrTUjc9tDiug3pVO07
         9mgU26ZJRyxM/OsMHfrL7G2WJH/bTXdo0fvCB9EyfleF27Zsfg3NXLjZIjwF9alFpSij
         kNdWYxHF8Qm47BVmGFJ2P3VJD6tSC6aQT355tPLVKbFcBtOSlVlRAGUYzWjXZcWvNs3P
         H60D7WLb8Hk8K4ham6IZc/tZCJaaXNyHsARqXI85ZU+paoKd/+4MV2QNIZ9+8O4FNFRR
         vnuxRzJti9Lr6fovOdskseMNQa10+io1UjtEeLEJMZKB/mRueli4EjcY5Z1yc0pUzm/N
         WLoQ==
X-Gm-Message-State: AOAM530WIifQaIWtVm+bvCgzeKY/HeEFJV7FmW57zrXvqUvR4keXSOIH
        1ryzU1jd63q5JDQECHLpZNl+8A==
X-Google-Smtp-Source: ABdhPJzFYvMoMd/DYEwzmCW8hHgLwFKZ8y2iqsYgldHqdKvGTT5OWqoxOn0DwxmW7UdQvzzC3qfAgg==
X-Received: by 2002:a17:902:6b46:b029:d6:e5c6:b3bc with SMTP id g6-20020a1709026b46b02900d6e5c6b3bcmr13844624plt.64.1604944130313;
        Mon, 09 Nov 2020 09:48:50 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id n1sm11179419pgl.31.2020.11.09.09.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2020 09:48:49 -0800 (PST)
Date:   Mon, 9 Nov 2020 10:48:47 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, mike.leach@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 19/26] coresight: etm4x: Detect access early on the
 target CPU
Message-ID: <20201109174847.GC3395222@xps15>
References: <20201028220945.3826358-1-suzuki.poulose@arm.com>
 <20201028220945.3826358-21-suzuki.poulose@arm.com>
 <20201106203438.GB3299843@xps15>
 <f66695c0-e436-0d5c-2e12-5383159e72d6@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66695c0-e436-0d5c-2e12-5383159e72d6@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 09, 2020 at 09:48:07AM +0000, Suzuki K Poulose wrote:
> On 11/6/20 8:34 PM, Mathieu Poirier wrote:
> > On Wed, Oct 28, 2020 at 10:09:38PM +0000, Suzuki K Poulose wrote:
> > > In preparation to detect the support for system instruction
> > > support, move the detection of the device access to the target
> > > CPU.
> > > 
> > > Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > ---
> > >   .../coresight/coresight-etm4x-core.c          | 45 ++++++++++++++++---
> > >   1 file changed, 40 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > index f038bb10bc78..308674ab746c 100644
> > > --- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
> > > @@ -56,6 +56,11 @@ static u64 etm4_get_access_type(struct etmv4_config *config);
> > >   static enum cpuhp_state hp_online;
> > > +struct etm_init_arg {
> > 
> > s/etm_init_arg/etm4_init_arg
> 
> Part of the reason was to add a future IP support where it is not all
> ETM4. Again it doesn't really matter. I could change it.
>

I thought about that too but the inclusion of etmv4_drvdata cancels any attempts
at making things generic.
 
> > 
> > > +	struct etmv4_drvdata	*drvdata;
> > > +	struct csdev_access	*csa;
> > > +};
> > > +
> > >   u64 etm4x_sysreg_read(struct csdev_access *csa,
> > >   		      u32 offset,
> > >   		      bool _relaxed,
> > > @@ -669,6 +674,22 @@ static const struct coresight_ops etm4_cs_ops = {
> > >   	.source_ops	= &etm4_source_ops,
> > >   };
> > > +static bool etm_init_iomem_access(struct etmv4_drvdata *drvdata,
> > > +				  struct csdev_access *csa)
> > > +{
> > > +	*csa = CSDEV_ACCESS_IOMEM(drvdata->base);
> > > +	return true;
> > > +}
> > > +
> > > +static bool etm_init_csdev_access(struct etmv4_drvdata *drvdata,
> > > +				  struct csdev_access *csa)
> > > +{
> > > +	if (drvdata->base)
> > > +		return etm_init_iomem_access(drvdata, csa);
> > > +
> > > +	return false;
> > > +}
> > 
> > Returning a boolean rather than an int for the above two functions seems odd to
> > me.
> > 
> 
> We don't return an error from the caller of these functions. So, all we

And this is done from smp_call_function_single() where returning a meaningful
error value would mandate changes to struct etm_init_arg, which is needlessly
messy for this set.  Void my comment. 

> need to know is, if the operation was success or failure. Having bool
> makes it explicit for the checkings, rather than documenting the
> expected return values. Hence the choice. But I am open to changing them
> if you prefer it that way.
> 
> 
> 
> Cheers
> Suzuki

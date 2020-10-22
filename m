Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05A132966CF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 23:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372509AbgJVVvq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 17:51:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2897894AbgJVVvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 17:51:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB04CC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:51:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id e7so2080457pfn.12
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 14:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+wVwzNPq/m5a8z79nf57WeG0wpvPOYgMcQgxD6E+uTI=;
        b=za5mhyMSIBmhfe83oq+5Dt3diKbGLhXKkTuTXMsGC2HqNgttYgcXVS6/wZ9VvBQ7RE
         aD9RRqORvUVLNS+/k4iv/UXHamoabW7gpiNW7h62VZ9vInIO0lMmdQk4fW+p6IHi31NV
         29LqJs4DD/97ykDGqUgWy0DSds/FzdbCEAx2bcN/28o9GiDyO5UWqVEoRgJm0NoB1Aag
         RYnlh/Q9uKrLqaXmhwDEP7c5VQSp+f7jasAY8X799p3X3OgoY4dKcjGULx5T76UN7bYb
         m31Addwx8crKcNjhKTqXPx/gvhSy1UFVPMpjI73adp0VxeS643DrtonLPgns5XWUEv0D
         7gsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+wVwzNPq/m5a8z79nf57WeG0wpvPOYgMcQgxD6E+uTI=;
        b=E610w3jl7XBSFsY38QhIfBMxWFINfjB8jo1ICcGuUChKD9QUlK3lJAY+ILRI0eczqK
         k6Wsxdlq12ni0MnuZ7fetbrs7hpxgSrA61v3wW57ZTASAV0s6agOqwVGDUnYbg0jwoCr
         Yd8wydalknmlnwxQl0lPXerhjwCIR+q4c/+2uVTu+YCilKRIpIi5zO7UjXmLnWhGlZeG
         hbrmZZxoAQmq92yvxUNpJ/3CmtZCTn2pYLmsrdHbSFZBdB3R2DOjI++PsIAWjdfrFmzA
         H4FnSC13ewBtxIug59Xuzq8T9Er2AZligCEQYABuRcco4OH5C5bj579tt0KFM8NMQpvC
         NkpA==
X-Gm-Message-State: AOAM531VM8EJwMYIV/Y5qpKgSPN0HnSMkQnyY8TlejUjTSwXLVjVdO6s
        2196k/h2yjww4RFl5G/oEVPAjw==
X-Google-Smtp-Source: ABdhPJwdOpv6eBG5NhCRK0TEA7432l0lqx0BRZNt89hUmGBiaZFYHps//vnlcOHCLbNmcD5vnCPrPQ==
X-Received: by 2002:a17:90b:190a:: with SMTP id mp10mr4008741pjb.183.1603403505371;
        Thu, 22 Oct 2020 14:51:45 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e2sm2373014pgd.27.2020.10.22.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 14:51:44 -0700 (PDT)
Date:   Thu, 22 Oct 2020 15:51:43 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "ohad@wizery.com" <ohad@wizery.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/13] remoteproc: Add new detach() remoteproc operation
Message-ID: <20201022215143.GA729430@xps15>
References: <20200826164529.224476-1-mathieu.poirier@linaro.org>
 <20200826164529.224476-6-mathieu.poirier@linaro.org>
 <DB6PR0402MB2760E8ECEBDBFF9E02FA74D888020@DB6PR0402MB2760.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB6PR0402MB2760E8ECEBDBFF9E02FA74D888020@DB6PR0402MB2760.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng - I restarting work on this topic.

On Thu, Oct 15, 2020 at 01:37:42AM +0000, Peng Fan wrote:
> > Subject: [PATCH 05/13] remoteproc: Add new detach() remoteproc operation
> > 
> > Add an new detach() operation in order to support scenarios where the
> > remoteproc core is going away but the remote processor is kept operating.
> > This could be the case when the system is rebooted or when the platform
> > driver is removed.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  include/linux/remoteproc.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h index
> > fe383392a821..1a57e165da2c 100644
> > --- a/include/linux/remoteproc.h
> > +++ b/include/linux/remoteproc.h
> > @@ -361,6 +361,7 @@ enum rsc_handling_status {
> >   * @start:	power on the device and boot it
> >   * @stop:	power off the device
> >   * @attach:	attach to a device that his already powered up
> > + * @detach:	tell the remote processor that the core is going away
> >   * @kick:	kick a virtqueue (virtqueue id given as a parameter)
> >   * @da_to_va:	optional platform hook to perform address translations
> >   * @parse_fw:	parse firmware to extract information (e.g. resource table)
> > @@ -382,6 +383,7 @@ struct rproc_ops {
> >  	int (*start)(struct rproc *rproc);
> >  	int (*stop)(struct rproc *rproc);
> >  	int (*attach)(struct rproc *rproc);
> > +	int (*detach)(struct rproc *rproc);
> >  	void (*kick)(struct rproc *rproc, int vqid);
> >  	void * (*da_to_va)(struct rproc *rproc, u64 da, size_t len);
> >  	int (*parse_fw)(struct rproc *rproc, const struct firmware *fw);
> > --
> 
> This look useful for i.MX8 partitioned case, M4 and A53 could reboot without
> impacting the other. When A53 reboot, detach is invoked if I understand correct.

You are correct (for this patchset).  Since this heuristic is quite stringent we are
contemplating different solutions that would allow platforms to decide what they
want to do based on the usecase they care about.

Thanks,
Mathieu

> 
> Reviewed-by: Peng Fan <peng.fan@nxp.com>

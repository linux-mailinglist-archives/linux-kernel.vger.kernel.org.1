Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28D9D2FBBE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:05:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391582AbhASQE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391937AbhASQBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:01:43 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2BC061794
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:00:37 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id u11so6461599plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 08:00:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjhn+ON+hkziQZDm4FU1RytdB4SSkjTn8+uofKtncf4=;
        b=d37eDwdiYcgU786B2/oaZHUv37IdCecqnYg5R1vsCoQXglwTHd6hvsG8k4V4VTmhcI
         7eH4JakNM29vrQ5BTQznO5HiZId7FzqVQfIDWL4w3qL6DbXiZZx2y8Sdtjyta8s9qdm7
         58paqu2uAH9OqJriHMFZf95FoRcXWnPa3Ph/Criww5sb744sR5UDVUWIuyHPYuAWnbQJ
         Ab1VaspMUK7s5AWhZZn+bUqNMdtLogYc/KzmJjTPybx8zbPRe+C0Oen2HgpqugmcynNx
         hLrFIDKWdEgryGNYcJVa4wklOvfNPST3pgCq28zYKBmIK/nnpo5tMBoR8XVRYfIg0p5A
         gZpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjhn+ON+hkziQZDm4FU1RytdB4SSkjTn8+uofKtncf4=;
        b=RM+RxNvJp+S5s9PgboJqDCQoOjUkN+HgLf87cB/2OY24hbdRLgGqT1MqxqzI8kTmIc
         t5DcfbnKcmWZeIME1lV0R0sp6t8xgKZsa60m3ojo7UwBIUt2Q2QJlIVlhqZ+9fUi/wdW
         7ioH21eu37s1Zx1yA+Qx2SdgKfklBaNgPMxubaPlP1amB1SSeiTgOYmj13JUDaLkJnIQ
         HaW1Pke6dPPT6hIclV8aDlhvk2e6GDcRlcXifus1N6IodzJT8Qav8FvEFOXeNMrB6Wlj
         y9f42nuk1Ll41pjX/pM59S+C3YRGcU3gff3XlBookYVXNCxXqPCuAPvQG5XcRJIR3pqR
         EaMQ==
X-Gm-Message-State: AOAM530jMiMRU3nzErC1+5kSwcbtx1Ch1tZ1/99jqfWm8WROGh1hJ9gm
        J8NGFz+9AF50mPHFJVH+kZRPSw==
X-Google-Smtp-Source: ABdhPJxxn9wfy3oMuHByRv7nVJi+Gxq6rGK6r1XgFPfGojJ12MEt28w4sbqXtyE0KooTYGUlUjCNCQ==
X-Received: by 2002:a17:902:d893:b029:da:72d4:8343 with SMTP id b19-20020a170902d893b02900da72d48343mr5435514plz.84.1611072036147;
        Tue, 19 Jan 2021 08:00:36 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id ne6sm4003328pjb.44.2021.01.19.08.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 08:00:35 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:00:33 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Cc:     Arnaud POULIQUEN - foss <arnaud.pouliquen@foss.st.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [Linux-stm32] [PATCH] rpmsg: char: return an error if device
 already open
Message-ID: <20210119160033.GB611676@xps15>
References: <20210106133714.9984-1-arnaud.pouliquen@foss.st.com>
 <20210114190543.GB255481@xps15>
 <6de9ff8f-0be1-387a-df7e-7d77dd859513@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6de9ff8f-0be1-387a-df7e-7d77dd859513@st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:13:35AM +0100, Arnaud POULIQUEN wrote:
> Hi Mathieu,
> 
> 
> On 1/14/21 8:05 PM, Mathieu Poirier wrote:
> > On Wed, Jan 06, 2021 at 02:37:14PM +0100, Arnaud Pouliquen wrote:
> >> The rpmsg_create_ept function is invoked when the device is opened.
> >> As only one endpoint must be created per device. It is not
> >> possible to open the same device twice.
> >> The fix consists in returning -EBUSY when device is already
> >> opened.
> >>
> >> Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
> >> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> >> ---
> >>  drivers/rpmsg/rpmsg_char.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/rpmsg/rpmsg_char.c b/drivers/rpmsg/rpmsg_char.c
> >> index 4bbbacdbf3bb..360a1ab0a9c4 100644
> >> --- a/drivers/rpmsg/rpmsg_char.c
> >> +++ b/drivers/rpmsg/rpmsg_char.c
> >> @@ -127,6 +127,9 @@ static int rpmsg_eptdev_open(struct inode *inode, struct file *filp)
> >>  	struct rpmsg_device *rpdev = eptdev->rpdev;
> >>  	struct device *dev = &eptdev->dev;
> >>  
> >> +	if (eptdev->ept)
> >> +		return -EBUSY;
> >> +
> > 
> > I rarely had to work so hard to review a 2 line patch...
> 
> That means that my commit description was not enough explicit...
> 
> > 
> > As far as I can tell the actual code is doing the right thing.  If user space is
> > trying to open the same eptdev more than once function rpmsg_create_ept() should
> > complain and the operation denied, wich is what the current code is doing.  
> > 
> > There is currently two customers for this API - SMD and GLINK.  The SMD code is
> > quite clear that if the channel is already open, the operation will be
> > denied [1].  The GLINK code isn't as clear but the fact that it returns NULL on
> > error conditions [2] is a good indication that things are working the same way.
> > 
> > What kind of use case are you looking to address?  Is there any way you can use
> > rpdev->ops->create_ept() as it is currently done?
> 
> This patch was part of the IOCTL rpmsg series. I sent it separately at Bjorn's
> request [1].
>

I am looking at [1] later today - I will get back to this patch when I have more
context.
 
> I detect the issue using the RPMSG_ADDR_ANY for the source address when tested
> it with the rpmsf_virtio bus. In this case at each sys open of the device, a new
> endpoint is created because a new source address is allocated.
> 
> [1]https://patchwork.kernel.org/project/linux-remoteproc/patch/20201222105726.16906-11-arnaud.pouliquen@foss.st.com/
> 
> Thanks,
> Arnaud
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > [1]. https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/rpmsg/qcom_smd.c#L920
> > [2]. https://elixir.bootlin.com/linux/v5.11-rc3/source/drivers/rpmsg/qcom_glink_native.c#L1149
> > 
> >>  	get_device(dev);
> >>  
> >>  	ept = rpmsg_create_ept(rpdev, rpmsg_ept_cb, eptdev, eptdev->chinfo);
> >> -- 
> >> 2.17.1
> >>
> > _______________________________________________
> > Linux-stm32 mailing list
> > Linux-stm32@st-md-mailman.stormreply.com
> > https://st-md-mailman.stormreply.com/mailman/listinfo/linux-stm32
> > 

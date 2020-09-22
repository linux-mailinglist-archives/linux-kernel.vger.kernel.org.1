Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF3102748FD
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgIVTWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgIVTWk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:22:40 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D927C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:22:40 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k8so13383495pfk.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L14mt/g8CAu9jAWZdD7P0nJx0vvCKpphuvpDY29hiVw=;
        b=GWE4dTwNEKjYJAdN8OTt1ybbnHt1rBPkRc6BPO5sn+9MCVC9X2YDUIewNM/pgA1f8l
         sPfJg+ZTBzEs8aVWr0OGtrP/bqj6Ra4mQYnYYe4loHOmh4q5gM3mSVe1hXS35/QTV6P2
         L8XxnwsUxDwVvpefMFQpOrdnksSWlQU4njtsiH7YlKBPH2BN19MmVbN49IxokfUc6j6D
         9W1DgLsLe2yfEjgl+j8HB9x2wBZpF/7Ya7uyuqqThLcTnP8ZPZgaKGv2qUEQpeZe4IIC
         QS8DYtq0gb2faQI8XNJMO4WsRRZ75xrtq2UNK1PyDPIXxrc4nFKT/4nkFGsb9VH1ZWq8
         yutA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L14mt/g8CAu9jAWZdD7P0nJx0vvCKpphuvpDY29hiVw=;
        b=Lxf7GFhMYyrJK3XLTs5EfXLH6mlkkpm3h3t2MOTqpsuZPxdEu16S9HwtsRFChcmGTg
         sM+MpICsWJJL/CyP8o0Z7RtCCmdPIy9ZtA3bJzlXcKcXFk3aTEMfijV6m8By1cmtnWzn
         8yUG92V1zZKrX7GL+mjBPYYRlFbM5dsqgsGwDltbMFmR+GHYsBObiIs3uWxBecIG6WAM
         C8J6a0Y2ba14F/a5WMtm8gsCIrxnAF4VgnbQea2a8UCoy522zQRWLk5lOgENadrhObfB
         cI9BsTb/DrP8ikWP/SkeVcl5dR7tbY4o26fBHR7yJYC6KxJyjuQS36PYOIGFNH+Udyr1
         tLZg==
X-Gm-Message-State: AOAM530U+r3CimohjF9tzqoU54FPO460JV0SOP5huBFMdPnXkHjfMb7Z
        EzLOGQSFYshp5P7kQ6Ij0chDhg==
X-Google-Smtp-Source: ABdhPJyFsDZPNZ1eLH+GQWVyuK7EQ3BDr8AoXEl2+2DzLiU/vosD1qDwLwumrGpwFQLnWl7azEAmLw==
X-Received: by 2002:aa7:948d:0:b029:13e:cb8d:60e0 with SMTP id z13-20020aa7948d0000b029013ecb8d60e0mr5550539pfk.9.1600802559917;
        Tue, 22 Sep 2020 12:22:39 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id o19sm15831125pfp.64.2020.09.22.12.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 12:22:39 -0700 (PDT)
Date:   Tue, 22 Sep 2020 13:22:37 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] rpmsg: virtio: rename rpmsg_create_channel
Message-ID: <20200922192237.GA931970@xps15>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
 <20200922001000.899956-2-mathieu.poirier@linaro.org>
 <20200922070603.GA4648@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200922070603.GA4648@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 22, 2020 at 09:06:03AM +0200, Guennadi Liakhovetski wrote:
> On Mon, Sep 21, 2020 at 06:09:51PM -0600, Mathieu Poirier wrote:
> > From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > 
> > Rename the internal function as it is internal, and as
> > the name will be used in rpmsg_core.
> > 
> > Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
> > ---
> >  drivers/rpmsg/virtio_rpmsg_bus.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/virtio_rpmsg_bus.c b/drivers/rpmsg/virtio_rpmsg_bus.c
> > index 7d7ed4e5cce7..e8d55c8b9cbf 100644
> > --- a/drivers/rpmsg/virtio_rpmsg_bus.c
> > +++ b/drivers/rpmsg/virtio_rpmsg_bus.c
> > @@ -395,8 +395,9 @@ static void virtio_rpmsg_release_device(struct device *dev)
> >   * this function will be used to create both static and dynamic
> >   * channels.
> >   */
> > -static struct rpmsg_device *rpmsg_create_channel(struct virtproc_info *vrp,
> > -						 struct rpmsg_channel_info *chinfo)
> > +static struct rpmsg_device *
> > +__rpmsg_create_channel(struct virtproc_info *vrp,
> > +		       struct rpmsg_channel_info *chinfo)
> 
> Nitpick: we now have 100 characters, so there's no *need* any more to split that 
> line, now it's more a matter of consistent style and personal preference. Most 
> functions in that file have function type and name on the same line, but a few 
> also make the split like here...
>
 So, we can choose our poison here I guess.
>

I agree - there is really no _better_ way of doing this.  I'll let Bjorn make
the final call but I'm pretty sure he doesn't have a strong opinion either.

> Thanks
> Guennadi
> 
> >  {
> >  	struct virtio_rpmsg_channel *vch;
> >  	struct rpmsg_device *rpdev;
> > @@ -869,7 +870,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >  		if (ret)
> >  			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> >  	} else {
> > -		newch = rpmsg_create_channel(vrp, &chinfo);
> > +		newch = __rpmsg_create_channel(vrp, &chinfo);
> >  		if (!newch)
> >  			dev_err(dev, "rpmsg_create_channel failed\n");
> >  	}
> > -- 
> > 2.25.1
> > 

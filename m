Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596622865DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgJGR0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbgJGR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:26:40 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173EEC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:26:39 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x5so1340437plo.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=M9ybGiqHvrypTyZEXdLpGDsphUXlCmQ4dG3V5WiWP+c=;
        b=hK7cH4Hi/OTAsATuPSF/XTD9n996EpRc1h5H9Pu2cn2i7W3Y+I4BuZKeYlUo/w/b35
         G8hDlilW3027XJeXWFviuDHG/IxcqdevZB5JAjXLBko1923w4dHEhrw2WvDAggSeOVDU
         ub2O0fqDEL0LnhcIR2eUu2t2lEj93U5R4f6zJNm6jP9hGMJVf50Cr6lgpylN9mtJnCyv
         V1mF1wjni/OjVuTplflycI62WIaI0l2df2ngb6Z5NURHxBuyRRBicvxsXhjgTI1+X0IH
         z+yjEQOEXq/y+oRUTpEe0BRM+g+WuThiuZp0NGeGZK04wVxbkDF0Cl+pmy8t7bfHhqz7
         x9gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M9ybGiqHvrypTyZEXdLpGDsphUXlCmQ4dG3V5WiWP+c=;
        b=H4OGjSRAxMFkA/fFwbhC1gHw/YeQt23OCH1o5FVJzCV7u2ho0o/2Cff7kNT2Rd1R48
         CQdERyJBx17ANv4ZIOgA3UYlITHiiqpW6dlGrmdzbhn8nkNygSzjUh3BWIqMF7Yt4Lq9
         o6dbtxzgP6+IEOWnY+NXwO615GzoTGeG1I24Ba8h4knUs1B5AGcjq5P4RS2QM3s1vobX
         SFNbu/uG6jzTac6wqxbBFWAF2lAgU7u52YnXh/ya3GdX7xjJQF919H0AS5Hv2bTiX8YR
         GuA69XrvHhESybu2p0A0LOGuHG5e74H9nIEZOaOyZAKl2nQIwkGwheE6qR7Nes47zOpw
         BunQ==
X-Gm-Message-State: AOAM5318Wk11kIQJ5ciw8SjjUYpCIO3pKEeZmHnQOVIi/OBNUxok3/wn
        NAjwBzAbu+zQJs5Ckgp3Y5iM+5000LOuFYX8
X-Google-Smtp-Source: ABdhPJxqdvCkHlZoZkrWmICIoJ7mRQH5Pym1nz8GkT6xy1fjzmpTNgxS0CG1uZPwNv+aiPcbo5lW0w==
X-Received: by 2002:a17:902:6b44:b029:d3:e78a:8ab6 with SMTP id g4-20020a1709026b44b02900d3e78a8ab6mr3747407plt.72.1602091598549;
        Wed, 07 Oct 2020 10:26:38 -0700 (PDT)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id e19sm4193538pfl.135.2020.10.07.10.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 10:26:37 -0700 (PDT)
Date:   Wed, 7 Oct 2020 11:26:36 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org, loic.pallardy@st.com,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 10/10] rpmsg: ns: Make Name service module transport
 agnostic
Message-ID: <20201007172636.GB575646@xps15>
References: <20200922001000.899956-1-mathieu.poirier@linaro.org>
 <20200922001000.899956-11-mathieu.poirier@linaro.org>
 <20200930071327.GG20683@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930071327.GG20683@ubuntu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 09:13:27AM +0200, Guennadi Liakhovetski wrote:
> On Mon, Sep 21, 2020 at 06:10:00PM -0600, Mathieu Poirier wrote:
> > Make name service module transport agnostic by using the rpmsg
> > device specific byte conversion routine.
> > 
> > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > ---
> >  drivers/rpmsg/rpmsg_ns.c | 10 ++++------
> >  include/linux/rpmsg_ns.h |  4 ++--
> >  2 files changed, 6 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
> > index b3318bf84433..1df3aaadfe10 100644
> > --- a/drivers/rpmsg/rpmsg_ns.c
> > +++ b/drivers/rpmsg/rpmsg_ns.c
> > @@ -18,9 +18,7 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >  	struct rpmsg_ns_msg *msg = data;
> >  	struct rpmsg_device *newch;
> >  	struct rpmsg_channel_info chinfo;
> > -	struct virtio_rpmsg_channel *vch = to_virtio_rpmsg_channel(rpdev);
> > -	struct virtproc_info *vrp = vch->vrp;
> > -	struct device *dev = &vrp->vdev->dev;
> > +	struct device *dev = &rpdev->dev;
> >  	int ret;
> >  
> >  #if defined(CONFIG_DYNAMIC_DEBUG)
> > @@ -38,13 +36,13 @@ static int rpmsg_ns_cb(struct rpmsg_device *rpdev, void *data, int len,
> >  
> >  	strncpy(chinfo.name, msg->name, sizeof(chinfo.name));
> >  	chinfo.src = RPMSG_ADDR_ANY;
> > -	chinfo.dst = virtio32_to_cpu(vrp->vdev, msg->addr);
> > +	chinfo.dst = rpmsg32_to_cpu(rpdev, msg->addr);
> >  
> >  	dev_info(dev, "%sing channel %s addr 0x%x\n",
> > -		 virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY ?
> > +		 rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY ?
> >  		 "destroy" : "creat", msg->name, chinfo.dst);
> >  
> > -	if (virtio32_to_cpu(vrp->vdev, msg->flags) & RPMSG_NS_DESTROY) {
> > +	if (rpmsg32_to_cpu(rpdev, msg->flags) & RPMSG_NS_DESTROY) {
> >  		ret = rpmsg_release_channel(rpdev, &chinfo);
> >  		if (ret)
> >  			dev_err(dev, "rpmsg_destroy_channel failed: %d\n", ret);
> > diff --git a/include/linux/rpmsg_ns.h b/include/linux/rpmsg_ns.h
> > index aabc6c3c0d6d..9f3030b2145b 100644
> > --- a/include/linux/rpmsg_ns.h
> > +++ b/include/linux/rpmsg_ns.h
> > @@ -41,8 +41,8 @@ struct rpmsg_hdr {
> >   */
> >  struct rpmsg_ns_msg {
> >  	char name[RPMSG_NAME_SIZE];
> > -	__virtio32 addr;
> > -	__virtio32 flags;
> > +	u32 addr;
> > +	u32 flags;
> 
> These aren't (necessarily) native endianness, right? Don't they deserve a 
> separate type? __rpmsg32?
> 

I kept them as u32 type to be as generic as possible and let the endianness
conversion callback do the work.  Making them a __rpmsg32 is a good idea, it
would force a proper implementation. 

> Thanks
> Guennadi
> 
> >  } __packed;
> >  
> >  /**
> > -- 
> > 2.25.1
> > 

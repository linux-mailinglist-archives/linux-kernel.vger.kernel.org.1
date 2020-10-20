Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3F0293683
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 10:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgJTIN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 04:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387511AbgJTIN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 04:13:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A09C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:13:26 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c77so807985wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 01:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=yjES9gaqH+r7PKEyUF//AteATy2JRLBioQzscOmtXtA=;
        b=JU+b83GXhEyYD9j42iFgaYqnEO9pM4i2Bnxt6a3R+hgfkw4l0pphxZBqjqWuycfUOv
         AregJP2jMrx2ZNIM+a1L2a+9YxvUrSigYexSKsti5xs69jqMYZqYUJ5KnsxGIXQmyfkN
         cRnfL+KygxgYnz3FGsyQquXL/4MJlSdYZ95ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=yjES9gaqH+r7PKEyUF//AteATy2JRLBioQzscOmtXtA=;
        b=OPdXz+0NcAlrgtcu9rwZsh+Rg5NekfXtza6J4ZPT/IAwAWzwpP42+tbLYZ+rQisQPW
         KVuRXm558JUZbZ52I/AVYbhB12D0WxAv/K9+wjKXmIhF8QH3EoSDsl1EhkK2ofVF7KqU
         03UBTlhpAU49ASYxhTBVaCKRFPbumnVPz3ARaiNobNjEDaNuYwELFA5aazBKqLRtGTgr
         +n2h2nwJvSqAcNKqV9kpttfKePVbbP5yKhbxl4mAXgF+ppMPcsLIH568F60BShSkmlDJ
         jb5U7VxRaUlWLZj+mBfW4dPnpxARgAR6LDtPbzaood5a5velDq8lcd+ySws2p2UWO64g
         nKrg==
X-Gm-Message-State: AOAM530MVRqBTfmft/0PnBZxPNEpY+WpsMSfh0RIfsTN5QA6BeNk1Xzp
        mQHSs5IcNVvYtdZSMDvna3UxWw==
X-Google-Smtp-Source: ABdhPJxnbA1ge0KCPiotTT9AHiVkZI9rcl5PStryqvQltSAM5y0gDcnp2H45cAeIHcdY9QnKtEvmcA==
X-Received: by 2002:a1c:e903:: with SMTP id q3mr1638057wmc.42.1603181604585;
        Tue, 20 Oct 2020 01:13:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v17sm1917002wrc.23.2020.10.20.01.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2020 01:13:23 -0700 (PDT)
Date:   Tue, 20 Oct 2020 10:13:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
Message-ID: <20201020081321.GI401619@phenom.ffwll.local>
Mail-Followup-To: Kever Yang <kever.yang@rock-chips.com>,
        Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200707112526.18438-1-hjc@rock-chips.com>
 <5c0cdb9d-8e35-fa0c-35b3-adfa7770fb30@rock-chips.com>
 <20201015152301.GE438822@phenom.ffwll.local>
 <e016801a-61aa-de6c-cb90-c62e03bdd067@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e016801a-61aa-de6c-cb90-c62e03bdd067@rock-chips.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 11:43:53AM +0800, Kever Yang wrote:
> Hi Daniel,
> 
> On 2020/10/15 下午11:23, Daniel Vetter wrote:
> > On Wed, Oct 14, 2020 at 09:48:43AM +0800, Kever Yang wrote:
> > > Hi Maintainers,
> > > 
> > >      Does this patch ready to merge?
> > Would maybe be good to get some acks from other drivers using this, then
> > Sandy can push to drm-misc-next.
> 
> Thanks for your reply, I can understand more 'acks' will be better, but
> there is no comments object to this patch
> 
> or any 'NAK' common for more then 3 months, maintainers should move to next
> step.

I expect you to poke relevant driver maintainers directly for these acks.
That was the purpose of my mail. All communication going through
maintainers, being exclusively orchestrated by maintainers, just doesn't
scale. So not an option for a big subsystem like drivers/gpu.

Hope that makes it clear.

For merging Sandy has commit rights to drm-misc, so that's not the
problem.

Cheers, Daniel

> 
> 
> Thanks,
> 
> - Kever
> 
> > -Daniel
> > > On 2020/7/7 下午7:25, Sandy Huang wrote:
> > > > don't mask possible_crtcs if remote-point is disabled.
> > > > 
> > > > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > > > ---
> > > >    drivers/gpu/drm/drm_of.c | 3 +++
> > > >    1 file changed, 3 insertions(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > > > index fdb05fbf72a0..565f05f5f11b 100644
> > > > --- a/drivers/gpu/drm/drm_of.c
> > > > +++ b/drivers/gpu/drm/drm_of.c
> > > > @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
> > > >    	uint32_t possible_crtcs = 0;
> > > >    	for_each_endpoint_of_node(port, ep) {
> > > > +		if (!of_device_is_available(ep))
> > > > +			continue;
> > > > +
> > > >    		remote_port = of_graph_get_remote_port(ep);
> > > >    		if (!remote_port) {
> > > >    			of_node_put(ep);
> > > Looks good to me.
> > > 
> > > 
> > > Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

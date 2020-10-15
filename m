Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A891328F5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 17:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388946AbgJOPXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 11:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 11:23:06 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C90C061755
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:23:05 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id g12so3963729wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 15 Oct 2020 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=37I63cZBodA+13wzLqZfOcrBqfvt4ww4Wg+i0WcmZ1o=;
        b=T+bebg+YD46I6Hulxd9R88hBGXswgNHgXR0A/YJJrQtmpNN2az61LLTpHx08Ky8qfP
         rg0NBZBPJk2cKDM+H4K3WnVuFEZejqm1XPacEKoLgD1V8exuQRx/JBP47RiMfp0lrNKs
         qSjJ4WyTF02hebJ0G5b1UxVgqX83E1+oYSL74=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=37I63cZBodA+13wzLqZfOcrBqfvt4ww4Wg+i0WcmZ1o=;
        b=DoI7oKsHwpYxWTsG2pKiYl1PQ+qHoU392134p0e6Qswm4wraoDhYvSSiQ/9PNtoCdU
         FgwQFrOjrMHY82kpPn8+sGvTo10WR/bUvkPgR1wlPK6C1T+xSOSXw0aw1BBgQ4Pr49kQ
         rMWitxYwiTZYix1WAxS3IDwkFv4OgF0NoGBGbN0GMdrciwsqhU4OT95/6j47KhCVy36j
         1P11vfCC8TphydPdSUjLBi668jZCcPvB+FO8fbza8Jddm/ZMZXmbqQQMZJdUvayK8qIb
         9eUfQOfZTEaRy+giMiabTuEz/b6Gsz3ZlqK2mzvySsPMcYzkLneAAkY0UyGcbzj/uN5Y
         c5qw==
X-Gm-Message-State: AOAM533BXowx+rNDchHmJdBgWhzEzQxeOjNRP6vHX7y22XlxpcekGJCc
        bChCC3ezvBi+HRyWofnHnwZbgQ==
X-Google-Smtp-Source: ABdhPJz60cxmP1IUgfdwoRtfsr/U5/cjrhpBEp04wKon+qeZgoUhNl224cILQcKvdUU3iiEaIgb54g==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr4820538wrt.51.1602775384469;
        Thu, 15 Oct 2020 08:23:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x3sm5050001wmi.45.2020.10.15.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 08:23:03 -0700 (PDT)
Date:   Thu, 15 Oct 2020 17:23:01 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Kever Yang <kever.yang@rock-chips.com>
Cc:     Sandy Huang <hjc@rock-chips.com>, heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, huangtao@rock-chips.com,
        andy.yan@rock-chips.com, linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/of: Consider the state in which the ep is disabled
Message-ID: <20201015152301.GE438822@phenom.ffwll.local>
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
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0cdb9d-8e35-fa0c-35b3-adfa7770fb30@rock-chips.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 14, 2020 at 09:48:43AM +0800, Kever Yang wrote:
> Hi Maintainers,
> 
>     Does this patch ready to merge?

Would maybe be good to get some acks from other drivers using this, then
Sandy can push to drm-misc-next.
-Daniel
> 
> On 2020/7/7 下午7:25, Sandy Huang wrote:
> > don't mask possible_crtcs if remote-point is disabled.
> > 
> > Signed-off-by: Sandy Huang <hjc@rock-chips.com>
> > ---
> >   drivers/gpu/drm/drm_of.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index fdb05fbf72a0..565f05f5f11b 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -66,6 +66,9 @@ uint32_t drm_of_find_possible_crtcs(struct drm_device *dev,
> >   	uint32_t possible_crtcs = 0;
> >   	for_each_endpoint_of_node(port, ep) {
> > +		if (!of_device_is_available(ep))
> > +			continue;
> > +
> >   		remote_port = of_graph_get_remote_port(ep);
> >   		if (!remote_port) {
> >   			of_node_put(ep);
> 
> Looks good to me.
> 
> 
> Reviewed-by: Kever Yang <kever.yang@rock-chips.com>
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414652A2B51
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 14:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgKBNSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 08:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgKBNSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 08:18:02 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E25B9C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 05:18:01 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id a9so14532806wrg.12
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 05:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZIqlXIfq5xntoWvtlW/vms8/Ik9yB8yy1Md20jy3FIk=;
        b=Y+lbD3NHv9Q1Lrb7kALnmHYZdWbOYJQB/m92V7HhsnJ6fNbnXexP0ImpltLcUHlvfB
         aU1f+LpfFv0KvE+Dsz1YWjx157GNjrNPqw4E3IeQjluM1zvHNoiSMQ82LXCYBq735EQ3
         YcCNyOr4U98q+sQmG+QUY6ngTjl6FIcgBW4Do=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=ZIqlXIfq5xntoWvtlW/vms8/Ik9yB8yy1Md20jy3FIk=;
        b=lw28hgkScBVebUdYWfo61MEdWhNddMR1TnnXYkVKhOJisTnrXhVesVXFr1HKBHwkg+
         1LQHwHsey9qEMJMixkX5tzbAU7IMV0CdmZqvpD4ErcC0MwTIbQYoFwlG63Uufzg28K9D
         XxdU0pGhQe3AP0gzjWsQa97c9NV1KWscMaTpSX+Jj1Hy/aqq7Ej59QizL7IAoTHidJCh
         ywYUCXV7+Pz5lMnptoy+PeiR56fXOlAfPR3LwwuY8MFUMkkZa6UfjwzHYvUeu/KvoUtw
         dYEyjlVN/ToXtkx+Quph4//BAH7hoE0A7SByqT5ODlVu0W1fqxbSxD6g9KrRuEDBKcnQ
         1RHA==
X-Gm-Message-State: AOAM531DhXUJgohn6c21FqlKLf18gBnHccahSNUURFwBcgbXJKZAueSA
        m4Jumy+7DAl20j+0kQrQ9E1Uew==
X-Google-Smtp-Source: ABdhPJyF8C0k5C9m1IBd3mC8j+J2oYVicusKVxv/pcvu+M/KQmTyp1FmZoIuTyrXSE77eDAz5OhP9w==
X-Received: by 2002:adf:e9cc:: with SMTP id l12mr14613849wrn.248.1604323080359;
        Mon, 02 Nov 2020 05:18:00 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z14sm16017863wmc.15.2020.11.02.05.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 05:17:59 -0800 (PST)
Date:   Mon, 2 Nov 2020 14:17:57 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Bernard <bernard@vivo.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
Subject: Re: Re: [PATCH] gpu/drm: make crtc check before new_connector circle
Message-ID: <20201102131757.GP401619@phenom.ffwll.local>
Mail-Followup-To: Bernard <bernard@vivo.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, opensource.kernel@vivo.com
References: <20201102101724.GO401619@phenom.ffwll.local>
 <APsA*wDGDQPaL*xHM6wdLqpj.3.1604322810049.Hmail.bernard@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <APsA*wDGDQPaL*xHM6wdLqpj.3.1604322810049.Hmail.bernard@vivo.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 09:13:30PM +0800, Bernard wrote:
> 
> 
> From: Daniel Vetter <daniel@ffwll.ch>
> Date: 2020-11-02 18:17:24
> To:  Bernard Zhao <bernard@vivo.com>
> Cc:  Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,Maxime Ripard <mripard@kernel.org>,Thomas Zimmermann <tzimmermann@suse.de>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
> Subject: Re: [PATCH] gpu/drm: make crtc check before new_connector circle>On Sun, Nov 01, 2020 at 06:58:51PM -0800, Bernard Zhao wrote:
> >> In function prepare_signaling, crtc check (c==0) is not related
> >> with the next new_connector circle, maybe we can put the crtc
> >> check just after the crtc circle and before new_connector circle.
> >> This change is to make the code to run a bit first.
> >
> >I'm a bit confused here with your explanation, I'm not understanding why
> >you do this change ... Can you pls elaborate? Maybe give an example or
> >something of the problem this patch solves, that often helps.
> >
> >Thanks, Daniel
> 
> Hi:
> 
> This change is to make the function return error earlier when run into the error branch:
> if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
>     return -EINVAL;
> There two main FOR circles in this function, and the second FOR circle
> never changes the if condition("(c == 0 && (arg->flags &
> DRM_MODE_PAGE_FLIP_EVENT))") variable`s value, like c & arg->flags.  So
> I think maybe we can check this condition before the second for circle,
> and return the error earlier when run into this error branch.

Ah ok. Makes sense, but this case is only ever hit for bad userspace that
got something wrong, so I'm not sure we should optimize for this. And with
this we kinda bury this fairly important check in the middle, so I don't
think it improves code readability.
-Daniel

> 
> BR//Bernard
> 
> >> 
> >> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> >> ---
> >>  drivers/gpu/drm/drm_atomic_uapi.c | 13 ++++++-------
> >>  1 file changed, 6 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
> >> index 25c269bc4681..566110996474 100644
> >> --- a/drivers/gpu/drm/drm_atomic_uapi.c
> >> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
> >> @@ -1182,6 +1182,12 @@ static int prepare_signaling(struct drm_device *dev,
> >>  
> >>  		c++;
> >>  	}
> >> +	/*
> >> +	 * Having this flag means user mode pends on event which will never
> >> +	 * reach due to lack of at least one CRTC for signaling
> >> +	 */
> >> +	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> >> +		return -EINVAL;
> >>  
> >>  	for_each_new_connector_in_state(state, conn, conn_state, i) {
> >>  		struct drm_writeback_connector *wb_conn;
> >> @@ -1220,13 +1226,6 @@ static int prepare_signaling(struct drm_device *dev,
> >>  		conn_state->writeback_job->out_fence = fence;
> >>  	}
> >>  
> >> -	/*
> >> -	 * Having this flag means user mode pends on event which will never
> >> -	 * reach due to lack of at least one CRTC for signaling
> >> -	 */
> >> -	if (c == 0 && (arg->flags & DRM_MODE_PAGE_FLIP_EVENT))
> >> -		return -EINVAL;
> >> -
> >>  	return 0;
> >>  }
> >>  
> >> -- 
> >> 2.29.0
> >> 
> >
> >-- 
> >Daniel Vetter
> >Software Engineer, Intel Corporation
> >http://blog.ffwll.ch
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACAF9292AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730320AbgJSPoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbgJSPom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:44:42 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCA2C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:44:41 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d3so307097wma.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZKAL2hZ3qOMWxJzH1IwKgv2j9AVNcU1OrEysy54jR20=;
        b=FQdQEmvxir1K1aSRwc/YD4OVhWIMURxeuwSI9q/LNHwUOw91nTK9CTKgBWOc/AgZEd
         5RIIYazWw8sNuCWtZMasBoU/vyV3T+ET1FUyoh+jurtniuoLYL8lKeCvnNdjk7bpySfc
         ZQSf9esLS8szzSzrUyms+bCdcYe3U35tH/skc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=ZKAL2hZ3qOMWxJzH1IwKgv2j9AVNcU1OrEysy54jR20=;
        b=j/tKQvCDkzjFOCyPZ2qNQVHk/nhLB98MoBCA+ypGST9vhFKzz5iO1P04xYcej026/t
         w9pHtMe9pMqe4SSP+vc1rC8fGu6GDYSu/Jcyat3E0BbDoLG2bwn9ymLvpO8XVjy+6t6X
         qAugb8TlPgW8RpQQnaQ1lmMtYsNScP2KWjt5LWVFpF8CAI7/wiGU5FHY1cCM6+dvV1KD
         27MWq+rBjFKEKacr2chif5axs9WlaIOA/6aGdhwM9jWRIaNujGemNueVKSeFGGHDK67b
         FqgR9BuwEpm28m4qxN/8BPJQra8OOvJv9Yj9fqSCV7r9ilvO3OdgnwbyfSFK163anqFz
         MB7Q==
X-Gm-Message-State: AOAM5319GUloSuhjj2jvsCzP60b/VO0fYHD4DGVx9X5FXtDUUSjtzYMC
        BF12TmooXkDknZSnp5Yo/YjFbg==
X-Google-Smtp-Source: ABdhPJx+1Aku6RCS8tZ4DS52dzWXQ674ssKWd4gf8//xA0eTRcqBv49MCEwytlX/u9Aulak9Afz9VQ==
X-Received: by 2002:a1c:9854:: with SMTP id a81mr40477wme.72.1603122280474;
        Mon, 19 Oct 2020 08:44:40 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id f17sm486108wme.22.2020.10.19.08.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 08:44:39 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:44:37 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] drm/panel: mantix panel reset fixes
Message-ID: <20201019154437.GE401619@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <cover.1602584953.git.agx@sigxcpu.org>
 <20201016142916.GA1184974@ravnborg.org>
 <20201017091307.GA2885@bogon.m.sigxcpu.org>
 <20201017104736.GA2822081@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201017104736.GA2822081@ravnborg.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 17, 2020 at 12:47:36PM +0200, Sam Ravnborg wrote:
> Hi Guido.
> 
> On Sat, Oct 17, 2020 at 11:13:07AM +0200, Guido Günther wrote:
> > Hi Sam,
> > On Fri, Oct 16, 2020 at 04:29:16PM +0200, Sam Ravnborg wrote:
> > > Hi Guido.
> > > On Tue, Oct 13, 2020 at 12:32:45PM +0200, Guido Günther wrote:
> > [..snip..]
> > > > 
> > > > Changes from v1:
> > > >  - As per review comments by Fabio Estevam
> > > >    https://lore.kernel.org/dri-devel/CAOMZO5B5ECcConvKej=RcaF8wvOxgq7nUzKJ-ad0aSAOzUqtbQ@mail.gmail.com/
> > > >    - Fix typo in commit messages
> > > >  - As per review comments by Rob Herring
> > > >    https://lore.kernel.org/dri-devel/20200929174624.GA832332@bogus/
> > > >    - Don't use an array of reset lines
> > > > 
> > > > Guido Günther (3):
> > > >   drm/panel: mantix: Don't dereference NULL mode
> > > >   drm/panel: mantix: Fix panel reset
> > > >   dt-binding: display: Require two resets on mantix panel
> > > 
> > > All applied to drm-misc-next and pushed out.
> > > And then I remembered you had commit right - sigh.
> > 
> > Thanks! Is there any special care needed to get that into 5.10? The
> > driver landed there in 72967d5616d3f0c714f8eb6c4e258179a9031c45.
> 
> As the patches was applied to drm-misc-next the easiet path would
> be to cherry-pick them and apply to drm-misc-fixes.
> dim has cherry-pick support - try to use it rahter than doing it by
> hand.

drm-misc-next-fixes while we're between freeze and merge window end:

https://drm.pages.freedesktop.org/maintainer-tools/committer-drm-misc.html#where-do-i-apply-my-patch

Cheers, Daniel

> 

> When you apply to drm-misc-fixes include a Fixes: tag so the tooling
> will pick the patches automagically.
> 
> In hindsight the patches should have carried a Fixes: tag from a start
> and should have been applied to drm-misc-fixes from a start too.
> 
> I have done something like above once or twice but anyway reach out if
> you have questions. Or ask at #dri-devel.
> 
> 	Sam

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

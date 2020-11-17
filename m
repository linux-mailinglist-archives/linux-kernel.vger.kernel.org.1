Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05D72B6E37
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727166AbgKQTO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbgKQTOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:14:55 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3666AC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:14:55 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id c17so24320923wrc.11
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HeTcjS/dd0NEqamTnE+1Ub8o0IkKzsWK8FFem51/YMU=;
        b=Y08Epjyl0jv752OAzfMzijr+QPSBQZvxPmJB73xMBGTQ7catufmLM8vobZzdseitJ+
         mqNBHjjJhvo/8Mjajlnm+MCG5V4xVT9IP1pRMdrltgKlNaVUFL630be158TXSWqhoTaA
         7q4y8bHLolzBmRg2J/GE026V5BtEulCYFECXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HeTcjS/dd0NEqamTnE+1Ub8o0IkKzsWK8FFem51/YMU=;
        b=SJNujuW+TEp8KoDjvpCArbm56ayo8SpHg72waFONg+zlUAmutmNmCX4ULQfHnJIIF6
         +7pKnDiYFwjyenCU0Dlm6EJ6bCKOgKodisCW01xd/Ix+HhA8DSBZjm5Z3KFVWPWhEA9F
         mEWZDpSNaxJS6KJU0mH6pPXAmavV8ACKbtd/WUMFkVAVotlUP3t1d1sZqCtvJZKdvWsA
         /SI09RoMp9nT1RUld/SEjO4jFl+tRW2D/eBLvM2/+41JU8hrKOzDqbKv8aUtg3Of7W/w
         CkkC5B+ZcF2+7mN0kOosZWH682F2qQNp5kqDKDFr/u42z0ioQZMgHSnqoZlMduEIWwmT
         qK/w==
X-Gm-Message-State: AOAM530sDpR1XQnPpNySe7cQH3/j1fkMrMMgskKz3Ws0YYZDZG7Seo03
        9Clr19i5X9aCeLaBa4B/URUFzg==
X-Google-Smtp-Source: ABdhPJxwGv9J2uCXaMCQag4+rIx+29M/rQeIQQVZBJw+rPjxUyGFygtXGZEg9n2MqtBn8+E5HjCATg==
X-Received: by 2002:a5d:4d02:: with SMTP id z2mr1050907wrt.109.1605640493957;
        Tue, 17 Nov 2020 11:14:53 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q66sm5489733wme.6.2020.11.17.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 11:14:53 -0800 (PST)
Date:   Tue, 17 Nov 2020 20:14:51 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 32/42] drm/ttm/ttm_tt: Demote kernel-doc header format
 abuses
Message-ID: <20201117191451.GT401619@phenom.ffwll.local>
Mail-Followup-To: Lee Jones <lee.jones@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-33-lee.jones@linaro.org>
 <bcb40255-312f-8cdb-28a8-7ee2e6596f90@amd.com>
 <20201117083346.GB1869941@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201117083346.GB1869941@dell>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 08:33:46AM +0000, Lee Jones wrote:
> On Mon, 16 Nov 2020, Christian König wrote:
> 
> > Am 16.11.20 um 18:41 schrieb Lee Jones:
> > > Fixes the following W=1 kernel build warning(s):
> > > 
> > >   drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'bo' not described in 'ttm_tt_create'
> > >   drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'zero_alloc' not described in 'ttm_tt_create'
> > >   drivers/gpu/drm/ttm/ttm_tt.c:83: warning: Function parameter or member 'ttm' not described in 'ttm_tt_alloc_page_directory'
> > 
> > Couldn't we rather describe the missing parameters? Shouldn't be much work.
> 
> My rule is; if a substantial attempt has been made to document
> something, I'll patch it up.  If little or no attempt has been made,
> then it gets demoted.
> 
> Please feel free to document and upgrade them once more.
> 
> Bear in mind however, there is a script that reports on all files
> which utilise kernel-doc notation but do not have matching references
> from the Documentation area.
> 
> See: scripts/find-unused-docs.sh

ttm docs need some serious love anyway, so I think this is fine. I applied
it.
-Daniel

> 
> > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > Cc: Huang Rui <ray.huang@amd.com>
> > > Cc: David Airlie <airlied@linux.ie>
> > > Cc: Daniel Vetter <daniel@ffwll.ch>
> > > Cc: dri-devel@lists.freedesktop.org
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >   drivers/gpu/drm/ttm/ttm_tt.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> > > index cfd633c7e7643..da9eeffe0c6d7 100644
> > > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > > @@ -38,7 +38,7 @@
> > >   #include <drm/drm_cache.h>
> > >   #include <drm/ttm/ttm_bo_driver.h>
> > > -/**
> > > +/*
> > >    * Allocates a ttm structure for the given BO.
> > >    */
> > >   int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
> > > @@ -73,7 +73,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
> > >   	return 0;
> > >   }
> > > -/**
> > > +/*
> > >    * Allocates storage for pointers to the pages that back the ttm.
> > >    */
> > >   static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
> > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

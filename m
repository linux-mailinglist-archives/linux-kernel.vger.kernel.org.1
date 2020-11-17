Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73F2B5B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 09:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbgKQIdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 03:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgKQIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 03:33:50 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA31C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:33:50 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id w24so2410387wmi.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 00:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jXS3JRBqPu/ouJmDg/xmae2SThRp3NsRXzX2BYUctrU=;
        b=NmDzOe3LdbzfAZUeAM5vuY/Mc3PzHlr9l4joMVf2ePlGLMAfdlwlLXItkNSZVXdlUH
         61q4xOhCxXR9dwUy0CYZVCeVZ3tBJD4FwoWLPX9vgGoamWYYvdM3NdLk9myeQ7+5CLsJ
         jPEhnoyVbbHGBWsbGjK8+3LQs6QjCFRVSu8kbBkzvEUyID6y+hEub7ZZUMcwmR869kbt
         hxYppdO+bCfFgMoc19/HDXKbRrRIEDwYs6FxoYIzX9skfHDfu19ZkP7kAsmdAcDqygcQ
         3JmmDXy6cTZtXdd6zYr2niLwvElDY3Fq5uU8r1zridlAev+wPMEngwj5WplY8JmjpsXH
         y5Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jXS3JRBqPu/ouJmDg/xmae2SThRp3NsRXzX2BYUctrU=;
        b=WxYnfQnerCofUoMcKI0HLfk1zNRTRY/Lr30fvxoIgkj/ABTU7i0VAIX4za5zVoxOUj
         uKpsx88GhRJLBDPEZju4fSBAgxT4bXcFGoA+OfR0idyxofCZnFuxohdJ4n28FP32YJOT
         pGrMc7KffEC8CKUEMagTL1nc6kQGbMpZwxAKyW/rsw/vf+u3Md5WAhfuzJq3e1A2lnZ9
         SQ5bxVZTpchrpjgXL3R1sgR14Qw4zjXXz6nWnJ5iwLW5hlvBXxgUgQYBLiroFoWTWAhy
         DrtIbNvsXp4TTR3HvNoOAPln8CHBcVC8eLX5fzVomkTjfLx0qi4jHqycoe1j/tyctcEP
         2NaA==
X-Gm-Message-State: AOAM532j9zDGrplA9w8tvdzCLG1UMUmAb/ihkoDsdEXAeDQlt/DQU3qp
        rYmYG5RUMsJY27FWyWFI2ZCOyg==
X-Google-Smtp-Source: ABdhPJzxWk6XuiGhBXFExyZ0JfUqN1RS3xrB52XjjVNRYWA6fBykStdQeer94ktHR6GxDDziqP+i2Q==
X-Received: by 2002:a7b:cb13:: with SMTP id u19mr3050107wmj.89.1605602028789;
        Tue, 17 Nov 2020 00:33:48 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id u14sm23640010wrq.93.2020.11.17.00.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2020 00:33:47 -0800 (PST)
Date:   Tue, 17 Nov 2020 08:33:46 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc:     linux-kernel@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 32/42] drm/ttm/ttm_tt: Demote kernel-doc header format
 abuses
Message-ID: <20201117083346.GB1869941@dell>
References: <20201116174112.1833368-1-lee.jones@linaro.org>
 <20201116174112.1833368-33-lee.jones@linaro.org>
 <bcb40255-312f-8cdb-28a8-7ee2e6596f90@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bcb40255-312f-8cdb-28a8-7ee2e6596f90@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Nov 2020, Christian König wrote:

> Am 16.11.20 um 18:41 schrieb Lee Jones:
> > Fixes the following W=1 kernel build warning(s):
> > 
> >   drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'bo' not described in 'ttm_tt_create'
> >   drivers/gpu/drm/ttm/ttm_tt.c:45: warning: Function parameter or member 'zero_alloc' not described in 'ttm_tt_create'
> >   drivers/gpu/drm/ttm/ttm_tt.c:83: warning: Function parameter or member 'ttm' not described in 'ttm_tt_alloc_page_directory'
> 
> Couldn't we rather describe the missing parameters? Shouldn't be much work.

My rule is; if a substantial attempt has been made to document
something, I'll patch it up.  If little or no attempt has been made,
then it gets demoted.

Please feel free to document and upgrade them once more.

Bear in mind however, there is a script that reports on all files
which utilise kernel-doc notation but do not have matching references
from the Documentation area.

See: scripts/find-unused-docs.sh

> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/gpu/drm/ttm/ttm_tt.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> > index cfd633c7e7643..da9eeffe0c6d7 100644
> > --- a/drivers/gpu/drm/ttm/ttm_tt.c
> > +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> > @@ -38,7 +38,7 @@
> >   #include <drm/drm_cache.h>
> >   #include <drm/ttm/ttm_bo_driver.h>
> > -/**
> > +/*
> >    * Allocates a ttm structure for the given BO.
> >    */
> >   int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
> > @@ -73,7 +73,7 @@ int ttm_tt_create(struct ttm_buffer_object *bo, bool zero_alloc)
> >   	return 0;
> >   }
> > -/**
> > +/*
> >    * Allocates storage for pointers to the pages that back the ttm.
> >    */
> >   static int ttm_tt_alloc_page_directory(struct ttm_tt *ttm)
> 

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

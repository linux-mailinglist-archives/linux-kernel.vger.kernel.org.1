Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141502AE97C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 08:18:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726311AbgKKHRc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 02:17:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgKKHQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 02:16:14 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F9D6C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:16:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h62so1338248wme.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 23:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+nPLAs9D2ufq7P4TZ41Op/D3bZShS4W5mF/VA6cz7/U=;
        b=mhLpXVeLoB/gkb+Az2aKW+BxBUlNW8rOmuRdOt96oIEMScXjIzJcNXw+VyxJ2zyqqD
         63lwWwl1iABwU2vFZf+lFGzPhbV4zMGFQddJNtt4jKve+Eafqby5GghY9WhQJdlQqZVl
         YXOQuEYjZinIUoRx5rvmldASKFngyXdqpzIKEB5JzqOuwtXJsbfCV24ikJTrExjv9xPx
         EKunKqMNq5IHYKC0EfAMyeLkY2J5rxBHYqSy2jqLO0Iiars08t2njEz+EVypbmWcQFVT
         Wn9Uk2cW+kMLbLWMOIBtFWj9Rov1xWzWiZSppd2jTU1Qvra5tSmai8BsptEgEp/doiTJ
         zzwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+nPLAs9D2ufq7P4TZ41Op/D3bZShS4W5mF/VA6cz7/U=;
        b=OW1zV4S3c4sOrLwikRTTw3EAiz6Korr2HcsHhFQLnWzBUAN4ECAj/Khm/gUBhKggHZ
         PqlO2NxbQCt4DOu0/7dTGh8onVN4yvdIjPCA6u2TfjFapObfVJP5KU1XNQ/nyFvhMymd
         xDcmzOxB6x9AGaLU6o2dmscHf1/yEIy3MCmeRPNTf61DHKCvBSV9b/RDw5Xy59gbXxlI
         U7+KsxY/FfYsRJWqZhwNNShY6SivmFaAesFhnx32JB4vtxQW6r/fcu97DePaJ0ye9FBB
         CQhzYqcbPrgGcV7mZD2NLwMsIdXgJ9XS2pPtGl3FVYJybd2BOVoVZl9788+Fkm4w6LoO
         W20g==
X-Gm-Message-State: AOAM533+Do9/pjeWQ85I4ZUzRMm5hjFQuP2I0IiuMFXkbUaeSFel26s8
        eacY4Yjsl6HSdsOUqGNsxsIWwQ==
X-Google-Smtp-Source: ABdhPJxq9nNsRdWxmsjRvYKprThebW/E99OrwREqb9B0XCSt/1vALQHP41UyvyzHl/CpRtuLhn++Fg==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr2293473wmg.21.1605078966759;
        Tue, 10 Nov 2020 23:16:06 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id w1sm1275524wro.44.2020.11.10.23.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2020 23:16:06 -0800 (PST)
Date:   Wed, 11 Nov 2020 07:16:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/30] drm/radeon/evergreen: Add comment for
 'evergreen_page_flip()'s 'async' param
Message-ID: <20201111071604.GN2063125@dell>
References: <20201110193112.988999-1-lee.jones@linaro.org>
 <20201110193112.988999-2-lee.jones@linaro.org>
 <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_MMDnk7fvoOv8poVvCx1EVGQ0XvujHG=fBwR5XgSO+qww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Nov 2020, Alex Deucher wrote:

> On Tue, Nov 10, 2020 at 2:31 PM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/radeon/evergreen.c: In function ‘evergreen_gpu_init’:
> >  drivers/gpu/drm/radeon/evergreen.c:1419: warning: Function parameter or member 'async' not described in 'evergreen_page_flip'
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied with minor fixups.  Thanks!

Superstar!  Thanks Alex.

Once these are all in -next, I'll rebase and fix the stragglers.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

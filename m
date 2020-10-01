Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF3D27FBDA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731604AbgJAItD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbgJAItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:49:03 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD34DC0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 01:49:00 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x14so4675355wrl.12
        for <linux-kernel@vger.kernel.org>; Thu, 01 Oct 2020 01:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=z3W/+UmHFDJR18MuX6sQgP8oE7n6vaF6n11YCm+XJiI=;
        b=U/JeWGe3SdUqAg1gTu7Y3Xv3WAzhqdCQ4Mu1Hi8lxqEJtuJ/8vwe90fj/S6vDe/me/
         ssWLVdhX73q1L0zPWAOlDGAgTDEapccIDXp/kK9DqX0y0ZCS58gT2lXDhzTlJE/lyp78
         4xETKJogwAFFERKf6kBBCLoC8phbOF9BsoIZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=z3W/+UmHFDJR18MuX6sQgP8oE7n6vaF6n11YCm+XJiI=;
        b=fl0+I7MyjbEnbz992L2vNk/Xu7Nu6bUS8TuvVCwX73rd+fK9zlpKgm25lALAB9Zaa2
         Gq0CHexozG6ByI2rESoiseOnw+rDjeHymBBOo/Ae7JKr12zB9/+Y1gjpLw1XhkWNnyZe
         LNmZzCvDmiNTrWpmT/SUHJAV9L5W2D/oD3OVO1iDbZnIMfHerAJsn9joYXtJY/+lze+X
         q3XUaIygXwjnKpNLjgxANMeYPV8Oh5IO+iLQojI0j4e419u4e4O5jWoyq2C3cPfVIbEg
         65NG5oadNH4bgpFJlsWQtYTViiTgKNrsM/d9N+wvHStDl6+jaRryC/eeR2t5+tUfN26J
         iwBw==
X-Gm-Message-State: AOAM530fvpC2qZ3/TjBV1jtE+XcEke3ImZyWsKUjsoR4G0EIogRqZaTz
        RWtJoKfovmg4PwI6rl8HN8QLHQ==
X-Google-Smtp-Source: ABdhPJxOxyoDX0b5gNKiFbSaDU5KDIBVsfBcvH3wwR1QPfbuHsRGFXu73fInXCqwuMEGoH0WdO1vqA==
X-Received: by 2002:a5d:4a48:: with SMTP id v8mr7600342wrs.304.1601542139344;
        Thu, 01 Oct 2020 01:48:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y1sm7475729wma.36.2020.10.01.01.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2020 01:48:58 -0700 (PDT)
Date:   Thu, 1 Oct 2020 10:48:56 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Alexandre Bailon <abailon@baylibre.com>
Cc:     linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        gpain@baylibre.com, stephane.leprovost@mediatek.com,
        jstephan@baylibre.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        mturquette@baylibre.com, bjorn.andersson@linaro.org,
        christian.koenig@amd.com, linux-media@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] Add a RPMsg driver to support AI Processing Unit
 (APU)
Message-ID: <20201001084856.GC438822@phenom.ffwll.local>
Mail-Followup-To: Alexandre Bailon <abailon@baylibre.com>,
        linux-remoteproc@vger.kernel.org, ohad@wizery.com,
        gpain@baylibre.com, stephane.leprovost@mediatek.com,
        jstephan@baylibre.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        mturquette@baylibre.com, bjorn.andersson@linaro.org,
        christian.koenig@amd.com, linux-media@vger.kernel.org
References: <20200930115350.5272-1-abailon@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930115350.5272-1-abailon@baylibre.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 01:53:46PM +0200, Alexandre Bailon wrote:
> This adds a RPMsg driver that implements communication between the CPU and an
> APU.
> This uses VirtIO buffer to exchange messages but for sharing data, this uses
> a dmabuf, mapped to be shared between CPU (userspace) and APU.
> The driver is relatively generic, and should work with any SoC implementing
> hardware accelerator for AI if they use support remoteproc and VirtIO.
> 
> For the people interested by the firmware or userspace library,
> the sources are available here:
> https://github.com/BayLibre/open-amp/tree/v2020.01-mtk/apps/examples/apu

Since this has open userspace (from a very cursory look), and smells very
much like an acceleration driver, and seems to use dma-buf for memory
management: Why is this not just a drm driver?
-Daniel

> 
> Alexandre Bailon (3):
>   Add a RPMSG driver for the APU in the mt8183
>   rpmsg: apu_rpmsg: update the way to store IOMMU mapping
>   rpmsg: apu_rpmsg: Add an IOCTL to request IOMMU mapping
> 
> Julien STEPHAN (1):
>   rpmsg: apu_rpmsg: Add support for async apu request
> 
>  drivers/rpmsg/Kconfig          |   9 +
>  drivers/rpmsg/Makefile         |   1 +
>  drivers/rpmsg/apu_rpmsg.c      | 752 +++++++++++++++++++++++++++++++++
>  drivers/rpmsg/apu_rpmsg.h      |  52 +++
>  include/uapi/linux/apu_rpmsg.h |  47 +++
>  5 files changed, 861 insertions(+)
>  create mode 100644 drivers/rpmsg/apu_rpmsg.c
>  create mode 100644 drivers/rpmsg/apu_rpmsg.h
>  create mode 100644 include/uapi/linux/apu_rpmsg.h
> 
> -- 
> 2.26.2
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

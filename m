Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC9362C3060
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbgKXTCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404154AbgKXTCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:02:09 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD09FC0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:02:08 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a3so2015wmb.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 11:02:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Iqfo9keS2TpK9GfS0c0b6OiBQlmC8pD8aAHf7OaR9CI=;
        b=HpLbM+V0jq7UNWv0s31h85bdrOxL/5xJyr4X+waMFda7d4JHut00b11AorcytoyUtN
         yc05zp19+B6hk0tcP5+pMqJW6JswuODpPbEiJIrRNS8f3syEKd3rfr/jJJso5oMeC8U6
         toNcyx5kAUZ0sZwYUj1VDTelp9sf1KXX8OWxt5lMwnhDHg9NB+XkCDYJFBaDtvrUIIJn
         lkAjiRQKIgi6BESygC6wxEjIv+fHTgdVrbELD+HhjlZTR0NcST3xGIweqIg3nxffRm2m
         8H6X49MT1ec7hpZFwM1o2lNu1czV1fdnifqMxZ1ofEc2KOSHxeT6myWUPRhjnAI9EfND
         LVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Iqfo9keS2TpK9GfS0c0b6OiBQlmC8pD8aAHf7OaR9CI=;
        b=mKZjcE/fvlm1pPWZKyi65+Hyj1qqQaoLoYg2LSAjVetz6oTriS+WpN/aOfOXC/TXjA
         Ht4/n1AWUBMtMGTGmNUZblojDE1r4FQ/2kf4yGbBcG90ES7gdYHccuyZOLEoMmHJ4ZHj
         ifwUOtjvUl14I2Oil4CAeyFySTc9GXiS2NUNcziyAgnMGPEGQmZBr5IO5dLObaZ3c9pK
         CQH1dXfXDl9GG1qMmQLjxXW6RO1edG8VBN8yMAyfDlgu7EEgATjGgVzHTxZAIFqil27F
         64xLNkGaXm6XkGx8RKPpDEG1i1TLMuiXI/ca+cxB86kiA+xhGO1NtCmUHfL/XqfyQA+u
         T9Lg==
X-Gm-Message-State: AOAM532rDQbV/UI0BrOGtD/e48CaOZ53ekxwou0NkQLp24yYkJmd0yZ+
        CT+F3sT6ZMd9rL4e1ZBUm15x9w==
X-Google-Smtp-Source: ABdhPJw/HJ98oz834LeZOvm1TSSpQe1fptg/MS2M8idKTbhtYAnFb4PUY3/ynRryGMQT1piVK1X2KQ==
X-Received: by 2002:a1c:b787:: with SMTP id h129mr5980131wmf.67.1606244527085;
        Tue, 24 Nov 2020 11:02:07 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id 6sm33311328wrn.72.2020.11.24.11.02.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 11:02:06 -0800 (PST)
Date:   Tue, 24 Nov 2020 19:02:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     David Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH 01/40] drm/radeon/radeon_device: Consume our own header
 where the prototypes are located
Message-ID: <20201124190204.GC4716@dell>
References: <20201123111919.233376-1-lee.jones@linaro.org>
 <20201123111919.233376-2-lee.jones@linaro.org>
 <CADnq5_PaFeyNAc3a8e0MmZRKzPxPQCxGyhD_7TP+jcuPvRt9NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_PaFeyNAc3a8e0MmZRKzPxPQCxGyhD_7TP+jcuPvRt9NQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Nov 2020, Alex Deucher wrote:

> On Mon, Nov 23, 2020 at 6:19 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > Fixes the following W=1 kernel build warning(s):
> >
> >  drivers/gpu/drm/radeon/radeon_device.c:637:6: warning: no previous prototype for ‘radeon_device_is_virtual’ [-Wmissing-prototypes]
> >
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: "Christian König" <christian.koenig@amd.com>
> > Cc: David Airlie <airlied@linux.ie>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Applied.  Thanks!

Thanks again Alex.  Great work!

Almost there now ...

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog

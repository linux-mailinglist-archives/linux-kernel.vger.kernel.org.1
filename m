Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3B82A77A5
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKEHA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgKEHA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:00:58 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B7EC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 23:00:58 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id 72so672959pfv.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=In22z4zSRFjmN0f9ZWT4tSWe/e4QLia1xEowLwJnVsw=;
        b=MXqPgs8+6JTdO/hUoDQw5oReQIcGnaaVfUbxHiTj/WNMBS0cf3z4ohV+gF45hY58w/
         aoFliyd9R/tnYceFsDd1i5ZqyVInBUwnOTkO0iGVPUyoNe059GQEoAK6RMQUzn3dMo1l
         n9M7VKH4+IyCkaIL+7QBE2LQmvswOpQQnMjujNrQlvxsPx87Z28CxZPz+egzh8LAELS1
         S+F/AqaP302QLGtQjTyL4M7IxF1We073NibdHPAzDHgpmmJILhf1mJaq6BnvAlrSjSh2
         LzOl1rH84hlkjcyzBvUXH9e57VW746Fzr1Vd5+qP9c9nk8Gtt7KQOSjZhfNjGgPBap4m
         fuoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=In22z4zSRFjmN0f9ZWT4tSWe/e4QLia1xEowLwJnVsw=;
        b=GKdpuxZF9cQW56NvvodPehCwVZVto1D8WAlUg+nme75T8Aj1f3n/jk3AJegyTy59sM
         WFB/OmXUpgG5b5gJpXuKdROlfcHpkeU3+2lM48tvS5A2cx97SSc/5DK48z2VDrq3/A+W
         iIbcRpvE1PTmMWaqdph1Df9My6Ar8LqlFTIaoNgOkE72LYihQd5seFsIoDnMW1/sj7Ua
         UTBajR9VMR+lm62iWJiNo8OHSuYG53U4qyBQllQDbQJCwp4aI4hBWW8TYF6gMui8ifCb
         /LvnOFlP0x3honal7nF1RnzBbQDhCGJF5FCMC5ondQTUvE/XRRPXFuMpwo6v42jyeuda
         Wcsg==
X-Gm-Message-State: AOAM533PbHhyRnFt/we0ndKu5M32jAyjG9j0oHSxe5T15zGe70fK0VZx
        pC2zN7OQIdrWJmCejAJW1rY=
X-Google-Smtp-Source: ABdhPJxccwbMNiHKtX8PlDU2gsnrWVHgRU2ASpOcGh5rnfj0CZusDbR0R9TyZJHcK06SvgZWWBZTOw==
X-Received: by 2002:a65:4b84:: with SMTP id t4mr1159089pgq.138.1604559657437;
        Wed, 04 Nov 2020 23:00:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:a6ae:11ff:fe11:4b46])
        by smtp.gmail.com with ESMTPSA id c11sm814474pjn.26.2020.11.04.23.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 23:00:56 -0800 (PST)
Date:   Thu, 5 Nov 2020 16:00:54 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Suleiman Souhlal <suleiman@google.com>,
        dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/virtio: use kvmalloc for large allocations
Message-ID: <20201105070054.GD128655@google.com>
References: <20201105014744.1662226-1-senozhatsky@chromium.org>
 <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105065233.3td3zuyfmbypjtvq@sirius.home.kraxel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (20/11/05 07:52), Gerd Hoffmann wrote:
> > -	*ents = kmalloc_array(*nents, sizeof(struct virtio_gpu_mem_entry),
> > -			      GFP_KERNEL);
> > +	*ents = kvmalloc_array(*nents,
> > +			       sizeof(struct virtio_gpu_mem_entry),
> > +			       GFP_KERNEL);
> 
> Shouldn't that be balanced with a kvfree() elsewhere?

I think it already is. ents pointer is assigned to vbuf->data_buf,
and free_vbuf() already uses kvfree(vbuf->data_buf) to free it.

	-ss

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7322F52B0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 19:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbhAMStm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 13:49:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60149 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728108AbhAMStl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 13:49:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610563695;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCkM8tqtFmqAljGsn+lrhwLEcfZSOOvR/2PaL+unCN0=;
        b=fgI+T3wn3OfSRElGF2n0VDNqzdAiVkWK8Rfo91zmC+tKuWSmZPy42MBLMlzdIC8YkXrXO/
        h4Qg97qRxnezdoToAl6mvOtqpBG6yJDh5qJD66UpxUR4m169P1p4FW3ZdS/TdM8puucQKS
        rSDULNAAwib1hq8N3p4u48+VsUWahC0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-127-D_PpFcatO5iuDQ68-Ph62Q-1; Wed, 13 Jan 2021 13:48:13 -0500
X-MC-Unique: D_PpFcatO5iuDQ68-Ph62Q-1
Received: by mail-qk1-f197.google.com with SMTP id a17so2150780qko.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 10:48:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=XCkM8tqtFmqAljGsn+lrhwLEcfZSOOvR/2PaL+unCN0=;
        b=Tb5Vr+Ar0MlC0UhZLcFXxl7XSjNcqsQAqBo+2UDFSJ6mHKiOUOzdJVJ88TUKH9ekxt
         XsSN1Kv//QqqVuo1Wy0QnW0l0i3841SXe02/sicRc3jaxWjGx3BAjOSQDCD/Lx5fwcR4
         DFgU4rCCaNJJbenbdKUJfMNhDmBEG2Y+Eun8KomLXLBzhUp6gZMSLTyB8q8EXDouWkgz
         eN8fNEJ34Z1ctwMX3np94h4aaViSn8oAAjh5H8pvgEHQp9U/oDMtW/MrI477+hrx4StH
         RZ77qFBPn/xpHi/aOUuL2BEJlrdu7OnHTUTMt1MRLm2cM/M5FNfmfjQvppZ5Wp++ZGPw
         VBYQ==
X-Gm-Message-State: AOAM533RlhAN4fChl0PafZPiUCkCLE4c1tIKOMOZ9RSR0IfMNM4TQ27N
        wND0BTSMiXJsnJkWeKnycg3Eu8fWg+kALmZQwEJ9gjvYqUNTtBumeVNyOQ50pp6s66AVM5IUPOl
        emFcz1V6nvDlrtQ/VZLt/B4UL
X-Received: by 2002:ac8:6c4a:: with SMTP id z10mr3566591qtu.183.1610563692843;
        Wed, 13 Jan 2021 10:48:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsr8BSxKJOMODCmmzJTXvHIK23vnDy1EDAf3ht8aYtQMMUO2lCrf8B/jgZneMtm/Hs7ut10w==
X-Received: by 2002:ac8:6c4a:: with SMTP id z10mr3566570qtu.183.1610563692657;
        Wed, 13 Jan 2021 10:48:12 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id z20sm1505438qtb.31.2021.01.13.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 10:48:11 -0800 (PST)
Message-ID: <a391f7b14dfede904d805a01340345deb4cf2617.camel@redhat.com>
Subject: Re: [PATCH 28/30] drm/nouveau/dispnv50/headc57d: Make local
 function 'headc57d_olut' static
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org
Date:   Wed, 13 Jan 2021 13:48:10 -0500
In-Reply-To: <20210113080752.1003793-29-lee.jones@linaro.org>
References: <20210113080752.1003793-1-lee.jones@linaro.org>
         <20210113080752.1003793-29-lee.jones@linaro.org>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Lyude Paul <lyude@redhat.com>

On Wed, 2021-01-13 at 08:07 +0000, Lee Jones wrote:
> Fixes the following W=1 kernel build warning(s):
> 
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c:173:1: warning: no previous
> prototype for ‘headc57d_olut’ [-Wmissing-prototypes]
> 
> Cc: Ben Skeggs <bskeggs@redhat.com>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> Signed-off-by: Lee Jones <lee.jones@linaro.org>
> ---
>  drivers/gpu/drm/nouveau/dispnv50/headc57d.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> index fd51527b56b83..bdcfd240d61c8 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/headc57d.c
> @@ -169,7 +169,7 @@ headc57d_olut_load(struct drm_color_lut *in, int size,
> void __iomem *mem)
>         writew(readw(mem - 4), mem + 4);
>  }
>  
> -bool
> +static bool
>  headc57d_olut(struct nv50_head *head, struct nv50_head_atom *asyh, int size)
>  {
>         if (size != 0 && size != 256 && size != 1024)

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!


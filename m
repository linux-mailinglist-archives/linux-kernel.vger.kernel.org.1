Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B192A6767
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 16:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgKDPUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 10:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730666AbgKDPUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 10:20:48 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BECC0613D4
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 07:20:47 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id e18so11687984edy.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 07:20:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=K6GVeC3Fe9IgK5J/YT3r7SRaxsgmqxRWiVLALkEOeGY=;
        b=PP9hTYWFv/W9cNYzfhYX8FzhaEimrLPsDz9brrFV/OJkAybD8lYvaC4XBQE+4Q+qnV
         Buw7flkjUTefR5EpRQK5S+oOj0o9IXRRtZOL7UrZVSuG1SSb2fwWBX0J/iL1HRH3mLzg
         aCjmaW1gRJ1+GoVddYUUD10IaazXdpdspVK6nqe7bJ/vUwmom86pXonZZTbm4E/Bnz0e
         cxRDLX9XVcGIXcTrtYhFIMGfW5paO6NcLJAGEzy0hE1DK+fQbhY4ovPd+1tNiZPceN9V
         oACsEbcOLNOLhpp7OOs1PBTLe2jO7K0ywZZ7bVFG4bJpivRXlcb6nldf1FMrm1y4wDaJ
         X+ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=K6GVeC3Fe9IgK5J/YT3r7SRaxsgmqxRWiVLALkEOeGY=;
        b=eAazRDbjruTjC7MdsYoDt+ejq3B4u0E5IjqioX+2Ing4XmIDf0B7uJGJDweurKqjDq
         TOaOCxmhKppklUUzxv5+VO/wRbzDdosEiWxcsth3QNstFKIw251HqIXAjsPAscTid5Gb
         Nhir/5Z3BYOt/sxPf74oJ1RH6ugQaFDGYNpmlGkc32fEUPiTd5jdapIDg2OJJJx3Ae/d
         E00odgd5bJIXvVqFnUYcZemg+bKDphFmyNXNxNQZmYK6PZBlYUuLKlg+ADcfIRT/WUMd
         DBCosAWGEWqwvkViAuL645cLwvM1mLTxmJUiNkggVhbHFnp0PzqhaHQBrnYidCIePxNy
         DQfw==
X-Gm-Message-State: AOAM531YifPRob4dPbci3Nj/vEchGrznf5Hmh8OQKLV73z3R19CRJi4p
        U4y9wsvoWH1iH+pMx8NBaB6T5/WHbt0=
X-Google-Smtp-Source: ABdhPJzOuCN7LWsNJ50reP+2044GxoJeD8b7MC874r9q4W6OkWtjk/+OVDLzSd7ZAZlauNczhrHrwg==
X-Received: by 2002:aa7:c955:: with SMTP id h21mr27922918edt.315.1604503246211;
        Wed, 04 Nov 2020 07:20:46 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7? ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
        by smtp.gmail.com with ESMTPSA id l12sm1215700edt.46.2020.11.04.07.20.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 07:20:45 -0800 (PST)
Reply-To: christian.koenig@amd.com
Subject: Re: [PATCH] drm/amdkfd: replace idr_init() by idr_init_base()
To:     Deepak R Varma <mh12gx2825@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20201104151359.GA69034@localhost>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <4d658fdf-9953-30a1-ca5d-a3431fc899cf@gmail.com>
Date:   Wed, 4 Nov 2020 16:20:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201104151359.GA69034@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 04.11.20 um 16:13 schrieb Deepak R Varma:
> idr_init() uses base 0 which is an invalid identifier. The new function
> idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> all lookups that otherwise starts from 0 since 0 is always unused.
>
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
>
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 2 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> index ba2c2ce0c55a..b3339b53c8ad 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> @@ -230,7 +230,7 @@ static int create_other_event(struct kfd_process *p, struct kfd_event *ev)
>   void kfd_event_init_process(struct kfd_process *p)
>   {
>   	mutex_init(&p->event_mutex);
> -	idr_init(&p->event_idr);
> +	idr_init_base(&p->event_idr, 1);
>   	p->signal_page = NULL;
>   	p->signal_event_count = 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index 65803e153a22..022e61babe30 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -1289,7 +1289,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
>   	list_add(&pdd->per_device_list, &p->per_device_data);
>   
>   	/* Init idr used for memory handle translation */
> -	idr_init(&pdd->alloc_idr);
> +	idr_init_base(&pdd->alloc_idr, 1);
>   
>   	return pdd;
>   


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC72A84C8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 18:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729980AbgKERYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 12:24:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbgKERYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 12:24:45 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16157C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 09:24:43 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id z3so1873721pfb.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 09:24:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=kRPEM8dLjyLiEebJREsbYoGi+98veJN3eW+L5N8MANw=;
        b=LJAxRqlgwpEP711TUT+dFB54aN1UL83lKZKvAOwC1z8du9AfiYoov5+1NgrIM+Rv0V
         ERrJ4sDvfB/7noY3mQ5+5pgpMk/cobJiBbCF5xJs3m4D0Mk3/aUz20pu1T7lX7evedV9
         44z04LDOg3sKgsfDYyisRMjVcRoBP82HNMInxO/4VAtYM0olHgJnCZ3Z7b3mLdoui1So
         WtLK24k2bvgYqI19m/jtq1S343uED2sj9bfnNyZ5kpkVVEblqVsrgrJTyhC7YBHUglQP
         QvGMdEJY7zRrz4YlWNlFt75KuQsPnTsOR29y4i5yG5L0gMAKpGMPDNOtOtBhmtZ2jAmW
         TGbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=kRPEM8dLjyLiEebJREsbYoGi+98veJN3eW+L5N8MANw=;
        b=ewWgMsAzPTLwrUFmNn0COivVn4HOfXDvkjgl6b2yBk9oTDMPrG2uxB5eAySR/dhvaN
         KApH5aQorDuRPvF/HFT+ZCTgduPoWzcdol/FMDjqhmn4Em+179D6F5AUUgq/jLA1/iI5
         7zK3NazutW+fWhkoufnGewsNFHG3VBL8fut7kWmCVOr3Md890+tccqpp7hTmJioQRlNv
         iFMjbAGoFWXhKS+9rUUEgh2d9T1tOcBMcoM8WLqgcd+MD8yYpG3C5l7QXof0KhTFKFRb
         r1pb579Y5aEbDBERydikoPnXcC0a76fq18zMB71zLXRwyMhsFOXnlJC1UExUazd/HFMu
         dDCQ==
X-Gm-Message-State: AOAM530fn+xTZhkZFO9s56CJo1CwddeFwSZvPO1sLGK7jQTQhwMI226G
        gV2m1yFqMJS59rkUGEaDn/k=
X-Google-Smtp-Source: ABdhPJyKHU9603o2tF6OrsxyE2Luza+oJ/CDl1+4JY+pPq6LDVqrIDKkrZsdsyc9MLqOn345oCoTeA==
X-Received: by 2002:a63:c20f:: with SMTP id b15mr3262198pgd.230.1604597082661;
        Thu, 05 Nov 2020 09:24:42 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id r127sm3113321pfc.159.2020.11.05.09.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 09:24:42 -0800 (PST)
Date:   Thu, 5 Nov 2020 22:54:29 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amdkfd: replace idr_init() by idr_init_base()
Message-ID: <20201105172429.GA41091@localhost>
References: <20201104151359.GA69034@localhost>
 <91ebae30-c75c-5485-8de5-36464e97ed7e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91ebae30-c75c-5485-8de5-36464e97ed7e@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04, 2020 at 03:01:17PM -0500, Felix Kuehling wrote:
> On 2020-11-04 10:13 a.m., Deepak R Varma wrote:
> > idr_init() uses base 0 which is an invalid identifier. The new function
> > idr_init_base allows IDR to set the ID lookup from base 1. This avoids
> > all lookups that otherwise starts from 0 since 0 is always unused.
> 
> I disagree. We call idr_alloc with start=0 for both these IDRs. That means 0
> seems to be a valid handle.

Hello Felix,
You are correct. There are calls made to idr_alloc with start range from
0. So, for this driver, id=0 seems a valid use case. The change I
proposed is not relevant for this driver. You may please ignore the
patch.

Thank you,
./drv

> 
> Regards,
>   Felix
> 
> 
> > 
> > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> > 
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> >   drivers/gpu/drm/amd/amdkfd/kfd_events.c  | 2 +-
> >   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > index ba2c2ce0c55a..b3339b53c8ad 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_events.c
> > @@ -230,7 +230,7 @@ static int create_other_event(struct kfd_process *p, struct kfd_event *ev)
> >   void kfd_event_init_process(struct kfd_process *p)
> >   {
> >   	mutex_init(&p->event_mutex);
> > -	idr_init(&p->event_idr);
> > +	idr_init_base(&p->event_idr, 1);
> >   	p->signal_page = NULL;
> >   	p->signal_event_count = 0;
> >   }
> > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > index 65803e153a22..022e61babe30 100644
> > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > @@ -1289,7 +1289,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
> >   	list_add(&pdd->per_device_list, &p->per_device_data);
> >   	/* Init idr used for memory handle translation */
> > -	idr_init(&pdd->alloc_idr);
> > +	idr_init_base(&pdd->alloc_idr, 1);
> >   	return pdd;

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4382C2A8748
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 20:33:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732144AbgKETdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 14:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726996AbgKETdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 14:33:19 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664B1C0613CF
        for <linux-kernel@vger.kernel.org>; Thu,  5 Nov 2020 11:33:19 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id 10so2114703pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Nov 2020 11:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eSpGHTliJf2Cyl4xNehipJVU0uhjtt4v/ABhWGSHLms=;
        b=IKr4/3tHu41qkkq+TXGIqQM0yq011kjtMFgajdBo2u01m4IN5baZXmD3uJ50QaW792
         t0aevmveRLayC8WW/2ndvF5IhEDrkQPehDbfQxdkncZaG+TxZRdzLow00cdnnm4TLbHr
         kXgxtkZP+tsW7mHAnr5mgWNOkeJO3Tr7+wbXe17/w63808LLT6RKuOLbC+tKHjWYFm6j
         rJe1GG7vULHd4HhrXl68nsDZ9kuEIB2RLlq/6GMhGCcA0kvI3cD9pNsLYb8eiuznc9A9
         tjpv1LnYpHMvepZlSnqJVK63N0R8KpipbmAZes5C0d9VaInD00G/OBrJ5ckJEy3IidPF
         zzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSpGHTliJf2Cyl4xNehipJVU0uhjtt4v/ABhWGSHLms=;
        b=G44AZXLzM3nP+HcqKfsgW3ecpADyiphxl5UpibzhjQgPknTqNLx4BtsIVvy2Tr7rfO
         l7YymgZeCKgU4LbvDzO0TQ5dx64DQTwuC9VI9Ps0AF4Q1GKWhru/fPUTQ6O7pAJj2baO
         ppKBh0yz6Nd2ckDFavNIIhI2NslTECrTwYlQLwzBAHDjb6rGQMoeziEGTcy505OJX5Aj
         qtkv/ukcXzLsGfBLDGNrhhfrGli4inNErrztQLbMYGG5OAcwpcTHwuaNOxr0WwBo4YJq
         oXyxHZ5IzXHuq84EwNMXM0F4tahSo5EFDYlbK1dIRsG7wL9YcknfIo/nP/jVnVoFQDOi
         pjKQ==
X-Gm-Message-State: AOAM532LDDoWWlkxgHhzGkQAFT4FFdhamyiS1c1BnNq8IhxzSEzmItZa
        EA+7VWLYhWf2yqE+DaCxYq4u796Kf/4=
X-Google-Smtp-Source: ABdhPJxBSGVVgTAvY+rQZZq/gwen/q3PAFD+cgTOxAs86LiDvDJWGDgrdY2V2X2GZfaiMXQU3ZmXhQ==
X-Received: by 2002:a63:9d8d:: with SMTP id i135mr3876922pgd.213.1604604798792;
        Thu, 05 Nov 2020 11:33:18 -0800 (PST)
Received: from localhost ([160.202.157.3])
        by smtp.gmail.com with ESMTPSA id y19sm3240844pfn.147.2020.11.05.11.33.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:33:18 -0800 (PST)
Date:   Fri, 6 Nov 2020 01:03:12 +0530
From:   Deepak R Varma <mh12gx2825@gmail.com>
To:     Eric Anholt <eric@anholt.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH] drm/vc4: replace idr_init() by idr_init_base()
Message-ID: <20201105193312.GA108505@localhost>
References: <20201105181613.GA42968@localhost>
 <CADaigPWV+x=6x_vso1Eb7ZEdmevpjgdGWO-epq-S6gJ3J1-sSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADaigPWV+x=6x_vso1Eb7ZEdmevpjgdGWO-epq-S6gJ3J1-sSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 05, 2020 at 11:25:11AM -0800, Eric Anholt wrote:
> On Thu, Nov 5, 2020 at 10:25 AM Deepak R Varma <mh12gx2825@gmail.com> wrote:
> >
> > idr_init() uses base 0 which is an invalid identifier for this driver.
> > The idr_alloc for this driver uses VC4_PERFMONID_MIN as start value for
> > ID range and it is #defined to 1. The new function idr_init_base allows
> > IDR to set the ID lookup from base 1. This avoids all lookups that
> > otherwise starts from 0 since 0 is always unused / available.
> >
> > References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> >
> > Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>
> > ---
> >  drivers/gpu/drm/vc4/vc4_perfmon.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vc4/vc4_perfmon.c b/drivers/gpu/drm/vc4/vc4_perfmon.c
> > index f4aa75efd16b..7d40f421d922 100644
> > --- a/drivers/gpu/drm/vc4/vc4_perfmon.c
> > +++ b/drivers/gpu/drm/vc4/vc4_perfmon.c
> > @@ -77,7 +77,7 @@ struct vc4_perfmon *vc4_perfmon_find(struct vc4_file *vc4file, int id)
> >  void vc4_perfmon_open_file(struct vc4_file *vc4file)
> >  {
> >         mutex_init(&vc4file->perfmon.lock);
> > -       idr_init(&vc4file->perfmon.idr);
> > +       idr_init_base(&vc4file->perfmon.idr, 1);
> >  }
> 
> Sounds like you should use VC4_PERFMONID_MIN instead of a magic 1 here.

Agreed. I will update and resend v2.

Thank you,
./drv

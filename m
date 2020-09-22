Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5680C274C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 00:44:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbgIVWoi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 22 Sep 2020 18:44:38 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38899 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726448AbgIVWoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 18:44:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id y5so17182952otg.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ci5rMCAbIUPU0EeoukaCTdHdW/bYhDqRoC55epoKiGw=;
        b=SXGWqd1g5aHh1dnZ1nN1W+OYoONol6qRSrTyfkL2VyMMAXDIcWRMGhsVEyehGpxIVo
         6SFNb1r5vanE40gKLXc8aUTATHh0QMlMVyt6Pzd4611CE3lNnO75NpWWrFfzSpLCMkPI
         ulu2zG8P/ssadUqJUz/eTCWSWp1U4K5GeT49tuVqwtqdyA0EME6wlC5cZObTL5359sBT
         zTQaGpv94lz9YPeyDXVQ34sgAUM1NxxsqXomRMTaUbQyz0gPFtb/1t3wq3cXDl92eS+U
         tzkbSKCcJ4PUTbs6Z9xBYuppWLzbrd6BSVoHzG+JhPBxoCYzCI7hBKdI0oLBJPhNwvhA
         0O3A==
X-Gm-Message-State: AOAM5338ToN3s6bigcxfD6l3wlyJBll2dnRCT8n5VmJCgFQ/hYcfT4mO
        a4mAreliwiv5y9m9oIrYNEXgxMThevdNkQUk
X-Google-Smtp-Source: ABdhPJwShnCmuzDxRDBYNSDFD4EXA7S5Ac4Mksc7fY9oRF7wJbRFpiQOLqrg868LaVrOVn3Vj9rzww==
X-Received: by 2002:a9d:68d3:: with SMTP id i19mr4488056oto.308.1600814676679;
        Tue, 22 Sep 2020 15:44:36 -0700 (PDT)
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com. [209.85.161.43])
        by smtp.gmail.com with ESMTPSA id c12sm7161121otm.61.2020.09.22.15.44.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2020 15:44:36 -0700 (PDT)
Received: by mail-oo1-f43.google.com with SMTP id b12so4549523oop.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 15:44:35 -0700 (PDT)
X-Received: by 2002:a4a:5896:: with SMTP id f144mr4501811oob.49.1600814675462;
 Tue, 22 Sep 2020 15:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200910140415.1132266-1-yanaijie@huawei.com> <CAJKOXPcsrL2T9EmiSnOhrC5Lh+ZM=nY4Go52cVDv1S6wxn5DHQ@mail.gmail.com>
In-Reply-To: <CAJKOXPcsrL2T9EmiSnOhrC5Lh+ZM=nY4Go52cVDv1S6wxn5DHQ@mail.gmail.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 22 Sep 2020 17:44:23 -0500
X-Gmail-Original-Message-ID: <CADRPPNQQ+fjAgFu9=vRKhi_fMwW8jaqrGNYkDohQRTq4vOkehg@mail.gmail.com>
Message-ID: <CADRPPNQQ+fjAgFu9=vRKhi_fMwW8jaqrGNYkDohQRTq4vOkehg@mail.gmail.com>
Subject: Re: [PATCH] soc: fsl: dpio: remove set but not used 'addr_cena'
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Jason Yan <yanaijie@huawei.com>, Roy Pledge <Roy.Pledge@nxp.com>,
        Youri Querry <youri.querry_1@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Hulk Robot <hulkci@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 20, 2020 at 3:20 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Thu, 10 Sep 2020 at 16:57, Jason Yan <yanaijie@huawei.com> wrote:
> >
> > This addresses the following gcc warning with "make W=1":
> >
> > drivers/soc/fsl/dpio/qbman-portal.c: In function
> > ‘qbman_swp_enqueue_multiple_direct’:
> > drivers/soc/fsl/dpio/qbman-portal.c:650:11: warning: variable
> > ‘addr_cena’ set but not used [-Wunused-but-set-variable]
> >   650 |  uint64_t addr_cena;
> >       |           ^~~~~~~~~
> >
> > Reported-by: Hulk Robot <hulkci@huawei.com>
> > Signed-off-by: Jason Yan <yanaijie@huawei.com>
>
> This was already reported:
> Reported-by: kernel test robot <lkp@intel.com>
> https://lkml.org/lkml/2020/6/12/290
>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Applied for next.  Thanks.

>
> Best regards,
> Krzysztof
>
> > ---
> >  drivers/soc/fsl/dpio/qbman-portal.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/soc/fsl/dpio/qbman-portal.c b/drivers/soc/fsl/dpio/qbman-portal.c
> > index 0ab85bfb116f..659b4a570d5b 100644
> > --- a/drivers/soc/fsl/dpio/qbman-portal.c
> > +++ b/drivers/soc/fsl/dpio/qbman-portal.c
> > @@ -647,7 +647,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
> >         const uint32_t *cl = (uint32_t *)d;
> >         uint32_t eqcr_ci, eqcr_pi, half_mask, full_mask;
> >         int i, num_enqueued = 0;
> > -       uint64_t addr_cena;
> >
> >         spin_lock(&s->access_spinlock);
> >         half_mask = (s->eqcr.pi_ci_mask>>1);
> > @@ -701,7 +700,6 @@ int qbman_swp_enqueue_multiple_direct(struct qbman_swp *s,
> >
> >         /* Flush all the cacheline without load/store in between */
> >         eqcr_pi = s->eqcr.pi;
> > -       addr_cena = (size_t)s->addr_cena;
> >         for (i = 0; i < num_enqueued; i++)
> >                 eqcr_pi++;
> >         s->eqcr.pi = eqcr_pi & full_mask;
> > --
> > 2.25.4
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1142E0BF0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 15:43:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgLVOnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 09:43:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbgLVOnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 09:43:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B0C061793
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:42:27 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id a12so32518145lfl.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 06:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QOsSeP8Izdxam9v2mGDHrUG4xsPA2erruOt/uVv66oE=;
        b=HqWh94hUaTDliG35Zagh2f9xBEF/weISci7WNbqpEcNYYUgmXJ1eT3aYMRTcPtGzey
         uKL8y5yEyMFZGUqJIYtd+D67pU8zOqcUk99fO18DohfDSO6o+fBr5bc+UqMBTFg5dQSd
         BJkLqaW4aJIm4o5BvC1EMdP7rLo6TeWi1tcL8TbzB03rLcXJgPLzhFsk1dMlHwA1lf+o
         rTB90BJBjfXtI7yonUC52lDUxrsgDMOtgFDfoDck01hcOx5PeyNHGpyr4bkB22HWdNx/
         aEVmjaXpKzKEmx5YCuGOKsjVsgnzc4r33NB4BH9vM6P/4QcvWftZWySPfLttxIOFEu6v
         VE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QOsSeP8Izdxam9v2mGDHrUG4xsPA2erruOt/uVv66oE=;
        b=gEDUQOKmtMTZknY+0U+SAZ0aQoAtiDW3Y9O51s+Z2hoPwC3YCZfXvSgp70X+d0fdYv
         EiskV/p4SjvHZQYqSvBI/PsLNlOayH9026swVRmq4TOqebFHpfFohzEG8TZh6ABxhxUO
         59nijO+0BsALp9tO/aWqdFGuJhXSZuXPrwlm5zp9HiUecrefPRjJxwoV0u+X0yqHtLPM
         dvXQ5Gcd1pBDDvpI0j1fOHFPs1FT4n79jBt/h0QAZSaIl64K2bYiENpGUh7YiwDldZ8U
         crQKbpDZrD1VwLRgkYEO0/+utjpAtsm1Ys1l2ui6EQodI9IFD7iLOYKLILK/9q0qBpxu
         sSOA==
X-Gm-Message-State: AOAM532w6toP+tWBLi/cBA7cCZHyYE9YkSW+v1s6fLDqtxfxhc8kVe3b
        KEFH6JijR36FGuZOpo+v0KJVhHsWghAdfvCYpI4=
X-Google-Smtp-Source: ABdhPJxqqF6DeEfobHr4FNiEpBMxW4vxPKWsWcJjyGcXFw9khzRdoSAi//pN1D6khHbWpS/nxbl3E2oiIBNjy+9urAU=
X-Received: by 2002:a05:651c:1068:: with SMTP id y8mr9567821ljm.76.1608648145923;
 Tue, 22 Dec 2020 06:42:25 -0800 (PST)
MIME-Version: 1.0
References: <20201221162519.GA22504@open-light-1.localdomain> <20201222122312.GH874@casper.infradead.org>
In-Reply-To: <20201222122312.GH874@casper.infradead.org>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 22 Dec 2020 22:42:13 +0800
Message-ID: <CA+2MQi8GMLfSFN30G8EEeXXsC5M+Et2oRMnynUp==eRbY0Z2Wg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > QEMU use 4K pages, THP is off
> >                   round1      round2      round3
> > w/o this patch:    23.5s       24.7s       24.6s
> > w/ this patch:     10.2s       10.3s       11.2s
> >
> > QEMU use 4K pages, THP is on
> >                   round1      round2      round3
> > w/o this patch:    17.9s       14.8s       14.9s
> > w/ this patch:     1.9s        1.8s        1.9s
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> The cost of zeroing pages has to be paid somewhere.  You've successfully
> moved it out of this path that you can measure.  So now you've put it
> somewhere that you're not measuring.  Why is this a win?

Win or not depends on its effect. For our case, it solves the issue that we
faced, so it can be thought as a win for us.
If others don't have the issue we faced, the result will be different,
maybe they
will be affected by the side effect of this feature. I think this is
your concern
behind the question. right? I will try to do more tests and provide more
benchmark performance data.

> > Speed up kernel routine
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > This can=E2=80=99t be guaranteed because we don=E2=80=99t pre zero out =
all the free pages,
> > but is true for most case. It can help to speed up some important syste=
m
> > call just like fork, which will allocate zero pages for building page
> > table. And speed up the process of page fault, especially for huge page
> > fault. The POC of Hugetlb free page pre zero out has been done.
>
> Try kernbench with and without your patch.

OK. Thanks for your suggestion!

Liang

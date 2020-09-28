Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D327AE28
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 14:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgI1Mtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgI1Mtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 08:49:39 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9850AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:49:39 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id o21so591993qtp.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 05:49:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C7pLuM6q9GITD003wal8FUvMqWiJb4o3xG/3xTeMIHw=;
        b=f9lb2tgPovyEXgA0Z4FOMgi3I5WM4fBlC3HOpM70LPWDcNTyUIrsetkEgxSbET6gAK
         3nKGSJc6Ub1KXYMckQVyXMumjmiBV4aEkPHu0vd33RSDrVhtFcOPjmx2R9RWDfoGSUF9
         WoK4s1dUzp5TRfJcyPWmkbAPdi/wMVzJf4V+S4eRYobTP9huYHbVRPyBLVb5yD8wNMxx
         Xz+rB/6VCcuNtjmYfQfJBfHnO7i0LEXvIwBrkzAc7KySYSwf4EgQ0JVLaTy/0P5QMCmX
         JSO4/vjoDkbffgbtEEU5bc9jR3Y6HY8/zAEtSRvZ53rivyLk2Zm8zuyZIJQT6qlcFPlq
         APsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C7pLuM6q9GITD003wal8FUvMqWiJb4o3xG/3xTeMIHw=;
        b=OkSMg8f3AF63X7iSmHqnlMiQXOVPVGEPApMhrdJbUDGsM3V20i0sghbCnqDw1k/nn4
         CWA67Of1Ff5AYkC0u6X+WovIb+DnNmKuvsljGX+J0xDUAC38tLFGmbGcTxAa3mS6sx5F
         NJbT8rb43oooAk/u6CbcMbYZS4wwV+tEpSrK46mtNqMowQvjeHHnEtR5Qkl942rrQOM0
         vf7FOH9RJQJaHk1XGfiqgPG6j0TAUz0EG4//v3QqkvwPY6f+Zt7WXDniKXT/1+mFwwgu
         2M0/7pe/+4sZ1yptrLnOVorSkPGNwYaxDtDqnAVRMFpmuXHLydTbgA6NnlMy8oEeA90M
         HTHg==
X-Gm-Message-State: AOAM530yq1xmynh89XmBBywhwD541ByyAuEh04MgTIoxS9Yzu30EmP/Z
        CJFJRO4gNwT/BeEPZBsEz5D46g==
X-Google-Smtp-Source: ABdhPJyB+Vuryqx/W9VfWYdCvFbbTCxY1i7cOBauOwmzZPqPCJn7ocXQN/trIb1W22V1vrEwQ9qduQ==
X-Received: by 2002:ac8:4d07:: with SMTP id w7mr1338294qtv.243.1601297378789;
        Mon, 28 Sep 2020 05:49:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id e24sm826203qka.76.2020.09.28.05.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 05:49:37 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMsb3-001ueb-Ap; Mon, 28 Sep 2020 09:49:37 -0300
Date:   Mon, 28 Sep 2020 09:49:37 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Leon Romanovsky <leonro@nvidia.com>, Peter Xu <peterx@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
Message-ID: <20200928124937.GN9916@ziepe.ca>
References: <20200924183953.GG9916@ziepe.ca>
 <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca>
 <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
 <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
 <20200927062337.GE2280698@unreal>
 <CAHk-=winqSOFsdn1ntYL13s2UuhpQQ9+GRvjWth3sA5APY4Wwg@mail.gmail.com>
 <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wj61s30pt8POVtKYVamYTh6h=7-_ser2Hx9sEjqeACkDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 27, 2020 at 11:45:30AM -0700, Linus Torvalds wrote:
> On Sun, Sep 27, 2020 at 11:16 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Btw, I'm not convinced about the whole "turn the pte read-only and
> > then back". If the fork races with another thread doing a pinning
> > fast-GUP on another CPU, there are memory ordering issues etc too.
> > That's not necessarily visible on x86 (the "turn read-only being a
> > locked op will force serialization), but it all looks dodgy as heck.

Oh. Yes, looking again the atomics in the final arrangement of
copy_present_page() aren't going to be strong enough to order this.

Sorry for missing, wasn't able to look very deeply during the weekend.

Not seeing an obvious option besides adding a smp_mb() before
page_maybe_dma_pinned() as Peter once suggested.

> .. looking at it more, I also think it could possibly lose the dirty
> bit for the case where another CPU did a HW dirty/accessed bit update
> in between the original read of the pte, and then us writing back the
> writable pte again.

Ah, I see:

               set_pte_at(src_mm, addr, src_pte, pte);

wants to be some arch specific single bit ptep_clear_wrprotect()..

Thanks,
Jason

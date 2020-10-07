Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE64286603
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 19:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728624AbgJGRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728594AbgJGRd0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 13:33:26 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C789C0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 10:33:26 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id ev17so1625952qvb.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TdSre1+FiF17b2WS+AUXMuyymNAaLTf4uLT17E+pnFU=;
        b=I7/owwaByfC+T615S4yoAl1o98d1ue1FvXLjxM8yebhh+9JecaDPgFNy3dbnkmB8TN
         Vzx15ySYhGig+ha8DgJwv0JB9nc9mTmHX7s01XzVMtrzGqF7F5ysx9nVT6a95aQv8luf
         ubR2OEMsVZaWQ7RmDyyDSLyoP0q7IOFEADlrOkM8v9xk0+G5fAvCgdRAbNUwL2HYX/wg
         NdxL0Agtty3FgSPu+bQMrdJNei+OMp8ipKgGOhWKyjOjRZlk7D/1NKUJUn0ab2X75jIZ
         GLdNE/c4Zf4maicgzgeRTMpXMrGmFUZrqUFukx9r5Pv+87LO5DNFvo/M0m7x2mbqppxs
         Yd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TdSre1+FiF17b2WS+AUXMuyymNAaLTf4uLT17E+pnFU=;
        b=fnyoGlEj6Hgcnju9JnUiADnSUVV5bsLE+QD0KXTkHptZQwBhOtBk8hUZKze+T1nI7z
         OOp/h6UEyhPToXNa1Dlgcs1XI32pNzl1U5zFp1gj0foMzQnYd7jCd9k3GaIjaIy81FZF
         +huRxy/7Jkwea3NuuW+3GuDMbVfgROrtywDjJg1tSzannyiMu90HDiLbwO4CtPT3edZB
         PLBcC/z/KtIhzx0RH8TOo01O973fH4/TIBpPEjmnPbrne+Yiic6zQxKKJHV0wVzmI7NU
         v1sqtQJwcVtz+PHjjlX3VCqZVpkmbfnvgx9GNCSmfIBshhWPwS+Rp4PnTRnhKZ8xAkHf
         olkA==
X-Gm-Message-State: AOAM530iwygN6s/FY0t/FkccDchl1XMhdagQcYgs2wtBoEiOqCUW9Lt/
        ZXgaKH4lUF1x/77CifbZghDubgXL48FEpt5Q
X-Google-Smtp-Source: ABdhPJw0qC4HxiG6+lNGoLhXdKRQ6phNXWeAziKb0zM4HKIClbwU3fAgBb5ZP6iA8tkK3T/vsUzqKA==
X-Received: by 2002:ad4:456c:: with SMTP id o12mr4490006qvu.48.1602092005183;
        Wed, 07 Oct 2020 10:33:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 184sm1954180qkl.104.2020.10.07.10.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 10:33:24 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQDJb-0010xU-S5; Wed, 07 Oct 2020 14:33:23 -0300
Date:   Wed, 7 Oct 2020 14:33:23 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, linux-s390@vger.kernel.org,
        Daniel Vetter <daniel.vetter@intel.com>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 05/13] mm/frame-vector: Use FOLL_LONGTERM
Message-ID: <20201007173323.GV5177@ziepe.ca>
References: <20201007164426.1812530-1-daniel.vetter@ffwll.ch>
 <20201007164426.1812530-6-daniel.vetter@ffwll.ch>
 <20201007165316.GT5177@ziepe.ca>
 <CAKMK7uGTpZcHwrBNQOXwzDAzyfSgoLSt_Dae_3hMRE2xwGx+GA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uGTpZcHwrBNQOXwzDAzyfSgoLSt_Dae_3hMRE2xwGx+GA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 07:12:24PM +0200, Daniel Vetter wrote:
> On Wed, Oct 7, 2020 at 6:53 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Wed, Oct 07, 2020 at 06:44:18PM +0200, Daniel Vetter wrote:
> > >
> > > -     /*
> > > -      * While get_vaddr_frames() could be used for transient (kernel
> > > -      * controlled lifetime) pinning of memory pages all current
> > > -      * users establish long term (userspace controlled lifetime)
> > > -      * page pinning. Treat get_vaddr_frames() like
> > > -      * get_user_pages_longterm() and disallow it for filesystem-dax
> > > -      * mappings.
> > > -      */
> > > -     if (vma_is_fsdax(vma)) {
> > > -             ret = -EOPNOTSUPP;
> > > -             goto out;
> > > -     }
> > > -
> > > -     if (!(vma->vm_flags & (VM_IO | VM_PFNMAP))) {
> > > -             vec->got_ref = true;
> > > -             vec->is_pfns = false;
> > > -             ret = pin_user_pages_locked(start, nr_frames,
> > > -                     gup_flags, (struct page **)(vec->ptrs), &locked);
> > > -             goto out;
> > > -     }
> >
> > The vm_flags still need to be checked before going into the while
> > loop. If the break is taken then nothing would check vm_flags
> 
> Hm right that's a bin inconsistent. follow_pfn also checks for this,
> so I think we can just ditch this entirely both here and in the do {}
> while () check, simplifying the latter to just while (vma). Well, just
> make it a real loop with less confusing control flow probably.

It does read very poorly with the redundant check, espeically since I
keep forgetting follow_pfn does it too :\

Jason

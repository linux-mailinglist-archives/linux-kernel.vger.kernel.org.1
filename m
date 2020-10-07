Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59512285FE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 15:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgJGNOd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 09:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728381AbgJGNOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 09:14:32 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB56EC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 06:14:30 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id t9so891895qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 06:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MmLkeDGPsMUHS0xvj3eEHFFmVdpcqhu0PPjOEhkFDRw=;
        b=E2hqgrVAYT0hzmQlUY2vSFECyG02KQklk4Q7aygEUVLS/VVeb3Tt27E/79H/UOl+9G
         SJBQ/lGMxMqipGbxoj7lfw0USKf2Sj6n3xYaQY9FvYamgoh5eKN5yzmXYMdRJ0LcIIqz
         VwpDBuIBc7R3DFnysJ6dY3hWBTL2Armw0wdMzfr++A3aRDehnCNFpI553/T5UM+DRyuQ
         Oek61rl8sZvLcPOv1smXPcbXY2ExA/erB9R5Jr+rymqCoLjWHjzuaE4tUHHAgHy+quP5
         QhDpDcvG1j+JZTxnHpIfusLhcypJ7HAV8RlkRBnFjKu3NO5ifvRL25XEKGsOMPhDPufR
         tnZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MmLkeDGPsMUHS0xvj3eEHFFmVdpcqhu0PPjOEhkFDRw=;
        b=e7X+u1R9V3qHEP22N8r//ue3sE44GaLXq1J0RGYnzBhnbU1aUIdUkSgp056uwXhsP6
         wvi77B2v4I/Km8sxTJM+Gk3zvpzKVFyaUXrFwvAG+tpvCggC3sd/JuWfRynjlE+HrE4X
         S7lhpw72bA3fVHv5oGwGGtOKf2WHaOv2Y9WZAGh95P6qCMFP456Y3BAXZ6sMa494wCNr
         dmH54lYqOGogcIXfIvYEPtC56AIXNwGQfYSvdYHd7pYlpNgZ9mF6D3/jlfZhOMS9ZEN9
         GripwfmysdnCW0Kh2nMvu9BnNdp+K6iMdr/HmtEzDQkVaBQ46LCTAL7YhihSUvo7B4ht
         lhow==
X-Gm-Message-State: AOAM5311TNTmZwsroY9Vp3ne7BCk/KBYV2EJQzbxmgOLqFOSjiBdhMX3
        A4JpNKM81lQW4FPng3M6FLlhMw==
X-Google-Smtp-Source: ABdhPJz8yWeQeFkSjjqVWhH1mXFkaZDdDkKqUssPTxNJCo0OrdjKtKBs9eNFjrd0s56SqUYqYVTBxw==
X-Received: by 2002:ac8:71c6:: with SMTP id i6mr3077500qtp.318.1602076469886;
        Wed, 07 Oct 2020 06:14:29 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id m15sm352795qtc.90.2020.10.07.06.14.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 06:14:29 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQ9H2-000u0D-Lc; Wed, 07 Oct 2020 10:14:28 -0300
Date:   Wed, 7 Oct 2020 10:14:28 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Pawel Osciak <pawel@osciak.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH 2/2] mm/frame-vec: use FOLL_LONGTERM
Message-ID: <20201007131428.GQ5177@ziepe.ca>
References: <20201002175303.390363-1-daniel.vetter@ffwll.ch>
 <20201002175303.390363-2-daniel.vetter@ffwll.ch>
 <20201002180603.GL9916@ziepe.ca>
 <CAKMK7uGF+y-r4swLXmodhduRMy0NPa=ASBY8JOXS_g=9Rq9XQw@mail.gmail.com>
 <20201002233118.GM9916@ziepe.ca>
 <CAAFQd5DkzxeHmHvipMR2YgDVC1uZrvVWgyWWYdyEM=yCOM7HwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5DkzxeHmHvipMR2YgDVC1uZrvVWgyWWYdyEM=yCOM7HwQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 03:06:17PM +0200, Tomasz Figa wrote:

> Note that vb2_vmalloc is only used for in-kernel CPU usage, e.g. the
> contents being copied by the driver between vb2 buffers and some
> hardware FIFO or other dedicated buffers. The memory does not go to
> any hardware DMA.

That is even worse, the CPU can't just blindly touch VM_IO pages, that
isn't portable.

> Could you elaborate on what "the REQUIRED behavior is"? I can see that
> both follow the get_vaddr_frames() -> frame_vector_to_pages() flow, as
> you mentioned. Perhaps the only change needed is switching to
> pin_user_pages after all?

It is the comment right on top of get_vaddr_frames():

  if @start belongs to VM_IO | VM_PFNMAP vma, we don't
  touch page structures and the caller must make sure pfns aren't
  reused for anything else while he is using them.

Which means excluding every kind of VMA that is not something this
driver understands and then using special knowledge of the
driver-specific VMA to assure the above.

For instance if you could detect the VMA is from a carevout and do
something special like hold the fget() while knowning that the struct
file guarentees the carveout remains reserved - then you could use
follow_pfn.

But it would be faster and better to ask the carveout FD for the vaddr
range.

Jason

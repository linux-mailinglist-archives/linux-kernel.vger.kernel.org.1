Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD75A285F69
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 14:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbgJGMoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 08:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbgJGMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 08:44:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F6C6C061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 05:44:12 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id w12so2447877qki.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 05:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHwK7fj40rs6RtWBfMsDdiNwOc6I5e7hiW0vaeAiWPE=;
        b=L3Snl2lKZ0Efotdw5H66ICtk7hAPeqPHl2yvT2hFObgLWAEy3EBTXL+OsvS8u/QndV
         Pj12VmdFi1Z+tf74AMThconTJmYhkFSDG8iZx1jlaA7Czeyr7poiFxBLjV1keUOmp1a1
         r6jTl4FOE/mmJjXmQ3zxvk1dmo6U3QKzXB0dREWbZ5bVe5DnC2HmgHKbEjSJ6zySfOog
         R+kS8ezo1stmGnlupvsVnR3bPxmU38krpYm29D741/i3IkmlnAWe/GfJ9rN+yP8YE0dg
         cFJCTIqTz/UvPJG/mR+/5L+YhDdX7fqDJnzC1ZYlkGVtaAUiADgRS6KwWpAwdsPJXKnQ
         JC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHwK7fj40rs6RtWBfMsDdiNwOc6I5e7hiW0vaeAiWPE=;
        b=GQWyEUYUVUgnqL8Bd0QIpUn45QXsxpeFnK1bU1+87BCy7FLpOZ4DNdRiSP9wcj6QJd
         CrFcfFPGnsLoJf4Ran9WJWOQaHu++0x6RGGc7q6YYGrLWOEwD9jSJO7pxyLYs9kJLIR6
         Dn7JNKoboLUo2DRr5qdl7w/znSlYaGavyD37iD31fWQplROthLI4pDnd1uHJQRnCMbZn
         K0CZETrO5MpxdxxuZyNBOMrnbnqKwOGh7St4V1eiMYfaJnMMCl0AQQWuukTSjeO2+cFJ
         pXFV3T1MTpe6tJxGAA21D2wiK5jCAIE+WTunWTvybyvyYrSQ+Hb8eLrPu2Si3ReIH7wn
         WN3g==
X-Gm-Message-State: AOAM530D0nRBx8HCs9N3KmbwX2KRxLWA4ayTSn/7kCyiZ0VvnEjECv8V
        kt77nujywyS53f/xEe/v6Cst/g==
X-Google-Smtp-Source: ABdhPJycqhqp8fRGIUb3jRYRy+8x/MiJ9pPbNPYQD1G3WrU7BU6Yp5GlTMFR/KPoICRs6eJqoSqkUQ==
X-Received: by 2002:a05:620a:a90:: with SMTP id v16mr2505177qkg.226.1602074650939;
        Wed, 07 Oct 2020 05:44:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id d37sm1423421qta.76.2020.10.07.05.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 05:44:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQ8nh-000tZ6-KI; Wed, 07 Oct 2020 09:44:09 -0300
Date:   Wed, 7 Oct 2020 09:44:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
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
        Kyungmin Park <kyungmin.park@samsung.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>, Oded Gabbay <oded.gabbay@gmail.com>
Subject: Re: [PATCH 2/2] mm/frame-vec: use FOLL_LONGTERM
Message-ID: <20201007124409.GN5177@ziepe.ca>
References: <20201002175303.390363-1-daniel.vetter@ffwll.ch>
 <20201002175303.390363-2-daniel.vetter@ffwll.ch>
 <20201002180603.GL9916@ziepe.ca>
 <CAKMK7uGF+y-r4swLXmodhduRMy0NPa=ASBY8JOXS_g=9Rq9XQw@mail.gmail.com>
 <20201002233118.GM9916@ziepe.ca>
 <CGME20201003094038eucas1p12aaafe0f52a7747bc2ba95ccb91d1651@eucas1p1.samsung.com>
 <CAKMK7uFP-XQHUPYeRhPx7tjvjARQiF-os9z9jx6WANV6sgSf6g@mail.gmail.com>
 <d2f8e8a7-614d-18c8-9e2a-c604e5e54ce6@samsung.com>
 <CAKMK7uF+a1PSn+e-6F+YhkSXn9vC7etS-z0AFBMCU+Vzb2PwqA@mail.gmail.com>
 <725819e9-4f07-3f04-08f8-b6180406b339@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <725819e9-4f07-3f04-08f8-b6180406b339@samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 07, 2020 at 02:33:56PM +0200, Marek Szyprowski wrote:
> Well, it was in vb2_get_vma() function, but now I see that it has been 
> lost in fb639eb39154 and 6690c8c78c74 some time ago...

There is no guarentee that holding a get on the file says anthing
about the VMA. This needed to check that the file was some special
kind of file that promised the VMA layout and file lifetime are
connected.

Also, cloning a VMA outside the mm world is just really bad. That
would screw up many assumptions the drivers make.

If it is all obsolete I say we hide it behind a default n config
symbol and taint the kernel if anything uses it.

Add a big comment above the follow_pfn to warn others away from this
code.

Jason

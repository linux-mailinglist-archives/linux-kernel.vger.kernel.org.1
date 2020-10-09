Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D857D288B50
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388738AbgJIOcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389023AbgJIOcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:32:11 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70616C0613D8
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 07:32:11 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id c2so10710806qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 07:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=73DpVirPZ06c1n2mkJSkENlUc+TenafPYOh6N9YsRj8=;
        b=j3fuCopb7iniyL2y53HSklILSjdWqx7XXY5J7anSdWIzVAS51yHUg1bH+xWsQqV3an
         hVaIqQtPYG5XhAZxJubl7tnA+2dzIyrb1eABP/rsrrjt9Ddzi0d1WmSuwF0UQqwD1tgr
         69SltM6wnxkhZu8y4olirPc3PCASUILXSC5ua6+ynVuzP7VwBBECaBlnoZLOtcJNGGyr
         NOkdDPv6Ux3fvUs6FlZoAKLjSdk3YJbxq2oDe3QQYv1fkcF15D+45H8TBvKAbi8SeVAg
         F1hEOalHcniDpc4tE9aqUhgdNW4MqmHYSXYkxAhz5TsGfdhszvZtn/5ZEIEGhUQjLvR4
         psaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=73DpVirPZ06c1n2mkJSkENlUc+TenafPYOh6N9YsRj8=;
        b=Rx17V6HnU4/1rxXiqNXGEFxAvEm3X1QyxDopM89SM217OxKERBIyvNbRMUJP/k33KH
         NoSUzpXNKfT+zo2RXFyau0lDExjCScqAWzFXLbLSMW2Wp8FrJwMTdjEv9oX+eeFUsKsI
         wwufqvAZd+OJIyHNCIuGOffxbt1k7sxA83eywskpTCJThUbtGBoqpeHKAC4WuYC1RaKx
         xfX/TkorGR55JGfwRFtz7msFpur1koeBxlzYUUrMLz2ZulzvAhiAvXbR8FSko8UfJ0p5
         tUGRSjUzjGuI3tezfVBXvlZ36KWwwmC6DWCoUujSduI2HRGaHKtjTww6JvW/fDD9BYuf
         IvOw==
X-Gm-Message-State: AOAM533oWdteM1yrLWj/cCRvu8wF5jbPAMqhQ4ASplf8aKgFPrL8UCDe
        7dKkqFiLs+5BcKL9V/TSHo/pNA==
X-Google-Smtp-Source: ABdhPJzpwYy/97Cu1hz1/nj4gs64VmTlSZ35zli/9trR97tocuoZHHYGhTwRETY7JpaxNsFSCH9jrQ==
X-Received: by 2002:a37:4d95:: with SMTP id a143mr13781409qkb.248.1602253930622;
        Fri, 09 Oct 2020 07:32:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id r64sm6400897qkf.119.2020.10.09.07.32.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:32:10 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kQtRJ-001zsY-G1; Fri, 09 Oct 2020 11:32:09 -0300
Date:   Fri, 9 Oct 2020 11:32:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Jan Kara <jack@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Hildenbrand <david@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v2 14/17] resource: Move devmem revoke code to resource
 framework
Message-ID: <20201009143209.GS5177@ziepe.ca>
References: <20201009075934.3509076-1-daniel.vetter@ffwll.ch>
 <20201009075934.3509076-15-daniel.vetter@ffwll.ch>
 <20201009123109.GO5177@ziepe.ca>
 <CAKMK7uFpPP-Q0jC0vM7vYPEcg0m4NzTw+Ld=swdTF3BgMX5Qug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFpPP-Q0jC0vM7vYPEcg0m4NzTw+Ld=swdTF3BgMX5Qug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 04:24:45PM +0200, Daniel Vetter wrote:
> On Fri, Oct 9, 2020 at 2:31 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >
> > On Fri, Oct 09, 2020 at 09:59:31AM +0200, Daniel Vetter wrote:
> >
> > > +struct address_space *iomem_get_mapping(void)
> > > +{
> > > +     return iomem_inode->i_mapping;
> >
> > This should pair an acquire with the release below
> >
> > > +     /*
> > > +      * Publish /dev/mem initialized.
> > > +      * Pairs with smp_load_acquire() in revoke_iomem().
> > > +      */
> > > +     smp_store_release(&iomem_inode, inode);
> >
> > However, this seems abnormal, initcalls rarely do this kind of stuff
> > with global data..
> >
> > The kernel crashes if this fs_initcall is raced with
> > iomem_get_mapping() due to the unconditional dereference, so I think
> > it can be safely switched to a simple assignment.
> 
> Ah yes I checked this all, but forgot to correctly annotate the
> iomem_get_mapping access. For reference, see b34e7e298d7a ("/dev/mem:
> Add missing memory barriers for devmem_inode").

Oh yikes, so revoke_iomem can run concurrently during early boot,
tricky.

> The reasons for the annotations is that iomem requests can happen
> fairly early, way before fs_initcalls happen. That means revoke_iomem
> needs to check for that and bail out if we race - nothing bad can
> happen since userspace isn't running at this point anyway. And
> apparently it needs to be a full acquire fence since we don't just
> write a value, but need a barrier for the struct stuff.

Yes, if that is what is happening it release/acquire is needed.

Jason

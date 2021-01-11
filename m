Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA12F1A6E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 17:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388304AbhAKQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 11:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727180AbhAKQGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 11:06:31 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11903C061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:05:51 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id y15so21366qtv.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 08:05:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VJXKJfI0gkDENX20LedauSobFPKF2L5M/RH/WmsJp4Q=;
        b=QjUyGJ59RkTenwFcqXVFU8Zcc3L7HYBxKmb4Tk+6nNJKizrbrrTv6nJblC/YT3Vdpn
         BKl24NzdGALlS4FrA+pAi4StCQE3H94rtiZnxwjEkj4nekVK9TwCD8bfI7Cx8AS6/QK9
         hwTjB75PvTQJZ4goicxxTHAp9voTWbGLOzdnuojAujabAppnuE8eUOWYPBRz6+T0L1UT
         HrVRuTgmtFbCdCgQ3ntXgEKgziYpheEhknBrRGrzns9XUrOSvTPD39aqtU8l3GmBS0EA
         COhGArctwrcxAjKs68+aSTkfcIl1a4/s3Txd9Qjs7XvS21C/79GpUDnAQ1OwTaXQs7gG
         XKmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VJXKJfI0gkDENX20LedauSobFPKF2L5M/RH/WmsJp4Q=;
        b=WO618aDDo/3A4KEgaICudISClt0XyC9xKjZU/5lD2mLwvkO1++JkhrsSHGBNXQx4VW
         Chjo69CcRDxO2r6Z4006QO9YOM/eGo7KWTMz3giTNL0XC1Wk037bXHH7jpE62UFRFx65
         igiDkrBBgdxaUJhVVop75Gi20kBB4vZet3F7n4QbTaJDMZx3YE9OV7KpHOEIRM7p7MXC
         4ldrp2BQUPWULZntTP4wCIjbt3PlBHrt1z+CYHAC7yo77JSa4KGNXzQ9uDqcBrZyIOW8
         pyGjychBGR3pyzjgk6gXHtpryAkVa76cAhWi3k/3Ol3viovDcC/6ze03Jzy7PkdHKJAX
         dn4Q==
X-Gm-Message-State: AOAM5335eDiC80oUclUSyhtwSS4JhvozvyitRiiRR+L+3ZJ1IWeViVxQ
        yqfB6WHoYjoZhNESapgG36Lmcw==
X-Google-Smtp-Source: ABdhPJxKir1OyQ6oe0SGLvUrpJGUR7oMsv4PsZ0mfg/4Ho7fV9G2CV+kpE259jU4OUWjCpYN/9BrOw==
X-Received: by 2002:ac8:4c8c:: with SMTP id j12mr268786qtv.133.1610381150214;
        Mon, 11 Jan 2021 08:05:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id h75sm91222qke.130.2021.01.11.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 08:05:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kyzhV-005YPG-0o; Mon, 11 Jan 2021 12:05:49 -0400
Date:   Mon, 11 Jan 2021 12:05:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
Message-ID: <20210111160549.GN504133@ziepe.ca>
References: <20210110004435.26382-1-aarcange@redhat.com>
 <CAHk-=wghqNywtf=sRv_5FmG=+hPGqj=KWakw34tNeoZ1wPuaHg@mail.gmail.com>
 <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com>
 <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 10, 2021 at 11:26:57PM -0800, John Hubbard wrote:

> So:
> 
> FOLL_PIN: would use DMA_PIN_COUNTING_BIAS to increment page refcount.
> These are long term pins for dma.
> 
> FOLL_GET: would use GUP_PIN_COUNTING_BIAS to increment page refcount.
> These are not long term pins.

Do we have any places yet that care about the long-term-ness?

The only place long term would matter is if something is waiting for
the page ref count to drop.

Jason

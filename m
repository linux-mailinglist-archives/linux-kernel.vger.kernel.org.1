Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C56FB270972
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 02:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbgISA2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 20:28:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgISA2w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 20:28:52 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31E4AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:28:52 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e7so6703926qtj.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Sep 2020 17:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j4P3BTqdkFuFYaLLGZbe7c2TIqQozYOPAE0JV1keGJo=;
        b=dLBnAlnwbin8WDERspJuceop3Te+BNeAc5uU9GUX9B0PcR+b2YgIDAH0JiWHmwvIl/
         eKo6b4RFOJbrPP1JGgI8gZaYIvehyRf1S1+m/DGm2fGyKMZ6b/Wwzt6zrfJhjxcdN2Gn
         XjMLJtWiRyph+GRm1L4JJKsFgvP1M/j4gKOhQ6NxatU8v1lbsloMYI+8NB2c6Y1X0qt/
         PNRv+gdoFqUmP3s8N88s4iK+6A4u1hkPMbBnEu8ofJhWz4VSd3kDY2GvZJJcR0R3WKRn
         5F2KAk8fSF4AotSJno+qerOij0Ebn0ylNz1h/Odkt/lTMVTWVrm77UJXaifsZA53uMzI
         PWMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=j4P3BTqdkFuFYaLLGZbe7c2TIqQozYOPAE0JV1keGJo=;
        b=KA3dNLNIIQBXX+E0junoVC9vZUUHYQehqJeADrCltQekXhpbVS0o1kXgAjb8HrqYtW
         g2qeYT9GK/8eQJr9AUWN541D94CG7qNVGlS3Th+/NESPqs7LlM+HWDpS2PeiDZQn1J0O
         4bUgWrHZiNLz+rs2htepttWC3hfBk/6b8CCprsdZmrvRStLnkCQBlatL2pWygtC3m9Wz
         uokx/BriA8HFj18Ne4975GZirvybP1SPn3v99a7s9ySl9InPkOvu/uGlEr1NbQhOQdse
         RE0KZ0Ox1zQEMboDjdjnFQwVRUhcNoJHFBeRS3YU9k7azKv+E8Mw+KjBV7PijfGwzG5k
         gguQ==
X-Gm-Message-State: AOAM533AXrSzpjXBzWuMF68vizRwHX+ciUa5Y9OQ5DCvLvUCWAV5CS7L
        7nD8PZ8IJChUbvbXcRCVbYbhAg==
X-Google-Smtp-Source: ABdhPJySxxqfzDfjfbksWHdFYTVJRjxf8rsXn3DLPgiggYB39MIUEoswhSgA5BPzH0RZb/+eHfRtKg==
X-Received: by 2002:ac8:4d84:: with SMTP id a4mr36829730qtw.365.1600475331321;
        Fri, 18 Sep 2020 17:28:51 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id j88sm3179374qte.96.2020.09.18.17.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 17:28:50 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kJQkE-001uTq-5K; Fri, 18 Sep 2020 21:28:50 -0300
Date:   Fri, 18 Sep 2020 21:28:50 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Jan Kara <jack@suse.cz>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200919002850.GA8409@ziepe.ca>
References: <20200916174804.GC8409@ziepe.ca>
 <20200916184619.GB40154@xz-x1>
 <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
 <CAHk-=wiF03A3X0FoE68yXWDqO19ofgXq=21kWcRAe5+uN-WHXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiF03A3X0FoE68yXWDqO19ofgXq=21kWcRAe5+uN-WHXw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 18, 2020 at 01:59:41PM -0700, Linus Torvalds wrote:

> Honestly, if we had a completely *reliable* sign of "this page is
> pinned", then I think the much nicer option would be to just say
> "pinned pages will not be copied at all". Kind of an implicit
> VM_DONTCOPY.

It would be simpler to implement, but it makes the programming model
really sketchy. For instance O_DIRECT is using FOLL_PIN, so imagine
this program:

        CPU0                                      CPU1

 a = malloc(1024);
                                                b = malloc(1024);
 read(fd, a, 1024); // FD is O_DIRECT
 ...                                            fork()
                                                  *b = ...
 read completes

Here a and b got lucky and both come from the same page due to the
allocator.

In this case the fork() child in CPU1, would be very surprised that
'b' was not mapped into the fork.

Similiarly, CPU0 would have silent data corruption if the read didn't
deposit data into 'a' - which is a bug we have today. In this race the
COW break of *b might steal the physical page to the child, and *a
won't see the data. For this reason, John is right, fork needs to
eventually do this for O_DIRECT as well.

The copy on fork nicely fixes all of this weird oddball stuff.

Jason

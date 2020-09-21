Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F81327234A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 14:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726844AbgIUMDH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 08:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726413AbgIUMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 08:03:04 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F79DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 05:03:04 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id c62so1412352qke.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 05:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=n8wdHOSqWX61vRwJu5wuprxjYIoUJUkiAYkQze1elTI=;
        b=Abeh9hY13m5rcDf2R4a80dJzuu1Hee7Ih3j8Yks8xuSgit73vPIzQdanCSdIw4+0Jx
         b8U0FIKHH7P6i/m4hI7yUqj2zNJX7luPpS2tQcwn1/MG930FELuaFpn9JE15hbEWr3qx
         5D5OlIBvua1SxZ2GAE1c5fIP18Rc2GC+9l1VLxgsh/1WG0So4jnOgA1/dymBfItFroZM
         qn7BY+C0WphAZp5muInIfPXxgVDk8z5ncjjOyKuX74nXveEjW34BOyCy5TVXzoPhvo0n
         lNxcnfrxwioFXE3ba5wxVcOn6IjcIe+pKiAVaKZb6vhwB+Vtgp5SHcPLstP16bTqhta0
         BR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n8wdHOSqWX61vRwJu5wuprxjYIoUJUkiAYkQze1elTI=;
        b=oHMyC3pY71WO1CCaXpIviTqUp+K7GEPJHluXDUO7TIOu+e65brFp26BHBcoDWPs+Dt
         2HkOrN09Dbf9BhnZdZNDC0a5Rs5SqDL/VvzbncLooQLkL9fy47MAe57H78D3LFKTT5z+
         Fk5w8yGNIX8OcKr2ZWAkkdzdIdiBRMFiIu/LPECNk1oximkVqRPeCp4f497cqe7hRLRv
         QJtswC/UHsOhj5a3NZdLX61iLfIRtquKsJLUC2oE5BfWxyrmPMwrQHOMZJlEP+Q0fZ8j
         I13qAcjGtySXkQlhldvKlCuN/kOiIvHYX+iXoBiLjE2fz2YREHAuJVyrX/+xoNfCaaGQ
         X35g==
X-Gm-Message-State: AOAM530sqMUP4FaFYRffZpGF+KSNa9WXRs4pHUZXtRmujoV9JTB9wR3H
        bgaq0odN96Jqmw1z1p8PZfoUKA==
X-Google-Smtp-Source: ABdhPJzxxdYt7396ODoa0fFeiNoyd3GAZ/6tK3YcBmZ4mWLGMfGNFMyjgRDaul4UGozJFwtmiLU5aQ==
X-Received: by 2002:a05:620a:2118:: with SMTP id l24mr33949186qkl.298.1600689783454;
        Mon, 21 Sep 2020 05:03:03 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b28sm4962241qka.117.2020.09.21.05.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 05:03:02 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kKKX7-002aiF-T0; Mon, 21 Sep 2020 09:03:01 -0300
Date:   Mon, 21 Sep 2020 09:03:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jan Kara <jack@suse.cz>
Cc:     John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Maya B . Gokhale" <gokhale2@llnl.gov>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Marty Mcfadden <mcfadden8@llnl.gov>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/4] mm: Trial do_wp_page() simplification
Message-ID: <20200921120301.GD8409@ziepe.ca>
References: <20200917112538.GD8409@ziepe.ca>
 <CAHk-=wjtfjB3TqTFRzVmOrB9Mii6Yzc-=wKq0fu4ruDE6AsJgg@mail.gmail.com>
 <20200917193824.GL8409@ziepe.ca>
 <CAHk-=wiY_g+SSjncZi8sO=LrxXmMox0NO7K34-Fs653XVXheGg@mail.gmail.com>
 <20200918164032.GA5962@xz-x1>
 <20200918173240.GY8409@ziepe.ca>
 <20200918204048.GC5962@xz-x1>
 <0af8c77e-ff60-cada-7d22-c7cfcf859b19@nvidia.com>
 <20200919000153.GZ8409@ziepe.ca>
 <20200921083505.GA5862@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921083505.GA5862@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 10:35:05AM +0200, Jan Kara wrote:
> > My thinking is to hit this issue you have to already be doing
> > FOLL_LONGTERM, and if some driver hasn't been properly marked and
> > regresses, the fix is to mark it.
> > 
> > Remember, this use case requires the pin to extend after a system
> > call, past another fork() system call, and still have data-coherence.
> > 
> > IMHO that can only happen in the FOLL_LONGTERM case as it inhernetly
> > means the lifetime of the pin is being controlled by userspace, not by
> > the kernel. Otherwise userspace could not cause new DMA touches after
> > fork.
> 
> I agree that the new aggressive COW behavior is probably causing issues
> only for FOLL_LONGTERM users. That being said it would be nice if even
> ordinary threaded FOLL_PIN users would not have to be that careful about
> fork(2) and possible data loss due to COW - we had certainly reports of
> O_DIRECT IO loosing data due to fork(2) and COW exactly because it is very
> subtle how it behaves... But as I wrote above this is not urgent since that
> problematic behavior exists since the beginning of O_DIRECT IO in Linux.

Yes, I agree - what I was thinking is to do this FOLL_LONGTERM for the
rc and then a small patch to make it wider for the next cycle so it
can test in linux-next for a responsible time period.

Interesting to hear you confirm block has also seen subtle user
problems with this as well.

Jason

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 440512EE6CC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:27:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbhAGU0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726646AbhAGU0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:26:07 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC85C0612F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 12:25:27 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id et9so3362056qvb.10
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:25:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a1+La7RSJx5ojmYbP5Ad9U1tNT01Ee+7olXre/2vb0w=;
        b=LfCDHyTsr7XsP4ntg9rIG1P4K6EMpjM6n+gSXufmtHnUs1LHUGF0xeYMt/oGPEXrK8
         yHA/Y0IUoMZlKx9OyLz0WcPyfeLSl5lx+rFXuyAsLvqVh4T6/G2upcvTt7qImhNtk165
         K6jEZY50rWZkIvbgpaXopo91VOWYv4TA6iavYNhbbyEWwp08+GHJGqIJAk8GgJob/Qs3
         CiRioRCYpZsJeLplH3BWYjRLUefZmVqm0nZqmHvz1UFuQ0Gq0kus2vkjNKr8cm1fHru0
         qCa9Q2VIigVgcMP+S/f0qZq0dNjxyonzANk/iLsuAkWu0Oxov6ku8FExIn7trKrUm3x7
         PsUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a1+La7RSJx5ojmYbP5Ad9U1tNT01Ee+7olXre/2vb0w=;
        b=bEHgdvAaN0eDWhS96/Ponk4zOfdRt2Nq3JHc1wpykL25e/i9szg0gucr+iTC1MY60R
         7a0z2eOAsTEjftvjeEFyfMXwKCZYBIxoILnI426SPQ6Eu5imtNQmuiYtsa9plsMw4xUS
         qXYp02tz9b1i7uekg2Y3dOayGyP21TEt+ndZ++AmNtzUHH+fLU9Wb0w/PiXczMUNAGST
         Ci3eIxo8TWBSr6zU/78Bs+yjftl3cHrCBL/orjOCig65U4TIo/ukUNkSH+TLVWKa01Zt
         p601eWpVkhoTG9Gq2rtx3THjA0VDSuJPUP+FXimr+G6vwNcdWCGhZdZpi+ZJObQOIZP1
         wtVA==
X-Gm-Message-State: AOAM531cAgD8ot2oSZqWoFN5yNBux2Xt5O61xu+/PCItSHEDAoqOy5bR
        Iuntt2RQvFliKxXqf+TugvuQHw==
X-Google-Smtp-Source: ABdhPJzyL47FcPVROVV2y/vCdG2NPcBICWubrj6+KiQfew4o8B1KI+yz8QILM/dGFOe3JJ9ChjQ59A==
X-Received: by 2002:a0c:b64e:: with SMTP id q14mr343807qvf.52.1610051126502;
        Thu, 07 Jan 2021 12:25:26 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id u65sm3796362qkb.58.2021.01.07.12.25.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 12:25:25 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kxbqX-003ua2-C3; Thu, 07 Jan 2021 16:25:25 -0400
Date:   Thu, 7 Jan 2021 16:25:25 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
Message-ID: <20210107202525.GD504133@ziepe.ca>
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210107200402.31095-1-aarcange@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 03:04:00PM -0500, Andrea Arcangeli wrote:

> vmsplice syscall API is insecure allowing long term GUP PINs without
> privilege.

Lots of places are relying on pin_user_pages long term pins of memory,
and cannot be converted to notifiers.

I don't think it is reasonable to just declare that insecure and
requires privileges, it is a huge ABI break.

FWIW, vhost tries to use notifiers as a replacement for GUP, and I
think it ended up quite strange and complicated. It is hard to
maintain performance when every access to the pages needs to hold some
protection against parallel invalidation.

Jason

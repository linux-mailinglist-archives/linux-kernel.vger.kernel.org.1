Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4172F2EE6F7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 21:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727197AbhAGUdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 15:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbhAGUdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 15:33:11 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3B8C0612F4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 12:32:30 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id o13so17746163lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=exdNoEK6aNVTIIvwBb552yhewWQizCMJvF9WzrX9jnw=;
        b=D2InA4ogLKOyCTV7NlZA4RiumoSXVMs9ntzahvPQMp4OQpQM96X0jajm3v+5LBd+6V
         dcoiw9TSyMMWbMbJAdUzTtk46W7QnhZWTW8BEnO7/8+YZfyERLDEnVshc67mBo+/e9h5
         irxASrqJdCjrw7OvErf1/1EFk61vrF1uPi45Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=exdNoEK6aNVTIIvwBb552yhewWQizCMJvF9WzrX9jnw=;
        b=JNQFV8i0LQ7ARJJDdSy+KkZ3ZilUiID9pkYIrqDvHdKa/eOdnUry0C++k86LlrB6Vv
         qmpvllAU3U6NQxxe2/Sgs9oqUmUxquXho+XCxV4/AD075YlhTj+R3uJIZUw4Ck8lsOVj
         xigv/KlLLi1eiOaxizYC51F0KTFQqOmC6D/b+WoRPvswB27HECHUA+wcNxYz5f8y+28B
         eAXLN1H/pS6MQXjLGSSsARiiVvrRG5xnz38UY0RA5GVo7uvaxdCypz7x26tWRnccWjVj
         lsuFmtFM2A+cFFwAob46vYHT7OeGcMSj35Buca9ekpmGDIsRFnjSb3aC4Dw41QoNT04N
         eW2Q==
X-Gm-Message-State: AOAM530V/GuuLLPp8Uwuv5ggnU0cMWqEVN/D1eMrtbLc4OWA58ERU6uR
        KFZB6z8MlylW8Zp7xBWctdkbSvgD3OFxvA==
X-Google-Smtp-Source: ABdhPJxI+YFRh8b3iKJoy5fxXvK0eiY5SCfAo7qjDD1Gqa9R4z2q9+XyL60DyhgA0czrx0eLGoWZRw==
X-Received: by 2002:a19:7ec9:: with SMTP id z192mr248483lfc.50.1610051547936;
        Thu, 07 Jan 2021 12:32:27 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id j12sm1394049lfc.99.2021.01.07.12.32.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 12:32:26 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id m12so17689397lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 12:32:26 -0800 (PST)
X-Received: by 2002:ac2:4987:: with SMTP id f7mr194200lfl.41.1610051545800;
 Thu, 07 Jan 2021 12:32:25 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
In-Reply-To: <20210107202525.GD504133@ziepe.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 12:32:09 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
Message-ID: <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
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
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 7, 2021 at 12:25 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> Lots of places are relying on pin_user_pages long term pins of memory,
> and cannot be converted to notifiers.
>
> I don't think it is reasonable to just declare that insecure and
> requires privileges, it is a huge ABI break.

Also, I think GUP (and pin_user_pages() as a special case) is a lot
more important and more commonly used than UFFD.

Which is really why I think this needs to be fixed by just fixing UFFD
to take the write lock.

I think Andrea is blinded by his own love for UFFDIO: when I do a
debian codesearch for UFFDIO_WRITEPROTECT, all it finds is the kernel
and strace (and the qemu copies of the kernel headers).

Does the debian code search cover everything? Obviously not. But if
you cannot find A SINGLE USE of that thing in the Debian code search,
then that is sure a sign of _something_.

            Linus

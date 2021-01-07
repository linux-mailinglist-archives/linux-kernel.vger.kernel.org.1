Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7352EE845
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 23:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbhAGWSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 17:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbhAGWSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 17:18:49 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78594C0612F6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jan 2021 14:18:08 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id o13so18369796lfr.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+47eR4Bwm2fUxRCzNw86b57GLxJUQgbaI393M/TdOC8=;
        b=VmzVoiO3iotOwKySTBYAbz22Cy0Mz1M2+2vk7cNz/0XZWWy9tIlfo7DJYlzHkwuF66
         JtSjlpK8HozPLFXsFYnF4DBLEW4G5OpBIWOhnY3wYJYGWCh+m+Tl0yv4PpdhrumsQ1dw
         ZszWwE/+nX4+2OPhkN4l6OSxeFMavhs9u4VmM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+47eR4Bwm2fUxRCzNw86b57GLxJUQgbaI393M/TdOC8=;
        b=lkXUtrW8VcBGKQJuvnv2A7mJC674f9H2bgITrljjqkrAw3IeuPO3h2GYQJqhA2bn5M
         rpOQ2PS8sPD2aHiGA4y2dMVUap9loQZ1gRY/Yw9nuKGFkCvvmnRWA35nkHycD5T4faps
         /W8wkaKs1W9j1v58Bti0WcFhSMmiHDoXCaL52+zFHcNwx5osQKqUNEyklSOVFurJMfWT
         r70FoeO76Vl/A5IZb+WeD+5SkY0PdxdBJ6j7IbvpIa6RAc9KCHLOqmF1HtZ/+nTexrJP
         q3Y7RpH7fFBvilLcQfXye7W8LChdmA1/F7CJU1A4sMnD3zNzD3tdZyt9pdqhkHFsnaE3
         Xp+w==
X-Gm-Message-State: AOAM532hWDeOHHGdEOe/2CRY4MUenslFVuriPmLdVoGCi0RP2TUr1mv5
        c7iWtjJ9txupMcUgcd0AC/Tl2Dg72qmUoA==
X-Google-Smtp-Source: ABdhPJztt6SgUzZg4uV+8gwDze1g3+p7D2scTyH9ymM6HM9YfX5VH3HWZB3FvL4ABTGTFD9vsWZK3A==
X-Received: by 2002:ac2:4e8d:: with SMTP id o13mr335613lfr.259.1610057887055;
        Thu, 07 Jan 2021 14:18:07 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id w202sm1455281lff.182.2021.01.07.14.18.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 14:18:06 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l11so18413603lfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 14:18:06 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr213490ljj.465.1610057885956;
 Thu, 07 Jan 2021 14:18:05 -0800 (PST)
MIME-Version: 1.0
References: <B1B85771-B211-4FCC-AEEF-BDFD37332C25@vmware.com>
 <20210107200402.31095-1-aarcange@redhat.com> <20210107202525.GD504133@ziepe.ca>
 <CAHk-=wjTuS9JB=Ms4WAMaOkGuLmvYwaf2W0JhXxNPdcv4NWZUA@mail.gmail.com>
 <CAHk-=wjDkyom4haQu6OU_yykkCFqMi98qO2gUPgZBF-11krRAA@mail.gmail.com> <X/eFCt/lxRKgoPXu@redhat.com>
In-Reply-To: <X/eFCt/lxRKgoPXu@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 7 Jan 2021 14:17:50 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjhpTa616YdTfincMV1LqqRWqokKtd1ARdMOPd1Wra8Pg@mail.gmail.com>
Message-ID: <CAHk-=wjhpTa616YdTfincMV1LqqRWqokKtd1ARdMOPd1Wra8Pg@mail.gmail.com>
Subject: Re: [PATCH 0/2] page_count can't be used to decide when wp_page_copy
To:     Andrea Arcangeli <aarcange@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Linux-MM <linux-mm@kvack.org>,
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

On Thu, Jan 7, 2021 at 2:03 PM Andrea Arcangeli <aarcange@redhat.com> wrote:
>
> If you could stop mentioning UFFDIO_WRITEPROTECT and only focus on
> softdirty/clear_refs, maybe you wouldn't think my judgment is biased
> towards clear_refs/softdirty too.

So I think we can agree that even that softdirty case we can just
handle by "don't do that then".

if a page is pinned, the dirty bit of it makes no sense, because it
might be dirtied complately asynchronously by the pinner.

So I think none of the softdirty stuff should touch pinned pages. I
think it falls solidly under that "don't do it then".

Just skipping over them in clear_soft_dirty[_pmd]() doesn't look that
hard, does it?

            Linus

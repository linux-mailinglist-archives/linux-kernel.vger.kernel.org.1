Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88FCC2F53B5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbhAMTzq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 14:55:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbhAMTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 14:55:45 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F73C061575
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:55:05 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o19so4600435lfo.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VVRnidq3Ezoxd8/TnzX5XA0I3NxFLA67+ejsz55qsA=;
        b=F9b11/Nz6rTHOculKOHTTHckBbUGSVIFhzWAuPpK6tgr/yr5VNKoSQOq4ATcv2NEYB
         fTH0oj2iOzfW7LrGOaGxAiB7AIQjx+IInRw1kFUYJTKZzZjVp3LlvdODW9YjJztz+Z7I
         BbBh607WMcIgEMFet9Z99iKvCvhUVIZMf9Qv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VVRnidq3Ezoxd8/TnzX5XA0I3NxFLA67+ejsz55qsA=;
        b=XCHJDwV7pg1nv4pXVX7XUqx00wVMSk9vsmjT1FAG3290UadAz3Xrt3H9XcJgN7uYnb
         f3mVLL/iNIo7rIRMOhtc4Nz/kxsMuQIJBtfXwilRJ1li57UzqW4IOembCBn6z27Z+lVY
         GbrPocOXepKCKJGdsb/DM2H/ZCMM7JB22zRhk5c2J6X14qKBSAzK4JZxM26gTddQnaUH
         w+YYEEoxLrm8A3161UZjedb4hy+g2wujram8Z9juYU3dIekeFNEB5045Syb5Pe9PVIXP
         Vk6VZh2QTUbCT6IJdgaoS7hteXHCN56TF8mhQFr0c9caGPkI6jMaByMxPg2/Mq70YC9Y
         zMlQ==
X-Gm-Message-State: AOAM532yDoq+lm9BmaUAFcXMvlB4OAxVuVYe+DqLu5n7REi782CZbzmD
        2IgSeW3poPZ1I8U5Pp7RUKX5qSfNspMLVg==
X-Google-Smtp-Source: ABdhPJzzmT822NYJiGXxVhtL2p0L8NQMPUh0obcuJ8rTQ3Ft9u42GY/he2Qq8b57qs/fy0cB0JpZuw==
X-Received: by 2002:ac2:5c5d:: with SMTP id s29mr1499972lfp.88.1610567703521;
        Wed, 13 Jan 2021 11:55:03 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id c1sm276407ljd.117.2021.01.13.11.55.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jan 2021 11:55:01 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id v67so4600141lfa.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 11:55:00 -0800 (PST)
X-Received: by 2002:a19:f014:: with SMTP id p20mr1485833lfc.421.1610567700198;
 Wed, 13 Jan 2021 11:55:00 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj5=1DKbQut1-21EwQbMSghNL3KOSd82rNrBhuG9+eekA@mail.gmail.com>
 <X/prosulFrEoNnoF@redhat.com> <CAHk-=wjZTMsv0_GOyQpLRk_5U1r5W8e21f8sV0jykK=z47hjGQ@mail.gmail.com>
 <CAHk-=wgi31FKc9AL6m87+pb2B79V2g_QjdhmtJNW8Pnq2ERQ-Q@mail.gmail.com>
 <45806a5a-65c2-67ce-fc92-dc8c2144d766@nvidia.com> <CAHk-=wipa-9wEuWHBjourmXAVHdeqDa59UxW6ZJ_Oqg6-Dwvdw@mail.gmail.com>
 <CAHk-=wje9r3fREBdZcOu=NihGczBtkqkhXRPDhY-ZkNVv=thiQ@mail.gmail.com>
 <20210113021619.GL35215@casper.infradead.org> <CAHk-=wjWMieNV3nAJgoG5prEHBEcOZiREmLUr499tA9NMttEqQ@mail.gmail.com>
 <20210113123232.62vv6xsrpitne7hc@box> <20210113125532.GN35215@casper.infradead.org>
In-Reply-To: <20210113125532.GN35215@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 13 Jan 2021 11:54:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh=-_F1_ozuF6Wzg1-u07iLuUG_77SQeuX7gwgC5DQKzQ@mail.gmail.com>
Message-ID: <CAHk-=wh=-_F1_ozuF6Wzg1-u07iLuUG_77SQeuX7gwgC5DQKzQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] mm: restore full accuracy in COW page reuse
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        John Hubbard <jhubbard@nvidia.com>,
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
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Nadav Amit <nadav.amit@gmail.com>, Jens Axboe <axboe@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 4:56 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Yes, Linus mis-stated it:

Yeah, I got the order wrong.

> ... but as David pointed out, I fixed this in e320d3012d25

.. and I must have seen it, but not really internalized it.

And now that I look at it more closely, I'm actually surprised that
other than the magic "speculative first page" case we don't seem to
use page reference counting for non-order-0 pages (which would break
that hack horribly).

             Linus

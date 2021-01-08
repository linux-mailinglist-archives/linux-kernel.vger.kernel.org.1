Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81972EF675
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 18:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbhAHRba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 12:31:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbhAHRb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 12:31:29 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B765C061380
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 09:30:49 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id l11so24837604lfg.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXIjqAGwIdysFUxFNrZdW6sBVj2LPsT4/aJMu2Daxhc=;
        b=h0uCqWoH0H5RlCTO201ht4IXE9MIKRtSYzynacRdMt8/vz8Rz7XretI9vI/MfaHP33
         gu558cgmEYSVoCm/9c5H7mLiFP/xi23mq5nwsloZLigSKTbed1joOkNERCziG0t5Y5nA
         cHAUCZdpY4VNWGyzBwpbsrtL9iIbmVeKUqilg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXIjqAGwIdysFUxFNrZdW6sBVj2LPsT4/aJMu2Daxhc=;
        b=MJGKe0spbUOqfLmuQoH9uUfadypjB8NRFMR7T7TKKFM+GzuJVvX4bZ/E/wornXhLdb
         KpTmpPlaAzLrqKTH03+Bh0P4NVaFQ5yX2La7sjnzgrZQKI4oWm0sbvvfExA5JsfKW5Qu
         /7SO822hLLTZ+LNzSMWeg7ho3j2HCFLUzI+nJQAih4dHuQNMbOg5z+vJpVRyx1w6B4tU
         tLy4L0Mp0zKEueSRc5aPMC70hVCHvVpZlsE3Z19B5fr/xPVZKejFatQNjjXTr0CNKXZ0
         eEsQLAa8svQancwh8WmqRH8O0n9Py5lj9tdGTM+S8qi4n6w7I77oJC0vX4pex0pSTjtT
         qN3Q==
X-Gm-Message-State: AOAM533ybfVfVUaTC2tjHQ6K4nZ7iftUDoRuWvpdvcyp3cghslptd0jZ
        ukDJC/1KZuu1YonsorwWDBHN0NI9V04GbQ==
X-Google-Smtp-Source: ABdhPJwe7YUEcOVSP9Ivsso7pW5pMkG8Fd5UEj/Tf9eWmhP/KZZVpBaHk+ZcSixqyrJCfs1iYvNyKg==
X-Received: by 2002:ac2:5e74:: with SMTP id a20mr1894930lfr.81.1610127047601;
        Fri, 08 Jan 2021 09:30:47 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id v6sm2143841lfa.200.2021.01.08.09.30.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 09:30:46 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id 23so24670954lfg.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 09:30:45 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr1834917ljj.465.1610127045470;
 Fri, 08 Jan 2021 09:30:45 -0800 (PST)
MIME-Version: 1.0
References: <20210107200402.31095-1-aarcange@redhat.com> <20210107200402.31095-3-aarcange@redhat.com>
 <CAHk-=whg-91=EF=8=ayyDQGx_3iuWKp3aHUkDCDkgUb15Yh8AQ@mail.gmail.com>
 <X/d2DyLfXZmBIreY@redhat.com> <CAHk-=wjs9v-hp_7HV_TrTmisu7pNX=MwZ62ZV82i0evLhPwS1Q@mail.gmail.com>
 <X/eLwQPd5bi620Vt@redhat.com> <CAHk-=whjS3pUZRJLR_HdgB0_1Sd4gWXUbLLyShKxOg0ySCdnUA@mail.gmail.com>
 <CAHk-=wgRZ5o5pUqKC6cwTLU=V-G+rF5DTexGh1kCMGrgXDufew@mail.gmail.com>
 <X/edsWgguQDgsOtx@redhat.com> <CAHk-=whTCBa6Frpbveuy7Hnz17P+g03yQvynkApFbBjV5rVrsA@mail.gmail.com>
 <20210108124815.GA4512@willie-the-truck>
In-Reply-To: <20210108124815.GA4512@willie-the-truck>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 09:30:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whe4ae4CWVf+MiMs_1x9RWVPOLKuAQB8GA0XUk1aG=YZg@mail.gmail.com>
Message-ID: <CAHk-=whe4ae4CWVf+MiMs_1x9RWVPOLKuAQB8GA0XUk1aG=YZg@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: soft_dirty: userfaultfd: introduce wrprotect_tlb_flush_pending
To:     Will Deacon <will@kernel.org>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu Zhao <yuzhao@google.com>, Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Minchan Kim <minchan@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Kara <jack@suse.cz>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 4:48 AM Will Deacon <will@kernel.org> wrote:
>
> It certainly looks simple and correct to me, although it means we're now
> taking the mmap sem for write in the case where we only want to clear the
> access flag, which should be fine with the thing only held for read, no?

When I was looking at that code, I was thinking that the whole
function should be split up to get rid of some of the indentation and
the "goto out_mm".

And yes, it would probably be good to split up up even more than that
"initial mm lookup and error handling", and have an actual case
statement for the different clear_ref 'type' cases.

And then it would be fairly simple and clean to say "this case only
needs the mmap_sem for read, that case needs it for write".

So I don't disagree, but I think it should be a separate patch - if it
even matters. Is this strange /proc case something that is even
commonly done?

            Linus

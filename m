Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1792CDF3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 20:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbgLCT6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 14:58:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgLCT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 14:58:36 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF74C061A52
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 11:57:50 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id hk16so1747828pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 11:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YC21jCFH+T6bNg6mCpBEH9LA7IBalHFyi6DVV8g6ygE=;
        b=iwveHThaR7rt4USbVY0nmfrQEqKcB5GNjW4CuEbwkbrKtXvn8+kZlnHkeTT8WXxyVV
         vRjljhf0KbTbds56ZoE8/GYDeqF/QoX1gRppxubEr/h/QEQew6Qa7tIUawzRb11lnxTK
         ogjxmvpDf8q1g9zpHo6qi+IzNJXWvN2qvGSzPoeaqXrNeRk2T638+1J4aJl94/eBK6nh
         FtZ5I1McTKYsYOfScqLPkzZWr3AaNxKsCKCFz5JlO6+8cMk4v5sM/kO4QkF6G10SoC+G
         DbjKMFadvOBS9rioprm24JiOz8EtyC8bLfng+lKQ/pGXWc6B+YQD+Jwj38AN+Oq+0kfe
         vNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=YC21jCFH+T6bNg6mCpBEH9LA7IBalHFyi6DVV8g6ygE=;
        b=szoCV15oeqtRLv2B3Nh5eZr8apt+HTdOT+v1STeKxw2Txooea3eQOfxnpDHxjLY3ol
         Fm2SNmM9M7p+qng79k8nocS7DP3NCQbHw2WXIqHUSZOY8GdNBFHbpWJIaUZWOPIrxt2f
         zAs7pav+tuQhKD7bU9QJFYmS/fK11WAgmu1MVvncN2pqlMrEFwHhugEfLOv+iym9y4m9
         QySB7G1TPa1ZuIdHNl4cu8r6ovQPXcF7PK+LCTYM8cg29RKo1T8Nl86c1WuyjQJJB663
         Y2F4A3wIUsnbEB7uZJi5Ax/WDuj4xHLIQQf3noQI+9qsTscy78/q4LLhM/wL+3CyHbNU
         egow==
X-Gm-Message-State: AOAM531bXgJgxss6qzI+tTOLg/VxaPKBfBm7LNnk7OMBZBLvy5Lp3rXG
        DX/P1C1X8s3SUBJ8b5XQw/g=
X-Google-Smtp-Source: ABdhPJz4ovh5ZU/Ytt6GUaKhyiwpEaFicj/3m3dV+EckHn4762woSgYaU6s851Mpxa3iOuBsOHZTcw==
X-Received: by 2002:a17:90a:1b29:: with SMTP id q38mr652392pjq.223.1607025469914;
        Thu, 03 Dec 2020 11:57:49 -0800 (PST)
Received: from ?IPv6:2601:647:4700:9b2:e462:2bde:2e8b:f9df? ([2601:647:4700:9b2:e462:2bde:2e8b:f9df])
        by smtp.gmail.com with ESMTPSA id j10sm201707pji.29.2020.12.03.11.57.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Dec 2020 11:57:48 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] userfaultfd: prevent non-cooperative events vs
 mcopy_atomic races
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
Date:   Thu, 3 Dec 2020 11:57:46 -0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Andrei Vagin <avagin@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <31DA12CC-E9CC-497D-A2EE-B83549D95CE8@gmail.com>
References: <1527061324-19949-1-git-send-email-rppt@linux.vnet.ibm.com>
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mike,

Regarding your (old) patch:

> On May 23, 2018, at 12:42 AM, Mike Rapoport <rppt@linux.vnet.ibm.com> =
wrote:
>=20
> If a process monitored with userfaultfd changes it's memory mappings =
or
> forks() at the same time as uffd monitor fills the process memory with
> UFFDIO_COPY, the actual creation of page table entries and copying of =
the
> data in mcopy_atomic may happen either before of after the memory =
mapping
> modifications and there is no way for the uffd monitor to maintain
> consistent view of the process memory layout.
>=20
> For instance, let's consider fork() running in parallel with
> userfaultfd_copy():
>=20
> process        		         |	uffd monitor
> ---------------------------------+------------------------------
> fork()        		         | userfaultfd_copy()
> ...        		         | ...
>    dup_mmap()        	         |     down_read(mmap_sem)
>    down_write(mmap_sem)         |     /* create PTEs, copy data */
>        dup_uffd()               |     up_read(mmap_sem)
>        copy_page_range()        |
>        up_write(mmap_sem)       |
>        dup_uffd_complete()      |
>            /* notify monitor */ |
>=20
> If the userfaultfd_copy() takes the mmap_sem first, the new page(s) =
will be
> present by the time copy_page_range() is called and they will appear =
in the
> child's memory mappings. However, if the fork() is the first to take =
the
> mmap_sem, the new pages won't be mapped in the child's address space.
>=20
> Since userfaultfd monitor has no way to determine what was the order, =
let's
> disallow userfaultfd_copy in parallel with the non-cooperative events. =
In
> such case we return -EAGAIN and the uffd monitor can understand that
> userfaultfd_copy() clashed with a non-cooperative event and take an
> appropriate action.

I am struggling to understand this patch and would appreciate your
assistance.

Specifically, I have two questions:

1. How can memory corruption occur? If the page is already mapped and =
the
handler =E2=80=9Cmistakenly" calls userfaultfd_copy(), wouldn't =
mcopy_atomic_pte()
return -EEXIST once it sees the PTE already exists? In such case, I =
would
presume that the handler should be able to recover gracefully by waking =
the
faulting thread.

2. How is memory ordering supposed to work here? IIUC, mmap_changing is =
not
protected by any lock and there are no memory barriers that are =
associated
with the assignment. Indeed, the code calls WRITE_ONCE()/READ_ONCE(), =
but
AFAIK this does not guarantee ordering with non-volatile reads/writes.

Thanks,
Nadav=

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636362E09F3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 13:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgLVMOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 07:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgLVMOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 07:14:08 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B80FC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:13:27 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b26so21940409lff.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 04:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XDqWemTZAr3Yf5zc0WPnza6SJa69M9w7Rj4fQPF3P5o=;
        b=tPpOPFZiOO+7bXVYjFI5JFD6T6i0npRgJb2VT4lieoQIF08DoFCYSGjj9UtUf7OlOT
         k59s2Xvq/lfysj+/GyyxJvQlfo02nL1EuA2PBhI+xh9pDS5Yg5bPQ4Zt7jO0QiFdxGdp
         dKcuZ4zXWF5bWyAxUTzFny3vMoMajws16JY40rUn6sUIVqICCZSBYnX5i8M7E+Z0u3CT
         lTPukRJlbMMNBCD78ibfqd94YssAxc4XtIpdyd2C7HlUWeqJ17NRIF47bAm5ugtNHU68
         U4khUQcaFfH58dRFjW4SmhGv0p2aKTkWcwPPS4ZUSjxZrs0qCCkJW8Il2Xt6AJjLwQiX
         KhqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XDqWemTZAr3Yf5zc0WPnza6SJa69M9w7Rj4fQPF3P5o=;
        b=bpQiufEbc2zRi/eKmb6jPQ0AIodjnQsUxibRezVEbjBTY6mwgqFYldMq293dF0T0dk
         A5o3nej1jgZjd0Bhcd2POmzRBBXly81QjlZbepM+1X6ilQYN+8ukA62xZRCkcQOWuGQh
         f5M+0espnjsUafFixFJVCJoQA3K3XlqMWL9heQo2QFd6b3MvGa/qze+YdeI8KrJI1GI7
         k30hAjElRXGahrMWPZkykwM0NjlQU+SS287Bha63AhtKtAi2ounyDhQolTAC4+UwGXni
         mOuyfabNTq8Vw1FEz7X5EAglZGQtuyHdMQNkvxaQeNeF5avJPjq+9oCQ36WAjkh3DRYS
         rxcQ==
X-Gm-Message-State: AOAM5308iH78yqrCnRtFvdgpBNmlBYEUT3GkI++Pk86JoIsf28OUEcFN
        BsNz6yxBj0HZ3frP4bal3kEDUBpy9X22j3X6M9E=
X-Google-Smtp-Source: ABdhPJy//mXDzhSL1YWk1GnMAjPpsove6BusTlVwzWEpUuwAUeHj+jE+6K6s+3pbthcvs1KaZqTkjZMhul0rQkreE6s=
X-Received: by 2002:a2e:b8d1:: with SMTP id s17mr10053775ljp.472.1608639206075;
 Tue, 22 Dec 2020 04:13:26 -0800 (PST)
MIME-Version: 1.0
References: <20201222074910.GA30051@open-light-1.localdomain>
 <585791f4-4b41-5e73-296e-691d5478a915@redhat.com> <a0bee19a-0703-54b1-2903-60383ab7da64@redhat.com>
In-Reply-To: <a0bee19a-0703-54b1-2903-60383ab7da64@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 22 Dec 2020 20:13:12 +0800
Message-ID: <CA+2MQi8kupPHetMhH97fn+toFk9HUYeVPnwdzrpyiS6Necn0CA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] mm: support free hugepage pre zero out
To:     David Hildenbrand <david@redhat.com>
Cc:     Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Free page reporting in virtio-balloon doesn't give you any guarantees
> > regarding zeroing of pages. Take a look at the QEMU implementation -
> > e.g., with vfio all reports are simply ignored.
> >
> > Also, I am not sure if mangling such details ("zeroing of pages") into
> > the page reporting infrastructure is a good idea.
> >
>
> Oh, now I get what you are doing here, you rely on zero_free_pages of
> your other patch series and are not relying on virtio-balloon free page
> reporting to do the zeroing.
>
> You really should have mentioned that this patch series relies on the
> other one and in which way.

I am sorry for that. After I sent out the patch, I realized I should
mention that, so I sent out an updated version which added the
information you mentioned :)

Thanks !
Liang

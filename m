Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39FE2E0239
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726048AbgLUV5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:57:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42023 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgLUV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:57:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608587734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Yag9dkUrJO2svaffFY55Sd1tdeWMDuxfetcMS6uoLIQ=;
        b=QVWelx1wydg6Q0d5K8xLHZz78AhuxQSWRihZeKiSM5KiBrXZD2H2dDgS+/u8wYMOCDDJb9
        LDo48UJUPHVH4Jye/9gTZWnyu/b6cqMaxl0Hu3PsmLdL+ZyxndtLGDuKb1aeswNB4DWW5z
        C2iSjVb1YERi9cyZeS4MeL/8+/twUF0=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-OfohUXtXPPi5JgaLgOHx8Q-1; Mon, 21 Dec 2020 16:55:30 -0500
X-MC-Unique: OfohUXtXPPi5JgaLgOHx8Q-1
Received: by mail-qt1-f200.google.com with SMTP id f7so8859693qtj.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Yag9dkUrJO2svaffFY55Sd1tdeWMDuxfetcMS6uoLIQ=;
        b=Wd3eBBcTIdhgysR+zFKYLQRCpDPzDBkgTaUekQZ/dr4CUIQHL7JyO1vIjhJXiJXWWr
         b1aTBRugpJ4OL6CZoJQdj3vAQUyaNpQ3gO+RhLSOxfPpUjxTyilZm5IteCBe0fHlYP7b
         kPGZSO13Ew5u+xWQVa/HMM4eXU2BwINYpyaH9+oD0P2mjhQCTxd6Epd1x1kh1Btc4mH/
         oCUVpfcztY6tKUeGCNyPB2eEWyqllWED01VmuGZnGQXO/re85JhSk3wPVfe8v7NFa5YU
         zDMhBEQb35IYPyJW1FW+YXr5Yat0YmvD4It3RsKw4W4qWqr9RWYxL1GJrBuWLgN6QbBf
         a+nw==
X-Gm-Message-State: AOAM5328mBVM5OvaL3a3d8cGwTie28rzVpjuxmiTPpMS16coUFy0q1xz
        dMf4Ll9x/79WmRktf9UI8W6DiM+0AjjU8b0LIThlzzQeTg3fKV0VnHmdPzt22h1HQsBQWM1kyrz
        qsfxo/EMfux2js08oEoKu0AYT
X-Received: by 2002:ae9:e8cf:: with SMTP id a198mr19348120qkg.11.1608587729512;
        Mon, 21 Dec 2020 13:55:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzatN9WDCPwo9Vy07PiXSPaoiCn0IUYUq1Z+VIHlvcPXq8+h8ImavpdP1rFFJhRQxKrzzuOZg==
X-Received: by 2002:ae9:e8cf:: with SMTP id a198mr19348106qkg.11.1608587729310;
        Mon, 21 Dec 2020 13:55:29 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id n188sm12004877qke.17.2020.12.21.13.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:55:28 -0800 (PST)
Date:   Mon, 21 Dec 2020 16:55:26 -0500
From:   Peter Xu <peterx@redhat.com>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Yu Zhao <yuzhao@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
Message-ID: <20201221215526.GK6640@xz-x1>
References: <20201219043006.2206347-1-namit@vmware.com>
 <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com>
 <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:23:06PM -0800, Nadav Amit wrote:
> 2. Copy the page in cow_user_page() while holding the PTL and after flushing
>    has been done. I am not sure if there are potential problems with
>    special-pages (2 flushes might be necessary for special pages).

This seems to be a good thing irrelevant of userfaultfd.

Frankly speaking I don't know why it's always safe to do data copy without the
pgtable lock in wp_page_copy(), since I don't know what guaranteed us from data
changing on the original page due to any reason.  We check and make sure pte
hasn't changed, but is that really enough?

So the safe way to me is that wp_page_copy() not only check pte_same() but also
data_same() on the old/new pages, then with that it's even easier if we just
move the data copy into the ptl as what Nadav said here.  But I have no idea on
the penalty to the rest of the world, especially on non-modern hosts.

Thanks,

-- 
Peter Xu


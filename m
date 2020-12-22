Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A53C2E0325
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 01:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726320AbgLVABJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 19:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgLVABI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 19:01:08 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE69AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:00:27 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id u12so10474760ilv.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3xnLRbZ/ommABW/N7AS5d+Sq3ewpFaRtL+dYAC3jB8I=;
        b=MqeiCLBFy+VDXF6Z23EmPSE4bReS3UwMjaDHYmQTnhONvvHbiQxNdLluMCed7sPiXd
         rsX4ElR9FdjIlWmhIoZCQ9wiTVU8tIcvC8q3whHZ3A3u8FF86Y+IcnvgdurGYHJa1eAy
         o3eQ17Y7og+9XeMS5i/sSrlNm7osKt4FUi3OJrwgCkdwj4SS70k3NJk2P93Pr172NLgw
         wpGnSRWfiXtSCq2DqlBneEjDQ+lPVvP2l0IjtS9hkrJk6O0fcVmInw96w2VzD3FOHVXS
         4IF91QZ0QoiRQqBrLqUtkHwHeMqk0Odq1M5Rqg1yMDe4L0yEL/z0c3Q2XWaxCRHKYm3u
         g6DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3xnLRbZ/ommABW/N7AS5d+Sq3ewpFaRtL+dYAC3jB8I=;
        b=dZxkwlbA08Show8l7Soe91lpnn+3z5yqXmlG6nudg2QiT7KEQ2ZY5G//C0Wsg2D6NR
         5oZk8ov45vGcgc24yjq6VF9IRSQjWk7j79neiByozm5ipj5jUpd3iYth8S8V+nvStsDq
         0uo7ZVVciDXKC0KvhlgFgTsPerhvYn98OlZLRTl3MXZBl1jASEVEKdFOHNvpSyvyDnPk
         koR2LSV7TqgyL1AIkPVvbGn/Ok/wLlg72iBCJXT1EcwCFnyPR+2ZHUOzDh5do7HjptPX
         P1g74BD2/OyhLycfjkzvLZGBRXay5rjzoD/ZQOhJzV8Qg08NskXAs6Rowa3eZrBRbEpQ
         QRzQ==
X-Gm-Message-State: AOAM531tl12FllpxEjvZAV00l8xu/Sa2k9O49pcnxOIYl1kaIdYM5vlM
        ht61/W1XlxDgw9dKWixlAG4t9Q==
X-Google-Smtp-Source: ABdhPJzgHxiH2dIc6yKy3VQ+h5AodxqQUu3cK805eJLtDeqqJK6H98AyhrZaQVndZN/FZsPd/zHneg==
X-Received: by 2002:a05:6e02:124e:: with SMTP id j14mr18387704ilq.284.1608595226989;
        Mon, 21 Dec 2020 16:00:26 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id h1sm13807012ilj.8.2020.12.21.16.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 16:00:26 -0800 (PST)
Date:   Mon, 21 Dec 2020 17:00:22 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Xu <peterx@redhat.com>, Nadav Amit <nadav.amit@gmail.com>,
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
Message-ID: <X+E3FmxrEVfc0B/X@google.com>
References: <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com>
 <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1>
 <X+Er1Rjv1W7rzcw7@google.com>
 <CAHk-=wiEp-D36h972CBHqJ-c8tR9fytg9tesZ1j_9B0ax9Ad_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiEp-D36h972CBHqJ-c8tR9fytg9tesZ1j_9B0ax9Ad_Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 03:33:30PM -0800, Linus Torvalds wrote:
> On Mon, Dec 21, 2020 at 3:12 PM Yu Zhao <yuzhao@google.com> wrote:
> >
> > I can't say I disagree with you but the man has made the call and I
> > think we should just move on.
> 
> "The man" can always be convinced by numbers.
> 
> So if somebody comes up with an alternate patch, and explains it, and
> shows that it is better - go for it.
> 
> I just think that if mprotect() can take the mmap lock for writing,
> then userfaultfd sure as hell can. What odd load does people have
> where userfaultfd is more important than mprotect?
> 
> So as far as the man is concerned, I think "just fix userfaultfd" is
> simply the default obvious operation.
> 
> Not necessarily a final endpoint.
> 
>                  Linus

My first instinct is to be conservative and revert 09854ba94c6a ("mm:
do_wp_page() simplification") so people are less likely to come back
and complain about performance issues from holding mmap lock for
write when clearing pte_write.

That being said, I do like the simplicity of 09854ba94c6a as well as
having one simple rule that dictates what we should do when clearing
pte_write(). And "userfaultfd is not the most important part of the
system" is a fair point.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7E72E0209
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 22:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgLUVZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 16:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726101AbgLUVZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 16:25:20 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C58EBC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:24:39 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id n9so10208134ili.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 13:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gt0GOM+mu9eCAi9ZwxTkAxhSO6qei0FrG7NI5v/BoDI=;
        b=ACpDdyiwt4yzErIqLdCpeaNIBrR4/bgLdfjMt1/9F8ZZFOMHGNH56+Edfr2m9edLS8
         YJoTMl2xATIDPeDCMciiGgJDwtllCD0RR+tXlKRWRIR5DHsL67/Qwmes3l7G1WpZrOgO
         FmbDWZqJa+20i6x4NSrn35qd2TAUf06sM+fTT4kZ4yzPg2Ri3E/RGJRGYUHLazaLlgh0
         Z6GfhQWEW9PuoSOR0RgQdp9JucsYj5Oxj6SQ9qj3B9e7jB0lW9pz6jCnm6gmiPNM8sN5
         gAAUGlXFu7zyctRCrFwGHfnFgyBtXYb6kAsE3rukf71mRYJ/HBcRNBBRWloAU77Sywxg
         kcdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gt0GOM+mu9eCAi9ZwxTkAxhSO6qei0FrG7NI5v/BoDI=;
        b=f0q1gTdWIz36MXbwzoB2Bce0IKJQsvf0c+P814z5ihW6gNmAFltqc3jweZLSKtzElh
         8wVsSwa4JaHyg8X/LP07tR+ExBb/E1G0omLYOHXybDe3b4Nwto952u2VtgNTgtr9rolh
         nRVkzoLq/sjF7nmpSP01QfmndhjDmh5m7UPdH0z+w2QCQFNX5Km9jwgt/j8epOEzAlho
         7WVWOTt1mZfFeuRtdfX0f5WvTDmIiyeYmz7dmD7u1BQcPOc8Sd7F1Rws6U9IssAS6SlP
         XTQA/KpavwSI6J8mYUKx6dhW9Ju5q1WlMe53BMjnsLk3mgOjk5h2l7EMuza0Ynq/+5hC
         PKbw==
X-Gm-Message-State: AOAM531tmyMQBhjxEialR+Y3vyQQF3GBU48u4zVSn2r/vJzLBn8lp20t
        e1lQDtJhMDahCWTy2hmO3Et/Yw==
X-Google-Smtp-Source: ABdhPJychXn0XslNMBwA9JjNdnXAOfUJzvSg3VkeXylKiLgYPfJfDi/cgzqACLTvDBwEhNJyinzdTg==
X-Received: by 2002:a92:d8cc:: with SMTP id l12mr17823222ilo.64.1608585878937;
        Mon, 21 Dec 2020 13:24:38 -0800 (PST)
Received: from google.com ([2620:15c:183:200:7220:84ff:fe09:2d90])
        by smtp.gmail.com with ESMTPSA id t2sm14659937ili.31.2020.12.21.13.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 13:24:38 -0800 (PST)
Date:   Mon, 21 Dec 2020 14:24:34 -0700
From:   Yu Zhao <yuzhao@google.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Nadav Amit <nadav.amit@gmail.com>, Peter Xu <peterx@redhat.com>,
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
Message-ID: <X+ESkna2z3WjjniN@google.com>
References: <X95RRZ3hkebEmmaj@redhat.com>
 <EDC00345-B46E-4396-8379-98E943723809@gmail.com>
 <X97pprdcRXusLGnq@google.com>
 <DDA15360-D6D4-46A8-95A4-5EE34107A407@gmail.com>
 <20201221172711.GE6640@xz-x1>
 <76B4F49B-ED61-47EA-9BE4-7F17A26B610D@gmail.com>
 <X+D0hTZCrWS3P5Pi@google.com>
 <CAHk-=wg_UBuo7ro1fpEGkMyFKA1+PxrE85f9J_AhUfr-nJPpLQ@mail.gmail.com>
 <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 21, 2020 at 12:26:22PM -0800, Linus Torvalds wrote:
> On Mon, Dec 21, 2020 at 12:23 PM Nadav Amit <nadav.amit@gmail.com> wrote:
> >
> > Using mmap_write_lock() was my initial fix and there was a strong pushback
> > on this approach due to its potential impact on performance.
> 
> From whom?
> 
> Somebody who doesn't understand that correctness is more important
> than performance? And that userfaultfd is not the most important part
> of the system?
> 
> The fact is, userfaultfd is CLEARLY BUGGY.
> 
>           Linus

Fair enough.

Nadav, for your patch (you might want to update the commit message).

Reviewed-by: Yu Zhao <yuzhao@google.com>

While we are all here, there is also clear_soft_dirty() that could
use a similar fix...

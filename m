Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502452E10A7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 00:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgLVXva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 18:51:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbgLVXva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 18:51:30 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DCCC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:50:49 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id l11so36037703lfg.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wT+z8aeZsnOOzxK6hRvN9mbQoYBCIG22xW14cZwa86w=;
        b=MyXM9vqGI+WhI8Rv8h6RJuLl253A3dVDm7Wiw79euFHzsqdzhooZCUkLAygIrH6ipb
         kAS54/dbjFQk681nMzW1KllhvwGrPLMHaiwMbXVIdiWMzE+LAAShC4Wb9zlbpq+nM4kS
         fWHpqNltPGPg5x9GVJGujYfbWfRTyMdNA8src=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wT+z8aeZsnOOzxK6hRvN9mbQoYBCIG22xW14cZwa86w=;
        b=mMovEaar5PVMNF8R0GRkie0ytMBhs8DPGY8HbZTX7Bkj3jyqdjkO0gVuJTG6OlVr7z
         KlfmeJ+wVu0Vos3CsqJzgntjuHvmez6qC3Wajd2DIUydQBFEC/skQLff+lQnu6HhcMxL
         yzc0QVsltU/0BsBP0yzjYkXwut44uBXrV/MPa08g3hiYzOgLcweWTjJkAZygt6zdAWEN
         rchRNHRxL2MRVUk7DeS+rfxN5/8duCEgQxLfhDv9/vTD0OmkGFCC6BctmwGcOKj5Ylbs
         8orLNxi3fd+v04VgrbcevJmFHvgohO5VGP/ny91MbEIVUkxI2WJNcy5lNeGyxrTiXXAb
         LYEA==
X-Gm-Message-State: AOAM530pURaHO2fCu7UfgZ8PFbA09Eqa9bRekzmfKVU3NiPdpL3u4Zte
        lGn2fmfisECTGvh4omRK1Un2VTcF6UA93w==
X-Google-Smtp-Source: ABdhPJwtzPFBaPcFEwqWvwkO7Odo8wLx3kIfkUO0laFl1zBVdNZo5PBRPmoI6TBvQj7+cfWwGXb3GA==
X-Received: by 2002:a05:6512:3089:: with SMTP id z9mr10386215lfd.433.1608681047817;
        Tue, 22 Dec 2020 15:50:47 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id l17sm2871075lfg.205.2020.12.22.15.50.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Dec 2020 15:50:46 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id s26so35910093lfc.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 15:50:46 -0800 (PST)
X-Received: by 2002:a2e:9ad7:: with SMTP id p23mr10303284ljj.465.1608681045870;
 Tue, 22 Dec 2020 15:50:45 -0800 (PST)
MIME-Version: 1.0
References: <9E301C7C-882A-4E0F-8D6D-1170E792065A@gmail.com>
 <CAHk-=wg-Y+svNy3CDkJjj0X_CJkSbpERLg64-Vqwq5u7SC4z0g@mail.gmail.com>
 <X+ESkna2z3WjjniN@google.com> <1FCC8F93-FF29-44D3-A73A-DF943D056680@gmail.com>
 <20201221223041.GL6640@xz-x1> <CAHk-=wh-bG4thjXUekLtrCg8FRrdWjtT40ibXXLSm_hzQG8eOw@mail.gmail.com>
 <CALCETrV=8tY7h=aaudWBEn-MJnNkm2wz5qjH49SYqwkjYTpOaA@mail.gmail.com>
 <X+JJqK91plkBVisG@redhat.com> <X+JhwVX3s5mU9ZNx@google.com>
 <X+Js/dFbC5P7C3oO@redhat.com> <X+KDwu1PRQ93E2LK@google.com>
In-Reply-To: <X+KDwu1PRQ93E2LK@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 22 Dec 2020 15:50:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
Message-ID: <CAHk-=wiBWkgxLtwD7n01irD7hTQzuumtrqCkxxZx=6dbiGKUqQ@mail.gmail.com>
Subject: Re: [PATCH] mm/userfaultfd: fix memory corruption due to writeprotect
To:     Yu Zhao <yuzhao@google.com>
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Xu <peterx@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        linux-mm <linux-mm@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Pavel Emelyanov <xemul@openvz.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        stable <stable@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 3:39 PM Yu Zhao <yuzhao@google.com> wrote:
>
> 2) is the false positive because of what we do, and it's causing the
> memory corruption because do_wp_page() tries to make copies of pages
> that seem to be RO but may have stale RW tlb entries pending flush.

Yeah, that's definitely a different bug.

The rule is that the TLB flush has to be done before the page table
lock is released.

See zap_pte_range() for an example of doing it right, even in the
presence of complexities (ie that has an example of both flushing the
TLB, and doing the actual "free the pages after flush", and it does
the two cases separately).

           Linus

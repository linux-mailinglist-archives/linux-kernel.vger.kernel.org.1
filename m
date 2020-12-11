Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA0722D8130
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 22:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391347AbgLKVhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 16:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391970AbgLKVhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 16:37:17 -0500
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA100C0613D3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:36:27 -0800 (PST)
Received: by mail-ej1-x641.google.com with SMTP id g20so14345202ejb.1
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 13:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YDCN24FrCRx5laL0ft+PuPUsmVSKnGqRS3+zbkukcGs=;
        b=b5kbkhPhvaw7foJtxfHYAzD4UJWKsxhJk/upexzoNGu32t+GxGxzsDExBMFrA6aiHz
         kiE3+ssj0Z1Uufp6NmYeoxvvFh1//aLSypJHZtlfoZSEER3TdL2EpepN89z58jfxlEdF
         mzKzq+lbZ3s8T30F12mCoHibxpmVvahQ6+VVjEGrwbrNAtsynfe3k5gWUVLLiTQ4N0OG
         E3Nw8pqvFmzvA1okIjq/di9tgSjZWwF7ONSwczGSiKL2CBT58VhXVrfdzeeX8w9eUuyZ
         UYxpbkTrntlvcEc8k8Y87uXsbmIiHEeieI122bLb4g9N6g7FDymsPUSGopffyWubJU/w
         aYRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YDCN24FrCRx5laL0ft+PuPUsmVSKnGqRS3+zbkukcGs=;
        b=C9MyAI5REaB0qjzY79AZc7rV3o6Vm1QEEAhE59GyoX2XH/lNxFKkmOfehYsbt9aEqJ
         7BVkkS7LqML3dHl5jY4O5fwiskUVKl7m8OhjZTot4clrSlepMEDl0E8gTb2JC1jZN6HO
         rsPMEdOBO62lvsMCOnthj667d3Lbc6tevQxOx0/a03I3lEntUmWRl30xxjeUMMHALPLV
         eBG7Fa9e3vRiFCzt8Bo6tZgs0Eh5BEIEx+VxasW8QkBRswkC2lhaw4ZczI9B3XgZwQ6u
         8843SD8FlQrFN/TCl66lsuZL1mKEU3ZdCflRWOqQtVG+Zhjq7luhuv5QXbxOghors/sk
         WwRQ==
X-Gm-Message-State: AOAM5305OyZNtFjR+Te7ZUjyUFUXBGV4d9I2Xac/E9581xgvLzdR1wat
        eD5G7jIaNIJr1ZdKGsECJzC1x6BifU9B4In2U3Jg2A==
X-Google-Smtp-Source: ABdhPJxo6RVmBht/M/c4z6MjVIdAjJITyJGjQx4OgVsXVYMyeIvbY66yPlaSrfLWFCIEXCj8M9PS1CYUDfm8x+g+SPY=
X-Received: by 2002:a17:906:7d98:: with SMTP id v24mr12888138ejo.129.1607722586264;
 Fri, 11 Dec 2020 13:36:26 -0800 (PST)
MIME-Version: 1.0
References: <CA+CK2bC6u4wnHX53ZhfPtQBLTDbD3t4V9Zuhj=HwD3gEyL4Puw@mail.gmail.com>
 <10F682D5-0654-4C42-9989-F999D4434295@redhat.com>
In-Reply-To: <10F682D5-0654-4C42-9989-F999D4434295@redhat.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Fri, 11 Dec 2020 16:35:50 -0500
Message-ID: <CA+CK2bCc9gk3Yy+ueaZVJs90MFE3fqukLsdb5R2kTUH4tWRbkA@mail.gmail.com>
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
To:     David Hildenbrand <david@redhat.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Sasha Levin <sashal@kernel.org>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, mike.kravetz@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 4:29 PM David Hildenbrand <david@redhat.com> wrote:
>
>
> > Am 11.12.2020 um 22:09 schrieb Pavel Tatashin <pasha.tatashin@soleen.co=
m>:
> >
> > =EF=BB=BFOn Fri, Dec 11, 2020 at 3:46 PM Jason Gunthorpe <jgg@ziepe.ca>=
 wrote:
> >>
> >>> On Fri, Dec 11, 2020 at 03:40:57PM -0500, Pavel Tatashin wrote:
> >>> On Fri, Dec 11, 2020 at 3:23 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> >>>>
> >>>> On Fri, Dec 11, 2020 at 03:21:39PM -0500, Pavel Tatashin wrote:
> >>>>> @@ -1593,7 +1592,7 @@ static long check_and_migrate_cma_pages(struc=
t mm_struct *mm,
> >>>>>                              }
> >>>>>
> >>>>>                              if (!isolate_lru_page(head)) {
> >>>>> -                                     list_add_tail(&head->lru, &cm=
a_page_list);
> >>>>> +                                     list_add_tail(&head->lru, &mo=
vable_page_list);
> >>>>>                                      mod_node_page_state(page_pgdat=
(head),
> >>>>>                                                          NR_ISOLATE=
D_ANON +
> >>>>>                                                          page_is_fi=
le_lru(head),
> >>>>> @@ -1605,7 +1604,7 @@ static long check_and_migrate_cma_pages(struc=
t mm_struct *mm,
> >>>>>              i +=3D step;
> >>>>>      }
> >>>>>
> >>>>> -     if (!list_empty(&cma_page_list)) {
> >>>>> +     if (!list_empty(&movable_page_list)) {
> >>>>
> >>>> You didn't answer my earlier question, is it OK that ZONE_MOVABLE
> >>>> pages leak out here if ioslate_lru_page() fails but the
> >>>> moval_page_list is empty?
> >>>>
> >>>> I think the answer is no, right?
> >>> In my opinion it is OK. We are doing our best to not pin movable
> >>> pages, but if isolate_lru_page() fails because pages are currently
> >>> locked by someone else, we will end up long-term pinning them.
> >>> See comment in this patch:
> >>> +        * 1. Pinned pages: (long-term) pinning of movable pages is a=
voided
> >>> +        *    when pages are pinned and faulted, but it is still poss=
ible that
> >>> +        *    address space already has pages in ZONE_MOVABLE at the =
time when
> >>> +        *    pages are pinned (i.e. user has touches that memory bef=
ore
> >>> +        *    pinning). In such case we try to migrate them to a diff=
erent zone,
> >>> +        *    but if migration fails the pages can still end-up pinne=
d in
> >>> +        *    ZONE_MOVABLE. In such case, memory offlining might retr=
y a long
> >>> +        *    time and will only succeed once user application unpins=
 pages.
> >>
> >> It is not "retry a long time" it is "might never complete" because
> >> userspace will hold the DMA pin indefinitely.
> >>
> >> Confused what the point of all this is then ??
> >>
> >> I thought to goal here is to make memory unplug reliable, if you leave
> >> a hole like this then any hostile userspace can block it forever.
> >
> > You are right, I used a wording from the previous comment, and it
> > should be made clear that pin may be forever. Without these patches it
> > is guaranteed that hot-remove will fail if there are pinned pages as
> > ZONE_MOVABLE is actually the first to be searched. Now, it will fail
> > only due to exceptions listed in ZONE_MOVABLE comment:
> >
> > 1. pin + migration/isolation failure
>
> Not sure what that really means. We have short-term pinnings (although we=
 might have a better term for =E2=80=9Epinning=E2=80=9C here) for example, =
when a process dies (IIRC). There is a period where pages cannot get migrat=
ed and offlining code has to retry (which might take a while). This still a=
pplies after your change - are you referring to that?
>
> > 2. memblock allocation due to limited amount of space for kernelcore
> > 3. memory holes
> > 4. hwpoison
> > 5. Unmovable PG_offline pages (? need to study why this is a scenario).
>
> Virtio-mem is the primary user in this context.
>
> > Do you think we should unconditionally unpin pages, and return error
> > when isolation/migration fails?
>
> I=E2=80=98m not sure what you mean here. Who=E2=80=99s supposed to unpin =
which pages?

Hi David,

When check_and_migrate_movable_pages() is called, the pages are
already pinned. If some of those pages are in movable zone, and we
fail to migrate or isolate them what should we do: proceed, and keep
it as exception of when movable zone can actually have pinned pages or
unpin all pages in the array, and return an error, or unpin only pages
in movable zone, and return an error?

Pasha

>
> >
> > Pasha
> >
> >>
> >> Jason
> >
>

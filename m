Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA732C49BA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731645AbgKYVNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:13:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731620AbgKYVNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:13:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606338831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2kFA8/66bJPsERy/zq7DBLLovoqQJHvXB9h63g9+0iU=;
        b=brzNpd3wbZe0WzpUktXDNBdGMTuHg9vcfeV2v1xZ7A9rCm3mnfdPtzZJ44UK3fcONfaFX6
        GiEgBsc/ZMxVuhezUiEnVqp/QD0v4Bi+Kp3KEu5aESgEp4C6UNEK8AQ4UD5xOKC3Twx02L
        zC9Rmrn8O2ssZlBd8tVUgwkM19xqHJI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-ROdVFXD5Pa26IsxUk-9CAQ-1; Wed, 25 Nov 2020 16:13:50 -0500
X-MC-Unique: ROdVFXD5Pa26IsxUk-9CAQ-1
Received: by mail-ej1-f69.google.com with SMTP id e22so1204292ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:13:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=2kFA8/66bJPsERy/zq7DBLLovoqQJHvXB9h63g9+0iU=;
        b=shnHpQ0WpHZhM5FUgtdI/pS8TAjMYzmkRkW+ZgLHJOZHBIu3R4KPeQa0iWShqwft7P
         PnQI3tfV2825jIWE37aLN8P8zgdzlQQm0GyBiCaTpphp+bpbJA9oagjUuV6E+cM7cFDr
         EFuPP/T84aSyamuvHstFKH6olwlq3u5uyXbtV1tA5TNzjXx417Jdrms9G3faD1gd8rBn
         GJogkB8TrgWK4hHCN43EfBgVuQS3r4lBgUf27j1py+MxsecsHfd+K4DgyEMjcOOMKBbB
         y/jcKQN4Lb1RHwbHAfrNPVwYRzJ2YzT91TCqPfXHouHuoSJDqyPhswRkIJpVViePB8Vd
         QJkQ==
X-Gm-Message-State: AOAM5320H8Cqa7m+3HMr5XL4Y1ynaQfmong1BdQZD0EccPsCdTQLkNA6
        9WRpJGD9Oqj8yy7UdQuiJGw/jAtzhp2BVjXcXl+XOOppgOgHIY4CTkK57IufP+NDZZjK1nf0Wex
        kPM6nn6zUo1cy7l8MhkQjBqne
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr4832959eju.375.1606338828544;
        Wed, 25 Nov 2020 13:13:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRMtDPt3uHZsbY3GNb7mUe4SPAyQtG7gBsGY6mxc2aX/XDRWyyXUgNMBOsjZOYuYaWreJHQw==
X-Received: by 2002:a17:906:4c85:: with SMTP id q5mr4832941eju.375.1606338828273;
        Wed, 25 Nov 2020 13:13:48 -0800 (PST)
Received: from [192.168.3.114] (p5b0c686a.dip0.t-ipconnect.de. [91.12.104.106])
        by smtp.gmail.com with ESMTPSA id op24sm1907291ejb.56.2020.11.25.13.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2020 13:13:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set pageblock_skip on reserved pages
Date:   Wed, 25 Nov 2020 22:13:46 +0100
Message-Id: <89B17C54-671B-4363-B425-CCFE17DD8FDD@redhat.com>
References: <X77BgHiTR3R7biho@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
In-Reply-To: <X77BgHiTR3R7biho@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.11.2020 um 21:41 schrieb Andrea Arcangeli <aarcange@redhat.com>:
>=20
> =EF=BB=BFOn Wed, Nov 25, 2020 at 08:27:21PM +0100, David Hildenbrand wrote=
:
>>> On 25.11.20 19:28, Andrea Arcangeli wrote:
>>> On Wed, Nov 25, 2020 at 07:45:30AM +0100, David Hildenbrand wrote:
>>>> Before that change, the memmap of memory holes were only zeroed
>>>> out. So the zones/nid was 0, however, pages were not reserved and
>>>> had a refcount of zero - resulting in other issues.
>>>=20
>>> So maybe that "0,0" zoneid/nid was not actually the thing that
>>> introduced the regression? Note: I didn't bisect anything yet, it was
>>> just a guess.
>>=20
>> I guess 0/0 is the issue, but that existed before when we had a simple
>> memmset(0). The root issue should be what Mike said:
>=20
> Yes, the second stage must have stopped running somehow.
>=20
> Is there anything we can do to induce a deterministically reproducible
> kernel crashing behavior if the second stage doesn't run?
>=20
> Why did we start doing a more graceful initialization in the first
> stage, instead of making a less graceful by setting it to 0xff instead
> of 0x00?

I guess because we weren=E2=80=98t aware of the issues we have :)

>=20
>> 73a6e474cb37 ("mm: memmap_init: iterate over memblock regions rather
>> that check each PFN")
>=20
> So if that's not intentional, are you suggesting nodeid/nid was a bug
> if it was set to 0,0 for a non-RAM valid pfn?
>=20

Depends on how we think checks for reserved pages should be performed. I am m=
ore of a friend of indicating =E2=80=9Ethis memmap is just garbage, skip it=E2=
=80=9C. If the reserved flag is not good enough, then via a special node/zon=
e - as you also suggest below.

>> "correct" is problematic. If you have an actual memory hole, there is
>> not always a right answer - unless I am missing something important.
>>=20
>>=20
>> Assume you have a layout like this
>>=20
>> [  zone X ] [ hole ] [ zone Y ]
>>=20
>> If either X and or Y starts within a memory section, you have a valid
>> memmap for X - but what would be the right node/zone?
>>=20
>>=20
>> Assume you have a layout like this
>>=20
>> [ zone X ]
>>=20
>> whereby X ends inside a memory section. The you hotplug memory. Assume
>> it goes to X
>>=20
>> [ zone X ][ hole in X ][ zone X]
>>=20
>> or it goes to y
>>=20
>> [ zone X ][ hole ][ zone Y ]
>>=20
>> This can easily be reproduced by starting a VM in qemu with a memory
>> size not aligned to 128 MB (e.g., -M 4000) and hotplugging memory.
>=20
> I don't get what the problem is sorry.
>=20
> You have a pfn, if pfn_valid() is true, pfn_to_page returns a page
> deterministically.
>=20
> It's up to the kernel to decide which page structure blongs to any pfn
> in the pfn_to_page function.
>=20
> Now if the pfn_to_page(pfn) function returns a page whose nid/zone_id
> in page->flags points to a node->zone whose zone_start_pfn -
> end_zone_pfn range doesn't contain "pfn" that is a bug in
> page_alloc.c.
>=20
> I don't see how is it not possible to deterministically enforce the
> above never happens. Only then it would be true that there's not
> always a right answer.
>=20
> zone can overlap, but it can't be that you do pfn_to_page of a
> pfn_valid and you obtain a page whose zone doesn't contain that
> pfn. Which is what is currently crashing compaction.
>=20
> I don't see how this is an unsolvable problem and why we should accept
> to live with a bogus page->flags for reserved pages.
>=20

I said it=E2=80=98s problematic, not unsolvable. Using a special zone/node i=
s certainly easier - but might reveal some issues we have to fix - I guess? =
Fair enough.

>> We can't. The general rule is (as I was once told by Michal IIRC) that
>=20
> The fact we can't kernel crash reliably when somebody uses the wrong
> 0,0 uninitialized value by not adding an explicit PageReserved check,
> is my primary concern in keeping those nodeid/nid uninitialized, but
> non-kernel-crashing, since it already created this unreproducible bug.

Agreed.

>=20
>> I'm not rooting for "keep this at 0/0" - I'm saying that I think there
>> are corner cases where it might not be that easy.
>=20
> I'm not saying it's easy. What I don't see is how you don't always
> have the right answer and why it would be an unsolvable problem.

=E2=80=9EProblematic=E2=80=9C does not imply unsolvable.

>=20
> It is certainly problematic and difficult to solve in the mem_map
> iniitalization logic, but to me having pfn_valid() &&
> page_zone(pfn_to_page(pfn)) randomly returning the DMA zone on first
> node also looks problematic and difficult to handle across all VM
> code, so overall it looks preferable to keep the complexity of the
> mem_map initialization self contained and not spilling over the rest
> of the VM.
>=20
>> Yes, but there is a "Some of these" :)
>>=20
>> Boot a VM with "-M 4000" and observe the memmap in the last section -
>> they won't get initialized a second time.
>=20
> Is the beyond the end of the zone yet another case? I guess that's
> less likely to give us problems because it's beyond the end of the
> zone. Would pfn_valid return true for those pfn? If pfn_valid is not

Yes. Especially, exposed after memory hotplug when zone/nid span changes.

> true it's not really a concern but the again I'd rather prefer if
> those struct pages beyond the end of the zone were kernel crashing set
> to 0xff.
>=20
> In other words I just don't see why we should ever prefer to leave
> some pages at a graceful and erroneous nid 0 nodeid 0 that wouldn't
> easily induce a crash if used.

I agree.

>=20
>> AFAIK, the mem_map array might have multiple NIDs - and it's set when
>> initializing the zones.
>=20
> Well because there's no mem_map array with SPARSEMEM, but it's not
> conceptually too different than if there was one. Even with flatmem
> there could be multiple page struct for each pfn, the disambiguation
> has to be handled by pfn_to_page regardless of SPARSEMEM or not.
>=20
> The point is that if zone_page(pfn_to_page(pfn)) points to DMA zone of
> first node, and the pfn isn't part of the DMA of first node that looks
> a bug and it can be enforced it doesn't happen.
>=20
>> Well, "reserved" is not a good indication "what" something actually is.
>>=20
>> I documented that a while ago in include/linux/page-flags.h
>>=20
>> "PG_reserved is set for special pages. The "struct page" of such a page
>> should in general not be touched (e.g. set dirty) except by its owner.
>> Pages marked as PG_reserved include:."
>>=20
>> I suggest looking at that.
>>=20
>> AFAIR, we have been setting *most* memmap in memory holes/non-ram
>> reserved for a long time - long before I added the __init_single_page -
>> see init_reserved_page() for example.
>=20
> Sure, non-RAM with valid page struct always has been marked
> PG_reserved. I wasn't suggesting that it shouldn't be PG_reserved.
>=20
> I was pointing out that RAM can also be marked PG_reserved later by
> the kernel, long after boot, as you mentioned for all other cases of
> PG_reserved, the most notable are drivers doing PG_reserved after
> allocating RAM either vmalloc or GART swapping RAM around at other
> alias physical address.
>=20
> That is all born as RAM at boot, it gets page->flags done right, with
> the right zoneid, and it becomes PG_reserved later.
>=20
> So I was suggesting physical ranges "pfn" of non-RAM (be those holes
> withtin zones, or in between zones doesn't matter) with a pfn_valid
> returning true and a pfn_to_page pointing deterministically to one and
> only one struct page, should have such struct page initialized exactly
> the same as if it was RAM.
>=20
> Either that or we can define a new NO_ZONE NO_ID id and crash in
> page_zonenum or page_to_nid if it is ever called on such a page
> struct.

I feel like that is easier and maybe cleaner. Mark memmaps that exist but sh=
ould be completely ignored. Could even check that in pfn_valid() and return =E2=
=80=9Efalse=E2=80=9C - might be expensive, though.

Anyhow, I do agree that properly catching these problematic pages, bailing o=
ut and fixing them (however we decide) is the right approach.

>=20
> Thanks,
> Andrea


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E57A32C393B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 07:47:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgKYGpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 01:45:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:50658 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726027AbgKYGpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 01:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606286736;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iVCSOn9Ecl9ByqntSO1LxevMD501S8BngRpqhk4mtlE=;
        b=ILlm6bVmt3znhvV/ewBQK8MWIhTTI8RQPkxKCeGtSEuYHLbflStMSUnTSSO5pDvbe9shBN
        qCY/XxB1jVpAFpclYWBH2j9+B+WhX/M53d/FPi5Uxc3GFDHkN0aPExbWXswnBFIsth+3kU
        8YXqEmEjVmYkX3To1zHXxdRsJHI/0Pc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-142-wm7svUUbNzKJFxGoRMxsAg-1; Wed, 25 Nov 2020 01:45:34 -0500
X-MC-Unique: wm7svUUbNzKJFxGoRMxsAg-1
Received: by mail-ej1-f71.google.com with SMTP id k2so480506eji.21
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 22:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=iVCSOn9Ecl9ByqntSO1LxevMD501S8BngRpqhk4mtlE=;
        b=IGsOzl44TnI8xfJDMV3tI9LzMyg+qi+ekci0h66jfkl4wkf1Ysw9U8BLe4zRB+Xxsz
         IjQY9Q+5HAv0AYw9HaaB0YP6ByE6iSuZ3sjA//BTP5i5PDuQLwRMxuN1bjjozUHrT9ZH
         SFFVIRDy2p/BciRfFgGVgddmcShEqKzNJ/6UMLSKPvXV/HYhuZkajmWEbq6E/88WbGhv
         R6buE9+RMoVtDzgGa34tYpY0ByWUV//JWHbRrYe8FW2YTneXGJc4OtsYO8arkhhO6vuz
         rnExy04WIOPpE9quorULEo/Wu83fUP9kjPYLSFqh5L8ip2kUuOJDz4Ptk1HrlhtZz++6
         MqFw==
X-Gm-Message-State: AOAM532+a7tNdxkSS1u8bJF2CpItdNjpQB5g7B3oIhXzCp6/g5GRvd06
        ylXAKFp+XGGSOjUVjSQ2tutbSjHL9m246dLzeF3SgTNNBEi7cgWiF6+qq2VL4jZOPDIo4WmK8eS
        pL3J/G8jfPf9MHDG4Na+PXth+
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr1811568ejb.513.1606286732915;
        Tue, 24 Nov 2020 22:45:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJztRhCRZTfAdp0SJUgVXKaCtygJKHQ4lau8ilIWjhYyPk46+ij001cyDUGY1Cf4LMafRvABwA==
X-Received: by 2002:a17:906:cc84:: with SMTP id oq4mr1811561ejb.513.1606286732683;
        Tue, 24 Nov 2020 22:45:32 -0800 (PST)
Received: from [192.168.3.114] (p5b0c686a.dip0.t-ipconnect.de. [91.12.104.106])
        by smtp.gmail.com with ESMTPSA id e10sm619438eds.8.2020.11.24.22.45.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2020 22:45:32 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 1/1] mm: compaction: avoid fast_isolate_around() to set pageblock_skip on reserved pages
Date:   Wed, 25 Nov 2020 07:45:30 +0100
Message-Id: <35F8AADA-6CAA-4BD6-A4CF-6F29B3F402A4@redhat.com>
References: <X73s8fxDKPRD6wET@redhat.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Qian Cai <cai@lca.pw>, Michal Hocko <mhocko@kernel.org>,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>
In-Reply-To: <X73s8fxDKPRD6wET@redhat.com>
To:     Andrea Arcangeli <aarcange@redhat.com>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 25.11.2020 um 06:34 schrieb Andrea Arcangeli <aarcange@redhat.com>:
>=20
> =EF=BB=BFHello,
>=20
>> On Mon, Nov 23, 2020 at 02:01:16PM +0100, Vlastimil Babka wrote:
>>> On 11/21/20 8:45 PM, Andrea Arcangeli wrote:
>>> A corollary issue was fixed in
>>> 39639000-39814fff : Unknown E820 type
>>>=20
>>> pfn 0x7a200 -> 0x7a200000 min_pfn hit non-RAM:
>>>=20
>>> 7a17b000-7a216fff : Unknown E820 type
>>=20
>> It would be nice to also provide a /proc/zoneinfo and how exactly the=20
>> "zone_spans_pfn" was violated. I assume we end up below zone's=20
>> start_pfn, but is it true?
>=20
> Agreed, I was about to grab that info along with all page struct
> around the pfn 0x7a200 and phys address 0x7a216fff.
>=20
> # grep -A1 E820 /proc/iomem
> 7a17b000-7a216fff : Unknown E820 type
> 7a217000-7bffffff : System RAM
>=20
> DMA      zone_start_pfn 1            zone_end_pfn() 4096         contiguou=
s 1    =20
> DMA32    zone_start_pfn 4096         zone_end_pfn() 1048576      contiguou=
s 0    =20
> Normal   zone_start_pfn 1048576      zone_end_pfn() 4715392      contiguou=
s 1    =20
> Movable  zone_start_pfn 0            zone_end_pfn() 0            contiguou=
s 0    =20
>=20
> 500222 0x7a1fe000 0x1fff000000001000 reserved True
> 500223 0x7a1ff000 0x1fff000000001000 reserved True
>=20
> # I suspect "highest pfn" was somewhere in the RAM range
> # 0x7a217000-0x7a400000 and the pageblock_start_pfn(pfn)
> # made highest point to pfn 0x7a200 physaddr 0x7a200000
> # below, which is reserved indeed since it's non-RAM
> # first number is pfn hex(500224) =3D=3D 0x7a200
>=20
> pfn    physaddr   page->flags
> 500224 0x7a200000 0x1fff000000001000 reserved True
> 500225 0x7a201000 0x1fff000000001000 reserved True
> *snip*
> 500245 0x7a215000 0x1fff000000001000 reserved True
> 500246 0x7a216000 0x1fff000000001000 reserved True
> 500247 0x7a217000 0x3fff000000000000 reserved False
> 500248 0x7a218000 0x3fff000000000000 reserved False
>=20
> All RAM pages non-reserved are starting at 0x7a217000 as expected.
>=20
> The non-RAM page_zonenum(pfn_to_page(0x7a200)) points to ZONE_DMA and=20
> page_zone(page) below was the DMA zone despite the pfn of 0x7a200 is
> in DMA32.
>=20
>    VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
>=20
> So the patch I sent earlier should prevent the above BUG_ON by not
> setting highest to 0x7a200 when pfn is in the phys RAM range
> 0x7a217000-0x7a400000, because pageblock_pfn_to_page will notice that
> the zone is the wrong one.
>=20
>    if (page_zone(start_page) !=3D zone)
>        return NULL;
>=20
> However the real bug seems that reserved pages have a zero zone_id in
> the page->flags when it should have the real zone id/nid. The patch I
> sent earlier to validate highest would only be needed to deal with
> pfn_valid.
>=20
> Something must have changed more recently than v5.1 that caused the
> zoneid of reserved pages to be wrong, a possible candidate for the
> real would be this change below:
>=20
> +               __init_single_page(pfn_to_page(pfn), pfn, 0, 0);
>=20

Before that change, the memmap of memory holes were only zeroed out. So the z=
ones/nid was 0, however, pages were not reserved and had a refcount of zero -=
 resulting in other issues.

Most pfn walkers shouldn=E2=80=98t mess with reserved pages and simply skip t=
hem. That would be the right fix here.

> Even if it may not be it, at the light of how the reserved page
> zoneid/nid initialized went wrong, the above line like it's too flakey
> to stay.
>=20
> It'd be preferable if the pfn_valid fails and the
> pfn_to_section_nr(pfn) returns an invalid section for the intermediate
> step. Even better memset 0xff over the whole page struct until the
> second stage comes around.

I recently discussed with Baoquan to
1. Using a new pagetype to mark memory holes
2. Using special nid/zid to mark memory holes

Setting the memmap to 0xff would be even more dangerous - pfn_zone() might s=
imply BUG_ON.

>=20
> Whenever pfn_valid is true, it's better that the zoneid/nid is correct
> all times, otherwise if the second stage fails we end up in a bug with
> weird side effects.

Memory holes with a valid memmap might not have a zone/nid. For now, skippin=
g reserved pages should be good enough, no?

>=20
> Maybe it's not the above that left a zero zoneid though, I haven't
> tried to bisect it yet to look how the page->flags looked like on a
> older kernel that didn't seem to reproduce this crash, I'm just
> guessing.
>=20
> Thanks,
> Andrea


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E42D85EE
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 11:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438766AbgLLKib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Dec 2020 05:38:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33358 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438758AbgLLKib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Dec 2020 05:38:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607769424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GsbWo8MzI5/BHYS/EaqKM/Ulw99yLlb1bIOuQBeR1lk=;
        b=D1Am+EVCzQF2nsMyzfwtTHf/xScL7+IQA6tg3qApDQQN8thTPG/m/MTVPPsmh3YJlD+eRp
        ED3qgflv3x3v8+mMj+lM6jD/gd26Q8IxNkWZho4EJVpCHx6bmDK89/fKlKcwCTTDGmH6/M
        FJ0eZyJYtuAmGvp0Oh1CANozgPP+Gio=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-lWcNj3zSPj2W3THsunYEGw-1; Sat, 12 Dec 2020 02:29:14 -0500
X-MC-Unique: lWcNj3zSPj2W3THsunYEGw-1
Received: by mail-ed1-f70.google.com with SMTP id bf13so5072939edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 23:29:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=GsbWo8MzI5/BHYS/EaqKM/Ulw99yLlb1bIOuQBeR1lk=;
        b=JXT2K/p+kneP4GLNPEIOQ6uGW8NhMZAp0lprN/Qe9LgM5l2M1snvOQLQPwgwvl5UEx
         5L4HJCeoELNDvxbI/8JbaJkNCc4iUF4eQoGmqoMFSzLzO+AtzQ+wxHbjbsqyUhdxyX/a
         8pmTKri10T1aoN6mgtYwFsGYt//wDDELFJ//PgMTGM8icKF7SUqSY6V4stSnxbUFxovM
         /7SxnYjgIzJGeVnq3BjJEwmgDLA+PloUbpuoJBEokxzUpd+lD+CKscpgQbIfluU3OihW
         jS0z0uEtr6oGdLhtKg7TAS9bOXaVOdnmM5h9T8q4sHHzEj6xdbq7/nGFymqaxey5CvM1
         0x1A==
X-Gm-Message-State: AOAM531D9Sic1lYV/A1MJkHvZT9mJ7ZDPu8cxUqwKOEa1WF35V+FJimE
        SVlh/FMJzHq4DuK5yc1VYPCkQq5bbWz28qa1wDHzLNejkhhDFXMCKVfZdaiI9GmQLpnyUsG7eZ/
        awrTNMN0C8jEp2kYeT8fYe2tk
X-Received: by 2002:a50:e78b:: with SMTP id b11mr15358820edn.165.1607758153444;
        Fri, 11 Dec 2020 23:29:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRL2Y1wyHXCG127r7zUT1/Oc/JcsKsqWphtjYAyN0whGHFHSKjen6fYKNLk/25u0gYQBpDQA==
X-Received: by 2002:a50:e78b:: with SMTP id b11mr15358792edn.165.1607758153223;
        Fri, 11 Dec 2020 23:29:13 -0800 (PST)
Received: from [192.168.3.114] (p4ff23bda.dip0.t-ipconnect.de. [79.242.59.218])
        by smtp.gmail.com with ESMTPSA id k21sm8459922ejv.80.2020.12.11.23.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Dec 2020 23:29:12 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 5/6] mm/gup: migrate pinned pages out of movable zone
Date:   Sat, 12 Dec 2020 08:29:11 +0100
Message-Id: <2D10D596-3159-483C-81B4-CD187806ED46@redhat.com>
References: <20201211235005.GE5487@ziepe.ca>
Cc:     David Hildenbrand <david@redhat.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
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
In-Reply-To: <20201211235005.GE5487@ziepe.ca>
To:     Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: iPhone Mail (18B92)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 12.12.2020 um 00:50 schrieb Jason Gunthorpe <jgg@ziepe.ca>:
>=20
> =EF=BB=BFOn Fri, Dec 11, 2020 at 10:53:00PM +0100, David Hildenbrand wrote=
:
>=20
>>> When check_and_migrate_movable_pages() is called, the pages are
>>> already pinned. If some of those pages are in movable zone, and we
>>> fail to migrate or isolate them what should we do: proceed, and
>>> keep it as exception of when movable zone can actually have pinned
>>> pages or unpin all pages in the array, and return an error, or
>>> unpin only pages in movable zone, and return an error?
>>=20
>> I guess revert what we did (unpin) and return an error. The
>> interesting question is what can make migration/isolation fail
>>=20
>> a) out of memory: smells like a zone setup issue. Failures are acceptable=
 I guess.
>=20
> Out of memory is reasonable..
>=20
>> b) short term pinnings: process dying - not relevant I guess. Other cases=
? (Fork?)
>=20
> Concurrent with non-longterm GUP users are less reasonable, fork is
> not reasonable, etc..

Concurrent alloc_contig_range(), memory offlining, compaction .. where we mi=
grate pages? Any experts on racing page migration in these scenarios?

(Also wondering what would happen if we are just about to swap)

>=20
> Racing with another GUP in another thread is also not reasonable, so
> failing to isolate can't be a failure

Having VMs with multiple vfio containers is certainly realistic, and optimiz=
ing in user space to do vfio mappings concurrently doesn=E2=80=98t sound too=
 crazy to me. But I haven=E2=80=98t checked if vfio common code already hand=
les such concurrency.

>=20
> Jasnon
>=20


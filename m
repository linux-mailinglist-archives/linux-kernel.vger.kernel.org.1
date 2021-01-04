Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF62E9EC0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 21:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbhADUTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 15:19:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52553 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726026AbhADUTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 15:19:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609791498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sL80W/bpndKTkJr6XATsXD1MBTH0F9B9dG84CxK2Xe0=;
        b=YlkYByt8RyJagDrSLhhiQRLUELAXMFA+64XtY1CUKWqgRTNZ9OouVy1nRk/MQqMOiXCBDr
        1QBd5cvMhEZYjox8De6nMKC/oKUNODle13RktwCQ5uTNKWeKYtY0G1x2xKS4ATSxRYItv7
        sKyTpbwU+szXY4n0DPo8acR7bI0KV/s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-1r42OV8zMc6kQgrEk91VAg-1; Mon, 04 Jan 2021 15:18:16 -0500
X-MC-Unique: 1r42OV8zMc6kQgrEk91VAg-1
Received: by mail-wr1-f72.google.com with SMTP id w5so13629380wrl.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 12:18:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=sL80W/bpndKTkJr6XATsXD1MBTH0F9B9dG84CxK2Xe0=;
        b=E0bIHWHMt2a6cOOc/q+d0EW7nsYSaRzYMbWp+at7dtIhVF98aQuDk0yd/z9FHwJnNm
         KnIzU6vu9AOxHqLS5VJAdRRLf4fpppjqApq5GazPIX7uW1RGUbfMZ69Khdrg5Y/jlQhw
         QFVDMe9/E3ggYCVWe5pycr3liXVySR72npfigt9LynDBs0VHhfqe4tQtNKReeqxQKV8q
         fSU2q85DoobpmZZumZR18Pk+YIBbAR5d8OyIKFX5RxbP8A6Ag1MLZA7nc4frYzvZAwym
         hRkYMTXNnKUujffxfeFNB3h1/GKzgms3Ma5B9srcUycb1xQtGViGFzEOawm+HufnPuCH
         3jEg==
X-Gm-Message-State: AOAM532Mx4uH7/YA6bfYpYMmTRQb0O3RYJWjUMKCNqn+95pFzR2BMlxZ
        I36lq6pdfugyDDs3AQkuE3oo/HtgxMTn2vJ7/l5UOBQR4kh1IqD8izG6dGDX0tRzjaLPCJDzEGS
        ARzKi2lWQx7WzeRp5tCTfLgo3
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr54719775wrr.319.1609791495697;
        Mon, 04 Jan 2021 12:18:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwx4gy5JFxjZnXjZPAl6stC7zCwsld9QLtkKU+syXPFvA2bF6Ji0oL2rXc4WQQ0vvJ9VuptQQ==
X-Received: by 2002:a5d:43cc:: with SMTP id v12mr54719760wrr.319.1609791495539;
        Mon, 04 Jan 2021 12:18:15 -0800 (PST)
Received: from [192.168.3.108] (p5b0c69d7.dip0.t-ipconnect.de. [91.12.105.215])
        by smtp.gmail.com with ESMTPSA id h9sm845757wme.11.2021.01.04.12.18.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jan 2021 12:18:15 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
Date:   Mon, 4 Jan 2021 21:18:14 +0100
Message-Id: <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
Cc:     David Hildenbrand <david@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Liang Li <liliangleo@didiglobal.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
In-Reply-To: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
To:     Liang Li <liliang324@gmail.com>
X-Mailer: iPhone Mail (18C66)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 23.12.2020 um 13:12 schrieb Liang Li <liliang324@gmail.com>:
>=20
> =EF=BB=BFOn Wed, Dec 23, 2020 at 4:41 PM David Hildenbrand <david@redhat.c=
om> wrote:
>>=20
>> [...]
>>=20
>>>> I was rather saying that for security it's of little use IMHO.
>>>> Application/VM start up time might be improved by using huge pages (and=

>>>> pre-zeroing these). Free page reporting might be improved by using
>>>> MADV_FREE instead of MADV_DONTNEED in the hypervisor.
>>>>=20
>>>>> this feature, above all of them, which one is likely to become the
>>>>> most strong one?  =46rom the implementation, you will find it is
>>>>> configurable, users don't want to use it can turn it off.  This is not=

>>>>> an option?
>>>>=20
>>>> Well, we have to maintain the feature and sacrifice a page flag. For
>>>> example, do we expect someone explicitly enabling the feature just to
>>>> speed up startup time of an app that consumes a lot of memory? I highly=

>>>> doubt it.
>>>=20
>>> In our production environment, there are three main applications have su=
ch
>>> requirement, one is QEMU [creating a VM with SR-IOV passthrough device],=

>>> anther other two are DPDK related applications, DPDK OVS and SPDK vhost,=

>>> for best performance, they populate memory when starting up. For SPDK vh=
ost,
>>> we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
>>> vhost 'live' upgrade, which is done by killing the old process and
>>> starting a new
>>> one with the new binary. In this case, we want the new process started a=
s quick
>>> as possible to shorten the service downtime. We really enable this featu=
re
>>> to speed up startup time for them  :)

Am I wrong or does using hugeltbfs/tmpfs ... i.e., a file not-deleted betwee=
n shutting down the old instances and firing up the new instance just solve t=
his issue?

>>=20
>> Thanks for info on the use case!
>>=20
>> All of these use cases either already use, or could use, huge pages
>> IMHO. It's not your ordinary proprietary gaming app :) This is where
>> pre-zeroing of huge pages could already help.
>=20
> You are welcome.  For some historical reason, some of our services are
> not using hugetlbfs, that is why I didn't start with hugetlbfs.
>=20
>> Just wondering, wouldn't it be possible to use tmpfs/hugetlbfs ...
>> creating a file and pre-zeroing it from another process, or am I missing
>> something important? At least for QEMU this should work AFAIK, where you
>> can just pass the file to be use using memory-backend-file.
>>=20
> If using another process to create a file, we can offload the overhead to
> another process, and there is no need to pre-zeroing it's content, just
> populating the memory is enough.

Right, if non-zero memory can be tolerated (e.g., for vms usually has to).

> If we do it that way, then how to determine the size of the file? it depen=
ds
> on the RAM size of the VM the customer buys.
> Maybe we can create a file
> large enough in advance and truncate it to the right size just before the
> VM is created. Then, how many large files should be created on a host?

That=E2=80=98s mostly already existing scheduling logic, no? (How many vms c=
an I put onto a specific machine eventually)

> You will find there are a lot of things that have to be handled properly.
> I think it's possible to make it work well, but we will transfer the
> management complexity to up layer components. It's a bad practice to let
> upper layer components process such low level details which should be
> handled in the OS layer.

It=E2=80=98s bad practice to squeeze things into the kernel that can just be=
 handled on upper layers ;)=


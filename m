Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D885B2EA885
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbhAEKW6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:22:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727768AbhAEKW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:22:57 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35830C061793
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 02:22:17 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id y19so71173290lfa.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 02:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5kKMEMOodY6kGWS9Y6O4QuS2Jo/OUIx2VF4zkaRwF7U=;
        b=ZqSdvv3lE8DyMK9cHX0L0iq0Wmq5P/xIlRNh7tHkh3VxljPNtgbX24RLEwulmUbej6
         dPrwUXdP44Ddkyc2JdWPMcRNXsy52EKz6n6S0mpZrNhAepsxOefAv5nQPKe8jlcdS3LL
         clswXiXzw47LhMECuEeNcw9Sc5ezTWXLgPR1AnmPoUrSK8nVauxMetpnuh16NRVr0CLp
         O/7YXSm1Rgt6tEazbVx9YORA6+eCAozpMeBSl/uftK1vr7h7Qo8wr2j3PziIfDIc9yEe
         YMLzrxRUmdjU4LevoafRSFzJD7CHeYpiApveXTR2JXTIXKH7k2MAuKQxgQIITF2hB6Ok
         G1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5kKMEMOodY6kGWS9Y6O4QuS2Jo/OUIx2VF4zkaRwF7U=;
        b=eoBtcR0HwVnLnEIqxPGhd8PFfxcT0RVH+ZKlsZw7o2knUn4aFm9UeN0FQ+or2c8sN5
         jeLFXYdTxgdOWFRTeAqyi5X94E+0gUNmfXiZuMKKdc5RNinHG1zuRdLJQSaX64d2zEf7
         xONXU4IDXNbUZ5f7B//rNpCb9MiFtdx/0X75Zb9EAO45FmobuVIZsYhKssiqXAWFBkco
         Kp28mFKcJZwfJ1WlAzRjQ1wlBUdbNGG5QjkpfWA+K3vvapADFGRA1AOqWcG8rzlksJ0S
         3eeDxOFVAXyIW+aCYJcY7a1EgIOR366BolDqnKb9uJ7SgC+Y4N2/WwMa/GaO2kBRUrrC
         2lSg==
X-Gm-Message-State: AOAM530KyqyJ2vXM+dIBzB9NHQo4ye6/2KNSPbqGxbO91A6p2WHUkedj
        twH04x2iS39OCXMKqbzcExhx0pHnFzh7uEyBA9M=
X-Google-Smtp-Source: ABdhPJzhAICElpCxt0p7fOjh2nlvJdOICyX5VQS3X21zKBfAKZBd916qPWUU1I7BFQmC/BVhFafClLc6oDwR70zNaIE=
X-Received: by 2002:a2e:96da:: with SMTP id d26mr35613030ljj.233.1609842135783;
 Tue, 05 Jan 2021 02:22:15 -0800 (PST)
MIME-Version: 1.0
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
 <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com> <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
 <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
In-Reply-To: <eea984f8-dbff-35d3-2c93-db8dc4b700c5@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 5 Jan 2021 18:22:03 +0800
Message-ID: <CA+2MQi9Qb5srEcx4qKNVWdphBGP0=HHV_h0hWghDMFKFmCOTMg@mail.gmail.com>
Subject: Re: [RFC v2 PATCH 0/4] speed up page allocation for __GFP_ZERO
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
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> >> That=E2=80=98s mostly already existing scheduling logic, no? (How many=
 vms can I put onto a specific machine eventually)
> >
> > It depends on how the scheduling component is designed. Yes, you can pu=
t
> > 10 VMs with 4C8G(4CPU, 8G RAM) on a host and 20 VMs with 2C4G on
> > another one. But if one type of them, e.g. 4C8G are sold out, customers
> > can't by more 4C8G VM while there are some free 2C4G VMs, the resource
> > reserved for them can be provided as 4C8G VMs
> >
>
> 1. You can, just the startup time will be a little slower? E.g., grow
> pre-allocated 4G file to 8G.
>
> 2. Or let's be creative: teach QEMU to construct a single
> RAMBlock/MemoryRegion out of multiple tmpfs files. Works as long as you
> don't go crazy on different VM sizes / size differences.
>
> 3. In your example above, you can dynamically rebalance as VMs are
> getting sold, to make sure you always have "big ones" lying around you
> can shrink on demand.
>
Yes, we can always come up with some ways to make things work.
it will make the developer of the upper layer component crazy :)

> >
> > You must know there are a lot of functions in the kernel which can
> > be done in userspace. e.g. Some of the device emulations like APIC,
> > vhost-net backend which has userspace implementation.   :)
> > Bad or not depends on the benefits the solution brings.
> > From the viewpoint of a user space application, the kernel should
> > provide high performance memory management service. That's why
> > I think it should be done in the kernel.
>
> As I expressed a couple of times already, I don't see why using
> hugetlbfs and implementing some sort of pre-zeroing there isn't sufficien=
t.

Did I miss something before? I thought you doubt the need for
hugetlbfs free page pre zero out. Hugetlbfs is a good choice and is
sufficient.

> We really don't *want* complicated things deep down in the mm core if
> there are reasonable alternatives.
>
I understand your concern, we should have sufficient reason to add a new
feature to the kernel. And for this one, it's most value is to make the
application's life is easier. And implementing it in hugetlbfs can avoid
adding more complexity to core MM.
I will send out a new revision and drop the part for 'buddy free pages pre
zero out'. Thanks for your suggestion!

Liang

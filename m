Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30E92EA341
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 03:17:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbhAECPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 21:15:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726163AbhAECPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 21:15:05 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E1CC061574
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jan 2021 18:14:25 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m25so69085629lfc.11
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jan 2021 18:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+xkQA9ZfR+79pp7Ulpm2NqZg2cDfkuU5Tk9TMW07Q/c=;
        b=L02eXfE4Jc7oT66d67QzqNj/RmpYwVhrjr6MB+Bxl5Ykw4KP9mwhqSGYxpwlcc6LPs
         /Md0OgTPowORc0tIgihkmp0cXgGl9FvYHClrCFudQ8cyUrZSEJxkcL8ELJvjSH1xbATH
         KvkVysRYh8uqCD5cS8vF6XjqittzzuOLQZrlBv4hY9DoEocTzzujuj+BjINCo8aEd0pT
         wasEfnStSTW9gkOyZY6cnDUD2vZTR/u58YzFvicQEN6mQ1xo8HKpWdk7H8+fZLTH+JL8
         eUbQPVsYeCCvHaQv+Zulne+dKgbRIqyT/koWDTHdmPkb2+/i62ZNAgdwjE4Pgjrnd660
         djGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+xkQA9ZfR+79pp7Ulpm2NqZg2cDfkuU5Tk9TMW07Q/c=;
        b=l3DMcwMJp4upJDX8BfJ3dGR0P3nDIq12NoZWLRiVkI/9Q5LEthPMn9FWsO/lFyrTNo
         z24iY/mEP3Vp4WxVK3jod7JsCLPMYl+tDVSpl9Djh7aNxYJ8Ig9PVPiZ918gXe9Fa5/f
         tFn7V0GhRuecQyd+HcEmP9KneQlxHkd9r0p/cU5ND6Kra2Zfigb889aszyZ9Ila5Qn4/
         ekP+LEIs1AmWDuV8xBJMypCbh5VqKPOrsIK0PawRflbA5RLIGaWE0JVCwdh36pr8Wyo9
         GVKRc7SwPJ6XKvf4OluX6j7/wfD/K9ZrWUoz+zxevq1HtEOUgmuqf4uQ9BPJxlWoDuFX
         GyTQ==
X-Gm-Message-State: AOAM531FIvR0+2cl2DSyaGAPmmp0UP8JmQsq3pXlLiAs6INlV6Dzg/sn
        V11AhM8aeRPepVbQOIOStX/TATxe7yJBc/dZg44=
X-Google-Smtp-Source: ABdhPJwS3i/LxCg32Rg+Qmv2lZZlfQUOdQkbfxLjoknBZAOR5Pc+gPjgDoCy+vUunI60PAIj6qPcLcr8EEpmDgxaH7w=
X-Received: by 2002:a19:804a:: with SMTP id b71mr31198406lfd.504.1609812863497;
 Mon, 04 Jan 2021 18:14:23 -0800 (PST)
MIME-Version: 1.0
References: <CA+2MQi_C-PTqyrqBprhtGBAiDBnPQBzwu6hvyuk+QiKy0L3sHw@mail.gmail.com>
 <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
In-Reply-To: <96BB0656-F234-4634-853E-E2A747B6ECDB@redhat.com>
From:   Liang Li <liliang324@gmail.com>
Date:   Tue, 5 Jan 2021 10:14:11 +0800
Message-ID: <CA+2MQi_O47B8zOa_TwZqzRsS0LFoPS77+61mUV=yT1U3sa6xQw@mail.gmail.com>
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

> >>> In our production environment, there are three main applications have=
 such
> >>> requirement, one is QEMU [creating a VM with SR-IOV passthrough devic=
e],
> >>> anther other two are DPDK related applications, DPDK OVS and SPDK vho=
st,
> >>> for best performance, they populate memory when starting up. For SPDK=
 vhost,
> >>> we make use of the VHOST_USER_GET/SET_INFLIGHT_FD feature for
> >>> vhost 'live' upgrade, which is done by killing the old process and
> >>> starting a new
> >>> one with the new binary. In this case, we want the new process starte=
d as quick
> >>> as possible to shorten the service downtime. We really enable this fe=
ature
> >>> to speed up startup time for them  :)
>
> Am I wrong or does using hugeltbfs/tmpfs ... i.e., a file not-deleted bet=
ween shutting down the old instances and firing up the new instance just so=
lve this issue?

You are right, it works for the SPDK vhost upgrade case.

>
> >>
> >> Thanks for info on the use case!
> >>
> >> All of these use cases either already use, or could use, huge pages
> >> IMHO. It's not your ordinary proprietary gaming app :) This is where
> >> pre-zeroing of huge pages could already help.
> >
> > You are welcome.  For some historical reason, some of our services are
> > not using hugetlbfs, that is why I didn't start with hugetlbfs.
> >
> >> Just wondering, wouldn't it be possible to use tmpfs/hugetlbfs ...
> >> creating a file and pre-zeroing it from another process, or am I missi=
ng
> >> something important? At least for QEMU this should work AFAIK, where y=
ou
> >> can just pass the file to be use using memory-backend-file.
> >>
> > If using another process to create a file, we can offload the overhead =
to
> > another process, and there is no need to pre-zeroing it's content, just
> > populating the memory is enough.
>
> Right, if non-zero memory can be tolerated (e.g., for vms usually has to)=
.

I mean there is no need to pre-zeroing the file content obviously in user s=
pace,
the kernel will do it when populating the memory.

> > If we do it that way, then how to determine the size of the file? it de=
pends
> > on the RAM size of the VM the customer buys.
> > Maybe we can create a file
> > large enough in advance and truncate it to the right size just before t=
he
> > VM is created. Then, how many large files should be created on a host?
>
> That=E2=80=98s mostly already existing scheduling logic, no? (How many vm=
s can I put onto a specific machine eventually)

It depends on how the scheduling component is designed. Yes, you can put
10 VMs with 4C8G(4CPU, 8G RAM) on a host and 20 VMs with 2C4G on
another one. But if one type of them, e.g. 4C8G are sold out, customers
can't by more 4C8G VM while there are some free 2C4G VMs, the resource
reserved for them can be provided as 4C8G VMs

> > You will find there are a lot of things that have to be handled properl=
y.
> > I think it's possible to make it work well, but we will transfer the
> > management complexity to up layer components. It's a bad practice to le=
t
> > upper layer components process such low level details which should be
> > handled in the OS layer.
>
> It=E2=80=98s bad practice to squeeze things into the kernel that can just=
 be handled on upper layers ;)
>

You must know there are a lot of functions in the kernel which can
be done in userspace. e.g. Some of the device emulations like APIC,
vhost-net backend which has userspace implementation.   :)
Bad or not depends on the benefits the solution brings.
From the viewpoint of a user space application, the kernel should
provide high performance memory management service. That's why
I think it should be done in the kernel.

Thanks
Liang

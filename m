Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70086283DA7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 19:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgJERm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 13:42:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43640 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725973AbgJERm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 13:42:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601919744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTv8qVn50BVMe41mnHOhz5zFgfNAnMlsJzHtN4tUUYY=;
        b=bcrPOG5WzxlRbADGHmq3n7/I3sPoquZde/Zzy49TBoknUVzSSwVcLbuodKJKGU4IcairOE
        gRdMjICMonAVMPzeCQZcV09KiDueo64vaDvvFuMbC2WN+/y6JciB8q88q1yZK3IE7qzuDR
        EyLdN1K0VHn8PWvbul42RZ1ng8QG8tU=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-9bxhHGEaPuOkDzEb8xMGlA-1; Mon, 05 Oct 2020 13:42:23 -0400
X-MC-Unique: 9bxhHGEaPuOkDzEb8xMGlA-1
Received: by mail-oi1-f200.google.com with SMTP id z25so2000517oih.23
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 10:42:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lTv8qVn50BVMe41mnHOhz5zFgfNAnMlsJzHtN4tUUYY=;
        b=ukn8QdsLuSpkwyInDvsmqYQ49tQEAG8U8BGhcyX6TEZloQPZ4WRXWtyOXcBojELE1Y
         Qp6gsdaSgFK73ZjrzvW2mm/BpWd+WpZZ5EDfVr88l1/StqKLBC1OGkhdEOT/eOUi77Pi
         ypfp1MIef6y8+CMGT22oJaO3a3wKken5p34XzbwF/919pavMXBGmjIbYaYFGN9dXgp/j
         CzQ/yUbo6btvDNrVpHNTB3n9Qj6Z2QSLkozvHs3oPUSerIVhKuSEeX3TA5RJEESNjfbX
         8TU8hpr2m7Y8TCZ+YDA/ucD/S7MSWTxez5ODEUitaWq+sDssqhVLoHyLZFU6A3NW559R
         GrKQ==
X-Gm-Message-State: AOAM533g1IkSgz5dNIkCF2w52a5YoJlwgIVQfmW8seLVhmEH5EqpHstO
        dVtJKtNZuXDv86UrIyWdaSwcNXc+uvs7DozEiXWnNIO/s0Lvz+vRMkdGdjXwIBkh3jwpAGsWCXZ
        UNQT7YR01KAt2PlP9heET1nVRv1gdJ/fCzIW2JjvK
X-Received: by 2002:a9d:a24:: with SMTP id 33mr255765otg.305.1601919741907;
        Mon, 05 Oct 2020 10:42:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyUwdJyVHIEtrpCyi9x3L1lyrhCd75vZ9+/aBnXjciOlpkIe+CX5Y4ESH+Vq6Rhy3CxhWne8HCSfmc8OJPjzQc=
X-Received: by 2002:a9d:a24:: with SMTP id 33mr255732otg.305.1601919741596;
 Mon, 05 Oct 2020 10:42:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200907134745.25732-1-chenzhou10@huawei.com> <e9b1b5db-a848-468e-6baf-2f7b4d658805@oracle.com>
 <20201005170937.GA14576@gaia>
In-Reply-To: <20201005170937.GA14576@gaia>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Mon, 5 Oct 2020 23:12:10 +0530
Message-ID: <CACi5LpMWUmP1df8fB8psJY_cNGHF9MNn+TNK4B4edaRHvOXxGQ@mail.gmail.com>
Subject: Re: [PATCH v12 0/9] support reserving crashkernel above 4G on arm64 kdump
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        Chen Zhou <chenzhou10@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        RuiRui Yang <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Prabhakar Kushwaha <prabhakar.pkin@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, nsaenzjulienne@suse.de,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        guohanjun@huawei.com, xiexiuqi@huawei.com, huawei.libin@huawei.com,
        wangkefeng.wang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin, Chen,

On Mon, Oct 5, 2020 at 10:39 PM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Sat, Sep 12, 2020 at 06:44:29AM -0500, John Donnelly wrote:
> > On 9/7/20 8:47 AM, Chen Zhou wrote:
> > > Chen Zhou (9):
> > >    x86: kdump: move CRASH_ALIGN to 2M
> > >    x86: kdump: make the lower bound of crash kernel reservation
> > >      consistent
> > >    x86: kdump: use macro CRASH_ADDR_LOW_MAX in functions
> > >      reserve_crashkernel[_low]()
> > >    x86: kdump: move reserve_crashkernel[_low]() into crash_core.c
> > >    arm64: kdump: introduce some macroes for crash kernel reservation
> > >    arm64: kdump: reimplement crashkernel=X
> > >    kdump: add threshold for the required memory
> > >    arm64: kdump: add memory for devices by DT property
> > >      linux,usable-memory-range
> > >    kdump: update Documentation about crashkernel
> [...]
> > I did a brief unit-test on 5.9-rc4.
> >
> > Please add:
> >
> > Tested-by:  John Donnelly <John.p.donnelly@oracle.com>
>
> Thanks for testing.
>
> > This activity is over a year old. It needs accepted.
>
> It's getting there, hopefully in 5.11. There are some minor tweaks to
> address.

I think my earlier email with the test results on this series bounced
off the mailing list server (for some weird reason), but I still see
several issues with this patchset. I will add specific issues in the
review comments for each patch again, but overall, with a crashkernel
size of say 786M, I see the following issue:

# cat /proc/cmdline
BOOT_IMAGE=(hd7,gpt2)/vmlinuz-5.9.0-rc7+ root=<..snip..>
rd.lvm.lv=<..snip..> crashkernel=786M

I see two regions of size 786M and 256M reserved in low and high
regions respectively, So we reserve a total of 1042M of memory, which
is an incorrect behaviour:

# dmesg | grep -i crash
[    0.000000] Reserving 256MB of low memory at 2816MB for crashkernel
(System low RAM: 768MB)
[    0.000000] Reserving 786MB of memory at 654158MB for crashkernel
(System RAM: 130816MB)
[    0.000000] Kernel command line:
BOOT_IMAGE=(hd2,gpt2)/vmlinuz-5.9.0-rc7+
root=/dev/mapper/rhel_ampere--hr330a--03-root ro
rd.lvm.lv=rhel_ampere-hr330a-03/root
rd.lvm.lv=rhel_ampere-hr330a-03/swap crashkernel=786M cma=1024M

# cat /proc/iomem | grep -i crash
  b0000000-bfffffff : Crash kernel (low)
  bfcbe00000-bffcffffff : Crash kernel

IMO, we should test this feature more before including this in 5.11

Thanks,
Bhupesh


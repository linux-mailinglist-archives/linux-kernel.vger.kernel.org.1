Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D44226D9DB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIQLHu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:07:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30876 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726651AbgIQLGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:06:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600340771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
        b=b1IwdvvCPKXgqxnRZTHwRNnpJqxm88bGwo1xD7Cwcjjb5sXRnfneRl0JHPNcWLWNb7Xa37
        rnuQrupzg+FYDF3VYE0RLoHup4n7YGL275eT0aIH5kbbiJfozsrh45PeqyHZ1cfi+SbV/A
        rwjH0171qRbhpIa3aZjYhnrNy92Xuko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-e7OPV5CXORmex1Mpj6a_xA-1; Thu, 17 Sep 2020 07:06:09 -0400
X-MC-Unique: e7OPV5CXORmex1Mpj6a_xA-1
Received: by mail-wm1-f70.google.com with SMTP id w3so621605wmg.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:06:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=GKnhWldhLJFQr5DuJgjC2hvPEX9vnawus1q/hrcZp+0=;
        b=bxNpx6gT/0idozhRJKUaYVF08eXDky44HK8sst8SSdX0GorNysQjXpoSaFDbpDYcNx
         6nW81Z6krwNMferqmuDZptLFrd8JtGjEzoTSyPURsA3J/eh1qXyEa+z/ic59FIMKlNvv
         445VFWknOijq2SZNSJIoWaTi7cACSTYOf6XZXgB1UIb7JWu0lverPYaUQvUU2nf9oHn8
         4krVTJFuSAYiR+VU5Sc/Eq3iYyUi3A/7pvjcWvQH4RIfMF1MEc32ftZ/VcUgVXunSJ19
         Pcff6yh9oPNae94rrvEr8CzGm3IQdo5n+XtsTFSTkn5zhGwUAPW/iJc8kFzanV4ax4tm
         TYJQ==
X-Gm-Message-State: AOAM531FfjsX+4vu0sgfap4MftVHmbX3mCH8x0scn/uKpatkNOsN8Llk
        LHOaMFPqWuMkWPWN9WcO/NgO74tP2SGHAjMHld5P2wObbYcFqXn9x2Iq2k9DVvDfidwzAjJXKg5
        03c9GNio+jtiHfhPTd8Sfzuea
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966914wma.141.1600340768655;
        Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfvk8nBFDHZbY4h5lzElLZko5UHfTtrciX4WBrNYMfc9yO+qi5h6FrEF/dqbAWoZhK7788tg==
X-Received: by 2002:a1c:480a:: with SMTP id v10mr8966887wma.141.1600340768444;
        Thu, 17 Sep 2020 04:06:08 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v4sm10412112wml.46.2020.09.17.04.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 04:06:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>
Cc:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        "virtualization\@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Nuno Das Neves <Nuno.Das@microsoft.com>,
        Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer\:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: RE: [EXTERNAL] Re: [PATCH RFC v1 08/18] x86/hyperv: handling hypercall page setup for root
In-Reply-To: <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
References: <20200914112802.80611-1-wei.liu@kernel.org> <20200914112802.80611-9-wei.liu@kernel.org> <87v9gfjpoi.fsf@vitty.brq.redhat.com> <20200915103710.cqmdvzh5lys4wsqo@liuwe-devbox-debian-v2> <SN4PR2101MB0880AAC1B92038C7FDE3496DC0210@SN4PR2101MB0880.namprd21.prod.outlook.com>
Date:   Thu, 17 Sep 2020 13:06:06 +0200
Message-ID: <87o8m4hdcx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sunil Muthuswamy <sunilmut@microsoft.com> writes:

>> 
>> On Tue, Sep 15, 2020 at 12:32:29PM +0200, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> >
>> > > When Linux is running as the root partition, the hypercall page will
>> > > have already been setup by Hyper-V. Copy the content over to the
>> > > allocated page.
>> >
>> > And we can't setup a new hypercall page by writing something different
>> > to HV_X64_MSR_HYPERCALL, right?
>> >
>> 
>> My understanding is that we can't, but Sunil can maybe correct me.
>
> That is correct. For root partition, the hypervisor has already allocated the
> hypercall page. The root is required to query the page, map it in its address
> space and wrmsr to enable it. It cannot change the location of the page. For
> guest, it can allocate and assign the hypercall page. This is covered a bit in the
> hypervisor TLFS (section 3.13 in TLFS v6), for the guest side. The root side is 
> not covered there, yet.

Ok, so it is guaranteed that root partition doesn't have this page in
its address space yet, otherwise it could've been used for something
else (in case it's just normal memory from its PoV).

Please add a comment about this as it is not really obvious.

Thanks,

-- 
Vitaly


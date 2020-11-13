Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 484E72B1FEB
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 17:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKMQQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 11:16:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28031 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMQQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 11:16:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605284188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyN+DRRhVWX4G1okBIOdr3MH4mQtZ4BI+4XoCFZkPBY=;
        b=DkSY0DTSRvCu9IEGbFLizm3K3eX+8p/hlAzzpVZB1Tif0/nmhsnTN3bvZRcbJcPChsXv/B
        QCD9EsXKVMLG5jV7yPi2VVHFO7SdbNRVsHzdNhRyO9dszKd7sy2yb+9I2Kw1JIw232dFrX
        XfmqR2KfZpvPROxFY4M3xkusL23sJyg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-552-N94m8hXJMbi0kq8Jvy3VJQ-1; Fri, 13 Nov 2020 11:16:26 -0500
X-MC-Unique: N94m8hXJMbi0kq8Jvy3VJQ-1
Received: by mail-wr1-f72.google.com with SMTP id h29so3994886wrb.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 08:16:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jyN+DRRhVWX4G1okBIOdr3MH4mQtZ4BI+4XoCFZkPBY=;
        b=SJ5y/XD+NYP3eoM+cDz8BVarLPSxyrqd5cI3fJb/cMoiZFl8o3p0zqjaZWmTCnAdjo
         M9jFCEU0WUo7M4YP8Ngf8UaPXvyB15FtlB5jXHwHeU5dfu4q5HqTbWxZifXAVN3QlqvT
         WJImaGroFPhc6wcKVcnMFl2Rv3t3bg1drwVxvK5bWhyDVlDEkohCDRHw/Rt88l77ExMv
         5Gx7HQjfnia6eZWLOyKH7HyVbfpIf9MoDVUQkomMVTMdSc/xmGBGCbqgs8HaMnJmcZnc
         TqrEPec5bBkkVILSs0W9mAX4oXvcYDVseW34Z74RypibrkjlPyQRramdrp7XUDibQ+FA
         XKWA==
X-Gm-Message-State: AOAM531rjcOI9Q79U3O/6a9gFhuRL17N3dMEVHm6vmQ/XHz91OOYw++L
        8LJLJG+PM3OWREfcJvY31Vq5Kpz+seFN4K86p2tHokzuoYW0jL4MCAxzvPZrth8d87/cSweIV/w
        xKYTpnSKJC+Im436k+h0WRLza
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr3226514wmi.122.1605284180498;
        Fri, 13 Nov 2020 08:16:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6qc4C468qlMkz/BkAoW2zg7V66Dzr5nIEzyPk8ex6nToKTomKk7QfUb8pi/ZNVqMxbgaPow==
X-Received: by 2002:a05:600c:210:: with SMTP id 16mr3226167wmi.122.1605284175430;
        Fri, 13 Nov 2020 08:16:15 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a131sm10530265wmh.30.2020.11.13.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 08:16:14 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 08/17] x86/hyperv: handling hypercall page setup for
 root
In-Reply-To: <20201113160907.rwgpge3zo53fcgvo@liuwe-devbox-debian-v2>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-9-wei.liu@kernel.org>
 <874kluy3o2.fsf@vitty.brq.redhat.com>
 <20201113153333.yt54enp5dbqjj5nu@liuwe-devbox-debian-v2>
 <20201113160907.rwgpge3zo53fcgvo@liuwe-devbox-debian-v2>
Date:   Fri, 13 Nov 2020 17:16:13 +0100
Message-ID: <87wnyput9u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei Liu <wei.liu@kernel.org> writes:

> On Fri, Nov 13, 2020 at 03:33:33PM +0000, Wei Liu wrote:
>> On Thu, Nov 12, 2020 at 04:51:09PM +0100, Vitaly Kuznetsov wrote:
>> > Wei Liu <wei.liu@kernel.org> writes:
>> > 
>> > > When Linux is running as the root partition, the hypercall page will
>> > > have already been setup by Hyper-V. Copy the content over to the
>> > > allocated page.
>> > >
>> > > The suspend, resume and cleanup paths remain untouched because they are
>> > > not supported in this setup yet.
>> > 
>> > What about adding BUG_ONs there then?
>> 
>> I generally avoid cluttering code if I'm sure it definitely does not
>> work.
>> 
>> In any case, adding BUG_ONs is not the right answer. Both hv_suspend and
>> hv_resume can return an error code. I would rather just do
>> 
>>    if (hv_root_partition)
>>        return -EPERM;
>> 
>> in both places.
>
> Correction: hv_resume is void, so I won't add that code snippet. But we
> should still be fine because hv_suspend will have already failed in the
> first place.
>

Works for me. I just very much prefer to get reports like "system
doesn't go to sleep" instead of "something crashes when I put my system
to sleep")

-- 
Vitaly


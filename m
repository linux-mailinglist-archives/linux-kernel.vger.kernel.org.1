Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3C62B2B1D
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Nov 2020 04:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgKNDiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 22:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgKNDiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 22:38:08 -0500
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24835C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 19:38:08 -0800 (PST)
Received: by mail-pf1-x443.google.com with SMTP id w14so9253011pfd.7
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 19:38:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=41w5QkCi0jm/NsWDXVJQyrMIYLbBdrENiMMbL7n0ons=;
        b=QlDaRdBAr5CQTuiAaY4+761DxXnEeI1c+ISNE1enscGGaqBQDWILJi2ysA0iQd70Pk
         Kb5qC8EWrNMxwFMh325mBVdDlkpF6ppKvXxiIsJE0Z9TgogYMIcjTtZly0RR9i2Xf9vP
         o4t+UPPZsgE3JE0qb0+fuxq2enMVAoy172wqH6n1St9mSDgC059K1JMNL+gYLpYPLZPG
         ZLqOccn6dWc/nqj2pRe5J3vzkJ+irOitu0Fti1A5otRhbifpa5gWzquSIWN4VTftkv34
         zdv0eNgqVuc8G1W4pXAGRh8/066VGB8TQgo6rLQjP55m6gdGgbkMCaIAVGR0Tf0WoBiQ
         LP9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=41w5QkCi0jm/NsWDXVJQyrMIYLbBdrENiMMbL7n0ons=;
        b=XfwT3agZ5al34t8Vx/dkcZBhbsOWSVdVaD/jUM59FthyOM3VfmtrRtmDbAuFBdPIwJ
         B66WxSNJfjelc0x0Zc6Jz7r31lcziXnBoCyL5bl6jtkoMUiqNlFxL2qwCVZEJjAOCsif
         DAg32tcFDf3AdV36vFut0i5xxxMqhgj5GQI6H64TA15hpIxdn0JLMpSWVC93tVeXgWki
         RcjCbl8Y8EOtsA0cRex0Nsu9L9wdBFi1Xs+AjibwZVmcj1CUzkYQIHYzAma3BBMr9RS4
         iYsuZh8F50KmdOtkmaW/ur3LftZKhR/QVta944HeXXnIKQOF4spaf4IrhDN3IvhvfnXY
         fYTQ==
X-Gm-Message-State: AOAM532u8qFhBGoUj5DSkx09ur9FD27YBN+9m2mJVDYwGs0Xauq7Hwzg
        pMpFFD6cCfqhLrK8M79WSLQUKQ==
X-Google-Smtp-Source: ABdhPJzUC/psLxZjw+z/8/2ist/4J1D/hfsv8vqZFwQohg7S1xTYNDiv2pSzfQc8+QawK+nplsdtfQ==
X-Received: by 2002:a63:e24:: with SMTP id d36mr4332922pgl.373.1605325087678;
        Fri, 13 Nov 2020 19:38:07 -0800 (PST)
Received: from [192.168.10.85] (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
        by smtp.gmail.com with UTF8SMTPSA id 144sm11375238pfb.71.2020.11.13.19.38.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2020 19:38:06 -0800 (PST)
Subject: Re: [PATCH kernel v3] genirq/irqdomain: Add reference counting to
 IRQs
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
        Michael Ellerman <mpe@ellerman.id.au>, Qian Cai <cai@lca.pw>,
        Rob Herring <robh@kernel.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <20201109094646.71565-1-aik@ozlabs.ru>
 <fac73255eabb43242528821888acf2cc@kernel.org>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <98d06682-da53-c851-74a7-952bf958b793@ozlabs.ru>
Date:   Sat, 14 Nov 2020 14:37:59 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <fac73255eabb43242528821888acf2cc@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/11/2020 05:34, Marc Zyngier wrote:
> Hi Alexey,
> 
> On 2020-11-09 09:46, Alexey Kardashevskiy wrote:
>> PCI devices share 4 legacy INTx interrupts from the same PCI host bridge.
>> Device drivers map/unmap hardware interrupts via irq_create_mapping()/
>> irq_dispose_mapping(). The problem with that these interrupts are
>> shared and when performing hot unplug, we need to unmap the interrupt
>> only when the last device is released.
>>
>> This reuses already existing irq_desc::kobj for this purpose.
>> The refcounter is naturally 1 when the descriptor is allocated already;
>> this adds kobject_get() in places where already existing mapped virq
>> is returned.
>>
>> This reorganizes irq_dispose_mapping() to release the kobj and let
>> the release callback do the cleanup.
>>
>> As kobject_put() is called directly now (not via RCU), it can also handle
>> the early boot case (irq_kobj_base==NULL) with the help of
>> the kobject::state_in_sysfs flag and without additional irq_sysfs_del().
>> While at this, clean up the comment at where irq_sysfs_del() was called.
>>
>> Quick grep shows no sign of irq reference counting in drivers. Drivers
>> typically request mapping when probing and dispose it when removing;
>> platforms tend to dispose only if setup failed and the rest seems
>> calling one dispose per one mapping. Except (at least) PPC/pseries
>> which needs https://lkml.org/lkml/2020/10/27/259
>>
>> Cc: Cédric Le Goater <clg@kaod.org>
>> Cc: Marc Zyngier <maz@kernel.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Qian Cai <cai@lca.pw>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
>> Cc: Michal Suchánek <msuchanek@suse.de>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>> This is what it is fixing for powerpc:
>>
>> There was a comment about whether hierarchical IRQ domains should
>> contribute to this reference counter and I need some help here as
>> I cannot see why.
>> It is reverse now - IRQs contribute to domain->mapcount and
>> irq_domain_associate/irq_domain_disassociate take necessary steps to
>> keep this counter in order. What might be missing is that if we have
>> cascade of IRQs (as in the IOAPIC example from
>> Documentation/core-api/irq/irq-domain.rst ), then a parent IRQ should
>> contribute to the children IRQs and it is up to
>> irq_domain_ops::alloc/free hooks, and they all seem to be eventually
>> calling irq_domain_alloc_irqs_xxx/irq_domain_free_irqs_xxx which seems
>> right.
>>
>> Documentation/core-api/irq/irq-domain.rst also suggests there is a lot
>> to see in debugfs about IRQs but on my thinkpad there nothing about
>> hierarchy.
>>
>> So I'll ask again :)
>>
>> What is the easiest way to get irq-hierarchical hardware?
>> I have a bunch of powerpc boxes (no good) but also a raspberry pi,
>> a bunch of 32/64bit orange pi's, an "armada" arm box,
>> thinkpads - is any of this good for the task?
> 
> If your HW doesn't require an interrupt hierarchy, run VMs!
> Booting an arm64 guest with virtual PCI devices will result in
> hierarchies being created (PCI-MSI -> GIC MSI widget -> GIC).

Absolutely :) But the beauty of ARM is that one can buy an actual ARM 
device for 20$, I have "opi one+ allwinner h6 64bit cortex a53 1GB RAM", 
is it worth using KVM on this device, or is it too small for that?

> You can use KVM, or even bare QEMU on x86 if you are so inclined.

Have a QEMU command line handy for x86/tcg?

> I'll try to go through this patch over the week-end (or more probably
> early next week), and try to understand where our understandings
> differ.

Great, thanks! Fred spotted a problem with irq_free_descs() not doing 
kobject_put() anymore and this is a problem for sa1111.c and the likes 
and I will go though these places anyway.


-- 
Alexey

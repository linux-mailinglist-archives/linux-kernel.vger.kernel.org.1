Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE86A2DBE94
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgLPKYN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 05:24:13 -0500
Received: from foss.arm.com ([217.140.110.172]:43876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725820AbgLPKYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 05:24:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B934F1FB;
        Wed, 16 Dec 2020 02:23:27 -0800 (PST)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 03FF13F66B;
        Wed, 16 Dec 2020 02:23:25 -0800 (PST)
Subject: Re: [PATCH v5 0/2] MTE support for KVM guest
To:     Haibo Xu <haibo.xu@linaro.org>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        QEMU Developers <qemu-devel@nongnu.org>,
        "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        kvmarm <kvmarm@lists.cs.columbia.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20201119153901.53705-1-steven.price@arm.com>
 <CAFEAcA85fiqA206FuFANKbV_3GkfY1F8Gv7MP58BgTT81bs9kA@mail.gmail.com>
 <20201119184248.4bycy6ouvaxqdiiy@kamzik.brq.redhat.com>
 <db5ad775fa7cfe7defbd78d9ca6ccfd8@kernel.org>
 <c25c297e-e9b5-ab3f-e401-c21ddd4d2ad1@arm.com>
 <CAJc+Z1H7akXwDtVvQLiGVVyZ0DfmsxyJQhE7Sno6aAO9GaafEA@mail.gmail.com>
 <46fd98a2-ee39-0086-9159-b38c406935ab@arm.com>
 <CAJc+Z1EzaUjbQ0o8BSF_+PQy_KnwPp1NqO+94RMphvaUu=dnug@mail.gmail.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <29a7229d-a1ff-98a5-3007-1addcc85aa04@arm.com>
Date:   Wed, 16 Dec 2020 10:22:52 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJc+Z1EzaUjbQ0o8BSF_+PQy_KnwPp1NqO+94RMphvaUu=dnug@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2020 07:31, Haibo Xu wrote:
[...]
> Hi Steve,

Hi Haibo

> I have finished verifying the POC on a FVP setup, and the MTE test case can
> be migrated from one VM to another successfully. Since the test case is very
> simple which just maps one page with MTE enabled and does some memory
> access, so I can't say it's OK for other cases.

That's great progress.

> 
> BTW, I noticed that you have sent out patch set v6 which mentions that mapping
> all the guest memory with PROT_MTE was not feasible. So what's the plan for the
> next step? Will new KVM APIs which can facilitate the tag store and recover be
> available?

I'm currently rebasing on top of the KASAN MTE patch series. My plan for 
now is to switch back to not requiring the VMM to supply PROT_MTE (so 
KVM 'upgrades' the pages as necessary) and I'll add an RFC patch on the 
end of the series to add an KVM API for doing bulk read/write of tags. 
That way the VMM can map guest memory without PROT_MTE (so device 'DMA' 
accesses will be unchecked), and use the new API for migration.

Thanks,

Steve

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66012D0D19
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgLGJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:35:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:54948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbgLGJfu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:35:50 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C02422ADF;
        Mon,  7 Dec 2020 09:35:09 +0000 (UTC)
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94)
        (envelope-from <maz@kernel.org>)
        id 1kmCvD-00GiE8-2h; Mon, 07 Dec 2020 09:35:07 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Dec 2020 09:35:06 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Will Deacon <will@kernel.org>, Wei Li <liwei213@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Steve Capper <steve.capper@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>, fengbaopeng2@hisilicon.com,
        butao@hisilicon.com,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: mm: decrease the section size to reduce the memory
 reserved for the page map
In-Reply-To: <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
References: <20201204014443.43329-1-liwei213@huawei.com>
 <20201204111347.GA844@willie-the-truck>
 <CAMj1kXGQ-CeYcbS-hc+Yy8DKHm2t-RYsLu4+7wOG1bWuJqkjGQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <390f5f441d99a832f4b2425b46f6d971@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: ardb@kernel.org, will@kernel.org, liwei213@huawei.com, song.bao.hua@hisilicon.com, steve.capper@arm.com, catalin.marinas@arm.com, linux-kernel@vger.kernel.org, rppt@linux.ibm.com, fengbaopeng2@hisilicon.com, butao@hisilicon.com, nsaenzjulienne@suse.de, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-12-07 09:09, Ard Biesheuvel wrote:
> (+ Marc)
> 
> On Fri, 4 Dec 2020 at 12:14, Will Deacon <will@kernel.org> wrote:
>> 
>> On Fri, Dec 04, 2020 at 09:44:43AM +0800, Wei Li wrote:
>> > For the memory hole, sparse memory model that define SPARSEMEM_VMEMMAP
>> > do not free the reserved memory for the page map, decrease the section
>> > size can reduce the waste of reserved memory.
>> >
>> > Signed-off-by: Wei Li <liwei213@huawei.com>
>> > Signed-off-by: Baopeng Feng <fengbaopeng2@hisilicon.com>
>> > Signed-off-by: Xia Qing <saberlily.xia@hisilicon.com>
>> > ---
>> >  arch/arm64/include/asm/sparsemem.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/arch/arm64/include/asm/sparsemem.h b/arch/arm64/include/asm/sparsemem.h
>> > index 1f43fcc79738..8963bd3def28 100644
>> > --- a/arch/arm64/include/asm/sparsemem.h
>> > +++ b/arch/arm64/include/asm/sparsemem.h
>> > @@ -7,7 +7,7 @@
>> >
>> >  #ifdef CONFIG_SPARSEMEM
>> >  #define MAX_PHYSMEM_BITS     CONFIG_ARM64_PA_BITS
>> > -#define SECTION_SIZE_BITS    30
>> > +#define SECTION_SIZE_BITS    27
>> 
>> We chose '30' to avoid running out of bits in the page flags. What 
>> changed?
>> 
>> With this patch, I can trigger:
>> 
>> ./include/linux/mmzone.h:1170:2: error: Allocator MAX_ORDER exceeds 
>> SECTION_SIZE
>> #error Allocator MAX_ORDER exceeds SECTION_SIZE
>> 
>> if I bump up NR_CPUS and NODES_SHIFT.
>> 
> 
> Does this mean we will run into problems with the GICv3 ITS LPI tables
> again if we are forced to reduce MAX_ORDER to fit inside
> SECTION_SIZE_BITS?

Most probably. We are already massively constraint on platforms
such as TX1, and dividing the max allocatable range by 8 isn't
going to make it work any better...

         M.
-- 
Jazz is not dead. It just smells funny...

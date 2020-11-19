Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33622B9A82
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 19:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgKSSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 13:18:30 -0500
Received: from foss.arm.com ([217.140.110.172]:36996 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728145AbgKSSS3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 13:18:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DCDF11595;
        Thu, 19 Nov 2020 10:18:28 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1DD923F70D;
        Thu, 19 Nov 2020 10:18:25 -0800 (PST)
Subject: Re: [PATCH v6 1/7] arm64: mm: Move reserve_crashkernel() into
 mem_init()
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     robh+dt@kernel.org, catalin.marinas@arm.com, hch@lst.de,
        ardb@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        will@kernel.org, jeremy.linton@arm.com,
        iommu@lists.linux-foundation.org,
        linux-rpi-kernel@lists.infradead.org, guohanjun@huawei.com,
        robin.murphy@arm.com, linux-arm-kernel@lists.infradead.org
References: <20201103173159.27570-1-nsaenzjulienne@suse.de>
 <20201103173159.27570-2-nsaenzjulienne@suse.de>
 <e60d643e-4879-3fc3-737d-2c145332a6d7@arm.com>
 <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
From:   James Morse <james.morse@arm.com>
Message-ID: <f15ad06d-faa8-65fc-6fc1-d5c77115b1f1@arm.com>
Date:   Thu, 19 Nov 2020 18:18:23 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <88c69ac0c9d7e144c80cebc7e9f82b000828e7f5.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(sorry for the late response)

On 06/11/2020 18:46, Nicolas Saenz Julienne wrote:
> On Thu, 2020-11-05 at 16:11 +0000, James Morse wrote:>> We also depend on this when skipping the checksum code in purgatory, which can be
>> exceedingly slow.
> 
> This one I don't fully understand, so I'll lazily assume the prerequisite is
> the same WRT how memory is mapped. :)

The aim is its never normally mapped by the kernel. This is so that if we can't get rid of
the secondary CPUs (e.g. they have IRQs masked), but they are busy scribbling all over
memory, we have a rough guarantee that they aren't scribbling over the kdump kernel.

We can skip the checksum in purgatory, as there is very little risk of the memory having
been corrupted.


> Ultimately there's also /sys/kernel/kexec_crash_size's handling. Same
> prerequisite.

Yeah, this lets you release PAGE_SIZEs back to the allocator, which means the
marked-invalid page tables we have hidden there need to be PAGE_SIZE mappings.


Thanks,

James


> Keeping in mind acpi_table_upgrade() and unflatten_device_tree() depend on
> having the linear mappings available. I don't see any simple way of solving
> this. Both moving the firmware description routines to use fixmap or correcting
> the linear mapping further down the line so as to include kdump's regions, seem
> excessive/impossible (feel free to correct me here). I'd be happy to hear
> suggestions. Otherwise we're back to hard-coding the information as we
> initially did.
> 
> Let me stress that knowing the DMA constraints in the system before reserving
> crashkernel's regions is necessary if we ever want it to work seamlessly on all
> platforms. Be it small stuff like the Raspberry Pi or huge servers with TB of
> memory.

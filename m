Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6EF2B600D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 14:07:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgKQNFp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 08:05:45 -0500
Received: from foss.arm.com ([217.140.110.172]:56224 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgKQNFo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 08:05:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D843101E;
        Tue, 17 Nov 2020 05:05:44 -0800 (PST)
Received: from [192.168.2.21] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D53A33F719;
        Tue, 17 Nov 2020 05:05:41 -0800 (PST)
Subject: Re: [PATCH 00/24] x86/resctrl: Merge the CDP resources
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <04fdd774-99e0-4b99-2d70-06cfd0ab3be6@intel.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <af17ed35-15e8-d779-60d1-c16f14004bec@arm.com>
Date:   Tue, 17 Nov 2020 13:05:39 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <04fdd774-99e0-4b99-2d70-06cfd0ab3be6@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Reinette,

On 16/11/2020 17:54, Reinette Chatre wrote:
> On 10/30/2020 9:10 AM, James Morse wrote:
>> MPAM has an equivalent feature to CDP, but its a property of the CPU,
>> not the cache. Resctrl needs to have x86's odd/even behaviour, as that
>> its the ABI, but this isn't how the MPAM hardware works. It is entirely
>> possible that an in-kernel user of MPAM would not be using CDP, whereas
>> resctrl is.

> The above seems to distinguish between "in-kernel user of MPAM" and resctrl (now obtaining
> support for MPAM). Could you please provide more details on the "in-kernel user of MPAM"
> and elaborate on how these two usages are expected to interact with MPAM concurrently?

This is a badly phrased reference to all the bits of MPAM that are left on the floor after
the resctrl support is plumbed up.

Currently none of the software exists, but MPAM also has support for: virtualisation, the
interrupt-controller (GIC) and the IO-MMU. None of these things are exposed via resctrl,
so they either need new schema (which must also work for x86), or handling 'invisibly' in
the kernel.

Virtualisation is probably the easiest example: With MPAM, the guest may be 'using CDP'
whereas the host is not, or vice-versa.
The guest will never be allowed to access the MMIO configuration directly, it will be
managed via the host's driver. Now the host's driver has to handle CDP-on and CDP-off
configurations.
Keeping the odd/even CDP stuff in resctrl means the arch-code/driver doesn't need to know
or care about this stuff if the hardware doesn't.

If the interrupt-controller or IO-MMU consume closid/rmid, then I'd describe them as
in-kernel users (as the kernel owns their configuration). These would never use CDP as
they don't fetch instructions.


How do I envision these things working concurrently?
(a) closid/rmid can be reserved before resctrl is mounted, or
(b) allocated by user-space and handed back to the kernel (e.g. virtualisation).

The ctrlval values move to belong to the arch-code/driver, so if 'something' changes the
configuration behind resctrls back, the new schema values are immediately visible via the
corresponding schema file in case (b). In case (a), resctrl would never look at those
closid, but it wouldn't matter if it did.

(the counter-example is mba_sc, which may need to convert the current ctrlval back to a
mbps_val if its being managed by something other than resctrl)



Thanks,

James

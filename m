Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A8C262B8B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 11:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729741AbgIIJPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 05:15:45 -0400
Received: from foss.arm.com ([217.140.110.172]:40334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIJPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:15:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5BE61FB;
        Wed,  9 Sep 2020 02:15:42 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AD523F66E;
        Wed,  9 Sep 2020 02:15:40 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] MTE support for KVM guest
To:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        eric.auger@redhat.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, qemu-devel@nongnu.org,
        Juan Quintela <quintela@redhat.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Peter Maydell <Peter.Maydell@arm.com>,
        Haibo Xu <Haibo.Xu@arm.com>
References: <20200904160018.29481-1-steven.price@arm.com>
 <20200907152812.GJ2682@work-vm>
From:   Steven Price <steven.price@arm.com>
Message-ID: <b457fdd2-785b-8692-c3a0-95ae73fec746@arm.com>
Date:   Wed, 9 Sep 2020 10:15:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200907152812.GJ2682@work-vm>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2020 16:28, Dr. David Alan Gilbert wrote:
> (cc'ing in Eric Auger)
> 
> * Steven Price (steven.price@arm.com) wrote:
>> Arm's Memory Tagging Extension (MTE) adds 4 bits of tag data to every 16
>> bytes of memory in the system. This along with stashing a tag within the
>> high bit of virtual addresses allows runtime checking of memory
>> accesses.
>>
>> These patches add support to KVM to enable MTE within a guest. They are
>> based on Catalin's v9 MTE user-space support series[1].
>>
>> I'd welcome feedback on the proposed user-kernel ABI. Specifically this
>> series currently:
>>
>>   1. Requires the VMM to enable MTE per-VCPU.
>>   2. Automatically promotes (normal host) memory given to the guest to be
>>      tag enabled (sets PG_mte_tagged), if any VCPU has MTE enabled. The
>>      tags are cleared if the memory wasn't previously MTE enabled.
>>   3. Doesn't provide any new methods for the VMM to access the tags on
>>      memory.
>>
>> (2) and (3) are particularly interesting from the aspect of VM migration.
>> The guest is able to store/retrieve data in the tags (presumably for the
>> purpose of tag checking, but architecturally it could be used as just
>> storage). This means that when migrating a guest the data needs to be
>> transferred (or saved/restored).
>>
>> MTE tags are controlled by the same permission model as normal pages
>> (i.e. a read-only page has read-only tags), so the normal methods of
>> detecting guest changes to pages can be used. But this would also
>> require the tags within a page to be migrated at the same time as the
>> data (since the access control for tags is the same as the normal data
>> within a page).
> 
> (Without understanding anything about your tag system...)
> 
> Note that during (normal, non-postcopy) migration the consistency can
> be a little loose - until the guest starts running; i.e. you can send
> a page that's in themiddle of being modified as long as you make sure
> you send it again later so that what the guest sees on the destination
> when it runs is consistent; i.e. it would be fine to send your tags
> separately to your data and allow them to get a little out of sync, as
> long as they caught up before the guest ran.

Yes, you can obviously pro-actively send data early as you as you 
appropriately deal with any potential changes that the guest might make. 
I'm not very familiar with exactly how QEMU handles this, so it might 
not be a problem - I just wanted to point out that we don't have 
separate access permissions.

>> (3) may be problematic and I'd welcome input from those familiar with
>> VMMs. User space cannot access tags unless the memory is mapped with the
>> PROT_MTE flag. However enabling PROT_MTE will also enable tag checking
>> for the user space process (assuming the VMM enables tag checking for
>> the process) and since the tags in memory are controlled by the guest
>> it's unlikely the VMM would have an appropriately tagged pointer for its
>> access. This means the VMM would either need to maintain two mappings of
>> memory (one to access tags, the other to access data) or disable tag
>> checking during the accesses to data.
> 
> Imagine I had a second mapping; what would it look like; how would I get
> and restore the tags?

At a very simple level you could do something like:

  normal_mapping = mmap(..., PROT_READ | PROT_WRITE, ..., fd, 0);
  mte_mapping = mmap(..., PROT_READ | PROT_WRITE | PROT_MTE, ..., fd, 0);

  /* access normal mapping as normal */
  normal_mapping[offset] = 0xf00 + normal_mapping[offset + 1];

  /* read tag from mte_mapping */
  uint64_t tag = ldg(&mte_mapping[offset]);

  /* write a new tag value (8)
   * NOTE: tags are stored in the top byte, hence the shift
   */
  stg(0x8ULL << 56, &mte_mapping[offset]);

Where stg() and ldg() are simple wrappers around the new instructions:

  stg:
         STG x0, [x1]
         RET

  ldg:
         LDG x0, [x0]
         RET

> In terms of migration stream, I guess we have two ways to do this,
> either it rides shotgun on the main RAM section pages, transmitting
> those few extra bytes whenever we transmit a page, or you have a
> separate iteratable device for RAMtags, and it just transmits those.
> How you keep the two together is an interesting question.
> The shotgun method sounds nasty to avoid putting special cases in the,
> already hairy, RAM code.

As you say above it may be possible to simply let the normal RAM and 
tags get out of sync. E.g. if you send all the normal RAM (marking 
read-only as you go), then all the tags (not changing the permissions) 
you will end up with all the pages that have remained read-only (i.e. 
the guest hasn't modified) being consistent on the destination. Pages 
that have been written by the guest will be inconsistent, but you were 
going to have to resend those anyway.

However for post-migration copy you need to copy *both* normal RAM and 
tags before resuming the guest. You might need special cases for this.

>> If it's not practical to either disable tag checking in the VMM or
>> maintain multiple mappings then the alternatives I'm aware of are:
>>
>>   * Provide a KVM-specific method to extract the tags from guest memory.
>>     This might also have benefits in terms of providing an easy way to
>>     read bulk tag data from guest memory (since the LDGM instruction
>>     isn't available at EL0).
>>   * Provide support for user space setting the TCMA0 or TCMA1 bits in
>>     TCR_EL1. These would allow the VMM to generate pointers which are not
>>     tag checked.
> 
> I guess you want the VMM to do as much tagged checked access as possible
> on it's own data structures?

Ideally yes, you would want the VMM to have checked accesses for all 
it's internal data structures because that gives the maximum benefit 
from MTE.

> How do things like virtio work where the qemu or kernel is accessing
> guest memory for IO?

Since virtio is effectively emulating a device it should be treated like 
a device - no tag checking and no tag storage used. This would be the 
obvious situation where you would use "normal_mapping" as above so tags 
wouldn't be visible or checked.

Really the VMM is only interested in guest tags for the migration case 
where it simply needs to preserve them. I don't expect the guest and VMM 
(or hypervisor) to communicate using tagged memory.

Steve

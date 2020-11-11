Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359182AEE2C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgKKJyp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:54:45 -0500
Received: from mga03.intel.com ([134.134.136.65]:24494 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgKKJyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:54:43 -0500
IronPort-SDR: Wv5aFNtcV7EFU0jeuHWVVCbS/9kJqWrIww7S0/CFrNYI61JoaXeZ5SORYFhQD9oiKSK05HNAE/
 FmlJ4TGidlFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="170232556"
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="170232556"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:54:38 -0800
IronPort-SDR: IQQc4une4KiOKuUL6UxQpwa6jaTZgg450jzpVV1OwLxar3FPzfRgM0gH6dI1JEjq8a65iDea/M
 L8ZuAMYSU0qA==
X-IronPort-AV: E=Sophos;i="5.77,469,1596524400"; 
   d="scan'208";a="541719728"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 01:54:33 -0800
Date:   Wed, 11 Nov 2020 17:54:31 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v5 07/17] virt: acrn: Introduce an ioctl to set vCPU
 registers state
Message-ID: <20201111095431.GH17702@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-8-shuo.a.liu@intel.com>
 <20201109170940.GA2013864@kroah.com>
 <20201110131419.GG17702@shuo-intel.sh.intel.com>
 <X6qpovz2TVpvZjDh@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X6qpovz2TVpvZjDh@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10.Nov'20 at 15:54:26 +0100, Greg Kroah-Hartman wrote:
>On Tue, Nov 10, 2020 at 09:14:19PM +0800, Shuo A Liu wrote:
>> > And there really is no validation of
>> > any fields?
>>
>> Yes. Because HSM driver has little knowledge to do the validation.
>
>What is "HSM driver"?  And you all are ready for fuzzers to break this
>into small pieces, right?  No validation of any input parameters feels
>really really wrong.  Best of luck!

This driver is HSM (Hypervisor Service Module) driver.
Take this hypercall for example. The register values are set by user, we
can do nothing to verify them. If the values are wrong, the VM will
crash and the hypervisor will handle that.

>
>> > > +struct acrn_regs {
>> > > +	struct acrn_gp_regs		gprs;
>> > > +	struct acrn_descriptor_ptr	gdt;
>> > > +	struct acrn_descriptor_ptr	idt;
>> > > +
>> > > +	__u64				rip;
>> >
>> > As these are all crossing the user/kernel boundry and then on to
>> > somewhere "else", you have to specify the endian of all of these, right?
>> >
>> > if not, why not?
>>
>> The hypervisor and the driver only support X86_64 platform for now. So, the
>> endian should be certain.
>
>Then specify it please.

Ok. Will be __le64. I will also fix other instances in this file.

>
>> > > +	__u16			reserved0[3];
>> >
>> > What does the reserved fields do?
>>
>> To keep same layout with the hypervisor. Because the structure will be
>> passed to hypervisor directly.
>>
>> >
>> > Is there a pointer to a public document for all of these structures
>> > somewhere?
>>
>> Unfortunately, no. I have added some documents for some strutures
>> in the code via kernel-doc format.
>
>Is this not the hypervisor that this code is for:
>	https://projectacrn.org/
>?
>
>If not, what is this thing?
>
>If so, how is there not documentation for it?

Oh, yes. We have the structures documentation on the website. Pls refer
https://projectacrn.github.io/latest/api/hypercall_api.html#
I meant that some fields of structures might be lack of explanation.

>
>> > > +	struct acrn_regs	vcpu_regs;
>> > > +} __attribute__((aligned(8)));
>> >
>> > What does the alignment do here?
>>
>> The hypervisor wants to access aligned data block to improve the
>> efficiency. Currently, the hypervisor only runs on x86_64 platform.
>
>That's nice, but what do you think that adding this attribute to a
>structure provides you?  Have you tested this really is doing what you
>think it is doing?

It could make the compiler put the data structure at aligned address.
In the kernel the structures are almost from kmalloc, so the attribute
might be not meaningful. But in the hypervisor, there are many such data
structures in stack or in static pool, this attribute can make sure the
data structures are located at the aligned address.

Thanks
shuo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F282AF6FE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 17:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgKKQzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 11:55:23 -0500
Received: from mga12.intel.com ([192.55.52.136]:43978 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgKKQzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 11:55:22 -0500
IronPort-SDR: xanFHdH1o18uzeV1TYDO6IAN+IFKE0CyMzTluKI0PcO0EDSfZXCvzpVOT9hHrUSJVacXxoY53O
 ZId7pS2sDC4w==
X-IronPort-AV: E=McAfee;i="6000,8403,9802"; a="149449335"
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="149449335"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 08:55:19 -0800
IronPort-SDR: iBdoHNfmwEz2iL31d6UO7v4YdMgw1auk59kyd11fUfAtwauesji6LXZB9Gc0XZRrMaS/OkewCI
 290H9rpNtbCA==
X-IronPort-AV: E=Sophos;i="5.77,470,1596524400"; 
   d="scan'208";a="541873069"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2020 08:55:16 -0800
Date:   Thu, 12 Nov 2020 00:55:14 +0800
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
Message-ID: <20201111165514.GJ17702@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-8-shuo.a.liu@intel.com>
 <20201109170940.GA2013864@kroah.com>
 <20201110131419.GG17702@shuo-intel.sh.intel.com>
 <X6qpovz2TVpvZjDh@kroah.com>
 <20201111095431.GH17702@shuo-intel.sh.intel.com>
 <X6u82BylaUR8nZec@kroah.com>
 <20201111120348.GI17702@shuo-intel.sh.intel.com>
 <X6vZHoA1Yyfev6QU@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X6vZHoA1Yyfev6QU@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11.Nov'20 at 13:29:18 +0100, Greg Kroah-Hartman wrote:
>On Wed, Nov 11, 2020 at 08:03:48PM +0800, Shuo A Liu wrote:
>> On Wed 11.Nov'20 at 11:28:40 +0100, Greg Kroah-Hartman wrote:
>> > On Wed, Nov 11, 2020 at 05:54:31PM +0800, Shuo A Liu wrote:
>> > > On Tue 10.Nov'20 at 15:54:26 +0100, Greg Kroah-Hartman wrote:
>> > > > On Tue, Nov 10, 2020 at 09:14:19PM +0800, Shuo A Liu wrote:
>> > > > > > And there really is no validation of
>> > > > > > any fields?
>> > > > >
>> > > > > Yes. Because HSM driver has little knowledge to do the validation.
>> > > >
>> > > > What is "HSM driver"?  And you all are ready for fuzzers to break this
>> > > > into small pieces, right?  No validation of any input parameters feels
>> > > > really really wrong.  Best of luck!
>> > >
>> > > This driver is HSM (Hypervisor Service Module) driver.
>> > > Take this hypercall for example. The register values are set by user, we
>> > > can do nothing to verify them. If the values are wrong, the VM will
>> > > crash and the hypervisor will handle that.
>> >
>> > Ah, nice, so you are creating a situation where any user can crash the
>> > VM, what can go wrong :(
>>
>> Not any user, only the one who create the VM. Others cannot access the
>> same VM. Let me list a piece of pesudo code of the device usage:
>>
>>  fd = open the /dev/acrn_hsm, HSM driver binds a VM with the fd
>>  ioctl (fd, CREATE_VM, SET_VCPU_REGS, START_VM ...)
>>  close fd
>>
>> The one who create the VM should have full control of the VM.
>
>Including crashing it and potentially corrupting the hypervisor?  Great,
>remind me to never use this code :)

The crashing here is within guest VM itself. It should not affect the
hypervisor, else bug appears. The hypervisor should handle such case
correctly (e.g. add more validataion in hypervisor) :)

>
>> > > > > >
>> > > > > > Is there a pointer to a public document for all of these structures
>> > > > > > somewhere?
>> > > > >
>> > > > > Unfortunately, no. I have added some documents for some strutures
>> > > > > in the code via kernel-doc format.
>> > > >
>> > > > Is this not the hypervisor that this code is for:
>> > > > 	https://projectacrn.org/
>> > > > ?
>> > > >
>> > > > If not, what is this thing?
>> > > >
>> > > > If so, how is there not documentation for it?
>> > >
>> > > Oh, yes. We have the structures documentation on the website. Pls refer
>> > > https://projectacrn.github.io/latest/api/hypercall_api.html#
>> > > I meant that some fields of structures might be lack of explanation.
>> >
>> > Please work on the documentation of the fields, otherwise it doesn't
>> > really make much sense what is happening here, right?
>>
>> Right. We will try to enrich them.
>>
>> >
>> > Along these lines, where is the userspace code that makes all of these
>> > ioctls?  Surely the fields must be documented there, right?
>>
>> A userspace tool uses the ioctls, you can find the source from:
>> https://github.com/projectacrn/acrn-hypervisor/blob/master/devicemodel/core/vmmapi.c
>> There is a bit difference with the version i posted as i did some polish for
>> upstream.
>
>I do not understand, this isn't your version?  Where is the "correct"
>implementation?  Shouldn't that be part of the patch series
>documentation?  Or was it and I missed it as this thread is so long?

You didn't miss that. The link i pasted above is from a userspace
application (named devicemodel in ACRN project) that using this driver
on ACRN hypervisor (like QEMU on KVM). I didn't put it in the patch,
because it's a huge program. There are some difference of the
ioctl definition within this patchset (changing of name and definition),
because we are using that currently for daily development. When the
upstreaming patch got merged, they will be updated.

So, it seems you wanted a brief example code of driver usage in
documentation, am i right? If yes, i can try to make one. But it
might only show a brief flow of VM creating, memory setup, vcpu setup,
VM starting, maybe IO handling, VM destroy, ..etc. Is that ok? 

>
>> > > > > > > +	struct acrn_regs	vcpu_regs;
>> > > > > > > +} __attribute__((aligned(8)));
>> > > > > >
>> > > > > > What does the alignment do here?
>> > > > >
>> > > > > The hypervisor wants to access aligned data block to improve the
>> > > > > efficiency. Currently, the hypervisor only runs on x86_64 platform.
>> > > >
>> > > > That's nice, but what do you think that adding this attribute to a
>> > > > structure provides you?  Have you tested this really is doing what you
>> > > > think it is doing?
>> > >
>> > > It could make the compiler put the data structure at aligned address.
>> >
>> > Are you sure this is the correct way to do that?
>>
>> I tried the attribute it works.
>>
>> test.c:
>>
>> struct foo_256_aligned {
>> 	int a;
>> 	unsigned char b;
>> } __attribute__((aligned(256)));
>>
>> struct foo {
>> 	int a;
>> 	unsigned char b;
>> };
>> int main(int argc, char** argv) {
>> 	struct foo_256_aligned a;
>> 	struct foo b;
>> 	printf("%p %p\n", &a, &b);
>> }
>>
>> # gcc -o test test.c && ./test
>> 0x7ffe2af04b00 0x7ffe2af04af8
>
>But you will not have these data structures defined on the stack like
>this in the kernel source.
>
>You will be assigning the structure to some chunk of memory you
>dynamically allocate, right?  That's my main point here, if this is

Understand.

>something that you HAVE to have right, then you HAVE to test and verify
>it is true when the structure is sent to you.
>
>To just assume that a compiler marking will somehow enforce this
>alignment on random chunks of allocated memory is very odd.
>
>> > > In the kernel the structures are almost from kmalloc, so the attribute
>> > > might be not meaningful. But in the hypervisor, there are many such data
>> > > structures in stack or in static pool, this attribute can make sure the
>> > > data structures are located at the aligned address.
>> >
>> > This is kernel data, not hypervisor data, in kernel memory.  If you
>> > require the hypervisor to get the structures at a specific alignment in
>> > memory, you better check that in the kernel code, otherwise how can you
>> > ensure it?
>>
>> Oh, this is a public header file which will be used by the hypervisor as
>> well.
>
>Then you HAVE to use the proper user/kernel structures for it.

Sorry, i didn't follow here. The structures are used in 

  * devicemodel (userspace application, like QEMU in KVM)
  * HSM (this driver, pass the data from devicemodel to hypervisor)
  * hypervisor

They all should be compiled with the same public header from kernel, is
my understanding right? If hypervisor source wants to use the compiler
marking, need i only duplicate one header with the modification for
that?


Thanks
shuo

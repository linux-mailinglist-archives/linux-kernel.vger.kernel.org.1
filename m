Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0322A7813
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729024AbgKEHfw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:35:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:8279 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725287AbgKEHfw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:35:52 -0500
IronPort-SDR: XVKRiZYV1FzzrSyLk6JebWJgZQa7QpLKRwjR7aMh9IZsBEy0H4RxyixfMrUAhd5qAIE9mIcgG4
 SAFelEXlqoiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="230968783"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="230968783"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:35:50 -0800
IronPort-SDR: pYepc2Da3JIP1u8Tj1XEp/Qu+ohzz8DSU4gFDjGJlH1bino9HFS6gZ8UsKuLDRzm50zrGU8npl
 mzpjWbnVTh4w==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="539268550"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 23:35:47 -0800
Date:   Thu, 5 Nov 2020 15:35:45 +0800
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
Subject: Re: [PATCH v5 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20201105073545.GD17702@shuo-intel.sh.intel.com>
References: <20201019061803.13298-1-shuo.a.liu@intel.com>
 <20201019061803.13298-7-shuo.a.liu@intel.com>
 <20201104190235.GA2855400@kroah.com>
 <20201105031029.GB17702@shuo-intel.sh.intel.com>
 <20201105062907.GA693781@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20201105062907.GA693781@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu  5.Nov'20 at  7:29:07 +0100, Greg Kroah-Hartman wrote:
>On Thu, Nov 05, 2020 at 11:10:29AM +0800, Shuo A Liu wrote:
>> On Wed  4.Nov'20 at 20:02:35 +0100, Greg Kroah-Hartman wrote:
>> > On Mon, Oct 19, 2020 at 02:17:52PM +0800, shuo.a.liu@intel.com wrote:
>> > > --- /dev/null
>> > > +++ b/include/uapi/linux/acrn.h
>> > > @@ -0,0 +1,56 @@
>> > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
>> > > +/*
>> > > + * Userspace interface for /dev/acrn_hsm - ACRN Hypervisor Service Module
>> > > + *
>> > > + * This file can be used by applications that need to communicate with the HSM
>> > > + * via the ioctl interface.
>> > > + */
>> > > +
>> > > +#ifndef _UAPI_ACRN_H
>> > > +#define _UAPI_ACRN_H
>> > > +
>> > > +#include <linux/types.h>
>> > > +
>> > > +/**
>> > > + * struct acrn_vm_creation - Info to create a User VM
>> > > + * @vmid:		User VM ID returned from the hypervisor
>> > > + * @reserved0:		Reserved
>> > > + * @vcpu_num:		Number of vCPU in the VM. Return from hypervisor.
>> > > + * @reserved1:		Reserved
>> > > + * @uuid:		UUID of the VM. Pass to hypervisor directly.
>> > > + * @vm_flag:		Flag of the VM creating. Pass to hypervisor directly.
>> > > + * @ioreq_buf:		Service VM GPA of I/O request buffer. Pass to
>> > > + *			hypervisor directly.
>> > > + * @cpu_affinity:	CPU affinity of the VM. Pass to hypervisor directly.
>> > > + * @reserved2:		Reserved
>> >
>> > Reserved and must be 0?
>>
>> Not a must.
>
>That's guaranteed to come back and bite you in the end.  

OK. I can fill them with zero before passing them to hypervisor.

>You all have read the "how to write a good api" document, right?

Is it Documentation/driver-api/ioctl.rst? Or i missed..

>
>> > What are they reserved for?
>> >
>> > Same for all of the reserved fields, why?
>>
>> Some reserved fields are to map layout in the hypervisor side, others
>> are for future use.
>
>ioctls should not have these, again, please read the documentation.  If
>you need something new in the future, just make a new ioctl.

OK. I will remove some reserved fields for scalability. Though i can
keep some reserved fields for alignment (and to keep same data structure
layout with the hypervisor), right?
Documentation/driver-api/ioctl.rst says that explicit reserved fields
could be used.

>
>> > > + */
>> > > +struct acrn_vm_creation {
>> > > +	__u16	vmid;
>> > > +	__u16	reserved0;
>> > > +	__u16	vcpu_num;
>> > > +	__u16	reserved1;
>> > > +	__u8	uuid[16];
>> >
>> > We have a userspace-visable uid structure in include/uapi/uuid.h, why
>> > not use that?
>>
>> we just pass the uuid data from user space to hypervisor. So, we can
>> remove a header dependeny with using raw data format.
>
>I do not understand this, please use the built-in kernel types we have.

OK. I will use that.

Thanks
shuo

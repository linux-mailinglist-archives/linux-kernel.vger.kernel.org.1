Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6F727A78F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgI1G3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:29:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:37573 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726420AbgI1G3l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:29:41 -0400
IronPort-SDR: uP0T/6wuYH3RYXW3nnbXmK47JuLmuRVrhqbiYKYXoqcqVG3zH8xlKxXWbxWny+wstI54kvUgkJ
 QLy8dWhMi+rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162834178"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="162834178"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 23:29:40 -0700
IronPort-SDR: VYyUWJ3nLvBOs8AbqvbWnQ7vLjSJ9dK2F5lEngiuzjgfRZHCCvxLQFg3YLfKM2lIuoRH/0rtCX
 G7J8lp3LSE0w==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488445109"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 23:29:37 -0700
Date:   Mon, 28 Sep 2020 14:29:34 +0800
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
Subject: Re: [PATCH v4 06/17] virt: acrn: Introduce VM management interfaces
Message-ID: <20200928062934.GF1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-7-shuo.a.liu@intel.com>
 <20200927104702.GE88650@kroah.com>
 <20200928035030.GD1057@shuo-intel.sh.intel.com>
 <20200928052516.GD767987@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200928052516.GD767987@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28.Sep'20 at  7:25:16 +0200, Greg Kroah-Hartman wrote:
>On Mon, Sep 28, 2020 at 11:50:30AM +0800, Shuo A Liu wrote:
>> > > +	write_lock_bh(&acrn_vm_list_lock);
>> > > +	list_add(&vm->list, &acrn_vm_list);
>> > > +	write_unlock_bh(&acrn_vm_list_lock);
>> >
>> > Why are the _bh() variants being used here?
>> >
>> > You are only accessing this list from userspace context in this patch.
>> >
>> > Heck, you aren't even reading from the list, only writing to it...
>>
>> acrn_vm_list is read in a tasklet which dispatch I/O requests and is wrote
>> in VM creation ioctl. Use the rwlock mechanism to protect it.
>> The reading operation is introduced in the following patches of this
>> series. So i keep the lock type at the moment of introduction.
>
>Ok, but think about someone trying to review this code.  Does this lock
>actually make sense here?  No, it does not.  How am I supposed to know
>to look at future patches to determine that it changes location and
>usage to require this?

OK. May i know how to handle such kind of code submission? Or which way
following do you prefer?
  1) Use a mutex lock here, then change it to rwlock in a later patch
     of this series.
  2) Add more comments in changelog about the lock. (Now, there is
     comment around the acrn_vm_list_lock)

>
>That's just not fair, would you want to review something like this?
>
>And a HUGE meta-comment, again, why am I the only one reviewing this
>stuff?  Why do you have a ton of Intel people on the Cc: yet it is, once
>again, my job to do this?

The patchset has been reviewed in Intel's internal mailist several
rounds and got Reviewed-by: before send out. That's why i Cced many
Intel people as well.

This patchset is all about a common driver for the ACRN hypervisor
support. I put the code in drivers/virt/ and found you are one of the
maintainer of vboxguest driver which is in the same subdirectory. I
thought you should be the right person to be Cced when i submitted this
series.

Certainly, any comments are welcome. And really appreciate your review
and help. I have little experience to submit a new driver to the
community, my apologies if thing goes wrong.

Thanks
shuo

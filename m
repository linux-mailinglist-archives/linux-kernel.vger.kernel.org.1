Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E732EBAE9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 08:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAFH5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 02:57:10 -0500
Received: from mga01.intel.com ([192.55.52.88]:39976 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727009AbhAFH5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 02:57:09 -0500
IronPort-SDR: 0skZls0VoMwnWwKjdj9ShdZWs0dcrg7yELjV3M1xaLAvVnls6s4QHu3HRtzvLnitTO9qi8opIE
 wm1kV3xx7PLw==
X-IronPort-AV: E=McAfee;i="6000,8403,9855"; a="195789238"
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="195789238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:56:29 -0800
IronPort-SDR: yDHut+n4aefPf78hOogS3Kr6jN0wwWICSct9fIcfEgfZcHpiEKn39qIlyzhyr5UE/2EZQvVCvB
 IdHDY6xOU/rQ==
X-IronPort-AV: E=Sophos;i="5.78,479,1599548400"; 
   d="scan'208";a="395535554"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2021 23:56:25 -0800
Date:   Wed, 6 Jan 2021 15:56:23 +0800
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
Subject: Re: [PATCH v6 06/18] virt: acrn: Introduce VM management interfaces
Message-ID: <20210106075623.GB22447@shuo-intel.sh.intel.com>
References: <20201201093853.12070-1-shuo.a.liu@intel.com>
 <20201201093853.12070-7-shuo.a.liu@intel.com>
 <X8YWa8IUCgOARYMS@kroah.com>
 <20201202021429.GL17702@shuo-intel.sh.intel.com>
 <20201215095259.GN17702@shuo-intel.sh.intel.com>
 <X9iJWXaIUpUq2qia@kroah.com>
 <20201215100251.GO17702@shuo-intel.sh.intel.com>
 <X/RxmiUYnhoQvdwz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X/RxmiUYnhoQvdwz@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  5.Jan'21 at 15:03:06 +0100, Greg Kroah-Hartman wrote:
>On Tue, Dec 15, 2020 at 06:02:51PM +0800, Shuo A Liu wrote:
>> On Tue 15.Dec'20 at 11:00:57 +0100, Greg Kroah-Hartman wrote:
>> > On Tue, Dec 15, 2020 at 05:52:59PM +0800, Shuo A Liu wrote:
>> > > On Wed  2.Dec'20 at 10:14:29 +0800, Shuo A Liu wrote:
>> > > > On Tue  1.Dec'20 at 11:09:47 +0100, Greg Kroah-Hartman wrote:
>> > > > > On Tue, Dec 01, 2020 at 05:38:41PM +0800, shuo.a.liu@intel.com wrote:
>> > > > > > +		vm_param->reserved0 = 0;
>> > > > > > +		vm_param->reserved1 = 0;
>> > > > >
>> > > > > NO!
>> > > > >
>> > > > > This means that userspace can put whatever crud they want in those
>> > > > > fields, and you will happily zero it out.  Then, when those reserved
>> > > > > fields are wanted to be used in the future, you will take those values
>> > > > > from userspace and accept them as a valid value.  But, since userspace
>> > > > > was sending crud before, now you will take that crud and do something
>> > > > > with it.
>> > > > >
>> > > > > TEST IT to verify that it is zero, that way userspace gets it right the
>> > > > > first time, and you don't get it wrong later, as you can not change it
>> > > > > later.
>> > > >
>> > > > OK. Thanks for the elaboration. I will test it and return -EINVAL if
>> > > > it is not zero.
>> > > >
>> > >
>> > > Hi Greg,
>> > >
>> > > Would you like to review other patches in this series on this version?
>> >
>> > Nope, it's the middle of the merge window, I can't do anything with any
>> > new patches until after 5.11-rc1 is out.  So I suggest you fix up the
>> > current issues and send a new patch series once 5.11-rc1 is released.
>>
>> Got it, thanks!
>
>Did this ever happen?  I don't see a new series anywhere, do you have a
>lore.kernel.org link?

Just back to work. :)

Sent new series already. The link is
https://lore.kernel.org/lkml/20210106075055.47226-1-shuo.a.liu@intel.com/

Thanks
shuo

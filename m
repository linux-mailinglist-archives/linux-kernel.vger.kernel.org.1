Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E940827A795
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 08:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1Gd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 02:33:26 -0400
Received: from mga09.intel.com ([134.134.136.24]:37845 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbgI1GdZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 02:33:25 -0400
IronPort-SDR: cgrBrYCME9dWWqafDLPzbJG7IUJSqoXZ9zMIUQV26pP9WNQGbPn2phmxwiH3enqfdL0Zpu7Z/M
 AyQVelxqX1ig==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="162834427"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="162834427"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 23:33:26 -0700
IronPort-SDR: ECQkjtQqaQzlKsJj/QQ4VYJjNZrYAczGB6N6PH4tiO43gfZuF2EVvq8hjlydKq/VGl2qXIYe+V
 T73VHlO5iDZw==
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="456711587"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 23:33:22 -0700
Date:   Mon, 28 Sep 2020 14:33:19 +0800
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
Subject: Re: [PATCH v4 17/17] virt: acrn: Introduce an interface for Service
 VM to control vCPU
Message-ID: <20200928063319.GG1057@shuo-intel.sh.intel.com>
References: <20200922114311.38804-1-shuo.a.liu@intel.com>
 <20200922114311.38804-18-shuo.a.liu@intel.com>
 <20200927104414.GC88650@kroah.com>
 <20200928041006.GE1057@shuo-intel.sh.intel.com>
 <20200928052305.GC767987@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200928052305.GC767987@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 28.Sep'20 at  7:23:05 +0200, Greg Kroah-Hartman wrote:
>On Mon, Sep 28, 2020 at 12:10:07PM +0800, Shuo A Liu wrote:
>> > You just raced with userspace and lost.  If you want to add attribute
>> > files to a device, use the default attribute group list, and it will be
>> > managed properly for you by the driver core.
>> >
>> > Huge hint, if a driver every has to touch a kobject, or call sysfs_*,
>> > then it is probably doing something wrong.
>>
>> Do you mean use .groups of struct miscdevice directly ?
>>
>> If yes, let me follow drivers/char/hw_random/s390-trng.c to do this.
>> BTW, few driver use the .groups directly. :)
>
>Drivers should almost never be messing with individual sysfs files.  And
>this ability to use .groups is a "new" one, conversions of existing code
>that do not use them is always welcome.

OK. Thanks for the explanation. I will follow the 'new' way :)

Thanks
shuo

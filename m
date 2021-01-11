Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 922E42F0BA9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 05:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727227AbhAKEEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 23:04:07 -0500
Received: from mga11.intel.com ([192.55.52.93]:49744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbhAKEEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 23:04:06 -0500
IronPort-SDR: FXfhJkaIeYMZa7KXYDrNeYJpzyS4uyJeesMHeZAi3M/EW0LQFQDH7KNlUQOLgDh4YQ0C8nTTCo
 I0g6KkEHJIKQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9860"; a="174292368"
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="174292368"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 20:03:26 -0800
IronPort-SDR: bNOGErMi/2oX0P5qyLbFMfEqnfOmG6KeUyGVi9zIq6DugpGOBw8wq1FPjODf21q9QbrCOiQ+zo
 Hbs6PfMUoC0Q==
X-IronPort-AV: E=Sophos;i="5.79,337,1602572400"; 
   d="scan'208";a="380869959"
Received: from shuo-intel.sh.intel.com (HELO localhost) ([10.239.154.30])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2021 20:03:23 -0800
Date:   Mon, 11 Jan 2021 12:03:21 +0800
From:   Shuo A Liu <shuo.a.liu@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Yu Wang <yu1.wang@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>
Subject: Re: [PATCH v7 08/18] virt: acrn: Introduce EPT mapping management
Message-ID: <20210111040321.GE22447@shuo-intel.sh.intel.com>
References: <20210106075055.47226-1-shuo.a.liu@intel.com>
 <20210106075055.47226-9-shuo.a.liu@intel.com>
 <X/h7bhf9RRGjnJ+a@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <X/h7bhf9RRGjnJ+a@kroah.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri  8.Jan'21 at 16:34:06 +0100, Greg Kroah-Hartman wrote:
>On Wed, Jan 06, 2021 at 03:50:45PM +0800, shuo.a.liu@intel.com wrote:
>> +/**
>> + * struct acrn_vm_memmap - A EPT memory mapping info for a User VM.
>> + * @type:		Type of the memory mapping (ACRM_MEMMAP_*).
>> + *			Pass to hypervisor directly.
>> + * @attr:		Attribute of the memory mapping.
>> + *			Pass to hypervisor directly.
>> + * @user_vm_pa:		Physical address of User VM.
>> + *			Pass to hypervisor directly.
>> + * @service_vm_pa:	Physical address of Service VM.
>> + *			Pass to hypervisor directly.
>> + * @vma_base:		VMA address of Service VM. Pass to hypervisor directly.
>> + * @len:		Length of the memory mapping.
>> + *			Pass to hypervisor directly.
>> + */
>> +struct acrn_vm_memmap {
>> +	__u32	type;
>> +	__u32	attr;
>> +	__u64	user_vm_pa;
>> +	union {
>> +		__u64	service_vm_pa;
>> +		__u64	vma_base;
>> +	};
>> +	__u64	len;
>> +};
>
>Endianness?

Same consideration within patch 06/18. Need i specify these values? They
are more like ioctls' paramter values.

Thanks
shuo
>

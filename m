Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9B52B7131
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 23:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728654AbgKQWEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 17:04:34 -0500
Received: from mga04.intel.com ([192.55.52.120]:45084 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726498AbgKQWEe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 17:04:34 -0500
IronPort-SDR: nxFfyr/0MkUGw5U/y2m6u60BZas5n9MdE5q+eh41WiNembKZ+ekCKz0/q11/i0PTe+oSTxnJgv
 UNQEIzQ5EAmA==
X-IronPort-AV: E=McAfee;i="6000,8403,9808"; a="168449692"
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="168449692"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:04:33 -0800
IronPort-SDR: bbizNljBmwqoOwvQ9PCE3yCIfYsp8o1XBVMRhgfWUd7IkgM/UfthgaecuZ9AqA2+sG55yXHIDt
 50ffQ+21VmMw==
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="430602888"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.24.101]) ([10.212.24.101])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2020 14:04:30 -0800
Subject: Re: [PATCH 06/24] x86/resctrl: Store the effective num_closid in the
 schema
To:     James Morse <james.morse@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        shameerali.kolothum.thodi@huawei.com,
        Jamie Iles <jamie@nuviainc.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>
References: <20201030161120.227225-1-james.morse@arm.com>
 <20201030161120.227225-7-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <14fa276a-ce44-07f4-203e-d1c8f5967b0b@intel.com>
Date:   Tue, 17 Nov 2020 14:04:29 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201030161120.227225-7-james.morse@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 10/30/2020 9:11 AM, James Morse wrote:
> resctrl_schema holds properties that vary with the style of configuration
> that resctrl applies to a resource.
> 
> Once the arch code has a single resource per cache that can be configured,
> resctrl will need to keep track of the num_closid itself.
> 
> Add num_closid to resctrl_schema. Change callers like
> rdtgroup_schemata_show() to walk the schema instead.

This is a significant patch in that it introduces a second num_closid 
available for code to use. Even so, the commit message is treating it 
quite nonchalantly ... essentially stating that "here is a new closid 
and change some code to use it".

Could you please elaborate how the callers needing to "walk the schema 
instead" were chosen?

This seems almost a revert of the earlier patch that introduced the 
helper and I wonder if it may not make this easier to understand if 
these areas do not receive the temporary change to use that helper.

> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>   arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 13 ++++++++-----
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 11 +++++------
>   include/linux/resctrl.h                   |  2 ++
>   3 files changed, 15 insertions(+), 11 deletions(-)
> 

...

> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index de6cbc725753..b32152968bca 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -166,10 +166,12 @@ struct rdt_resource {
>   /**
>    * @list:	Member of resctrl's schema list
>    * @res:	The rdt_resource for this entry
> + * @num_closid	Number of CLOSIDs available for this resource

Missing a ":"?

>    */
>   struct resctrl_schema {
>   	struct list_head		list;
>   	struct rdt_resource		*res;
> +	u32				num_closid;
>   };
>   
>   /* The number of closid supported by this resource regardless of CDP */
> 

Reinette

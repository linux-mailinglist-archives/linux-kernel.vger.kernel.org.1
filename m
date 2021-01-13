Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917422F50B6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 18:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbhAMRMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 12:12:00 -0500
Received: from mga04.intel.com ([192.55.52.120]:40759 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727271AbhAMRL7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 12:11:59 -0500
IronPort-SDR: ZiuAZ/n9IDHFOMMXbh28a57zzhBb53zN2+yQwxUt+nIMVL7UukbTvyKjO3Cllt0pzZczOULBoy
 wc896LQtbBrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9863"; a="175658880"
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="175658880"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:11:19 -0800
IronPort-SDR: vzJgBHS4YBl/l/AzqUuJCLJW3mMm868A1Q5oevO/rmHrb37TNg+5W5dMNQboMufp+7nrFBu3Ll
 GUZAuHy95zqQ==
X-IronPort-AV: E=Sophos;i="5.79,344,1602572400"; 
   d="scan'208";a="363944293"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.214.199]) ([10.212.214.199])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2021 09:11:18 -0800
Subject: Re: [PATCH V4] arch: kernel: cpu: x86/resctrl: Takes a letter away
 and append a colon to match below struct member
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Cc:     rdunlap@infradead.org
References: <20210113020333.29803-1-unixbhaskar@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <7e3a5c13-db5c-7399-2b80-f1284786ea77@intel.com>
Date:   Wed, 13 Jan 2021 09:11:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210113020333.29803-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

The prefix in the subject line should be "x86/resctrl:" only. The 
subject line could be (also taking liberty to shorten it here):
x86/resctrl: Fix typo and append a colon to match struct member

I would like to repeat my suggestion made in response to your previous 
version, especially if you are planning cleanup in many areas of the 
kernel: Use "git log" to take a look at the custom of patches in the 
area you are contributing to. While the kernel may appear to be a single 
code base there can be different customs in the various subsystems.

On 1/12/2021 6:03 PM, Bhaskar Chowdhury wrote:
> s/kernlfs/kernfs/
> s/@mon_data_kn/@mon_data_kn:/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Changes from V3: Fix the subject line typo stuc to struct and mention cpu architecture
>   arch/x86/kernel/cpu/resctrl/internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ee71c47844cb..ef9e2c0809b8 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -142,7 +142,7 @@ enum rdtgrp_mode {
> 
>   /**
>    * struct mongroup - store mon group's data in resctrl fs.
> - * @mon_data_kn		kernlfs node for the mon_data directory
> + * @mon_data_kn:		kernfs node for the mon_data directory
>    * @parent:			parent rdtgrp
>    * @crdtgrp_list:		child rdtgroup node list
>    * @rmid:			rmid for this rdtgroup
> --
> 2.20.1
> 

Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27C372C2E64
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 18:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390773AbgKXRXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 12:23:30 -0500
Received: from mga05.intel.com ([192.55.52.43]:21901 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390656AbgKXRXa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 12:23:30 -0500
IronPort-SDR: Hzn5cX4Ycj/CJWM1cKcew/sp+peKHF7avtZx9G3FmtZf5PbsodhE9ui8j4/HodL3crL6yxFTte
 KqaJGxEHp6Lg==
X-IronPort-AV: E=McAfee;i="6000,8403,9815"; a="256692766"
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="256692766"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 09:23:29 -0800
IronPort-SDR: MC+PK9tKwzS1nAMIGFCkpyJLeMsfD7rs4nVXjPl8wajir7Ov8/4HQXG7E7h/Kev+y/W8f9WHWc
 jjwPCHlL855g==
X-IronPort-AV: E=Sophos;i="5.78,366,1599548400"; 
   d="scan'208";a="332634097"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.252.136.150]) ([10.252.136.150])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2020 09:23:26 -0800
Subject: Re: [PATCH v2] x86/resctrl: Fix AMD L3 QOS CDP enable/disable
To:     Babu Moger <babu.moger@amd.com>, bp@alien8.de
Cc:     fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, hpa@zytor.com, tglx@linutronix.de
References: <160589301962.26308.4728709200492788764.stgit@bmoger-ubuntu>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <cd932b15-4094-7f97-a019-057af2aa577c@intel.com>
Date:   Tue, 24 Nov 2020 09:23:23 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <160589301962.26308.4728709200492788764.stgit@bmoger-ubuntu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 11/20/2020 9:25 AM, Babu Moger wrote:
> When the AMD QoS feature CDP(code and data prioritization) is enabled
> or disabled, the CDP bit in MSR 0000_0C81 is written on one of the
> CPUs in L3 domain(core complex). That is not correct. The CDP bit needs
> to be updated all the logical CPUs in the domain.
> 
> This was not spelled out clearly in the spec earlier. The specification
> has been updated. The updated specification, "AMD64 Technology Platform
> Quality of Service Extensions Publication # 56375 Revision: 1.02 Issue
> Date: October 2020" is available now. Refer the section: Code and Data
> Prioritization.
> 
> Fix the issue by adding a new flag arch_has_per_cpu_cfg in rdt_cache
> data structure.
> 
> The documentation can be obtained at the links below:
> https://developer.amd.com/wp-content/resources/56375.pdf
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> v2: Taken care of Reinette's comments. Changed the field name to
>      arch_has_per_cpu_cfg to be bit more meaningful about the CPU scope.
>      Also fixed some wordings.
> 
> v1: https://lore.kernel.org/lkml/160469365104.21002.2901190946502347327.stgit@bmoger-ubuntu/
> 
>   arch/x86/kernel/cpu/resctrl/core.c     |    4 ++++
>   arch/x86/kernel/cpu/resctrl/internal.h |    3 +++
>   arch/x86/kernel/cpu/resctrl/rdtgroup.c |    9 +++++++--
>   3 files changed, 14 insertions(+), 2 deletions(-)
> 

...

> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 80fa997fae60..bcd9b517c765 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -360,6 +360,8 @@ struct msr_param {
>    *			executing entities
>    * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
>    * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
> + * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
> + * 				level has CPU scope.

Please fixup the spacing to not have spaces before tabs. This will make 
checkpatch happy and fit with in with the rest of the comments for this 
struct.

>    */
>   struct rdt_cache {
>   	unsigned int	cbm_len;
> @@ -369,6 +371,7 @@ struct rdt_cache {
>   	unsigned int	shareable_bits;
>   	bool		arch_has_sparse_bitmaps;
>   	bool		arch_has_empty_bitmaps;
> +	bool		arch_has_per_cpu_cfg;
>   };
>   
>   /**

...

This patch looks good to me.

With the one style comment addressed you can add:
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>

Thank you very much

Reinette

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252052EE7FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 22:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbhAGVwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 16:52:41 -0500
Received: from mga12.intel.com ([192.55.52.136]:49369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbhAGVwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 16:52:41 -0500
IronPort-SDR: ikjdqDm8rjbu6QhR97Pji9nilJ7kbJAWjWpRymVSW3hHkfjpU5JLXmJrg6ghZXAA8+Mh84MsWg
 23H1VYJaGrWw==
X-IronPort-AV: E=McAfee;i="6000,8403,9857"; a="156684187"
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="156684187"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 13:52:00 -0800
IronPort-SDR: 4saJ7QS+n8ISD5MG7mZzaCK3vDu/QggCM2ebRoIZcvCxoqYPnILhVQb0sOSCH4dxecYLbbUou8
 8cIkqhEu02Fw==
X-IronPort-AV: E=Sophos;i="5.79,330,1602572400"; 
   d="scan'208";a="566271409"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.212.132.29]) ([10.212.132.29])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2021 13:52:00 -0800
Subject: Re: [PATCH] x86/resctrl: add printf attribute to log function
To:     trix@redhat.com, fenghua.yu@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
References: <20201221160009.3752017-1-trix@redhat.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <25b32e4b-72c6-bf66-5088-7851b237329f@intel.com>
Date:   Thu, 7 Jan 2021 13:51:59 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201221160009.3752017-1-trix@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 12/21/2020 8:00 AM, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Attributing the function allows the compiler to more thoroughly
> check the use of the function with -Wformat and similar flags.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>   arch/x86/kernel/cpu/resctrl/internal.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index ee71c47844cb..c4d320d02fd5 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -572,6 +572,7 @@ union cpuid_0x10_x_edx {
>   
>   void rdt_last_cmd_clear(void);
>   void rdt_last_cmd_puts(const char *s);
> +__printf(1, 2)
>   void rdt_last_cmd_printf(const char *fmt, ...);
>   
>   void rdt_ctrl_update(void *arg);
> 

This is a valuable addition, thank you.

Acked-by: Reinette Chatre <reinette.chatre@intel.com>

Reinette

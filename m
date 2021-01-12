Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190BA2F3603
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390392AbhALQnY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:43:24 -0500
Received: from mga12.intel.com ([192.55.52.136]:49184 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbhALQnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:43:23 -0500
IronPort-SDR: kLYv/rMaoWqcbVBOC7qqj4mX6pwiew8yILKywFbTRQ6Vmb5DkU/DDQKAgUGV8kY+wrfQSyP+sQ
 LXTMWTy3BOaA==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="157247720"
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="157247720"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 08:42:42 -0800
IronPort-SDR: KCTlQPGjM95+co2GTQQk/P/Rt7sC5Ar41/WTcgTm3+Y1P73g2kqk3fAq6imoUx/gNOrsAkzbXk
 fy15Qj09f2wA==
X-IronPort-AV: E=Sophos;i="5.79,341,1602572400"; 
   d="scan'208";a="348510141"
Received: from rchatre-mobl3.amr.corp.intel.com (HELO [10.254.43.43]) ([10.254.43.43])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 08:42:41 -0800
Subject: Re: [PATCH V3] arch: x86: kernel: cpu: Takes a letter away and append
 a colon to match below stuc member
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, fenghua.yu@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org, gustavo@embeddedor.com
Cc:     rdunlap@infradead.org
References: <20210112110131.23378-1-unixbhaskar@gmail.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <6964dc91-f87d-22c8-002d-164cf9da52b5@intel.com>
Date:   Tue, 12 Jan 2021 08:42:40 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20210112110131.23378-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhaskar,

Thank you for fixing this.

Could you please fix the subject line to:
1) have correct prefix of "x86/resctrl:". You can see the custom by 
running "git log arch/x86/kernel/cpu/resctrl".
2) fix the typo: stuc -> struct

On 1/12/2021 3:01 AM, Bhaskar Chowdhury wrote:
> s/kernlfs/kernfs/
> s/@mon_data_kn/@mon_data_kn:/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
> Changes from V2: Modified the subject line to match exact change description
> 
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
> 2.26.2
> 

Thank you

Reinette

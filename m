Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175962A8FBC
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 07:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKFG5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 01:57:19 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:14870 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKFG5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 01:57:19 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CSB5m178Xz9tyl8;
        Fri,  6 Nov 2020 07:57:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0tvnNDWyEbSe; Fri,  6 Nov 2020 07:57:16 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CSB5l6dqHz9tyl7;
        Fri,  6 Nov 2020 07:57:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B95238B885;
        Fri,  6 Nov 2020 07:57:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id M78HGa_Z50-v; Fri,  6 Nov 2020 07:57:16 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5854B8B75F;
        Fri,  6 Nov 2020 07:57:16 +0100 (CET)
Subject: Re: [PATCH v2] kernel/watchdog: Fix watchdog_allowed_mask not used
 warning
To:     Santosh Sivaraj <santosh@fossix.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>
References: <20201106015025.1281561-1-santosh@fossix.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <78e3bbe8-4f45-0b68-6e72-85fcc4f75695@csgroup.eu>
Date:   Fri, 6 Nov 2020 07:57:16 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201106015025.1281561-1-santosh@fossix.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/11/2020 à 02:50, Santosh Sivaraj a écrit :
> Define watchdog_allowed_mask only when SOFTLOCKUP_DETECTOR is enabled.
> 
> Fixes: 7feeb9cd4f5b ("watchdog/sysctl: Clean up sysctl variable name space")
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Santosh Sivaraj <santosh@fossix.org>

Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> ---
> v2:
> Added Petr's reviewed-by from [1] and add fixes tag as suggested by Christophe.
> 
> [1]: https://lkml.org/lkml/2020/8/20/1030
> 
>   kernel/watchdog.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/watchdog.c b/kernel/watchdog.c
> index 5abb5b22ad13..71109065bd8e 100644
> --- a/kernel/watchdog.c
> +++ b/kernel/watchdog.c
> @@ -44,8 +44,6 @@ int __read_mostly soft_watchdog_user_enabled = 1;
>   int __read_mostly watchdog_thresh = 10;
>   static int __read_mostly nmi_watchdog_available;
>   
> -static struct cpumask watchdog_allowed_mask __read_mostly;
> -
>   struct cpumask watchdog_cpumask __read_mostly;
>   unsigned long *watchdog_cpumask_bits = cpumask_bits(&watchdog_cpumask);
>   
> @@ -162,6 +160,8 @@ static void lockup_detector_update_enable(void)
>   int __read_mostly sysctl_softlockup_all_cpu_backtrace;
>   #endif
>   
> +static struct cpumask watchdog_allowed_mask __read_mostly;
> +
>   /* Global variables, exported for sysctl */
>   unsigned int __read_mostly softlockup_panic =
>   			CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE;
> 

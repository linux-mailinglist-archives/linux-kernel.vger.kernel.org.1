Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F782A85B8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 19:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731196AbgKESJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 13:09:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:37560 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKESJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 13:09:56 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1604599794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mv7ODK6mkgvs0jq5vnw1lPFEHG64V1hqt9dlD+8z708=;
        b=qAJ4IYQCtWO5HNQQT9GoZF12XXiutACfMoz2nVVT8Le/kJGZCgTPj0/roXO98foZwCJMRl
        eaCQ+scvWW833SNJ/WQyATmk6Ih5CcNPGGO5W1/CGvvw7C/il1nK1Lm7dlARF0z+zhAYXN
        yJ/ktifov7l96XasilqHHcHyZufkz38=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6773DABAE;
        Thu,  5 Nov 2020 18:09:54 +0000 (UTC)
Date:   Thu, 5 Nov 2020 19:09:53 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Matteo Croce <mcroce@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Robin Holt <robinmholt@gmail.com>,
        Fabian Frederick <fabf@skynet.be>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 3/3] reboot: refactor and comment the cpu selection
 code
Message-ID: <20201105180953.GI1602@alley>
References: <20201103214025.116799-1-mcroce@linux.microsoft.com>
 <20201103214025.116799-4-mcroce@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103214025.116799-4-mcroce@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-11-03 22:40:25, Matteo Croce wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> Small improvements to the code, without changing the way it works:
> - use a local variable, to avoid a small time lapse where reboot_cpu
>   can have an invalid value
> - comment the code which is not easy to understand at a glance
> - merge two identical code blocks into one
> - replace pointer arithmetics with equivalent array syntax
> 
> Signed-off-by: Matteo Croce <mcroce@microsoft.com>
> ---
>  kernel/reboot.c | 30 +++++++++++++++++-------------
>  1 file changed, 17 insertions(+), 13 deletions(-)
> 
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index af6f23d8bea1..dd483bde932b 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -551,20 +551,24 @@ static int __init reboot_setup(char *str)
>  			break;
>  
>  		case 's':
> -			if (isdigit(*(str+1)))
> -				reboot_cpu = simple_strtoul(str+1, NULL, 0);
> -			else if (str[1] == 'm' && str[2] == 'p' &&
> -							isdigit(*(str+3)))
> -				reboot_cpu = simple_strtoul(str+3, NULL, 0);
> -			else
> +			/*
> +			 * reboot_cpu is s[mp]#### with #### being the processor
> +			 * to be used for rebooting. Skip 's' or 'smp' prefix.
> +			 */
> +			str += str[1] == 'm' && str[2] == 'p' ? 3 : 1;
> +
> +			if (isdigit(str[0])) {
> +				int cpu = simple_strtoul(str, NULL, 0);
> +
> +				if (cpu >= num_possible_cpus()) {
> +					pr_err("Ignoring the CPU number in reboot= option. "
> +					"CPU %d exceeds possible cpu number %d\n",

Same here. I am not sure if Andrew would like to get this on a single
line.

In both cases:

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

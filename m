Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE1D1F15D0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 11:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729243AbgFHJqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 05:46:46 -0400
Received: from foss.arm.com ([217.140.110.172]:50484 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbgFHJqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:46:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16BAF31B;
        Mon,  8 Jun 2020 02:46:45 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4FC0E3F73D;
        Mon,  8 Jun 2020 02:46:43 -0700 (PDT)
Date:   Mon, 8 Jun 2020 10:46:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Wang ShaoBo <bobo.shaobowang@huawei.com>
Cc:     huawei.libin@huawei.com, cj.chengjian@huawei.com,
        xiexiuqi@huawei.com, mark.rutland@arm.com, hch@infradead.org,
        wcohen@redhat.com, linux-kernel@vger.kernel.org,
        mtk.manpages@gmail.com, wezhang@redhat.com,
        gregkh@linuxfoundation.org, Will Deacon <will@kernel.org>
Subject: Re: [RESEND PATCH] sys_personality: Add optional arch hook
 arch_check_personality
Message-ID: <20200608094640.GA13596@gaia>
References: <20200608024925.42510-1-bobo.shaobowang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608024925.42510-1-bobo.shaobowang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 10:49:25AM +0800, Wang ShaoBo wrote:
> Currently arm64 personality syscall uses wrapper __arm64_sys_personality
> to redirect to __arm64_sys_arm64_personality, it's easily confused,
> Whereas using an normal hook arch_check_personality() can reject
> additional settings like this for special case of different architectures.
> 
> This makes code clean and easier for subsequent modification.

Do you plan to add more stuff here? Curious what triggered this patch.

> diff --git a/arch/arm64/kernel/sys.c b/arch/arm64/kernel/sys.c
> index d5ffaaab31a7..5c01816d7a77 100644
> --- a/arch/arm64/kernel/sys.c
> +++ b/arch/arm64/kernel/sys.c
> @@ -28,12 +28,13 @@ SYSCALL_DEFINE6(mmap, unsigned long, addr, unsigned long, len,
>  	return ksys_mmap_pgoff(addr, len, prot, flags, fd, off >> PAGE_SHIFT);
>  }
>  
> -SYSCALL_DEFINE1(arm64_personality, unsigned int, personality)
> +int arch_check_personality(unsigned int personality)
>  {
>  	if (personality(personality) == PER_LINUX32 &&
>  		!system_supports_32bit_el0())
>  		return -EINVAL;
> -	return ksys_personality(personality);
> +
> +	return 0;
>  }

We use the ksys_* pattern in other places as well, so this wouldn't be
something new.

> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 1815065d52f3..3dbbad498027 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -1393,16 +1393,6 @@ static inline long ksys_truncate(const char __user *pathname, loff_t length)
>  	return do_sys_truncate(pathname, length);
>  }
>  
> -static inline unsigned int ksys_personality(unsigned int personality)
> -{
> -	unsigned int old = current->personality;
> -
> -	if (personality != 0xffffffff)
> -		set_personality(personality);
> -
> -	return old;
> -}
> -
>  /* for __ARCH_WANT_SYS_IPC */
>  long ksys_semtimedop(int semid, struct sembuf __user *tsops,
>  		     unsigned int nsops,
> diff --git a/kernel/exec_domain.c b/kernel/exec_domain.c
> index 33f07c5f2515..f3682f4bf205 100644
> --- a/kernel/exec_domain.c
> +++ b/kernel/exec_domain.c
> @@ -35,9 +35,21 @@ static int __init proc_execdomains_init(void)
>  module_init(proc_execdomains_init);
>  #endif
>  
> +int __weak arch_check_personality(unsigned int personality)
> +{
> +	return 0;
> +}
> +
>  SYSCALL_DEFINE1(personality, unsigned int, personality)
>  {
> -	unsigned int old = current->personality;
> +	int err;
> +	unsigned int old;
> +
> +	err = arch_check_personality(personality);
> +	if (err)
> +		return err;
> +
> +	old = current->personality;

I'm surprised that the generic sys_personality() doesn't call
ksys_personality() directly but rather duplicates the code.

Anyway, without knowing what else you plan to do with
arch_check_personality(), I don't think it's worth changing. Calling
ksys_personality() directly from sys_personality() would be a good
clean-up though.

-- 
Catalin

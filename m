Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D8D1F470B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 21:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgFITYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 15:24:30 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:39768 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730673AbgFITY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 15:24:29 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jijrH-0007GE-Ir; Tue, 09 Jun 2020 13:24:27 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jijrG-0004Qt-E0; Tue, 09 Jun 2020 13:24:27 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     <keescook@chromium.org>, <ak@linux.intel.com>,
        <alex.huangjianhui@huawei.com>, <linzichang@huawei.com>,
        <linux-kernel@vger.kernel.org>
References: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
Date:   Tue, 09 Jun 2020 14:20:21 -0500
In-Reply-To: <1591683605-8585-1-git-send-email-nixiaoming@huawei.com>
        (Xiaoming Ni's message of "Tue, 9 Jun 2020 14:20:05 +0800")
Message-ID: <87a71c59my.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jijrG-0004Qt-E0;;;mid=<87a71c59my.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Ta2Jkjn5MEo5+y1s73413m8ZQ6ys6rZg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.8 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_XMDrugObfuBody_08
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 0; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: ; sa05 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Xiaoming Ni <nixiaoming@huawei.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 713 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 13 (1.8%), b_tie_ro: 11 (1.5%), parse: 1.78
        (0.3%), extract_message_metadata: 25 (3.6%), get_uri_detail_list: 6
        (0.8%), tests_pri_-1000: 20 (2.8%), tests_pri_-950: 1.65 (0.2%),
        tests_pri_-900: 1.22 (0.2%), tests_pri_-90: 136 (19.1%), check_bayes:
        134 (18.8%), b_tokenize: 16 (2.2%), b_tok_get_all: 11 (1.6%),
        b_comp_prob: 3.5 (0.5%), b_tok_touch_all: 99 (13.9%), b_finish: 1.12
        (0.2%), tests_pri_0: 500 (70.2%), check_dkim_signature: 0.87 (0.1%),
        check_dkim_adsp: 3.6 (0.5%), poll_dns_idle: 0.69 (0.1%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 7 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] sysctl: Delete the code of sys_sysctl
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoming Ni <nixiaoming@huawei.com> writes:

> Since the commit 61a47c1ad3a4dc ("sysctl: Remove the sysctl system call"),
> sys_sysctl has lost its actual role: any input can only return an error.

The remaining code does have a role.  It reports programs that attempt
to use the removed sysctl.

It would help if your change description had a reason why we don't want
to warn people that a program has used a removed system call.

Probably something like:

  We have been warning about people using the sysctl system call for years
  and believe there are no more users.  Even if there are users of this
  interface if they have not complained or fixed their code by now they
  probably are not going to, so there is no point in warning them any
  longer.

With a change like that made to the patch description.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>


> Delete the code and return -ENOSYS directly at the function entry
>
> Signed-off-by: Xiaoming Ni <nixiaoming@huawei.com>
> ---
>  kernel/sysctl_binary.c | 146 +------------------------------------------------
>  1 file changed, 2 insertions(+), 144 deletions(-)
>
> diff --git a/kernel/sysctl_binary.c b/kernel/sysctl_binary.c
> index 7d550cc..41a88f8 100644
> --- a/kernel/sysctl_binary.c
> +++ b/kernel/sysctl_binary.c
> @@ -1,126 +1,11 @@
>  // SPDX-License-Identifier: GPL-2.0
> -#include <linux/stat.h>
>  #include <linux/sysctl.h>
> -#include "../fs/xfs/xfs_sysctl.h"
> -#include <linux/sunrpc/debug.h>
> -#include <linux/string.h>
>  #include <linux/syscalls.h>
> -#include <linux/namei.h>
> -#include <linux/mount.h>
> -#include <linux/fs.h>
> -#include <linux/nsproxy.h>
> -#include <linux/pid_namespace.h>
> -#include <linux/file.h>
> -#include <linux/ctype.h>
> -#include <linux/netdevice.h>
> -#include <linux/kernel.h>
> -#include <linux/uuid.h>
> -#include <linux/slab.h>
>  #include <linux/compat.h>
>  
> -static ssize_t binary_sysctl(const int *name, int nlen,
> -	void __user *oldval, size_t oldlen, void __user *newval, size_t newlen)
> -{
> -	return -ENOSYS;
> -}
> -
> -static void deprecated_sysctl_warning(const int *name, int nlen)
> -{
> -	int i;
> -
> -	/*
> -	 * CTL_KERN/KERN_VERSION is used by older glibc and cannot
> -	 * ever go away.
> -	 */
> -	if (nlen >= 2 && name[0] == CTL_KERN && name[1] == KERN_VERSION)
> -		return;
> -
> -	if (printk_ratelimit()) {
> -		printk(KERN_INFO
> -			"warning: process `%s' used the deprecated sysctl "
> -			"system call with ", current->comm);
> -		for (i = 0; i < nlen; i++)
> -			printk(KERN_CONT "%d.", name[i]);
> -		printk(KERN_CONT "\n");
> -	}
> -	return;
> -}
> -
> -#define WARN_ONCE_HASH_BITS 8
> -#define WARN_ONCE_HASH_SIZE (1<<WARN_ONCE_HASH_BITS)
> -
> -static DECLARE_BITMAP(warn_once_bitmap, WARN_ONCE_HASH_SIZE);
> -
> -#define FNV32_OFFSET 2166136261U
> -#define FNV32_PRIME 0x01000193
> -
> -/*
> - * Print each legacy sysctl (approximately) only once.
> - * To avoid making the tables non-const use a external
> - * hash-table instead.
> - * Worst case hash collision: 6, but very rarely.
> - * NOTE! We don't use the SMP-safe bit tests. We simply
> - * don't care enough.
> - */
> -static void warn_on_bintable(const int *name, int nlen)
> -{
> -	int i;
> -	u32 hash = FNV32_OFFSET;
> -
> -	for (i = 0; i < nlen; i++)
> -		hash = (hash ^ name[i]) * FNV32_PRIME;
> -	hash %= WARN_ONCE_HASH_SIZE;
> -	if (__test_and_set_bit(hash, warn_once_bitmap))
> -		return;
> -	deprecated_sysctl_warning(name, nlen);
> -}
> -
> -static ssize_t do_sysctl(int __user *args_name, int nlen,
> -	void __user *oldval, size_t oldlen, void __user *newval, size_t newlen)
> -{
> -	int name[CTL_MAXNAME];
> -	int i;
> -
> -	/* Check args->nlen. */
> -	if (nlen < 0 || nlen > CTL_MAXNAME)
> -		return -ENOTDIR;
> -	/* Read in the sysctl name for simplicity */
> -	for (i = 0; i < nlen; i++)
> -		if (get_user(name[i], args_name + i))
> -			return -EFAULT;
> -
> -	warn_on_bintable(name, nlen);
> -
> -	return binary_sysctl(name, nlen, oldval, oldlen, newval, newlen);
> -}
> -
>  SYSCALL_DEFINE1(sysctl, struct __sysctl_args __user *, args)
>  {
> -	struct __sysctl_args tmp;
> -	size_t oldlen = 0;
> -	ssize_t result;
> -
> -	if (copy_from_user(&tmp, args, sizeof(tmp)))
> -		return -EFAULT;
> -
> -	if (tmp.oldval && !tmp.oldlenp)
> -		return -EFAULT;
> -
> -	if (tmp.oldlenp && get_user(oldlen, tmp.oldlenp))
> -		return -EFAULT;
> -
> -	result = do_sysctl(tmp.name, tmp.nlen, tmp.oldval, oldlen,
> -			   tmp.newval, tmp.newlen);
> -
> -	if (result >= 0) {
> -		oldlen = result;
> -		result = 0;
> -	}
> -
> -	if (tmp.oldlenp && put_user(oldlen, tmp.oldlenp))
> -		return -EFAULT;
> -
> -	return result;
> +	return -ENOSYS;
>  }
>  
>  
> @@ -138,34 +23,7 @@ struct compat_sysctl_args {
>  
>  COMPAT_SYSCALL_DEFINE1(sysctl, struct compat_sysctl_args __user *, args)
>  {
> -	struct compat_sysctl_args tmp;
> -	compat_size_t __user *compat_oldlenp;
> -	size_t oldlen = 0;
> -	ssize_t result;
> -
> -	if (copy_from_user(&tmp, args, sizeof(tmp)))
> -		return -EFAULT;
> -
> -	if (tmp.oldval && !tmp.oldlenp)
> -		return -EFAULT;
> -
> -	compat_oldlenp = compat_ptr(tmp.oldlenp);
> -	if (compat_oldlenp && get_user(oldlen, compat_oldlenp))
> -		return -EFAULT;
> -
> -	result = do_sysctl(compat_ptr(tmp.name), tmp.nlen,
> -			   compat_ptr(tmp.oldval), oldlen,
> -			   compat_ptr(tmp.newval), tmp.newlen);
> -
> -	if (result >= 0) {
> -		oldlen = result;
> -		result = 0;
> -	}
> -
> -	if (compat_oldlenp && put_user(oldlen, compat_oldlenp))
> -		return -EFAULT;
> -
> -	return result;
> +	return -ENOSYS;
>  }
>  
>  #endif /* CONFIG_COMPAT */

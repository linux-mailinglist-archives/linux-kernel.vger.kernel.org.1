Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD6A2DC21A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726459AbgLPOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:24:32 -0500
Received: from relay.sw.ru ([185.231.240.75]:42752 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725550AbgLPOYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:24:32 -0500
Received: from [192.168.15.178]
        by relay3.sw.ru with esmtp (Exim 4.94)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1kpXi4-00DHGG-90; Wed, 16 Dec 2020 17:23:20 +0300
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
To:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com,
        Christian Brauner <christian.brauner@ubuntu.com>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
 <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
 <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
Date:   Wed, 16 Dec 2020 17:23:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.12.2020 16:32, Mike Galbraith wrote:
> On Wed, 2020-12-16 at 15:35 +0300, Kirill Tkhai wrote:
>> Hi, Alexander,
>>
>> On 16.12.2020 14:02, Mike Galbraith wrote:
>>> Greetings,
>>>
>>> With this commit, bisected and confirmed, kdump stops working here,
>>> makedumpfile saying "check_release: Can't get the kernel version".
>>
>> hasn't your commit 55d9e11398a4 "kdump: append uts_namespace.name offset to VMCOREINFO"
>> fixed this issue?
> 
> FWIW, I applied the below, but it didn't help.
> 
> ---
>  kernel/crash_core.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/kernel/crash_core.c
> +++ b/kernel/crash_core.c
> @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_
>  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> 
>  	VMCOREINFO_SYMBOL(init_uts_ns);
> +	VMCOREINFO_OFFSET(uts_namespace, name);
>  	VMCOREINFO_SYMBOL(node_online_map);
>  #ifdef CONFIG_MMU
>  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);

As I see, makedumpfile hardcodes recent supported kernel version.
(I downloaded makedumpfile from here: https://github.com/makedumpfile/makedumpfile)

#define LATEST_VERSION          KERNEL_VERSION(5, 9, 4) /* linux-5.9.4 */
int32_t         
get_kernel_version(char *release)
{
	...
        if ((version < OLDEST_VERSION) || (LATEST_VERSION < version)) {
                MSG("The kernel version is not supported.\n");
                MSG("The makedumpfile operation may be incomplete.\n");
        }
	...
}

So, in case of you revert the patch, makedumpfile also should fail:

root@qemu:~# ./makedumpfile/makedumpfile -g VMCOREINFO -x ./vmlinux 
The kernel version is not supported.
The makedumpfile operation may be incomplete.

The vmcoreinfo is saved to VMCOREINFO.

makedumpfile Completed.

Does this regression only cause that one error message "check_release: Can't get the kernel version"
is printed instead of another: "The kernel version is not supported."?

Kirill

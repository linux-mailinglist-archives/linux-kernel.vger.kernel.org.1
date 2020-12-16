Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 489EF2DC220
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 15:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLPO0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 09:26:34 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:47956 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPO0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 09:26:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kpXkV-0006dp-LP; Wed, 16 Dec 2020 14:25:51 +0000
Date:   Wed, 16 Dec 2020 15:25:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
Message-ID: <20201216142550.lhmksmdoovivylrz@wittgenstein>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
 <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
 <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
 <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 05:23:30PM +0300, Kirill Tkhai wrote:
> On 16.12.2020 16:32, Mike Galbraith wrote:
> > On Wed, 2020-12-16 at 15:35 +0300, Kirill Tkhai wrote:
> >> Hi, Alexander,
> >>
> >> On 16.12.2020 14:02, Mike Galbraith wrote:
> >>> Greetings,
> >>>
> >>> With this commit, bisected and confirmed, kdump stops working here,
> >>> makedumpfile saying "check_release: Can't get the kernel version".
> >>
> >> hasn't your commit 55d9e11398a4 "kdump: append uts_namespace.name offset to VMCOREINFO"
> >> fixed this issue?
> > 
> > FWIW, I applied the below, but it didn't help.
> > 
> > ---
> >  kernel/crash_core.c |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > --- a/kernel/crash_core.c
> > +++ b/kernel/crash_core.c
> > @@ -447,6 +447,7 @@ static int __init crash_save_vmcoreinfo_
> >  	VMCOREINFO_PAGESIZE(PAGE_SIZE);
> > 
> >  	VMCOREINFO_SYMBOL(init_uts_ns);
> > +	VMCOREINFO_OFFSET(uts_namespace, name);
> >  	VMCOREINFO_SYMBOL(node_online_map);
> >  #ifdef CONFIG_MMU
> >  	VMCOREINFO_SYMBOL_ARRAY(swapper_pg_dir);
> 
> As I see, makedumpfile hardcodes recent supported kernel version.
> (I downloaded makedumpfile from here: https://github.com/makedumpfile/makedumpfile)
> 
> #define LATEST_VERSION          KERNEL_VERSION(5, 9, 4) /* linux-5.9.4 */
> int32_t         
> get_kernel_version(char *release)
> {
> 	...
>         if ((version < OLDEST_VERSION) || (LATEST_VERSION < version)) {
>                 MSG("The kernel version is not supported.\n");
>                 MSG("The makedumpfile operation may be incomplete.\n");
>         }
> 	...
> }
> 
> So, in case of you revert the patch, makedumpfile also should fail:
> 
> root@qemu:~# ./makedumpfile/makedumpfile -g VMCOREINFO -x ./vmlinux 
> The kernel version is not supported.
> The makedumpfile operation may be incomplete.
> 
> The vmcoreinfo is saved to VMCOREINFO.
> 
> makedumpfile Completed.
> 
> Does this regression only cause that one error message "check_release: Can't get the kernel version"
> is printed instead of another: "The kernel version is not supported."?

(I take it you're debugging this now, Kirill. Thank you!)

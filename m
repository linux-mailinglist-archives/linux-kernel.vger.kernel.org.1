Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A42DC343
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Dec 2020 16:39:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgLPPin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 10:38:43 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50434 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgLPPim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 10:38:42 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kpYsI-0003Ul-Su; Wed, 16 Dec 2020 15:37:59 +0000
Date:   Wed, 16 Dec 2020 16:37:50 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, egorenar@linux.ibm.com
Subject: Re: regression: 9a56493f6942 "uts: Use generic ns_common::count"
 broke makedumpfile 1.6.7
Message-ID: <20201216153750.2ffhyo76uie33xfg@wittgenstein>
References: <7b13506084a015d0256222cdd278fe461cdd4a74.camel@gmx.de>
 <6933cde2-7d43-7d7e-066c-1c4a13c752dd@virtuozzo.com>
 <ad3bfa510282d3122069dafe98666aa2d6b5b0ff.camel@gmx.de>
 <60200005-a9a2-4994-b730-e22fd8f01ae4@virtuozzo.com>
 <19b5ee604512d09bc4b059b7e59d73681937048a.camel@gmx.de>
 <c3132ac7e0536a30aefc833df16f5a24de7e4529.camel@gmx.de>
 <61ae6135-dca7-db73-f048-0a35f69cb5c4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <61ae6135-dca7-db73-f048-0a35f69cb5c4@virtuozzo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 16, 2020 at 06:20:36PM +0300, Kirill Tkhai wrote:
> On 16.12.2020 17:49, Mike Galbraith wrote:
> > On Wed, 2020-12-16 at 15:31 +0100, Mike Galbraith wrote:
> >> On Wed, 2020-12-16 at 17:23 +0300, Kirill Tkhai wrote:
> >>>
> >>> Does this regression only cause that one error message "check_release: Can't get the kernel version"
> >>> is printed instead of another: "The kernel version is not supported."?
> >>
> >> The thing does indeed mutter about the kernel version, with or without
> >> 9a56493f6942 reverted, but it work despite the muttering with
> >> 9a56493f6942 reverted.
> > 
> > makedumpfile 1.6.7 source only claims to work up to linux-5.4.8, but
> > actually does work all the way up until 9a56493f6942.
> > 
> > If the answer here is that v1,6,7 has reached EOL, that's fine, I'll
> > just carry a revert until I can cobble together an updated package.
> 
> I think, since there is no a makedumpfile version working, this is a regression,
> and it should be workarounded it in kernel.
> 
> We may consider a patch like the below till updated makedumpfile is not published:
> 
> diff --git a/include/linux/utsname.h b/include/linux/utsname.h
> index 2b1737c9b244..d6bcad448f52 100644
> --- a/include/linux/utsname.h
> +++ b/include/linux/utsname.h
> @@ -8,6 +8,7 @@
>  #include <linux/ns_common.h>
>  #include <linux/err.h>
>  #include <uapi/linux/utsname.h>
> +#include <linux/kref.h>
>  
>  enum uts_proc {
>  	UTS_PROC_OSTYPE,
> @@ -21,6 +22,7 @@ struct user_namespace;
>  extern struct user_namespace init_user_ns;
>  
>  struct uts_namespace {
> +	struct kref unused;
>  	struct new_utsname name;
>  	struct user_namespace *user_ns;
>  	struct ucounts *ucounts;

I'm not sure we really want to do that especially if the tool claims
that it's only supposed to work up to 5.4.8. But if we go down this
route then there should be a comment why this kref unused thing is
there.

Christian

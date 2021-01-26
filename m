Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F50303146
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 02:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbhAZBaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 20:30:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:58742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731346AbhAZB1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 20:27:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FF9923105;
        Tue, 26 Jan 2021 01:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1611624407;
        bh=y/fXhdD3swirdWFjIq9hYlSWOGNcaO0RMCIn6wGW60Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=myNDR6H83dMFO9Zk/+tJiKst4K05kAtBZuymdWXDKVyU/Szam31RD2iRK6NjmoA+T
         49RKgrQSwGQbu2dawlDoZZSzthwUHWQ2xj5qjqZOHx1UC8PxQIcvYAdCZe7SoNLdSR
         hbVjUEbG2pkRTGfC9GS/LIsF82bwJJ1PJ77iSkhY=
Date:   Mon, 25 Jan 2021 17:26:46 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     <christian.brauner@ubuntu.com>, <tglx@linutronix.de>,
        <areber@redhat.com>, <thomascedeno@google.com>,
        <Nicolas.Viennot@twosigma.com>, <walken@google.co>,
        <viresh.kumar@linaro.org>, <liao.pingfang@zte.com.cn>,
        <mchristi@redhat.com>, <viro@zeniv.linux.org.uk>,
        <linux@rasmusvillemoes.dk>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] kernel/sys.c: Remove unused including
 <linux/version.h>
Message-Id: <20210125172646.41f1767ceea28fc9a024f0d2@linux-foundation.org>
In-Reply-To: <1611578869-43453-1-git-send-email-zou_wei@huawei.com>
References: <1611578869-43453-1-git-send-email-zou_wei@huawei.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Jan 2021 20:47:49 +0800 Zou Wei <zou_wei@huawei.com> wrote:

> Fix the following versioncheck warning:
> 
> kernel/sys.c:42:1: unused including <linux/version.h>
> 
> ...
>
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -39,7 +39,6 @@
>  #include <linux/mount.h>
>  #include <linux/gfp.h>
>  #include <linux/syscore_ops.h>
> -#include <linux/version.h>
>  #include <linux/ctype.h>
>  #include <linux/syscall_user_dispatch.h>
>  

x86 allnoconfig:

kernel/sys.c: In function override_release:
kernel/sys.c:1244:7: error: LINUX_VERSION_PATCHLEVEL undeclared (first use in this function)
   v = LINUX_VERSION_PATCHLEVEL + 60;
       ^~~~~~~~~~~~~~~~~~~~~~~~


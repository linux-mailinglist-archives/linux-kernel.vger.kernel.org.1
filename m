Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A682D1156
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 14:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgLGNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 08:05:35 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34206 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725779AbgLGNFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 08:05:34 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kmGCB-00065A-87; Mon, 07 Dec 2020 13:04:51 +0000
Date:   Mon, 7 Dec 2020 14:04:49 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Christian Brauner <christian@brauner.io>,
        linux-kernel@vger.kernel.org, Tycho Andersen <tycho@tycho.ws>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Serge Hallyn <serge@hallyn.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] signal: propagate __user annotations properly
Message-ID: <20201207130449.nbt23aholqebbvux@wittgenstein>
References: <20201207123610.18246-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207123610.18246-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:36:10PM +0100, Lukas Bulwahn wrote:
> Commit 3eb39f47934f ("signal: add pidfd_send_signal() syscall") introduced
> copy_siginfo_from_user_any(), but missed to add the __user annotation to
> the user pointer that is passed as second argument.
> 
> Hence, when copy_siginfo_from_user_any() calls copy_siginfo_from_user(),
> sparse warns:
> 
>   kernel/signal.c:3716:46: warning: incorrect type in argument 2 (different address spaces)
>   kernel/signal.c:3716:46:    expected struct siginfo const [noderef] [usertype] __user *from
>   kernel/signal.c:3716:46:    got struct siginfo [usertype] *info
> 
> And when pidfd_send_signal() calls copy_siginfo_from_user_any(), sparse
> warns as well:
> 
>   kernel/signal.c:3776:58: warning: incorrect type in argument 2 (different address spaces)
>   kernel/signal.c:3776:58:    expected struct siginfo [usertype] *info
>   kernel/signal.c:3776:58:    got struct siginfo [noderef] [usertype] __user *info
> 
> Add the __user annotation to repair this chain of propagating __user
> annotations.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> applies cleanly on current master (v5.10-rc7) and next-20201204
> 
> Christian, please pick this minor non-urgent clean-up patch.

Thanks for the patch. Unfortunately I already picked up Jann's patch who
sent it yesterday or this morning:
https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/commit/?h=pidfd

Thanks!
Christian

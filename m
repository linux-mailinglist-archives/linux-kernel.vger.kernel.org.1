Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183352D0E0D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgLGKdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:33:16 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:58484 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbgLGKdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:33:15 -0500
Received: from ip5f5af0a0.dynamic.kabel-deutschland.de ([95.90.240.160] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1kmDom-00045N-42; Mon, 07 Dec 2020 10:32:32 +0000
Date:   Mon, 7 Dec 2020 11:32:30 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Jann Horn <jannh@google.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH pidfd] signal: Add missing __user annotation to
 copy_siginfo_from_user_any
Message-ID: <20201207103230.inx52blkask3662j@wittgenstein>
References: <20201207000252.138564-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201207000252.138564-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 01:02:52AM +0100, Jann Horn wrote:
> copy_siginfo_from_user_any() takes a userspace pointer as second
> argument; annotate the parameter type accordingly.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---
> I'm messing around with clang's version of __user annotation checking
> and it spotted this issue:
> 
> kernel/signal.c:3759:44: warning: casting to dereferenceable pointer removes 'noderef' attribute [-Wnoderef]
>                 ret = copy_siginfo_from_user_any(&kinfo, info);
>                                                          ^~~~
> Untracked cast to function pointer at kernel/signal.c:4294:26
> 
> 
> Christian, since this is pidfd code, can you take this through your tree?
> Or should I send this to akpm (or someone else)?

I'm picking it up now. :) Thanks!

Christian

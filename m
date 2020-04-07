Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1681A113A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgDGQWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 12:22:17 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56038 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727582AbgDGQWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 12:22:17 -0400
Received: from ip5f5bf7ec.dynamic.kabel-deutschland.de ([95.91.247.236] helo=wittgenstein)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <christian.brauner@ubuntu.com>)
        id 1jLqzN-0007M8-Uz; Tue, 07 Apr 2020 16:22:14 +0000
Date:   Tue, 7 Apr 2020 18:22:13 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexey Gladkov <gladkov.alexey@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>
Subject: Re: [RFC][PATCH 0/3] exec_update_mutex related cleanups
Message-ID: <20200407162213.tgdjzgzwrebqxchc@wittgenstein>
References: <87blobnq02.fsf@x220.int.ebiederm.org>
 <CAHk-=wgYCUbEmwieOBzVNZbSAM9wCZA8Z0665onpNnEcC-UpDg@mail.gmail.com>
 <AM6PR03MB5170B606F9AC663225EC9609E4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=whM3r7zrm8mSi7HJhuZbYiXx9PFU5VQYeKm6Low=r15eQ@mail.gmail.com>
 <AM6PR03MB517003D5965F48AC5FE7283DE4C60@AM6PR03MB5170.eurprd03.prod.outlook.com>
 <CAHk-=wg5LvjumW9PVQiF7jB8yig98K8XTk4tHo9W-sYmxzW+9g@mail.gmail.com>
 <87lfnda3w3.fsf@x220.int.ebiederm.org>
 <CAHk-=wjuv_J+2KOi+Fhr_nBKYf5CXr76DQKThA3uxXm3rCC3Uw@mail.gmail.com>
 <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87wo6s3wxd.fsf_-_@x220.int.ebiederm.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 08:29:50PM -0500, Eric W. Biederman wrote:
> 
> Linus,
> 
> Since you rightly pointed out the code in fs/exec.c is less readable
> than it should be right now.  Here is where I currently sit on making
> that code static where possible and as obvious as possible.
> 
> I will resend this after the merge window for a proper review when
> people are less likely to be distrcacted but I figured I might as well
> send this out now so I can see if anyone runs screaming from this code.
> 
> Eric W. Biederman (3):
>       binfmt: Move install_exec_creds after setup_new_exec to match binfmt_elf
>       exec: Make unlocking exec_update_mutex explict
>       exec: Rename the flag called_exec_mmap point_of_no_return

Under the assumption that we go forward with this approach this seems
like a good cleanup.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>

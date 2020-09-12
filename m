Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772A22678AC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgILHyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:54:10 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45646 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgILHyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:54:06 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 08D8629B631
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     luto@kernel.org, tglx@linutronix.de, hpa@zytor.com, bp@alien8.de,
        rric@kernel.org, peterz@infradead.org, mingo@redhat.com,
        x86@kernel.org, linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH 2/6] x86: Simplify compat syscall userspace allocation
Organization: Collabora
References: <20200912070553.330622-1-krisman@collabora.com>
        <20200912070553.330622-3-krisman@collabora.com>
        <20200912070802.GA19621@lst.de>
Date:   Sat, 12 Sep 2020 03:54:01 -0400
In-Reply-To: <20200912070802.GA19621@lst.de> (Christoph Hellwig's message of
        "Sat, 12 Sep 2020 09:08:02 +0200")
Message-ID: <87zh5vmnvq.fsf@collabora.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> On Sat, Sep 12, 2020 at 03:05:49AM -0400, Gabriel Krisman Bertazi wrote:
>> When allocating user memory space for a compat system call, don't
>> consider whether the originating code is IA32 or X32, just allocate from
>> a safe region for both, beyond the redzone.  This should be safe for
>> IA32, and has the benefit of avoiding TIF_IA32, which we want to drop.
>
> This doesn't look wrong, by why bother (maybe Ccing me on the whole
> seris as you always should instead of sending annoying out of context
> single patches would have told..).

Hi Chris,

Thanks for the quick reply. sorry and I will make sure to cc you for the
rest of the series if this spin again.  The reason is the removal of
TIF_IA32 to reclaim some bits in the ti flags.

If you want to see the rest of it immediately: <https://lkml.org/lkml/2020/9/12/28>

> We will hopefully kill off compat_alloc_user_space in the next few
> merge windows..

I plan to kill TIF_IA32 hopefully in the next merge window, to
facilitate other work I'm doing and I wouldn't like to wait for other
stuff, since this is trivial enough.  Can I get your reviewed-by here?

Thanks,

-- 
Gabriel Krisman Bertazi

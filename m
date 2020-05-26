Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11051A8F8A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 02:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392269AbgDOAId (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 20:08:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:35608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392264AbgDOAI2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 20:08:28 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 949782076B;
        Wed, 15 Apr 2020 00:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586909307;
        bh=cdX73dCi301I9IaDllfT9erksCJfp1wTJ5tC0x+WiuA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=2mGwezel0ZXkJr4sx2a0wDhInI7pjl5enz3UaaoGYhfXZ/wUoVmUbTrcMwRxXw1jv
         fPXjR/bmvr/56sm7nrV2qyYWd7Npe3LuzHY44neC3rTOdwDK4OxAcn95d5EC4SoJl7
         /Nu4RdF2mi2gnU/YXKDoSs10B1MsP9DDHzpxvpbw=
Date:   Tue, 14 Apr 2020 17:08:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <wsd_upstream@mediatek.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH] mm/gup: fix null pointer dereference detected by
 coverity
Message-Id: <20200414170827.d32fc1fc12a33b140b740b94@linux-foundation.org>
In-Reply-To: <20200407095107.1988-1-miles.chen@mediatek.com>
References: <20200407095107.1988-1-miles.chen@mediatek.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Apr 2020 17:51:07 +0800 Miles Chen <miles.chen@mediatek.com> wrote:

> In fixup_user_fault(), it is possible that unlocked is NULL,
> so we should test unlocked before using it.
> 
> For example, in arch/arc/kernel/process.c, NULL is passed
> to fixup_user_fault().
> 
> SYSCALL_DEFINE3(arc_usr_cmpxchg, int *, uaddr, int, expected, int, new)
> {
> ...
> 	ret = fixup_user_fault(current, current->mm, (unsigned long) uaddr,
> 			       FAULT_FLAG_WRITE, NULL);
> ...
> }

(cc Peter)

> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1230,7 +1230,8 @@ int fixup_user_fault(struct task_struct *tsk, struct mm_struct *mm,
>  	if (ret & VM_FAULT_RETRY) {
>  		down_read(&mm->mmap_sem);
>  		if (!(fault_flags & FAULT_FLAG_TRIED)) {
> -			*unlocked = true;
> +			if (unlocked)
> +				*unlocked = true;
>  			fault_flags |= FAULT_FLAG_TRIED;
>  			goto retry;
>  		}

Not sure.  If the caller passes FAULT_FLAG_ALLOW_RETRY then they must
also pass in a valid non-NULL `unlocked'.  If the caller passed
FAULT_FLAG_ALLOW_RETRY and unlocked==NULL then the resulting oops is an
appropriate way of reporting this mistake.  I think?


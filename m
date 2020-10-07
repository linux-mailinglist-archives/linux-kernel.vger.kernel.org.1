Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F171C286199
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 16:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbgJGOzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 10:55:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34972 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728677AbgJGOzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 10:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602082499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YfwhkGiRrOH1PcwmIuFTvVZZYAlXa4jhrjm0JixaXmc=;
        b=DkQgQbPw1YDjt242yuYHWzgy7sYUUf5ZJSmKRPwPhUBZk0yt0MHkZnJ4hInUIfqMcg/qil
        RroW9N/fwuElMaQkycDL00+tN/GqgRtm6wwDQZI5nkv3CeyVFEMqmcjLqjWYoA17FXysNK
        gtWELB+2Nb92cURCTLoQYnKPVpnl3jc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-138-QylDYpxLMG2OMX3mEuDZTg-1; Wed, 07 Oct 2020 10:54:55 -0400
X-MC-Unique: QylDYpxLMG2OMX3mEuDZTg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92C0F108E1A1;
        Wed,  7 Oct 2020 14:54:54 +0000 (UTC)
Received: from treble (ovpn-113-148.rdu2.redhat.com [10.10.113.148])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D2DC5C1BD;
        Wed,  7 Oct 2020 14:54:53 +0000 (UTC)
Date:   Wed, 7 Oct 2020 09:54:50 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH] x86/unwind/orc: fix inactive tasks with sp in sp
Message-ID: <20201007145450.32yrrq75csmq7vgo@treble>
References: <20201007081909.29226-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201007081909.29226-1-jslaby@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-ENOPARSE on $SUBJECT.

Also please address it to x86@kernel.org, I think the tip maintainers
can pick up the fix directly.

Also it might be a good idea to Cc the live-patching mailing list, I
presume this causes a livepatch stall?

On Wed, Oct 07, 2020 at 10:19:09AM +0200, Jiri Slaby wrote:
> gcc-10 optimizes the scheduler code differently than its predecessors,
> depending on DEBUG_SECTION_MISMATCH=y config -- the config sets
> -fno-inline-functions-called-once.

Weird.  Was GCC ignoring this flag before?

> @@ -663,7 +656,13 @@ void __unwind_start(struct unwind_state *state, struct task_struct *task,
>  	} else {
>  		struct inactive_task_frame *frame = (void *)task->thread.sp;
>  
> -		state->sp = task->thread.sp;
> +		/*
> +		 * @ret_addr is in __schedule _before_ the @frame is pushed to
> +		 * the stack, but @thread.sp is saved in __switch_to_asm only
> +		 * _after_ saving the @frame, so subtract the @frame size, i.e.
> +		 * add it to @thread.sp.
> +		 */
> +		state->sp = task->thread.sp + sizeof(*frame);

IMO, the code speaks for itself and the comment may be superfluous.

Otherwise it looks good to me.  Thanks for fixing it!

-- 
Josh


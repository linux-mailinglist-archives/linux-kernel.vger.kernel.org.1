Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF96292A63
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbgJSP3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgJSP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:29:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C3BC0613CE;
        Mon, 19 Oct 2020 08:29:13 -0700 (PDT)
Date:   Mon, 19 Oct 2020 17:29:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603121351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSA1rgI9oUHNMXQCJ0EHFIg5+7llZCrIXvKF9z6SCbw=;
        b=yvag/1WyE7YGO01tuOZMVDXYJVVbRSZUTTDcNEFrW2Szp/K6KmRMXSdrwwJh0jiFmcGJLY
        8KE6KOMD91iSqyY/CyDUCrqp/hAKY1ILkKnYqLfuhW8O5IW0a9jGHHDikT1fNnfmJ/Fgav
        3C5W0+duxLTiCXtadB7bTetmmPu6616zmO3m0aie/2Hnh9nX8DmrYUIS/byQ9/x1a4ysRF
        oviWNZFtVpiXa0WdOMA1dSkH1t4fzBXGOsEbei86vRflWSjW7Pym78fr/8t/x/6jwgyXCu
        4Kpxjs0IEaN7cXS0MkaOiv08H5Qi3dAv7EW75YhcfDSCCrTfSiPb8yccXJa4KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603121351;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SSA1rgI9oUHNMXQCJ0EHFIg5+7llZCrIXvKF9z6SCbw=;
        b=IQqz/onU2+jf4eNXTVcyVbj2HSt8tXuWdeTBN+hX+PstwLXy8ahJIUMMkGX0/vlc3putCI
        MM5QglGrGXuSwfDw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Mike Galbraith <umgwanakikbuti@gmail.com>, ngupta@vflare.org,
        sergey.senozhatsky.work@gmail.com,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] zram: Fix __zram_bvec_{read,write}() locking order
Message-ID: <20201019152909.rlnhqokqhhauq2kw@linutronix.de>
References: <CABXGCsOL0pW0Ghh-w5d12P75ve6FS9Rgmzm6DvsYbJY-jMTCdg@mail.gmail.com>
 <20201016124009.GQ2611@hirez.programming.kicks-ass.net>
 <20201016153324.GA1976566@google.com>
 <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019101353.GJ2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-19 12:13:53 [+0200], Peter Zijlstra wrote:
> 
> Mikhail reported a lockdep spat detailing how __zram_bvec_read() and
> __zram_bvec_write() use zstrm->lock and zspage->lock in opposite order.
> 
> Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

We have the same patch in RT. I didn't submit it with the other
local-lock patches because this splat pops up once pin_tag() is made a
sleeping lock. I missed the part where migrate_read_lock() can be a
lock. So:

Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

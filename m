Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 515682AC26F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731708AbgKIRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729879AbgKIRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:36:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F51C0613CF;
        Mon,  9 Nov 2020 09:36:01 -0800 (PST)
Date:   Mon, 9 Nov 2020 18:35:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604943359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2dryvWRnKFE9uA4AaRvda1gcxtz4I+yd661Z0CXB6Q=;
        b=B8JBB5n+JAEE7dxBS9h3nrpuXRrWXGVGB9pYFfYM+Jubof/6cUvmN7J58PogD2ne7FSzeb
        28kDtCoDUH1FWuUEg3kWLPHOstsU45pPlg953fWTfOFR7LbaN+k1zM79z1pHPDNO+c/FCZ
        m0SGzvo9MYlFGQrj+hx5iq8VmJXk3jKUGR2kazX0AtolMtId4y+4DL4JNOVsALzLTbROuz
        327wPRPiLu6HNMrrqSkXxya8KFexAsUMLqgy3qQaWQl+Dpo0BpoY8IMYmknFeaM38W6E1R
        CKXwl9QOxcl/iJkcdgRAYToOX6z03Sp+2nGEKlfzpLUO/NqT5MkCxXemNPOTtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604943359;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=v2dryvWRnKFE9uA4AaRvda1gcxtz4I+yd661Z0CXB6Q=;
        b=7GOhd7MjLZMwjD3v/F8UXd/NvM5gKTZWv2LihSySU3W8g7HX10zd9FZBtQpJUmbiaihTZx
        vVjhbMFSE7W+RODw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>, Daniel Wagner <wagi@monom.org>,
        Tom Zanussi <zanussi@kernel.org>,
        "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH RT 2/6] tcp: Remove superfluous BH-disable around
 listening_hash
Message-ID: <20201109173558.ouf25konbwpvp4hi@linutronix.de>
References: <20201107020636.598338441@goodmis.org>
 <20201107020727.806739147@goodmis.org>
 <20201109092231.3t2pawkvv7dxasfs@linutronix.de>
 <20201109120106.4fe828b4@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201109120106.4fe828b4@oasis.local.home>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-11-09 12:01:06 [-0500], Steven Rostedt wrote:
> Note, I took this because it mentioned:
> 
> "Commit
>        9652dc2eb9e40 ("tcp: relax listening_hash operations")
>     
>     removed the need to disable bottom half while acquiring
>     listening_hash.lock. There are still two callers left which disable
>     bottom half before the lock is acquired."
> 
> And that commit was added in 4.10.

Yes. I was aiming to sell this as an optimisation to upstream but that
patch isn't exactly a beauty queen and that optimisation isn't enormous
so they may not want to buy it.
Also: upstream's lockdep isn't complaining here so the alternative route
is to get RT's lockdep to be quiet here as well and then drop that
patch.

Sebastian

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42522B7F50
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgKROYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:24:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726479AbgKROYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:24:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42D4C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 06:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HcSckMJ4nvuu0X/47sgttQL+uAFnUib5cDBIpjcS1ug=; b=qZ/SdaLtCalXtUHVRVHVu0KleG
        RK8xcdEgaPfP7aU/l0JZJm1KOzMiqLh/ZZ3QX4gew+5++SewSID/3mV7CG4On+WiYtH8bvIHGQOST
        I0NUlIcEZgkAvjuJBds539ii7scbxo1q37hB2qwZSSBjXF3nZS9u0AniH5PQFkVnyJjdqKk2le0/Y
        yUq03ohVXDmagqLJH0TEdQDdIWSeMEcolfU+4ah+s3SMkzJ+PrCNMuKokGNLVOtVLhx/illXizYlS
        nSheXft+0pfiN+X4fISqqEWxib4nrc+Bp9+/OEP3CD0WCPTlFEZ4Jl8U8VN0S7jTR2yjuzrn9gbqQ
        Flm9GdKg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kfONK-0003Yj-HO; Wed, 18 Nov 2020 14:23:58 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CF0933012C3;
        Wed, 18 Nov 2020 15:23:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B412820116725; Wed, 18 Nov 2020 15:23:57 +0100 (CET)
Date:   Wed, 18 Nov 2020 15:23:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v3] lockdep: Allow tuning tracing capacity constants.
Message-ID: <20201118142357.GW3121392@hirez.programming.kicks-ass.net>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <384ce711-25c5-553b-8d22-965847132fbd@i-love.sakura.ne.jp>
 <0eb519fa-e77b-b655-724a-4e9eecc64626@i-love.sakura.ne.jp>
 <6933e938-f219-5e13-aee6-fe4de87eb43e@i-love.sakura.ne.jp>
 <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81ab0ffd-6e80-c96c-053a-b1b4fe8694c1@i-love.sakura.ne.jp>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 18, 2020 at 10:57:08PM +0900, Tetsuo Handa wrote:
> Peter, do you have a plan to make this problem actionable?

I don't even know what the problem is.. nor do you. You can keep sending
this bad paper-over-issues patch until you're blue in the face, I'll not
take it for reasons I've explained before.

I've also previously said that the right way to go about this is to
figure out what exactly is consuming these resources and then figure out
how to cure _that_. Blindly increasing the number only enables bad
actors to get away with being bad.

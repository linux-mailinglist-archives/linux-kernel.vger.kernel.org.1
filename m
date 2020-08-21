Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C61924DEBC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 19:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgHURlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 13:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgHURlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:41:44 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B833EC061573;
        Fri, 21 Aug 2020 10:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6BZYjkXJw2hECx4MwMllL13NtAbX5PJwgINVHzD8dEs=; b=HBfIXnbFbKOM5MeWh+6dOLQ3al
        LzUl6SH6xEctUyN2iN8E8qDSk9eYhvqEI1/EZMqC/vgihb65WpE18kGfm3+Wl8kyUO62AgCtqvsBg
        kQzEBobaapdgKirQXRmYBIzhNgOnUEL+Tua9fQlCSpfLZT9oPt6VuPqofmowF72N4s1qPpe9bqYDh
        vyJ0+BMO2LI7KRYviMYeTIv2DZ/eVjOf3fP3rQyG2HlqdYhrurnO7wW5P3RNfH5K4Lm3ohUHMl5uR
        gn80tObV3tp6p0ppQ3sQVepg1+G8wXeJ40hUDZj5unjwQGiN+LMQNIAordLK7q93J6Qms6+3dg4zX
        lvyEaVSQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k9B2n-000299-7z; Fri, 21 Aug 2020 17:41:37 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D33E980DF7; Fri, 21 Aug 2020 19:41:33 +0200 (CEST)
Date:   Fri, 21 Aug 2020 19:41:32 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Waiman Long <longman@redhat.com>
Subject: Re: [RFC v7 14/19] lockdep: Take read/write status in consideration
 when generate chainkey
Message-ID: <20200821174132.GR3982@worktop.programming.kicks-ass.net>
References: <20200807074238.1632519-1-boqun.feng@gmail.com>
 <20200807074238.1632519-15-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200807074238.1632519-15-boqun.feng@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


So far so good, excellent work.

On Fri, Aug 07, 2020 at 03:42:33PM +0800, Boqun Feng wrote:
> @@ -371,6 +371,21 @@ static struct hlist_head classhash_table[CLASSHASH_SIZE];
>  
>  static struct hlist_head chainhash_table[CHAINHASH_SIZE];
>  
> +/*
> + * the id of held_lock
> + */
> +static inline u16 hlock_id(struct held_lock *hlock)
> +{
> +	BUILD_BUG_ON(MAX_LOCKDEP_KEYS_BITS + 2 > 16);
> +
> +	return (hlock->class_idx | (hlock->read << MAX_LOCKDEP_KEYS_BITS));
> +}
> +
> +static inline unsigned int chain_hlock_class_idx(u16 hlock_id)
> +{
> +	return hlock_id & MAX_LOCKDEP_KEYS;

But did that want to be:

	return hlock_id & (MAX_LOCKDEP_KEYS-1);

?

> +}

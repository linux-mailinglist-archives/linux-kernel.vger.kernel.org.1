Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E96D62A6325
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 12:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729678AbgKDLRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 06:17:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48670 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729616AbgKDLRd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 06:17:33 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604488648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lc46Rd9wCuf9yAM3x0VKjRoapHGrztvOKUbPr8Ji7E=;
        b=cO2ZF0wwv9S0cKsVczS3IlOIfnKxt1HkxQVk5uvfxYDhOuVYIWxSGp1kuFtWX76T18qsjX
        hB7J94xcYaJqB+ORmCbkLyhQfKnxqQDUDVuxZgafVeyEtEpTZS1Yu/RCPv0c/ftZRLoi4B
        gFxgkCBSyTfMADAUDhKcg43UfS550sNrwxtf8s1J3LKE0uKeYaTNDm/nkYO+hp3xP5Qn0k
        Qc7p+FEa30cjAjyOdb0Zm9Zmc4VuE3+v7XgtO9Be9RWAm9b5e8BabDp52zLkSQja76bBvK
        H+/YEPEqq84hMi52VV3kNBTzaRg3D89YWqT6GDKVLLGXHaArGwcafPgBPILTXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604488648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1lc46Rd9wCuf9yAM3x0VKjRoapHGrztvOKUbPr8Ji7E=;
        b=ktTTc5QEuhm/ecR+uDBY6KbenTPsRh9aO5iQN0v/VhZwDpxz4ozua95XP7fQfPtYQ9mbeM
        Dn5AlhgWk5shKsCA==
To:     Mike Galbraith <efault@gmx.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: BUG_ON(!newowner) in fixup_pi_state_owner()
In-Reply-To: <874km5mnbf.fsf@nanos.tec.linutronix.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com> <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de> <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de> <874km5mnbf.fsf@nanos.tec.linutronix.de>
Date:   Wed, 04 Nov 2020 12:17:28 +0100
Message-ID: <871rh9mkvr.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 04 2020 at 11:24, Thomas Gleixner wrote:
> On Wed, Nov 04 2020 at 08:42, Mike Galbraith wrote:
>> On Wed, 2020-11-04 at 01:56 +0100, Mike Galbraith wrote:
>> --- a/kernel/futex.c
>> +++ b/kernel/futex.c
>> @@ -2383,7 +2383,18 @@ static int fixup_pi_state_owner(u32 __us
>>  		 * Since we just failed the trylock; there must be an owner.
>>  		 */
>>  		newowner = rt_mutex_owner(&pi_state->pi_mutex);
>> -		BUG_ON(!newowner);
>> +
>> +		/*
>> +		 * Why? Because I know what I'm doing with these beasts?  Nope,
>> +		 * but what the hell, a busy restart loop let f_boosted become
>> +		 * owner, so go for it. Box still boots, works, no longer makes
>> +		 * boom with fbomb_v2, and as an added bonus, didn't even blow
>> +		 * futextests all up.  Maybe it'll help... or not, we'll see.
>> +		 */
>> +		if (unlikely(!newowner)) {
>> +			err = -EAGAIN;
>> +			goto handle_err;
>
> Yes, that cures it, but does not really explain why newowner is
> NULL. Lemme stare more.

Aside of that it's going to create inconsistent state in the worst
case. There is something really fishy in the trace Gratian provided....

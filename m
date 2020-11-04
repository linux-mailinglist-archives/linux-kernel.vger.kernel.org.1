Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02C22A6A6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 17:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731810AbgKDQus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 11:50:48 -0500
Received: from mout.gmx.net ([212.227.15.19]:40677 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731764AbgKDQuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 11:50:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604508621;
        bh=a8xcy7k7OAoCLMxIFLMY6hOiExRZJifNzzJndA+GmOg=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=JWmfABcV59BaobLbCSH/Ii7sY46VaI7tVGY2o/FtObofBnaRvkzoFKpENp48SAeXG
         tcmuGuo3Ch/sHxxjozD5zOxe3Wt07KkY86watpLWCrbpdwhfkf51uJBhms5z4fvINH
         hv3+4M7yhmc8S32LIG6M6mmxjkfXQRejX3xmUWXk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from homer.fritz.box ([185.221.148.80]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1jwdSu3FhY-00mfL7; Wed, 04
 Nov 2020 17:50:20 +0100
Message-ID: <3fa8a9a3e447b7216610b01a31310ef1f9f7cd69.camel@gmx.de>
Subject: Re: [PATCH] futex: Handle transient "ownerless" rtmutex state
 correctly
From:   Mike Galbraith <efault@gmx.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Gratian Crisan <gratian.crisan@ni.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org,
        Brandon Streiff <brandon.streiff@ni.com>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        James Minor <james.minor@ni.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date:   Wed, 04 Nov 2020 17:50:20 +0100
In-Reply-To: <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
References: <87a6w6x7bb.fsf@ni.com> <878sbixbk4.fsf@ni.com>
         <2376f4e71c638aee215a4911e5efed14c5adf56e.camel@gmx.de>
         <5f536491708682fc3b86cb5b7bc1e05ffa3521e7.camel@gmx.de>
         <874km5mnbf.fsf@nanos.tec.linutronix.de>
         <871rh9mkvr.fsf@nanos.tec.linutronix.de>
         <87v9ell0cn.fsf@nanos.tec.linutronix.de>
         <a9e88887c027b11596cd7fb96c425011c36e5d29.camel@gmx.de>
         <87sg9pkvf7.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.34.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3Be43IoHgozZduYyg8KHi8muOQYyFkuTJRKr0i/RHPxKSKfSoBf
 m3bTBvVKMjmNhYhf3/3d7S1DDc0rlrHwghYLNkKJDbF8851wFMB1gZPJvbGjycsYhwVJg28
 wtRp+ydPeJFbCVp8u0kiEfAQ/srw4AKlBDbRKO6aIdYC6N7c51590qV0EE5L918oYaWEQW1
 jnC+a4rG8LiGCz2+JUkSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:1H9IYpapMlk=:q6FZXjlHWnMei6TxINLLPF
 bpAu6HzneXJvdcb7wW1XXvpwFazNSZOHk0aUFpPJ/IrPyAzLn9vCmxBDtO6KbyMq++xmAoMr8
 c3k4ldRo38tTppJJ5685OgVes3wH7IeLLo7NCHQDknDTffJl2gryIqlpvz7ArN8EHVO/fAf7K
 RQ5nwav0x5/3AeurGEHusPenvdUFDq5jctyTZnKZyzuQ48nXLgZriaeIfvti9vqLvKA0q1JU/
 R8OuXWUPvVxsxuLN6278n7ODqDrupuRG7hQ0rKSOLHI3gxsk7zcXChx1aY+4Jm2AhMxVIngq5
 7zFsUPhvjd6Zi5J30VcS7ok+3Bmr+vZeSgeqQFx9SiCNKqdFxTmbYFX/FqHk7KmLBR0c2wCDw
 gyRpJ5FN6pLXPQn02wPW3izgqLl71X7HYDDMvpAkFXbb+QojbMTtHv8eagmx1oc4jlkwvHHbn
 qczMlMOOVM0F3OYkqxyQKXc7ynzzOB27dAdpNMd11Kh+jGUMt2Sp1oRAq14tnR0sZjK/2MiWm
 arI647YNbElWmWxtXFSew4uCtoXsdyz8BkD/eBelbQzy36GNJ+BAv4TerQbN2gNVoWxo8L9Gm
 5qlAqww4OGKal0Zq8YPwCqXDcMnOO4CRVLjbufJOciyHFtDrxuKv0Bvhurwp/zNlu5d+depjH
 YdoZDiPAqah4/Dql8L5Zz5VcdSn9ghB8fMSEpx4Zsmr89YlgVIMh4etDavXA8rh2YLQ2iG37B
 aequYpmWzCNYV5A/AU8a7VraCz2U2aFezD9q2DqSHLBNKlDlgOXsn5cmdt/naH7osQcHOR4Yw
 jXtSFhp5iYZKBlmrA0OiHODX7hT7HfHK86qAPh2Ialt9zodurU93B0N2I1DRdo1JeDt4RAB6U
 xfYQXiPLkzOYD+aKL4og==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-04 at 16:12 +0100, Thomas Gleixner wrote:
> From: Mike Galbraith <efault@gmx.de>

Hrmph.  How about a suggested-by, or just take it.  That dinky diag hit
the mark (not _entirely_ by accident, but..;) is irrelevant, you did
all of the work to make it a patch.

	-Mike

> Gratian managed to trigger the BUG_ON(!newowner) in fixup_pi_state_owner=
().
> This is one possible chain of events leading to this:
>
> Task Prio       Operation
> T1   120	lock(F)
> T2   120	lock(F)   -> blocks (top waiter)
> T3   50 (RT)	lock(F)   -> boosts T3 and blocks (new top waiter)
> XX   		timeout/  -> wakes T2
> 		signal
> T1   50		unlock(F) -> wakes T3 (rtmutex->owner =3D=3D NULL, waiter bit i=
s set)
> T2   120	cleanup   -> try_to_take_mutex() fails because T3 is the top wa=
iter
>      			     and the lower priority T2 cannot steal the lock.
>      			  -> fixup_pi_state_owner() sees newowner =3D=3D NULL -> BUG_ON(=
)
>
> The comment states that this is invalid and rt_mutex_real_owner() must
> return a non NULL owner when the trylock failed, but in case of a queued
> and woken up waiter rt_mutex_real_owner() =3D=3D NULL is a valid transie=
nt
> state. The higher priority waiter has simply not yet managed to take ove=
r
> the rtmutex.
>
> The BUG_ON() is therefore wrong and this is just another retry condition=
 in
> fixup_pi_state_owner().
>
> Drop the locks, so that T3 can make progress, and then try the fixup aga=
in.
>
> Gratian provided a great analysis, traces and a reproducer. The analysis=
 is
> to the point, but it confused the hell out of that tglx dude who had to
> page in all the futex horrors again. Condensed version is above.
>
> [ tglx: Wrote comment and changelog ]
>
> Fixes: c1e2f0eaf015 ("futex: Avoid violating the 10th rule of futex")
> Reported-by: Gratian Crisan <gratian.crisan@ni.com>
> Signed-off-by: Mike Galbraith <efault@gmx.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: stable@vger.kernel.org
> Link: https://lore.kernel.org/r/87a6w6x7bb.fsf@ni.com
> ---
>  kernel/futex.c |   16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
>
> --- a/kernel/futex.c
> +++ b/kernel/futex.c
> @@ -2380,10 +2380,22 @@ static int fixup_pi_state_owner(u32 __us
>  		}
>
>  		/*
> -		 * Since we just failed the trylock; there must be an owner.
> +		 * The trylock just failed, so either there is an owner or
> +		 * there is a higher priority waiter than this one.
>  		 */
>  		newowner =3D rt_mutex_owner(&pi_state->pi_mutex);
> -		BUG_ON(!newowner);
> +		/*
> +		 * If the higher priority waiter has not yet taken over the
> +		 * rtmutex then newowner is NULL. We can't return here with
> +		 * that state because it's inconsistent vs. the user space
> +		 * state. So drop the locks and try again. It's a valid
> +		 * situation and not any different from the other retry
> +		 * conditions.
> +		 */
> +		if (unlikely(!newowner)) {
> +			ret =3D -EAGAIN;
> +			goto handle_err;
> +		}
>  	} else {
>  		WARN_ON_ONCE(argowner !=3D current);
>  		if (oldowner =3D=3D current) {


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF8B290D64
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728867AbgJPVo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 17:44:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728247AbgJPVo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 17:44:56 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602884693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4Y/Wt7tM2dD+n94ti9omNPIQiGoPI87kFrGJopqis=;
        b=AvnfzyyWAhwaXS8agUNy4fM9ukHCV5Vh4pi/ZXYG4AdsmpNWLP8uaAluacXIgoCA9c7bt+
        Ag+jNB7UdMchJ33W7dLoVC1tFUhi2OuuRhgvJXXUGLXYaYbNEtj6VydgUBjdNusn+BdUqo
        rt3DhQ0o4yhLclLJZPDG6+92+8gCV0i9lIbvAFlQ3YUyEHqHTJiGLvFInqoZvJ9CyTl+0T
        3wNaaLLiXybHcvAswwP/8pU1LaZT8EFf7/gPJ8FXX9QnFwSi54wwzaGjddjddqVche0tiJ
        U2p3rO2HzfomUVsdPPf4NZIrpK1O3HoPlcMMTjmlkb3/lxJzJhXN9egci+suTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602884693;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sw4Y/Wt7tM2dD+n94ti9omNPIQiGoPI87kFrGJopqis=;
        b=CSJc0UzkAtAo29RyuTD/p+Otxpj/XIImHqHBdCxgINsnEN9jVlCQak0k7viWE+usXSc5Ad
        e4N1/tNIbccZ7zAw==
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] task_work: cleanup notification modes
In-Reply-To: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
Date:   Fri, 16 Oct 2020 23:44:53 +0200
Message-ID: <87tuutalre.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 16 2020 at 09:16, Jens Axboe wrote:
> A previous commit changed the notification mode from 0/1 to allowing

No. It changed it from boolean to an int.

There is a fundamental difference between 0/1 and false/true simply
because it's a compiler implementation detail how to represent a boolean
value.

Assume the following:

#define BAZ	0x08

       task_work_add(tsk, &work, foo & BAZ);

So with a function signature of

       task_work_add(*tsk, *work, bool signal);

the above 'foo & BAZ' becomes either true of false.

With the changed function signature of

       task_work_add(*tsk, *work, int signal);

the above becomes the result of 'foo & BAZ' which means that this
construct will not longer do the right thing.

It's pure luck that none of the usage sites relied on the boolean
property of that argument.

Please spell it out correctly that converting a boolean argument to an
integer argument is not equivalent.

>  	switch (notify) {
> +	case TWA_NONE:
> +		break;
>  	case TWA_RESUME:
>  		set_notify_resume(task);
>  		break;

The enum will not prevent that either and what you really want to do is
to have some form of debug warning if 'notify' is out of range, which
would have been the right thing to do in the first place.

> - * @notify: send the notification if true
> + * @notify: send chosen notification, if any

Is that really all you found to be wrong in that comment?

There is more and please take your time which will in turn save time and
nerves on both ends.

Thanks,

        tglx

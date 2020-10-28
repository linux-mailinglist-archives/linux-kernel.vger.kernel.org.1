Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99E9829D4B8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 22:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728551AbgJ1VyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 17:54:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40155 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgJ1VyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 17:54:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id 23so866004ljv.7
        for <linux-kernel@vger.kernel.org>; Wed, 28 Oct 2020 14:54:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:message-id:date:mime-version;
        bh=hBvzK8lkv0/Kr6sllr3rVdlaKd0LEpV25zHBAjm2eYs=;
        b=FQxkCrAaytd47GlTo5h0PICfrRUdHZ0JRSksQaAkIABXQl0OfC3HvUfh2mQNnNY/po
         6NymwTsEZGd2nUdHuyYgm5flNlVP6Te+LVx7KTO8ne4lzNDnSMyro3ZMC5RmXILSIE6j
         9FF1Bk3chfB8za4FwnU9k3DDQWSKBujp/3I8tNPTx/4d+G32KskMBta5rRDB8IcuD0gf
         hNPSFZza5rN4EsyVIj6MRsaAcxn6PkWcQOcioRLXWHawmzDlR/OCuH7xtE5/8PruKP3f
         SHZcOUKagxxp66mUFklyFeHGAGMZs7yOdbq6pAzo+XVTtbxFmpRDzwANNuAh/T9xdg/E
         Lo2w==
X-Gm-Message-State: AOAM533WlUnKSu8/cmltL4Cvo8gtLgxnIMw+bD7xtNOcSRkclyxMoR8v
        6AGfHj65lPZiTbo0oPCXKgaNDlSDXLhERIvK
X-Google-Smtp-Source: ABdhPJyGLZtL+SLHLS8mwY46Tb6XUV1LVkmU7GdD9NvRNoqlUSsJFjQEFs68oKmFwmLvpV/nb2SaqQ==
X-Received: by 2002:aa7:c3c8:: with SMTP id l8mr69277edr.189.1603908298881;
        Wed, 28 Oct 2020 11:04:58 -0700 (PDT)
Received: from darkstar ([2a04:ee41:4:5025:8295:1d2:ca0d:985e])
        by smtp.gmail.com with ESMTPSA id u14sm232746edv.6.2020.10.28.11.04.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 11:04:58 -0700 (PDT)
References: <20201025073632.720393-1-hsiang023167@gmail.com>
 <08b7cdda-291c-bdf1-b72d-0a3ef411fcf3@arm.com>
 <20201026154538.GA807103@ubuntu>
 <605c21f7-3c4d-5c24-6d23-9f2604e6757b@arm.com>
 <20201027155813.GA818508@ubuntu> <87v9eumzic.derkling@matbug.net>
 <20201028113943.7jzxbytizrv7wsm3@e107158-lin>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Patrick Bellasi <patrick.bellasi@matbug.net>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Yun Hsiang <hsiang023167@gmail.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] sched/uclamp: add SCHED_FLAG_UTIL_CLAMP_RESET
 flag to reset uclamp
In-reply-to: <20201028113943.7jzxbytizrv7wsm3@e107158-lin>
Message-ID: <87sg9ymdmw.derkling@matbug.net>
Date:   Wed, 28 Oct 2020 19:03:35 +0100
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 28, 2020 at 12:39:43 +0100, Qais Yousef <qais.yousef@arm.com> wrote...

> On 10/28/20 11:11, Patrick Bellasi wrote:
>> >>  
>> >>  		/*
>> >>  		 * RT by default have a 100% boost value that could be modified
>> >>  		 * at runtime.
>> >>  		 */
>> >>  		if (unlikely(rt_task(p) && clamp_id == UCLAMP_MIN))
>> >> -			__uclamp_update_util_min_rt_default(p);
>> >> +			value = sysctl_sched_uclamp_util_min_rt_default;
>> 
>> By removing this usage of __uclamp_updadate_util_min_rt_default(p),
>> the only other usage remaining is the call from:
>>    uclamp_udpate_util_min_rt_default().
>> 
>> What about an additional cleanup by in-lining the only surviving usage?
>
> This is not a cleanup IMO. There is special rule about updating that are
> encoded and documented in this helper function. Namely:
>
> 	* p->pi_lock must be held.
> 	* p->uclamp_req[].user_defined must be false.

Both these conditions are satisfied in the above call site:
 - user_defined is tested just 4 lines above
 - pi_lock is taken by the caller, i.e. __sched_setscheduler()
Thus, there is no need to test them two times.

Moreover, the same granted pi_lock you check in
__ucalmp_update_util_min_rt_default() is not checked at all in the rest
of __setscheduler_uclamp().

Thus, perhaps we should have just avoided to add
__uclamp_update_util_min_rt_default() since the beginning and:
 - have all its logic in the _only_ place where it's required
 - added the lockdep_assert_held() in __setscheduler_uclamp()

That's why I consider this a very good cleanup opportunity.

> I don't see open coding helps but rather makes the code harder to read and
> prone to introduce bugs if anything gets reshuffled in the future.

It's not open coding IMHO, it's just adding the code that's required.


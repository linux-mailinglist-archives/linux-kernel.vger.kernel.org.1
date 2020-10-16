Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191C2290DD1
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 00:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388307AbgJPWjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 18:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732280AbgJPWjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 18:39:52 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD91C061755
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:39:51 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id a1so2280631pjd.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 15:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W5eJvlDCVkWgb0uzCV+zk/jlgsjkTpcxKZ/p/XIgL6I=;
        b=BgYXxMIxHeO0qr+T27MqcmhFecsWAYaiE42KQLreb/h0BIhiwMtHS6A+peXScjFlUD
         MEztR9SSW7hwfNAMm9veseGnPeHJA5orfamncIRdbWe2zWbqMmh4NOxxL68XxcWH74Bw
         8GMKiJ48lwcRlmscqTqqSlRkvFws8NAqT/1hzX0Px5YhyCwpgKm6NdhTjkbjBdPowBFp
         wI/4uMpz5uMqdm7F8W7VGMYKLMyybJieH4Zc9Z3Qi9FqQQuhdRy1ouUjekHyV13sOoi1
         2wsLTVLskpNCtEstSWrWIdCN1xpJ8k+mp/DDkCvNqoaG8jghDF7hYdbYsBsdGzHRb342
         /NLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W5eJvlDCVkWgb0uzCV+zk/jlgsjkTpcxKZ/p/XIgL6I=;
        b=CW1J7PnvJ2Y96f+2BDivWd4PFfDs5WuW0uQWdkSAmMLyBFkNxph/4ftYSq2xP8C9vs
         SpSKU96KPEB4MILaFmz1fMLJGoaz8QvoeW/eT+wsZWHXLMQ3J/So1noKPd1TszTGGsjT
         FrMxe3ajCdnc0invMiqVYaEhs77zr4GHGCdniflk28hfy9wPg3v398wYlEkDj10Okdq6
         c43ezg+sG+XXsy83qbRNOxyy2BVPzJ6WXXjQ41IAV0ouwrI0n7an2GaBI9tguU45a/c5
         gn/s6s9gzozigE3vDYzfy6UhmDgt00JNA48mNxN4Xz+DmncRFg+GaXS3iddTPZRALXel
         ienw==
X-Gm-Message-State: AOAM531yP5sTrCkRJ6VEYQPbIq1lsIfuHA/S4+A65L85KJqCXNIWyUaX
        i20JDMUNDfHqmv90+879JECxXgNEi7Rsuw==
X-Google-Smtp-Source: ABdhPJxBO5RMNpoNrb/bpi9DiTzUCq57ms3w9wlCmpJACgOkUIj7a+TH1cYmUzy9GMUiIo6KDn0aMA==
X-Received: by 2002:a17:902:326:b029:d1:e5e7:be04 with SMTP id 35-20020a1709020326b02900d1e5e7be04mr6448518pld.55.1602887990216;
        Fri, 16 Oct 2020 15:39:50 -0700 (PDT)
Received: from ?IPv6:2600:380:4910:fe35:1659:7eea:2a98:b14b? ([2600:380:4910:fe35:1659:7eea:2a98:b14b])
        by smtp.gmail.com with ESMTPSA id y10sm3870996pff.119.2020.10.16.15.39.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 15:39:49 -0700 (PDT)
Subject: Re: [PATCH] task_work: cleanup notification modes
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <93292d5b-9124-d252-c81f-1f2cfbd60e7b@kernel.dk>
 <87tuutalre.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <aaed79d1-972f-e4bd-f3ac-d589cd729163@kernel.dk>
Date:   Fri, 16 Oct 2020 16:39:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <87tuutalre.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/16/20 3:44 PM, Thomas Gleixner wrote:
> On Fri, Oct 16 2020 at 09:16, Jens Axboe wrote:
>> A previous commit changed the notification mode from 0/1 to allowing
> 
> No. It changed it from boolean to an int.
> 
> There is a fundamental difference between 0/1 and false/true simply
> because it's a compiler implementation detail how to represent a boolean
> value.
> 
> Assume the following:
> 
> #define BAZ	0x08
> 
>        task_work_add(tsk, &work, foo & BAZ);
> 
> So with a function signature of
> 
>        task_work_add(*tsk, *work, bool signal);
> 
> the above 'foo & BAZ' becomes either true of false.
> 
> With the changed function signature of
> 
>        task_work_add(*tsk, *work, int signal);
> 
> the above becomes the result of 'foo & BAZ' which means that this
> construct will not longer do the right thing.
> 
> It's pure luck that none of the usage sites relied on the boolean
> property of that argument.

It wasn't pure luck, that was checked before that change was made. No
users did anything funky, it was all false/true or 0/1.

> Please spell it out correctly that converting a boolean argument to an
> integer argument is not equivalent.

Fixed up the commit message to be more descriptive.

>>  	switch (notify) {
>> +	case TWA_NONE:
>> +		break;
>>  	case TWA_RESUME:
>>  		set_notify_resume(task);
>>  		break;
> 
> The enum will not prevent that either and what you really want to do is
> to have some form of debug warning if 'notify' is out of range, which
> would have been the right thing to do in the first place.

I added a WARN_ON_ONCE() in the default case for that one.

>> - * @notify: send the notification if true
>> + * @notify: send chosen notification, if any
> 
> Is that really all you found to be wrong in that comment?

There really is nothing wrong, but it's not very descriptive (wasn't
before either). I've added a fuller description of the various TWA_*
notification types now.

-- 
Jens Axboe


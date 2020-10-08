Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 715382875A3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730458AbgJHOH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbgJHOH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:07:57 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32F5C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 07:07:56 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id l16so5743015ilt.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 07:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=diM16rALesHaCmwXGl03a1r60jg62usWEYSJ8E59HcQ=;
        b=dGWchd14Qhgki7wTp4s3wAGENm3BnuFx6wwLUm9CyWKSzpBBScby8wM1IW687+3qyq
         b5qbTGQ08HSpX32nGgwQNyO9GCZvRuW7cMsovzjzOVC6kg/2fzVWgmGmG/ddhqzq8iGV
         4oxVGZTcpsHEFRUYpvc/wqaKWillCTtAkMW/V/WVFwmVkRF2lkAA7xPV2ZPFn3raUpGu
         8E9XTe1cgYx+vUUyXPyBl5Co7f+CgMUavAAHBCkivdsBZmluS/Ohbvu1NGxVOwlXRfGF
         NmxrprhTSQq92ENFloJfFX6/vo1Q04mGIfwTvhmvCLs22gXIOjF0qBBrxZClYVG37VdU
         cEnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=diM16rALesHaCmwXGl03a1r60jg62usWEYSJ8E59HcQ=;
        b=j9//t7J1wsiVGKDiy5aDSx0DJfQJenGdPstiZp4wjH3dmIBSzgWnUYOSXhupC5T1IH
         +mQ7lrqPbUGqP6rjvMfBrK0V8pDJI93Nyjpym6hMGZ1pkof8sps1ZnPg55rq8gMNKCVO
         EIjpsPymWiSkJjDv7nWfbYkOiAL8pjnBVusBXyflpdypBI+j/2DCJAAlZLdcyuTIBh8P
         EKTdoRS8YntbtooMU1lNoWKum34AmVwO2iM26l7/OtxCBpOeMsuUUm23Yo4E5mmfRVb2
         o6GyRbdjQH8dikLwPELJKSsEluymzZKSg5vrFOXHZE4081mMqSFaaCekzIwueuPX/b8o
         EJ5Q==
X-Gm-Message-State: AOAM532aWki6maXpAdt/YtJmgjCE3aH3JjngreimVxC4GQckjW4pcfHg
        mFquV62JKgdZJGrbWe1DjfJusA==
X-Google-Smtp-Source: ABdhPJzN0O4GYXwVtzshMhwu2JGkqvxiOKnf/9fN5dg8j/tlNarx0Pyra0Nc6zri58QPeCAPvroKXg==
X-Received: by 2002:a92:6e05:: with SMTP id j5mr6436063ilc.248.1602166076312;
        Thu, 08 Oct 2020 07:07:56 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t10sm2279646iog.49.2020.10.08.07.07.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 07:07:55 -0700 (PDT)
Subject: Re: [PATCH 4/6] kernel: add support for TIF_NOTIFY_SIGNAL
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     linux-kernel@vger.kernel.org, io-uring@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de
References: <20201005150438.6628-1-axboe@kernel.dk>
 <20201005150438.6628-5-axboe@kernel.dk> <20201008135325.GG9995@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b691ff60-8847-e48f-956b-41f8f5c1275b@kernel.dk>
Date:   Thu, 8 Oct 2020 08:07:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201008135325.GG9995@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 7:53 AM, Oleg Nesterov wrote:
> On 10/05, Jens Axboe wrote:
>>
>>  static inline int signal_pending(struct task_struct *p)
>>  {
>> +#ifdef TIF_NOTIFY_SIGNAL
>> +	/*
>> +	 * TIF_NOTIFY_SIGNAL isn't really a signal, but it requires the same
>> +	 * behavior in terms of ensuring that we break out of wait loops
>> +	 * so that notify signal callbacks can be processed.
>> +	 */
>> +	if (unlikely(test_tsk_thread_flag(p, TIF_NOTIFY_SIGNAL)))
>> +		return 1;
>> +#endif
>>  	return task_sigpending(p);
>>  }
> 
> perhaps we can add test_tsk_thread_mask() later...

Yeah would be nice, and I bet there are a lot of cases in the kernel
that test multiple bits like that.

>>  static inline void restore_saved_sigmask_unless(bool interrupted)
>>  {
>> -	if (interrupted)
>> +	if (interrupted) {
>> +#ifdef TIF_NOTIFY_SIGNAL
>> +		WARN_ON(!test_thread_flag(TIF_SIGPENDING) &&
>> +			!test_thread_flag(TIF_NOTIFY_SIGNAL));
>> +#else
>>  		WARN_ON(!test_thread_flag(TIF_SIGPENDING));
>> -	else
>> +#endif
>> +	} else {
>>  		restore_saved_sigmask();
>> +	}
> 
> I'd suggest to simply do
> 
> 	-	WARN_ON(!test_thread_flag(TIF_SIGPENDING));
> 	+	WARN_ON(!signal_pending(current);

Ah yes, that's much better. I'll make the edit.

>> --- a/kernel/entry/kvm.c
>> +++ b/kernel/entry/kvm.c
>> @@ -8,6 +8,9 @@ static int xfer_to_guest_mode_work(struct kvm_vcpu *vcpu, unsigned long ti_work)
>>  	do {
>>  		int ret;
>>  
>> +		if (ti_work & _TIF_NOTIFY_SIGNAL)
>> +			tracehook_notify_signal();
> 
> Can't really comment this change, but to me it would be more safe to
> simply return -EINTR.
> 
> Or perhaps even better, treat _TIF_NOTIFY_SIGNAL and _TIF_SIGPENDING
> equally:
> 
> 	-	if (ti_work & _TIF_SIGPENDING) {
> 	+	if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL)) {
> 			kvm_handle_signal_exit(vcpu);
> 			return -EINTR;

Not sure I follow your logic here. Why treat it any different than
NOTIFY_RESUME from this perspective?

-- 
Jens Axboe


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C62E28DDA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Oct 2020 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbgJNJad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 05:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgJNJTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 05:19:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB9FC08EC23
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:46:00 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a1so469822pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Oct 2020 16:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q17Q7ktlNhaXKY65m0KUKSOOR+9TcrtRgolKl3qJcfE=;
        b=PHkhpxNOAvRkgVrDqONoYBYXObf8ngZR0j4/P7nnssklPxBVA8loBCzAmxX3hE1JH2
         OX60jBe8wRs21OYODQxGq+x4G+tZHwfFg/kka8IUNo60oykxymzSprxVkuSBsXij+XHU
         vbIaeMWwoB/vgAkWjGghD9ONJR43j2IuF/lorwoMoQZuV1IyfbU/ByVRqcLkVrJb0mEc
         6aEdvoDQp2hs7Zkd3aaB882RCC48J3Z9n3O/u3H+Z0UtgJdw16hgN8S4mVsuv1dVg4ha
         UtM8rHdeZ5rNyskewlRZftleEErGLbFBVkr+zxOH7L9+kLteYdR3pi/xJ9S9RCsHQ4Vg
         7bEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q17Q7ktlNhaXKY65m0KUKSOOR+9TcrtRgolKl3qJcfE=;
        b=AA7HluPFx2pG+FivcMgBoGOzYztzVv1K7ithwfLTNtClqgkOsu+GYwQ/Er1nxSuZJ5
         VbZhoxZG/3RBy2FA+PRUpJLfWjtnONL92nevnYKhUiRh8gvpMVF95gIJP+cL2VUq4fOC
         sR8T859aUfhoxD2UmQKiZqPuzWgx0o5qKaXNN4Jg81nLLkg6WgcSQXt+NQbgHL1WdUoi
         F+XWJTsfPRFhDFSTG7RAeb7q9ChOwnWIeCjwDP5ydEXuzs2M87F/S07kKftKhLS+HIgA
         4Vtrw5dbkhXRsbdTrrGF3OIDQXQ0mbdu1Gwk5ndR1AiALvv3mLmaEe1EdJIPF9JacS9v
         NQGQ==
X-Gm-Message-State: AOAM531gD2A96nNSQEV0tl3tV3T8kWGh4ye+Apl0AhdFFCPC22zNstEx
        Q3sk4iz2aW6A76MnMx5z9rg9Tw==
X-Google-Smtp-Source: ABdhPJyZF8vBZZV9RVyjy7KiAqYs9zYIr6oaLx/hTtuS8cK+eB3uoFljOHpht0SFKCleu+sVCS9Y7w==
X-Received: by 2002:a17:902:b089:b029:d4:d5c6:fed0 with SMTP id p9-20020a170902b089b02900d4d5c6fed0mr2103378plr.9.1602632760084;
        Tue, 13 Oct 2020 16:46:00 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id w4sm368023pjh.50.2020.10.13.16.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Oct 2020 16:45:59 -0700 (PDT)
Subject: Re: [PATCH 3/4] kernel: add support for TIF_NOTIFY_SIGNAL
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        io-uring@vger.kernel.org
Cc:     peterz@infradead.org, oleg@redhat.com
References: <20201008152752.218889-1-axboe@kernel.dk>
 <20201008152752.218889-4-axboe@kernel.dk>
 <878sc9d75u.fsf@nanos.tec.linutronix.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <5ae0077a-d215-82a0-49d4-d715714e2219@kernel.dk>
Date:   Tue, 13 Oct 2020 17:45:57 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <878sc9d75u.fsf@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/20 5:42 PM, Thomas Gleixner wrote:
> On Thu, Oct 08 2020 at 09:27, Jens Axboe wrote:
>> This adds TIF_NOTIFY_SIGNAL handling in the generic code, which if set,
>> will return true if signal_pending() is used in a wait loop. That causes
>> an exit of the loop so that notify_signal tracehooks can be run. If the
>> wait loop is currently inside a system call, the system call is restarted
>> once task_work has been processed.
>>
>> x86 is using the generic entry code, add the necessary TIF_NOTIFY_SIGNAL
>> definitions for it.
> 
> Can you please split that into core changes and a patch which adds
> support for x86?

Sure, I'll split it into generic and then x86 after that.

>>  static inline int signal_pending(struct task_struct *p)
>>  {
>> +#ifdef TIF_NOTIFY_SIGNAL
> 
> As I said in the other thread, plase make this
> 
> #if defined(CONFIG_GENERIC_ENTRY) && defined(TIF_NOTIFY_SIGNAL)

Thanks, I'll make those tweaks.

> Other than that, this approach of using arch_do_signal() addresses my
> earlier concerns about the syscall restart machinery.

Great! Thanks for taking a look.

-- 
Jens Axboe


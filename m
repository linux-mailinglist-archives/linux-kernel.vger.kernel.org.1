Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5373922F446
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 18:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbgG0QEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 12:04:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbgG0QEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 12:04:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A64C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 09:04:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595865893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0LY3rc/JxTz4zHSXGZjMTZLTeOUukogWFIR25veM+k=;
        b=SBIehMvtfAwbSKeCm+n8tRHdnaazd/n7jEEZDRrYY6VKSJllK9b2k494Zfec0XaOJuJ0ig
        BRNPxohzuT/frswDwSNCwWDLiefWiu0PhmtOxsdjGp+yisy24XtQwj/6ty+8kl0FKivvO2
        efqHN/gyRi65pADwWcMgQosK/zV3eeNbs+MY/iBMwlzZr4PHwbw5LWFOiRBg/TgdruJhTF
        Ze72ZSHWBs2NujWVlhVV9ICGRl1jnnfQNcUUW4NZwWU3g18eUD4SKjoRuwFEBlwVPIEsHz
        kMbOkFUswhAlQH6Lcj0SOVIfcTetC7S0uickKLT8RqJVX0fIn4X4EZg0V/HuwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595865893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D0LY3rc/JxTz4zHSXGZjMTZLTeOUukogWFIR25veM+k=;
        b=rP0xkzei41oXXiogTgxGm787+Z1oHVKjgef7GyLhs/nx3rbZ5c9LI0Y1KyFyuA7tbM4UUM
        UvYHk8O2YtXJRgBQ==
To:     Ingo Molnar <mingo@kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Cc:     peterz@infradead.org, bigeasy@linutronix.de, namit@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] smp: Fix a potential usage of stale nr_cpus
In-Reply-To: <20200727114303.GA57241@gmail.com>
References: <20200721034239.72013-1-songmuchun@bytedance.com> <20200727114303.GA57241@gmail.com>
Date:   Mon, 27 Jul 2020 18:04:53 +0200
Message-ID: <87mu3laqqi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@kernel.org> writes:
>> -	get_option(&str, &nr_cpus);
>> +	if (get_option(&str, &nr_cpus) != 1)
>> +		return -EINVAL;
>> +
>>  	if (nr_cpus > 0 && nr_cpus < nr_cpu_ids)
>>  		nr_cpu_ids = nr_cpus;
>> +	else
>> +		return -EINVAL;
>
> Exactly what does 'not valid' mean, and why doesn't get_option() 
> return -EINVAL in that case?

What's unclear about invalid? If you specify nr_cpus=-1 or
nr_cpus=2000000 the its obviously invalid.

How should get_option() know that this is invalid? get_option() is a
number parser and does not know about any restrictions on the parsed
value obviously.

get_option() returns string parsing information:

       0 -> not integer found
       1 -> integer found, no trailing comma or hyphen
       2 -> integer found and trailing comma
       3 -> integer found and traling hyphen (range parsing)

And that's what is checked in if (get_option() != 1), i.e. anything else
than a plain integer is invalid for this command line option.

Thanks,

        tglx



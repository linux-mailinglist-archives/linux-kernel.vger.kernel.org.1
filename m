Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B6926FB7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Sep 2020 13:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726044AbgIRLbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 07:31:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33838 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIRLa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 07:30:26 -0400
X-Greylist: delayed 80002 seconds by postgrey-1.27 at vger.kernel.org; Fri, 18 Sep 2020 07:30:25 EDT
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600428606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8efSfSmWaNbeYbeXyDKLA+gUx+Kn3kVHQX4V3piCYI=;
        b=hZ2vQvKy3SsAvSsP5u6L6uh4RCjF9TTilJjTnHRlYQMpniz49lLtJus3K3YZrZpqzPiNjL
        q6sjxyF4EhLeccI7WbmICPjGZIK/PloNiBDq1SLZ+IDiL9cRvmlpyJAI7vWuTeHKuFUaSd
        QqtkWLCaD1UOSoMy4zIbUFFKugvBNeoF1jQQ4On0KeZy7HHROk5VFg/gRP4EiShFp9KSVC
        o0Ky8lNNBErh2tePouP8goWez5bAyQKSTvn9V3Wn/f0nWBTkgH8T0rm0i2vPu63i/j2g6I
        jnXL6DrhxP1+qgAU6SaKDCAfRPEknXxW6lgRdeFJlVpt5e72ycoCDECVl++D4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600428606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X8efSfSmWaNbeYbeXyDKLA+gUx+Kn3kVHQX4V3piCYI=;
        b=xw89RIR38MEmhGSYjel2Ruz1PQC2IWwp/zIQQ++7r0w8DqLucqBaL/qUYBQJYl9/Pdsexq
        wgYqSf6xEEhmIoAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk 1/3] printk: move printk_info into separate array
In-Reply-To: <20200918100602.GB14605@alley>
References: <20200917131644.25838-1-john.ogness@linutronix.de> <20200917131644.25838-2-john.ogness@linutronix.de> <20200918100602.GB14605@alley>
Date:   Fri, 18 Sep 2020 13:36:06 +0206
Message-ID: <87k0wrb9vl.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-18, Petr Mladek <pmladek@suse.com> wrote:
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -1097,6 +1097,7 @@ static char setup_dict_buf[CONSOLE_EXT_LOG_MAX] __initdata;
>>  
>>  void __init setup_log_buf(int early)
>>  {
>> +	struct printk_info *new_infos;
>>  	unsigned int new_descs_count;
>>  	struct prb_desc *new_descs;
>>  	struct printk_info info;
>> @@ -1156,6 +1157,17 @@ void __init setup_log_buf(int early)
>>  		return;
>>  	}
>>  
>> +	new_descs_size = new_descs_count * sizeof(struct printk_info);
>
> Must be stored into new variable, e.g.  new_infos_size.=

Ack.

>> +	new_infos = memblock_alloc(new_descs_size, LOG_ALIGN);
>> +	if (unlikely(!new_infos)) {
>> +		pr_err("log_buf_len: %zu info bytes not available\n",
>> +		       new_descs_size);
>> +		memblock_free(__pa(new_descs), new_log_buf_len);
>> +		memblock_free(__pa(new_dict_buf), new_log_buf_len);
>
> The above two calls have wrong size.
>
> The same problem is there also in the error path when new_descs
> allocation fail. It might be better to handle this using some
> goto err_* tagrets.
>
> Please, fix the old problem in a separate patch.

The "old problem" didn't exist. The problem is introduced with this
series. I will fix it with appropriate goto err_* targets for v2.

>> --- a/kernel/printk/printk_ringbuffer.c
>> +++ b/kernel/printk/printk_ringbuffer.c
>> @@ -1726,12 +1762,12 @@ static bool copy_data(struct prb_data_ring *data_ring,
>>  	/*
>>  	 * Actual cannot be less than expected. It can be more than expected
>>  	 * because of the trailing alignment padding.
>> +	 *
>> +	 * Note that invalid @len values can occur because the caller loads
>> +	 * the value during an allowed data race.
>
> I hope that this will not bite us in the future. The fact is that
> copying the entire struct printk_info in get_desc() is ugly and
> copy_data() has to be careful anyway.

It isn't an issue because the state is verified again at the end of
prb_read(). I added the comment because if all you are looking at is
copy_data(), you may not know that @len was read on a data-race. Whereas
inside of prb_read(), it is obvious that the memcpy() is a data-race.

John Ogness

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB34269DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 07:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726132AbgIOFKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 01:10:10 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:23363 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgIOFKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 01:10:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600146605; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To: From:
 Subject: Sender; bh=B6VMcUMbely6FiLPgQT06jsV/DKFK3KvFB4W6h9BsJI=; b=p6Nc1wFSBYEiD0ps0JuaIgBPR1LnG2EMKJd8C5w3JaaaKWhG1OmypEtX4S7qLF22Pfun9niU
 blrnHH5Sr4XAXf1zklauki3cqeNZ2ShWT1021/CzfqbkMkcGM1P6ofQiZ00f5PiXPwPavXGX
 QDXtE+qhV8zan3CZ6waW3hJLo+M=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f604c39885efaea0a119d8b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 05:08:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6618C433CA; Tue, 15 Sep 2020 05:08:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.4] (unknown [171.49.233.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8CD70C433C8;
        Tue, 15 Sep 2020 05:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8CD70C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] trace: Fix race in trace_open and buffer resize call
From:   Gaurav Kohli <gkohli@codeaurora.org>
To:     rostedt@goodmis.org, mingo@redhat.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <1599199797-25978-1-git-send-email-gkohli@codeaurora.org>
 <d4691a90-9a47-b946-f2cd-bb1fce3981b0@codeaurora.org>
Message-ID: <2fe2a843-e2b5-acf8-22e4-7231d24a9382@codeaurora.org>
Date:   Tue, 15 Sep 2020 10:38:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <d4691a90-9a47-b946-f2cd-bb1fce3981b0@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hi Steven,
thanks for reply.

On 9/14/2020 9:49 PM, Steven Rostedt wrote:
 > On Mon, 14 Sep 2020 10:00:50 +0530
 > Gaurav Kohli <gkohli@codeaurora.org> wrote:
 >
 >> Hi Steven,
 >>
 >> Please let us know, if below change looks good.
 >> Or let us know some other way to solve this.
 >>
 >> Thanks,
 >> Gaurav
 >>
 >>
 >
 > Hmm, for some reason, I don't see this in my INBOX, but it shows up in my
 > LKML folder. :-/
 >
 >


 >>> +void ring_buffer_mutex_release(struct trace_buffer *buffer)
 >>> +{
 >>> +    mutex_unlock(&buffer->mutex);
 >>> +}
 >>> +EXPORT_SYMBOL_GPL(ring_buffer_mutex_release);
 >
 > I really do not like to export these.
 >

Actually available reader lock is not helping 
here(&cpu_buffer->reader_lock), So i took ring buffer mutex lock to 
resolve this(this came on 4.19/5.4), in latest tip it is trace buffer 
lock. Due to this i have exported api.
 >>> +/**
 >>>     * ring_buffer_record_off - stop all writes into the buffer
 >>>     * @buffer: The ring buffer to stop writes to.
 >>>     *
 >>> @@ -4918,6 +4937,8 @@ void ring_buffer_reset(struct trace_buffer 
*buffer)
 >>>        struct ring_buffer_per_cpu *cpu_buffer;
 >>>        int cpu;
 >>>    +    /* prevent another thread from changing buffer sizes */
 >>> +    mutex_lock(&buffer->mutex);
 >>>        for_each_buffer_cpu(buffer, cpu) {
 >>>            cpu_buffer = buffer->buffers[cpu];
 >>>    @@ -4936,6 +4957,7 @@ void ring_buffer_reset(struct trace_buffer 
*buffer)
 >>>            atomic_dec(&cpu_buffer->record_disabled);
 >>>            atomic_dec(&cpu_buffer->resize_disabled);
 >>>        }
 >>> +    mutex_unlock(&buffer->mutex);
 >>>    }
 >>>    EXPORT_SYMBOL_GPL(ring_buffer_reset);
 >>>    diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
 >>> index f40d850..392e9aa 100644
 >>> --- a/kernel/trace/trace.c
 >>> +++ b/kernel/trace/trace.c
 >>> @@ -2006,6 +2006,8 @@ void tracing_reset_online_cpus(struct 
array_buffer *buf)
 >>>        if (!buffer)
 >>>            return;
 >>>    +    ring_buffer_mutex_acquire(buffer);
 >>> +
 >>>        ring_buffer_record_disable(buffer);
 >
 > Hmm, why do we disable here as it gets disabled again in the call to
 > ring_buffer_reset_online_cpus()? Perhaps we don't need to disable the
You mean cpu_buffer->reader_lock in reset_disabled_cpu_buffer?
Actually reader lock is already there but this is not helping if 
tracing_open and ring_buffer_resize are running parallel on different cpus.

We are seeing below race mainly during removal of extra pages:

                                             ring_buffer_resize
                                            //Below portion of code
                                            //not under any lock
                                             nr_pages_to_update < 0
                                            init_list_head(new_pages)
                                            rb_update_pages


ring_buffer_resize
tracing_open
tracing_reset_online_cpus
ring_buffer_reset_cpu
                                           cpu_buffer_reset done
                                           //now lock started

                                           warning(nr_removed)

We are seeing cases like cpu buffer got reset due to tracing open in 
other call, and then seeing issue in  rb_remove_pages.

Similar case can come during rb_insert_pages as well:

rb_insert_pages(struct ring_buffer_per_cpu *cpu_buffer)
{
         struct list_head *pages = &cpu_buffer->new_pages;
         int retries, success;
//before lock cpu buffer may get reset in another cpu, due to which we 
are seeing infinite loop cases as new_pages pointer got reset in 
rb_reset_cpu.

         raw_spin_lock_irq(&cpu_buffer->reader_lock);

 > buffer here. The only difference is that we have:
 >
 >   buf->time_start = buffer_ftrace_now(buf, buf->cpu);
 >
 > And that the above disables the entire buffer, whereas the reset only
 > resets individual ones.
 >
 > But I don't think that will make any difference.
 >
 > -- Steve
 >


-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

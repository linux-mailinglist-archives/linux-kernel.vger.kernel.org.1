Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB8626AC9B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 20:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbgIOSx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 14:53:28 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:51662 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727821AbgIORYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 13:24:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1600190650; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mmUpR8kyg48G1ucp+HFseTlZkNpLrALzY0olaGIaa88=; b=bla9us1WSwTAuU22+WO5ykrSqU5TDYOiw08E5nsLgMcFEGvjdacHjqy6fpQ3V/whL4kxRhvF
 bdgA+vFNw905fbkgm7mz71fM3Eawt1rtQxUhCUtpBc8rGv1Su046MG1Ymtlt5J+bJhd6CvWl
 M0/QQB7b8XYl/bFEVACxezFKzB0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-west-2.postgun.com with SMTP id
 5f60f8a4cc683673f91050f5 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 15 Sep 2020 17:23:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 3F761C433F0; Tue, 15 Sep 2020 17:23:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.1.4] (unknown [122.175.29.203])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: gkohli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 684A9C433C8;
        Tue, 15 Sep 2020 17:23:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 684A9C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=gkohli@codeaurora.org
Subject: Re: [PATCH] trace: Fix race in trace_open and buffer resize call
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <1599199797-25978-1-git-send-email-gkohli@codeaurora.org>
 <d4691a90-9a47-b946-f2cd-bb1fce3981b0@codeaurora.org>
 <2fe2a843-e2b5-acf8-22e4-7231d24a9382@codeaurora.org>
 <20200915092353.5b805468@gandalf.local.home>
From:   Gaurav Kohli <gkohli@codeaurora.org>
Message-ID: <08d6f338-3be3-c5a2-ba4b-0116de9672c2@codeaurora.org>
Date:   Tue, 15 Sep 2020 22:53:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915092353.5b805468@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/15/2020 6:53 PM, Steven Rostedt wrote:
> On Tue, 15 Sep 2020 10:38:03 +0530
> Gaurav Kohli <gkohli@codeaurora.org> wrote:
> 
>>
>>   >>> +void ring_buffer_mutex_release(struct trace_buffer *buffer)
>>   >>> +{
>>   >>> +    mutex_unlock(&buffer->mutex);
>>   >>> +}
>>   >>> +EXPORT_SYMBOL_GPL(ring_buffer_mutex_release);
>>   >
>>   > I really do not like to export these.
>>   >
>>
>> Actually available reader lock is not helping
>> here(&cpu_buffer->reader_lock), So i took ring buffer mutex lock to
>> resolve this(this came on 4.19/5.4), in latest tip it is trace buffer
>> lock. Due to this i have exported api.
> 
> I'm saying, why don't you take the buffer->mutex in the
> ring_buffer_reset_online_cpus() function? And remove all the protection in
> tracing_reset_online_cpus()?

Yes, got your point. then we can avoid export. Actually we are seeing 
issue in older kernel like 4.19/4.14/5.4 and there below patch was not 
present in stable branches:

ommit b23d7a5f4a07 ("ring-buffer: speed up buffer resets by
 > avoiding synchronize_rcu for each CPU")

Actually i have also thought to take mutex lock in ring_buffer_reset_cpu
while doing individual cpu reset, but this could cause another problem:

Different cpu buffer may have different state, so i have taken lock in 
tracing_reset_online_cpus.
>
> void tracing_reset_online_cpus(struct array_buffer *buf)
> {
> 	struct trace_buffer *buffer = buf->buffer;
> 
> 	if (!buffer)
> 		return;
> 
> 	buf->time_start = buffer_ftrace_now(buf, buf->cpu);
> 
> 	ring_buffer_reset_online_cpus(buffer);
> }
> 
> The reset_online_cpus() is already doing the synchronization, we don't need
> to do it twice.
> 
> I believe commit b23d7a5f4a07 ("ring-buffer: speed up buffer resets by
> avoiding synchronize_rcu for each CPU") made the synchronization in
> tracing_reset_online_cpus() obsolete.
> 
> -- Steve
> 

Yes, with above patch no need to take lock in tracing_reset_online_cpus.
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center,
Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F31F2C6321
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgK0Kci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:32:38 -0500
Received: from foss.arm.com ([217.140.110.172]:37432 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbgK0Kch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:32:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CDDF1516;
        Fri, 27 Nov 2020 02:32:36 -0800 (PST)
Received: from [10.57.56.151] (unknown [10.57.56.151])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 18CE03F71F;
        Fri, 27 Nov 2020 02:32:33 -0800 (PST)
Subject: Re: [RFC 09/11] coresight: etm-perf: Disable the path before
 capturing the trace data
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, Al Grant <Al.Grant@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2019e06d-65e1-fee8-f75d-bfa5750d2458@arm.com>
Date:   Fri, 27 Nov 2020 10:32:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/20 12:45 PM, Anshuman Khandual wrote:
> perf handle structure needs to be shared with the TRBE IRQ handler for
> capturing trace data and restarting the handle. There is a probability
> of an undefined reference based crash when etm event is being stopped
> while a TRBE IRQ also getting processed. This happens due the release
> of perf handle via perf_aux_output_end(). This stops the sinks via the
> link before releasing the handle, which will ensure that a simultaneous
> TRBE IRQ could not happen.

Or in other words :

We now have :

	update_buffer()

	perf_aux_output_end(handle)

	...
	disable_path()

This is problematic due to various reasons :

1) The semantics of update_buffer() is not clear. i.e, whether it
    should leave the "sink" "stopped" or "disabled" or "active"

2) This breaks the recommended trace collection sequence of
    "flush" and "stop" from source to the sink for trace collection.
     i.e, we stop the source now. But don't flush the components
     from source to sink, rather we stop and flush from the sink.
     And we flush and stop the path after we have collected the
     trace data at sink, which is pointless.

3) For a sink with IRQ handler, if we don't stop the sink with
    update_buffer(), we could have a situation :

    update_buffer()

    perf_aux_outpuf_end(handle) # handle is invalid now

  -----------------> IRQ    -> irq_handler()
                                perf_aux_output_end(handle) # Wrong !


    disable_path()

The sysfs mode is fine, as we defer the trace collection to disable_path().

The proposed patch is still racy, as we could still hit the problem.

So, to avoid all of these situations, I think we should defer the the
update_buffer() to sink_ops->disable(), when we have flushed and stopped
the all the components upstream and avoid any races with the IRQ
handler.

i.e,

	source_ops->stop(csdev);

	disable_path(handle); // similar to the enable_path


sink_ops->disable(csdev, handle)
{
   /* flush & stop */

   /* collect trace */
   perf_aux_output_end(handle, size);
}


Kind regards
Suzuki



> 
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> This might cause problem with traditional sink devices which can be
> operated in both sysfs and perf mode. This needs to be addressed
> correctly. One option would be to move the update_buffer callback
> into the respective sink devices. e.g, disable().
> 
>   drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index 534e205..1a37991 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -429,7 +429,9 @@ static void etm_event_stop(struct perf_event *event, int mode)
>   
>   		size = sink_ops(sink)->update_buffer(sink, handle,
>   					      event_data->snk_config);
> +		coresight_disable_path(path);
>   		perf_aux_output_end(handle, size);
> +		return;
>   	}
>   
>   	/* Disabling the path make its elements available to other sessions */
> 


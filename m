Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606922B01F2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgKLJ2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:28:06 -0500
Received: from foss.arm.com ([217.140.110.172]:45076 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgKLJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:28:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7BB8C1FB;
        Thu, 12 Nov 2020 01:28:04 -0800 (PST)
Received: from [10.57.23.123] (unknown [10.57.23.123])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38CD03F73C;
        Thu, 12 Nov 2020 01:28:03 -0800 (PST)
Subject: Re: [RFC 09/11] coresight: etm-perf: Disable the path before
 capturing the trace data
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        mike.leach@linaro.org
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
 <1605012309-24812-10-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1ad992f4-5981-6ff1-470b-875e30d3c229@arm.com>
Date:   Thu, 12 Nov 2020 09:27:56 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.1
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

As you mentioned, this is not ideal where another session could be triggered on
the sink from a different ETM (not for per-CPU sink) in a different mode before
you collect the buffer. I believe the best option is to leave the
update_buffer() to disable_hw. This would need to pass on the "handle" to the
disable_path.

That way the races can be handled inside the sinks. Also, this aligns the
perf mode of the sinks with that of the sysfs mode.

Suzuki

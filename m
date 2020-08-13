Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99018243853
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Aug 2020 12:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgHMKRQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Aug 2020 06:17:16 -0400
Received: from foss.arm.com ([217.140.110.172]:52938 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgHMKRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 06:17:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A8B931B;
        Thu, 13 Aug 2020 03:17:14 -0700 (PDT)
Received: from [10.37.8.11] (unknown [10.37.8.11])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AE62A3F70D;
        Thu, 13 Aug 2020 03:17:02 -0700 (PDT)
Subject: Re: [PATCH] coresight: fix offset by one error in counting ports
To:     ykaukab@suse.de, linux-arm-kernel@lists.infradead.org,
        mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
        mike.leach@linaro.org, gregkh@linuxfoundation.org,
        tingwei@codeaurora.org, ro@suse.com, jeremy.linton@arm.com
References: <20200813100456.11803-1-ykaukab@suse.de>
 <20200813100456.11803-2-ykaukab@suse.de>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <213e9d02-b945-1317-bc54-83b64ac376cf@arm.com>
Date:   Thu, 13 Aug 2020 11:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200813100456.11803-2-ykaukab@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/13/2020 11:04 AM, Mian Yousaf Kaukab wrote:
> Since port-numbers start from 0, add 1 to port-number to get the port
> count.
> 
> Fix following crash when Coresight is enabled on ACPI based systems:
> 
> [   61.061736] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> ...
> [   61.135494] pc : acpi_coresight_parse_graph+0x1c4/0x37c
> [   61.140705] lr : acpi_coresight_parse_graph+0x160/0x37c
> [   61.145915] sp : ffff800012f4ba40
> [   61.145917] x29: ffff800012f4ba40 x28: ffff00becce62f98
> [   61.159896] x27: 0000000000000005 x26: ffff00becd8a7c88
> [   61.165195] x25: ffff00becd8a7d88 x24: ffff00becce62f80
> [   61.170492] x23: ffff800011ef99c0 x22: ffff009efb8bc010
> [   61.175790] x21: 0000000000000018 x20: 0000000000000005
> [   61.181087] x19: ffff00becce62e80 x18: 0000000000000020
> [   61.186385] x17: 0000000000000001 x16: 00000000000002a8
> [   61.191682] x15: ffff000838648550 x14: ffffffffffffffff
> [   61.196980] x13: 0000000000000000 x12: ffff00becce62d87
> [   61.202277] x11: 00000000ffffff76 x10: 000000000000002e
> [   61.207575] x9 : ffff8000107e1a68 x8 : ffff00becce63000
> [   61.212873] x7 : 0000000000000018 x6 : 000000000000003f
> [   61.218170] x5 : 0000000000000000 x4 : 0000000000000000
> [   61.223467] x3 : 0000000000000000 x2 : 0000000000000000
> [   61.228764] x1 : ffff00becce62f80 x0 : 0000000000000000
> [   61.234062] Call trace:
> [   61.236497]  acpi_coresight_parse_graph+0x1c4/0x37c
> [   61.241361]  coresight_get_platform_data+0xdc/0x130
> [   61.246225]  tmc_probe+0x138/0x2dc
> [   61.246227]  amba_probe+0xdc/0x220
> [   61.255779]  really_probe+0xe8/0x49c
> [   61.255781]  driver_probe_device+0xec/0x140
> [   61.255782]  device_driver_attach+0xc8/0xd0
> [   61.255785]  __driver_attach+0xac/0x180
> [   61.265857]  bus_for_each_dev+0x78/0xcc
> [   61.265859]  driver_attach+0x2c/0x40
> [   61.265861]  bus_add_driver+0x150/0x244
> [   61.265863]  driver_register+0x80/0x13c
> [   61.273591]  amba_driver_register+0x60/0x70
> [   61.273594]  tmc_driver_init+0x20/0x2c
> [   61.281582]  do_one_initcall+0x50/0x230
> [   61.281585]  do_initcalls+0x104/0x144
> [   61.291831]  kernel_init_freeable+0x168/0x1dc
> [   61.291834]  kernel_init+0x1c/0x120
> [   61.299215]  ret_from_fork+0x10/0x18
> [   61.299219] Code: b9400022 f9400660 9b277c42 8b020000 (f9400404)
> [   61.307381] ---[ end trace 63c6c3d7ec6a9b7c ]---
> [   61.315225] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> 
> Fixes: d375b356e687 ("coresight: Fix support for sparsely populated ports")
> Reported-by: Ruediger Oertel <ro@suse.com>
> Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>


> ---
>   drivers/hwtracing/coresight/coresight-platform.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> index bfd44231d7ad..227e234a2470 100644
> --- a/drivers/hwtracing/coresight/coresight-platform.c
> +++ b/drivers/hwtracing/coresight/coresight-platform.c
> @@ -711,11 +711,11 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>   			return dir;
>   
>   		if (dir == ACPI_CORESIGHT_LINK_MASTER) {
> -			if (ptr->outport > pdata->nr_outport)
> -				pdata->nr_outport = ptr->outport;
> +			if (ptr->outport >= pdata->nr_outport)
> +				pdata->nr_outport = ptr->outport + 1;
>   			ptr++;
>   		} else {
> -			WARN_ON(pdata->nr_inport == ptr->child_port);
> +			WARN_ON(pdata->nr_inport == ptr->child_port + 1);
>   			/*
>   			 * We do not track input port connections for a device.
>   			 * However we need the highest port number described,
> @@ -723,8 +723,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
>   			 * record for an output connection. Hence, do not move
>   			 * the ptr for input connections
>   			 */
> -			if (ptr->child_port > pdata->nr_inport)
> -				pdata->nr_inport = ptr->child_port;
> +			if (ptr->child_port >= pdata->nr_inport)
> +				pdata->nr_inport = ptr->child_port + 1;
>   		}
>   	}



I was about to post a similar fix following a report from
Jeremy. This looks fine to me.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

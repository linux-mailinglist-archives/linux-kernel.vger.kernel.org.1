Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043C52546F0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 16:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728075AbgH0OdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 10:33:11 -0400
Received: from hostingweb31-40.netsons.net ([89.40.174.40]:45168 "EHLO
        hostingweb31-40.netsons.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgH0O3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:29:08 -0400
Received: from [78.134.86.56] (port=42726 helo=[192.168.77.62])
        by hostingweb31.netsons.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <luca@lucaceresoli.net>)
        id 1kBItY-0004dO-C9; Thu, 27 Aug 2020 16:28:52 +0200
Subject: Re: [PATCH 1/3] fpga manager: xilinx-spi: remove stray comment
To:     Moritz Fischer <mdf@kernel.org>
Cc:     linux-fpga@vger.kernel.org, Tom Rix <trix@redhat.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anatolij Gustschin <agust@denx.de>
References: <20200817165911.32589-1-luca@lucaceresoli.net>
 <20200820041110.GA4022@epycbox.lan>
From:   Luca Ceresoli <luca@lucaceresoli.net>
Message-ID: <3fe28140-0ea1-90a1-d5a0-1ca5fa83cb8e@lucaceresoli.net>
Date:   Thu, 27 Aug 2020 16:28:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200820041110.GA4022@epycbox.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hostingweb31.netsons.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lucaceresoli.net
X-Get-Message-Sender-Via: hostingweb31.netsons.net: authenticated_id: luca@lucaceresoli.net
X-Authenticated-Sender: hostingweb31.netsons.net: luca@lucaceresoli.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Moritz,

On 20/08/20 06:11, Moritz Fischer wrote:
> On Mon, Aug 17, 2020 at 06:59:09PM +0200, Luca Ceresoli wrote:
>> Remove comment committed by mistake.
>>
>> Fixes: dd2784c01d93 ("fpga manager: xilinx-spi: check INIT_B pin during write_init")
>> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
>> ---
>>  drivers/fpga/xilinx-spi.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/drivers/fpga/xilinx-spi.c b/drivers/fpga/xilinx-spi.c
>> index 2967aa2a74e2..502fae0d1d85 100644
>> --- a/drivers/fpga/xilinx-spi.c
>> +++ b/drivers/fpga/xilinx-spi.c
>> @@ -57,7 +57,6 @@ static int wait_for_init_b(struct fpga_manager *mgr, int value,
>>  
>>  	if (conf->init_b) {
>>  		while (time_before(jiffies, timeout)) {
>> -			/* dump_state(conf, "wait for init_d .."); */
>>  			if (gpiod_get_value(conf->init_b) == value)
>>  				return 0;
>>  			usleep_range(100, 400);
>> -- 
>> 2.28.0
>>
> 
> Applied to for-next,
> 
> Thanks
> 

Thanks, but still I don't see it. Missing push?

As I'm sending a v2 patch series, I'll keep this patch for now, just in
case.

-- 
Luca

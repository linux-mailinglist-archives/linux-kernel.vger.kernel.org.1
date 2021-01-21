Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E767F2FE335
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 07:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbhAUGvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 01:51:09 -0500
Received: from a1.mail.mailgun.net ([198.61.254.60]:64218 "EHLO
        a1.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbhAUGvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 01:51:04 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1611211832; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=PwTBUKX4zXJvBDtn++wgHmrDeVAGMzEFT5WBMoLMpQo=; b=qH2PkBia0lgnFdR/9Rl1c0tUxe1z/Xh3FRbOgH1uv5i3OXhTebl2A2Euo6wn407V2N/3GVp+
 3C038JbRpyBi10WL1eWAszda9pKHapHVjbP+U+lc858j2AnixXtZs++6R/N+P5ajs3pHkO59
 WiJSZcS8lQtyMOZEQM3tn55Fu/E=
X-Mailgun-Sending-Ip: 198.61.254.60
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 6009241bad4c9e395bda0421 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 21 Jan 2021 06:50:03
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 82FECC43462; Thu, 21 Jan 2021 06:50:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.0
Received: from [192.168.0.105] (unknown [49.204.182.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AFEB9C433CA;
        Thu, 21 Jan 2021 06:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AFEB9C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH V1] clk: qcom: gcc-sc7180: Mark the MM XO clocks to be
 always ON
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette ? <mturquette@baylibre.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1611128871-5898-1-git-send-email-tdas@codeaurora.org>
 <YAixaN6fta27XDnO@builder.lan>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <71dc2c94-7488-1a69-5cb8-2ff4db184338@codeaurora.org>
Date:   Thu, 21 Jan 2021 12:19:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <YAixaN6fta27XDnO@builder.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 1/21/2021 4:10 AM, Bjorn Andersson wrote:
> On Wed 20 Jan 01:47 CST 2021, Taniya Das wrote:
> 
>> There are intermittent GDSC power-up failures observed for titan top
>> gdsc, which requires the XO clock. Thus mark all the MM XO clocks always
>> enabled from probe.
>>
> 
> But if this is the reason for keeping all these {ahb,xo}_clks critical
> (or upstream just a bunch of hard coded regmap_update_bits()) why don't
> we properly describe them as dependencies for the clock controller/gdsc?
> I.e. by the use of pm_clk_add()?
> 
> Regards,
> Bjorn

They are already defined in the camcc driver, but they are not working 
as expected, thus I am forced to mark them always ON.

> 
>> Fixes: 8d4025943e13 ("clk: qcom: camcc-sc7180: Use runtime PM ops instead of clk ones")
>> Signed-off-by: Taniya Das <tdas@codeaurora.org>
>> ---
>>   drivers/clk/qcom/gcc-sc7180.c | 47 ++++---------------------------------------
>>   1 file changed, 4 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
>> index b05901b..88e896a 100644
>> --- a/drivers/clk/qcom/gcc-sc7180.c
>> +++ b/drivers/clk/qcom/gcc-sc7180.c
>> @@ -1,6 +1,6 @@
>>   // SPDX-License-Identifier: GPL-2.0-only
>>   /*
>> - * Copyright (c) 2019-2020, The Linux Foundation. All rights reserved.
>> + * Copyright (c) 2019-2021, The Linux Foundation. All rights reserved.
>>    */
>>
>>   #include <linux/clk-provider.h>
>> @@ -919,19 +919,6 @@ static struct clk_branch gcc_camera_throttle_hf_axi_clk = {
>>   	},
>>   };
>>
>> -static struct clk_branch gcc_camera_xo_clk = {
>> -	.halt_reg = 0xb02c,
>> -	.halt_check = BRANCH_HALT,
>> -	.clkr = {
>> -		.enable_reg = 0xb02c,
>> -		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data){
>> -			.name = "gcc_camera_xo_clk",
>> -			.ops = &clk_branch2_ops,
>> -		},
>> -	},
>> -};
>> -
>>   static struct clk_branch gcc_ce1_ahb_clk = {
>>   	.halt_reg = 0x4100c,
>>   	.halt_check = BRANCH_HALT_VOTED,
>> @@ -1096,19 +1083,6 @@ static struct clk_branch gcc_disp_throttle_hf_axi_clk = {
>>   	},
>>   };
>>
>> -static struct clk_branch gcc_disp_xo_clk = {
>> -	.halt_reg = 0xb030,
>> -	.halt_check = BRANCH_HALT,
>> -	.clkr = {
>> -		.enable_reg = 0xb030,
>> -		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data){
>> -			.name = "gcc_disp_xo_clk",
>> -			.ops = &clk_branch2_ops,
>> -		},
>> -	},
>> -};
>> -
>>   static struct clk_branch gcc_gp1_clk = {
>>   	.halt_reg = 0x64000,
>>   	.halt_check = BRANCH_HALT,
>> @@ -2159,19 +2133,6 @@ static struct clk_branch gcc_video_throttle_axi_clk = {
>>   	},
>>   };
>>
>> -static struct clk_branch gcc_video_xo_clk = {
>> -	.halt_reg = 0xb028,
>> -	.halt_check = BRANCH_HALT,
>> -	.clkr = {
>> -		.enable_reg = 0xb028,
>> -		.enable_mask = BIT(0),
>> -		.hw.init = &(struct clk_init_data){
>> -			.name = "gcc_video_xo_clk",
>> -			.ops = &clk_branch2_ops,
>> -		},
>> -	},
>> -};
>> -
>>   static struct clk_branch gcc_mss_cfg_ahb_clk = {
>>   	.halt_reg = 0x8a000,
>>   	.halt_check = BRANCH_HALT,
>> @@ -2304,7 +2265,6 @@ static struct clk_regmap *gcc_sc7180_clocks[] = {
>>   	[GCC_BOOT_ROM_AHB_CLK] = &gcc_boot_rom_ahb_clk.clkr,
>>   	[GCC_CAMERA_HF_AXI_CLK] = &gcc_camera_hf_axi_clk.clkr,
>>   	[GCC_CAMERA_THROTTLE_HF_AXI_CLK] = &gcc_camera_throttle_hf_axi_clk.clkr,
>> -	[GCC_CAMERA_XO_CLK] = &gcc_camera_xo_clk.clkr,
>>   	[GCC_CE1_AHB_CLK] = &gcc_ce1_ahb_clk.clkr,
>>   	[GCC_CE1_AXI_CLK] = &gcc_ce1_axi_clk.clkr,
>>   	[GCC_CE1_CLK] = &gcc_ce1_clk.clkr,
>> @@ -2317,7 +2277,6 @@ static struct clk_regmap *gcc_sc7180_clocks[] = {
>>   	[GCC_DISP_GPLL0_DIV_CLK_SRC] = &gcc_disp_gpll0_div_clk_src.clkr,
>>   	[GCC_DISP_HF_AXI_CLK] = &gcc_disp_hf_axi_clk.clkr,
>>   	[GCC_DISP_THROTTLE_HF_AXI_CLK] = &gcc_disp_throttle_hf_axi_clk.clkr,
>> -	[GCC_DISP_XO_CLK] = &gcc_disp_xo_clk.clkr,
>>   	[GCC_GP1_CLK] = &gcc_gp1_clk.clkr,
>>   	[GCC_GP1_CLK_SRC] = &gcc_gp1_clk_src.clkr,
>>   	[GCC_GP2_CLK] = &gcc_gp2_clk.clkr,
>> @@ -2413,7 +2372,6 @@ static struct clk_regmap *gcc_sc7180_clocks[] = {
>>   	[GCC_VIDEO_AXI_CLK] = &gcc_video_axi_clk.clkr,
>>   	[GCC_VIDEO_GPLL0_DIV_CLK_SRC] = &gcc_video_gpll0_div_clk_src.clkr,
>>   	[GCC_VIDEO_THROTTLE_AXI_CLK] = &gcc_video_throttle_axi_clk.clkr,
>> -	[GCC_VIDEO_XO_CLK] = &gcc_video_xo_clk.clkr,
>>   	[GPLL0] = &gpll0.clkr,
>>   	[GPLL0_OUT_EVEN] = &gpll0_out_even.clkr,
>>   	[GPLL6] = &gpll6.clkr,
>> @@ -2510,6 +2468,9 @@ static int gcc_sc7180_probe(struct platform_device *pdev)
>>   	regmap_update_bits(regmap, 0x0b004, BIT(0), BIT(0));
>>   	regmap_update_bits(regmap, 0x0b008, BIT(0), BIT(0));
>>   	regmap_update_bits(regmap, 0x0b00c, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x0b02c, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x0b028, BIT(0), BIT(0));
>> +	regmap_update_bits(regmap, 0x0b030, BIT(0), BIT(0));
>>   	regmap_update_bits(regmap, 0x71004, BIT(0), BIT(0));
>>
>>   	ret = qcom_cc_register_rcg_dfs(regmap, gcc_dfs_clocks,
>> --
>> Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
>> of the Code Aurora Forum, hosted by the  Linux Foundation.
>>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C28C28D2D0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Oct 2020 19:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387622AbgJMRFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Oct 2020 13:05:38 -0400
Received: from z5.mailgun.us ([104.130.96.5]:13831 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728619AbgJMRFi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Oct 2020 13:05:38 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602608736; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=YTaebKKbSFfDkBLgSmtyi+26Uv70n9SE6Qp6TyuX3HI=; b=UtGDNnwOqP7fhq7CJnVD/AxYMCjtszA3hAAR8e7EB1TDtTTxLo9uEeQjlLm8BuVKiXLJOJfz
 kSYUjWSW9P3yJCaBkWvECjgM3epiFOre+pbW7hDkVFYI3u1tbSvES/MsFF26G/zx6n/4RKu0
 CrT+K3rYwNPfUsPfV1L+KPJIoe4=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f85de044f8cc67c310a915e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 13 Oct 2020 17:04:04
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E0A13C43382; Tue, 13 Oct 2020 17:04:03 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from [192.168.0.104] (unknown [49.204.182.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 65688C433CB;
        Tue, 13 Oct 2020 17:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 65688C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tdas@codeaurora.org
Subject: Re: [PATCH v1 1/3] clk: qcom: clk-alpha-pll: Add support for
 controlling Agera PLLs
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        robh@kernel.org, robh+dt@kernel.org
References: <1599584848-15530-1-git-send-email-tdas@codeaurora.org>
 <1599584848-15530-2-git-send-email-tdas@codeaurora.org>
 <160012882627.4188128.11464299361688037948@swboyd.mtv.corp.google.com>
From:   Taniya Das <tdas@codeaurora.org>
Message-ID: <a88817ea-6fd2-9225-41e4-b6b9dff2fb13@codeaurora.org>
Date:   Tue, 13 Oct 2020 22:33:54 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <160012882627.4188128.11464299361688037948@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Stephen.

On 9/15/2020 5:43 AM, Stephen Boyd wrote:
> Quoting Taniya Das (2020-09-08 10:07:26)
>> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
>> index 26139ef..fb27fcf 100644
>> --- a/drivers/clk/qcom/clk-alpha-pll.c
>> +++ b/drivers/clk/qcom/clk-alpha-pll.c
>> @@ -1561,3 +1571,75 @@ const struct clk_ops clk_alpha_pll_postdiv_lucid_ops = {
>>          .set_rate = clk_alpha_pll_postdiv_fabia_set_rate,
>>   };
>>   EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_lucid_ops);
>> +
>> +void clk_agera_pll_configure(struct clk_alpha_pll *pll, struct regmap *regmap,
>> +                       const struct alpha_pll_config *config)
>> +{
>> +       if (config->l)
>> +               regmap_write(regmap, PLL_L_VAL(pll), config->l);
>> +
>> +       if (config->alpha)
>> +               regmap_write(regmap, PLL_ALPHA_VAL(pll), config->alpha);
>> +
>> +       if (config->user_ctl_val)
>> +               regmap_write(regmap, PLL_USER_CTL(pll), config->user_ctl_val);
>> +
>> +       if (config->config_ctl_val)
>> +               regmap_write(regmap, PLL_CONFIG_CTL(pll),
>> +                                               config->config_ctl_val);
>> +
>> +       if (config->config_ctl_hi_val)
>> +               regmap_write(regmap, PLL_CONFIG_CTL_U(pll),
>> +                                               config->config_ctl_hi_val);
>> +
>> +       if (config->test_ctl_val)
>> +               regmap_write(regmap, PLL_TEST_CTL(pll),
>> +                                               config->test_ctl_val);
>> +
>> +       if (config->test_ctl_hi_val)
>> +               regmap_write(regmap,  PLL_TEST_CTL_U(pll),
>> +                                               config->test_ctl_hi_val);
>> +}
>> +EXPORT_SYMBOL_GPL(clk_agera_pll_configure);
>> +
>> +static int alpha_pll_agera_set_rate(struct clk_hw *hw, unsigned long rate,
> 
> Why not clk_alpha_pll prefix? We should prefix the other PLL functions
> in here with clk_alpha_ like trion and fabia
> 

Yes, I will update this in the next patch.

>> +                                                       unsigned long prate)
>> +{
>> +       struct clk_alpha_pll *pll = to_clk_alpha_pll(hw);
>> +       u32 l, alpha_width = pll_alpha_width(pll);
>> +       unsigned long rrate;
>> +       u64 a;
>> +
>> +       rrate = alpha_pll_round_rate(rate, prate, &l, &a, alpha_width);
>> +
>> +       /*
>> +        * Due to limited number of bits for fractional rate programming, the
>> +        * rounded up rate could be marginally higher than the requested rate.
>> +        */
>> +       if (rrate > (rate + PLL_RATE_MARGIN) || rrate < rate) {
>> +               pr_err("Call set rate on the PLL with rounded rates!\n");
>> +               return -EINVAL;
>> +       }
> 
> See commit f78f29079327 ("clk: qcom: alpha-pll: Make error prints more
> informative") where I tried to make this better. Can you extract this
> check into a function that helps us understand the error better?
> 

Updated to follow the same.

>> +
>> +       /* change L_VAL without having to go through the power on sequence */
>> +       regmap_write(pll->clkr.regmap, PLL_L_VAL(pll), l);
>> +       regmap_write(pll->clkr.regmap, PLL_ALPHA_VAL(pll), a);
>> +
>> +       /* Ensure that the write above goes through before proceeding. */
>> +       mb();
> 
> regmap has an mb() in it. Remove this?
> 

Yes, will remove it.

>> +
>> +       if (clk_hw_is_enabled(hw))
>> +               return wait_for_pll_enable_lock(pll);
>> +
>> +       return 0;
>> +}
>> +
>> +const struct clk_ops clk_alpha_pll_agera_ops = {
>> +       .enable = clk_alpha_pll_enable,
>> +       .disable = clk_alpha_pll_disable,
>> +       .is_enabled = clk_alpha_pll_is_enabled,
>> +       .recalc_rate = alpha_pll_fabia_recalc_rate,
>> +       .round_rate = clk_alpha_pll_round_rate,
>> +       .set_rate = alpha_pll_agera_set_rate,
>> +};
>> +EXPORT_SYMBOL_GPL(clk_alpha_pll_agera_ops);

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation.

--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 120871C35D4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 11:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbgEDJch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 May 2020 05:32:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:37572 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726625AbgEDJch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 05:32:37 -0400
IronPort-SDR: UO6hnEJI0jgCptRStUSRHFswz44PU36PtuzA1j/MOVO/Wf3vyXKXm8t2407133kv/lcB/weKCB
 iwOybFQPdl7Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 May 2020 02:32:36 -0700
IronPort-SDR: gogS56CzkeTAhj4gf/NBkhnc2YLR41DiO9IoL86fVUfYgn0W5qOamzEYizWTABiIY9+PgZGvOB
 3L2qC5eQ8GNQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,351,1583222400"; 
   d="scan'208";a="406421994"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 04 May 2020 02:32:36 -0700
Received: from [10.215.163.15] (ekotax-mobl.gar.corp.intel.com [10.215.163.15])
        by linux.intel.com (Postfix) with ESMTP id 6BD5B580613;
        Mon,  4 May 2020 02:32:33 -0700 (PDT)
Subject: Re: [PATCH v7 3/3] phy: intel: Add driver support for ComboPhy
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kishon@ti.com,
        devicetree@vger.kernel.org, lee.jones@linaro.org, arnd@arndb.de,
        robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1588230494.git.eswara.kota@linux.intel.com>
 <af8a7d7025990d22f6062953247cf80e64c6fd2f.1588230494.git.eswara.kota@linux.intel.com>
 <20200504072923.GN1375924@vkoul-mobl>
 <f12e76ac-e0fd-4afa-e1cd-2b90f175adfd@linux.intel.com>
 <20200504092034.GS1375924@vkoul-mobl>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0de7ba47-bc98-9267-46b4-230a86151c2d@linux.intel.com>
Date:   Mon, 4 May 2020 17:32:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504092034.GS1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/4/2020 5:20 PM, Vinod Koul wrote:
> On 04-05-20, 16:26, Dilip Kota wrote:
>> On 5/4/2020 3:29 PM, Vinod Koul wrote:
>>> On 30-04-20, 15:15, Dilip Kota wrote:
>>>
>>>> +					  u32 mask, u32 val)
>>>> +{
>>>> +	u32 reg_val;
>>>> +
>>>> +	reg_val = readl(base + reg);
>>>> +	reg_val &= ~mask;
>>>> +	reg_val |= FIELD_PREP(mask, val);
>>>> +	writel(reg_val, base + reg);
>>> bypassing regmap here... why?
>> It is not regmap address, one of the below two addresses are passed to this
>> function.
> okay, perhaps add a comment somewhere that regmap is not used for this
> base?
I dont see a need of adding a comment, describing don't do regmap here.
>
>> struct intel_combo_phy {
>> ...
>>          void __iomem            *app_base;
>>          void __iomem            *cr_base;
>> ...
>> }
>
>>>> +static int intel_cbphy_calibrate(struct phy *phy)
>>>> +{
>>>> +	struct intel_cbphy_iphy *iphy = phy_get_drvdata(phy);
>>>> +	struct intel_combo_phy *cbphy = iphy->parent;
>>>> +	void __iomem *cr_base = cbphy->cr_base;
>>>> +	int val, ret, id;
>>>> +
>>>> +	if (cbphy->phy_mode != PHY_XPCS_MODE)
>>>> +		return 0;
>>>> +
>>>> +	id = PHY_ID(iphy);
>>>> +
>>>> +	/* trigger auto RX adaptation */
>>>> +	combo_phy_w32_off_mask(cr_base, CR_ADDR(PCS_XF_ATE_OVRD_IN_2, id),
>>>> +			       ADAPT_REQ_MSK, 3);
>>>> +	/* Wait RX adaptation to finish */
>>>> +	ret = readl_poll_timeout(cr_base + CR_ADDR(PCS_XF_RX_ADAPT_ACK, id),
>>>> +				 val, val & RX_ADAPT_ACK_BIT, 10, 5000);
>>>> +	if (ret)
>>>> +		dev_err(cbphy->dev, "RX Adaptation failed!\n");
>>> you want to continue her and not return error?
>> Next step is stopping the Adaptation, it should be done in both error and
>> success case.
> Again documenting this helps, pls add some comments on this behaviour
Comments are already in place, mentioning Start and Stop of Rx 
Adaptation. And Stop is being is done as Start is triggered, so not 
needed to mention error and success.

Regards,
Dilip
>

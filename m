Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6526B1D8F2A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 07:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgESFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 01:25:36 -0400
Received: from mga06.intel.com ([134.134.136.31]:62017 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726272AbgESFZg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:25:36 -0400
IronPort-SDR: F0TyniTaYOpQcPcEYX/tssZaMxgGWRCIThMKbrTlQoDic4B4Cu9VFi9Iw3+8a67MZfNSZf9RVU
 tOXIBM6hr8kw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 22:25:35 -0700
IronPort-SDR: LGX8upskP+MMLGkSI3XQm3x4oUBqrBi32q+HnjFHIJ7xsmZZbVwRGjygVmPlNb83gfEtLcx9bQ
 fo9IuLbtUUpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,409,1583222400"; 
   d="scan'208";a="308305319"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 18 May 2020 22:25:34 -0700
Received: from [10.213.130.67] (ekotax-mobl.gar.corp.intel.com [10.213.130.67])
        by linux.intel.com (Postfix) with ESMTP id 5846E580613;
        Mon, 18 May 2020 22:25:32 -0700 (PDT)
Subject: Re: [RESEND PATCH v8 0/3] Add Intel ComboPhy driver
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, vkoul@kernel.org,
        devicetree@vger.kernel.org
Cc:     robh@kernel.org, andriy.shevchenko@intel.com,
        cheol.yong.kim@intel.com, chuanhua.lei@linux.intel.com,
        qi-ming.wu@intel.com, yixin.zhu@intel.com
References: <cover.1589530082.git.eswara.kota@linux.intel.com>
 <1d58e6e6-4860-dbde-1b9e-e0804180cddb@ti.com>
 <3e7e3f45-1441-84bd-a218-63847363d9ff@linux.intel.com>
 <18a8da3f-4fdf-3da6-2023-c5c66176475d@ti.com>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <0ca57046-9bdc-69f3-3891-cac19cd57e8e@linux.intel.com>
Date:   Tue, 19 May 2020 13:25:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <18a8da3f-4fdf-3da6-2023-c5c66176475d@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/19/2020 1:17 PM, Kishon Vijay Abraham I wrote:
> Dilip,
>
> On 5/19/2020 9:26 AM, Dilip Kota wrote:
>> On 5/18/2020 9:49 PM, Kishon Vijay Abraham I wrote:
>>> Dilip,
>>>
>>> On 5/15/2020 1:43 PM, Dilip Kota wrote:
>>>> This patch series adds Intel ComboPhy driver, respective yaml schemas
>>>>
>>>> Changes on v8:
>>>>     As per PHY Maintainer's request add description in comments for doing
>>>>     register access through register map framework.
>>>>
>>>> Changes on v7:
>>>>     As per System control driver maintainer's inputs remove
>>>>       fwnode_to_regmap() definition and use device_node_get_regmap()
>>> Can you fix this warning and resend the patch?
>>> drivers/phy/intel/phy-intel-combo.c:229:6: warning: ‘cb_mode’ may be used
>>> uninitialized in this function [-Wmaybe-uninitialized]
>>>     ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
>>>     ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/phy/intel/phy-intel-combo.c:204:24: note: ‘cb_mode’ was declared here
>>>     enum intel_combo_mode cb_mode;
>>>                           ^~~~~~~
>> I noticed this warning while preparing the patch.
>> It sounds like false warning because:
>> 1.) "cb_mode" is initialized in the switch case based on the "mode =
>> cbphy->phy_mode;"
>> 2.) cbphy->phy_mode is initialized during the probe in
>> "intel_cbphy_fwnode_parse()" with one of the 3 values.
>> PHY_PCIE_MODE, PHY_SATA_MODE, PHY_XPCS_MODE.
>> 3.) There is no chance of "cbphy->phy_mode" having different value.
>> 4.) And "cb_mode" will be initialized according to the "mode = cbphy->phy_mode;"
>> 5.) Hence, there is no chance of "cb_mode" getting accessed uninitialized.
> Let's try to keep the compiler happy. Please fix this warning.
Sure, will fix it and send the patch series.
>
> Thanks
> Kishon

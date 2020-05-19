Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1EE1D8F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 07:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgESFSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 01:18:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39422 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbgESFSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 01:18:01 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04J5Hu3w128117;
        Tue, 19 May 2020 00:17:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589865476;
        bh=d/XYFqVdSGUT+50/eTEWr58MI/LZrlOnTqNemlIfRzk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=H8Q4t53Mkf3ONinqGeBDmIA3DgyyKj+4kwch9eqJotd8cnRfMjo1smdtpWEIFJLAv
         sDFEoppkxzEZDP9fo3gFsP9Ob85EmJHkBMQRqVmtxchh7zGQTIBHEuAumkA9YJiG2V
         5zkvQHgzDSYI6KMVlGFr9I+WTjsAlslhK7YTgTzs=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04J5Hu7F049091;
        Tue, 19 May 2020 00:17:56 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 00:17:55 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 00:17:55 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04J5Hql3092372;
        Tue, 19 May 2020 00:17:53 -0500
Subject: Re: [RESEND PATCH v8 0/3] Add Intel ComboPhy driver
To:     Dilip Kota <eswara.kota@linux.intel.com>,
        <linux-kernel@vger.kernel.org>, <vkoul@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh@kernel.org>, <andriy.shevchenko@intel.com>,
        <cheol.yong.kim@intel.com>, <chuanhua.lei@linux.intel.com>,
        <qi-ming.wu@intel.com>, <yixin.zhu@intel.com>
References: <cover.1589530082.git.eswara.kota@linux.intel.com>
 <1d58e6e6-4860-dbde-1b9e-e0804180cddb@ti.com>
 <3e7e3f45-1441-84bd-a218-63847363d9ff@linux.intel.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <18a8da3f-4fdf-3da6-2023-c5c66176475d@ti.com>
Date:   Tue, 19 May 2020 10:47:52 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3e7e3f45-1441-84bd-a218-63847363d9ff@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dilip,

On 5/19/2020 9:26 AM, Dilip Kota wrote:
> 
> On 5/18/2020 9:49 PM, Kishon Vijay Abraham I wrote:
>> Dilip,
>>
>> On 5/15/2020 1:43 PM, Dilip Kota wrote:
>>> This patch series adds Intel ComboPhy driver, respective yaml schemas
>>>
>>> Changes on v8:
>>>    As per PHY Maintainer's request add description in comments for doing
>>>    register access through register map framework.
>>>
>>> Changes on v7:
>>>    As per System control driver maintainer's inputs remove
>>>      fwnode_to_regmap() definition and use device_node_get_regmap()
>> Can you fix this warning and resend the patch?
>> drivers/phy/intel/phy-intel-combo.c:229:6: warning: ‘cb_mode’ may be used
>> uninitialized in this function [-Wmaybe-uninitialized]
>>    ret = regmap_write(cbphy->hsiocfg, REG_COMBO_MODE(cbphy->bid), cb_mode);
>>    ~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/phy/intel/phy-intel-combo.c:204:24: note: ‘cb_mode’ was declared here
>>    enum intel_combo_mode cb_mode;
>>                          ^~~~~~~
> I noticed this warning while preparing the patch.
> It sounds like false warning because:
> 1.) "cb_mode" is initialized in the switch case based on the "mode =
> cbphy->phy_mode;"
> 2.) cbphy->phy_mode is initialized during the probe in
> "intel_cbphy_fwnode_parse()" with one of the 3 values.
> PHY_PCIE_MODE, PHY_SATA_MODE, PHY_XPCS_MODE.
> 3.) There is no chance of "cbphy->phy_mode" having different value.
> 4.) And "cb_mode" will be initialized according to the "mode = cbphy->phy_mode;"
> 5.) Hence, there is no chance of "cb_mode" getting accessed uninitialized.

Let's try to keep the compiler happy. Please fix this warning.

Thanks
Kishon

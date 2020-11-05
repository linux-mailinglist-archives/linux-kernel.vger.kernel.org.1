Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A992A75F1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 04:10:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733236AbgKEDKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 22:10:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:7830 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731175AbgKEDKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 22:10:32 -0500
IronPort-SDR: EatM2lZeseVgFQW6dicSpZs9NfoTEeWmTklcGZikfTUcVN8elszCc5bwTFUjbBzXLUUu0kWAe/
 U7YdyzL+TBTg==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="149174162"
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="149174162"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2020 19:10:32 -0800
IronPort-SDR: PuvK8QPaHSE8f6b9etfQGhzDqsRW0Ahlj3lBVZPmEq5ms0IxAK0PUXeAHJbBtif2czvu1eHgOr
 LvMtHnR3aH9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,452,1596524400"; 
   d="scan'208";a="325858998"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 04 Nov 2020 19:10:31 -0800
Received: from [10.226.38.24] (unknown [10.226.38.24])
        by linux.intel.com (Postfix) with ESMTP id A401558078C;
        Wed,  4 Nov 2020 19:10:28 -0800 (PST)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v16 1/2] dt-bindings: mtd: Add Nand Flash Controller
 support for Intel LGM SoC
To:     Rob Herring <robh@kernel.org>
Cc:     robh+dt@kernel.org, cheol.yong.kim@intel.com,
        tudor.ambarus@microchip.com, miquel.raynal@bootlin.com,
        vigneshr@ti.com, devicetree@vger.kernel.org, dinguyen@kernel.org,
        qi-ming.wu@intel.com, linux-mtd@lists.infradead.org,
        richard@nod.at, simon.k.r.goldschmidt@gmail.com,
        linux-kernel@vger.kernel.org
References: <20201103075655.18699-1-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201103075655.18699-2-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20201104185631.GA3946406@bogus>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <877b315f-c551-822d-71a8-84589b116c0f@linux.intel.com>
Date:   Thu, 5 Nov 2020 11:10:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104185631.GA3946406@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 5/11/2020 2:56 am, Rob Herring wrote:
> On Tue, 03 Nov 2020 15:56:54 +0800, Ramuthevar,Vadivel MuruganX wrote:
>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>
>> Add YAML file for dt-bindings to support NAND Flash Controller
>> on Intel's Lightning Mountain SoC.
>>
>> Signed-off-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>   .../devicetree/bindings/mtd/intel,lgm-nand.yaml    | 99 ++++++++++++++++++++++
>>   1 file changed, 99 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml
>>
> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/mtd/intel,lgm-nand.yaml:24:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
> 
> dtschema/dtc warnings/errors:
> 
> 
> See https://patchwork.ozlabs.org/patch/1392698
> 
> The base for the patch is generally the last rc1. Any dependencies
> should be noted.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
Thank you Rob, will install, check and update.

Regards
Vadivel
> 

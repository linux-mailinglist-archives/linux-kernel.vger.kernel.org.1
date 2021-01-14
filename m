Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0578F2F5E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 11:20:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbhANKSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jan 2021 05:18:11 -0500
Received: from foss.arm.com ([217.140.110.172]:47166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbhANKSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jan 2021 05:18:04 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 917731FB;
        Thu, 14 Jan 2021 02:17:19 -0800 (PST)
Received: from [10.57.56.97] (unknown [10.57.56.97])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9ED2E3F70D;
        Thu, 14 Jan 2021 02:17:17 -0800 (PST)
Subject: Re: [PATCH V2 11/11] dts: bindings: Document device tree bindings for
 Arm TRBE
To:     Rob Herring <robh@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mike.leach@linaro.org, devicetree@vger.kernel.org
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
 <1610511498-4058-12-git-send-email-anshuman.khandual@arm.com>
 <1610552704.268262.2506183.nullmailer@robh.at.kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b35f87bf-554f-444c-8b8e-9d62cf12d8f7@arm.com>
Date:   Thu, 14 Jan 2021 10:17:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <1610552704.268262.2506183.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob

On 1/13/21 3:45 PM, Rob Herring wrote:
> On Wed, 13 Jan 2021 09:48:18 +0530, Anshuman Khandual wrote:
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> Document the device tree bindings for Trace Buffer Extension (TRBE).
>>
>> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: devicetree@vger.kernel.org
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   Documentation/devicetree/bindings/arm/trbe.yaml | 46 +++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/arm/trbe.yaml
>>
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/arm/trbe.yaml:39:2: [warning] wrong indentation: expected 2 but found 1 (indentation)
> 
> dtschema/dtc warnings/errors:

Thanks for that. I guess Anshuman can fix this up, with the following patch:

diff --git a/Documentation/devicetree/bindings/arm/trbe.yaml 
b/Documentation/devicetree/bindings/arm/trbe.yaml
index 2258595c40dd..24951e02fa58 100644
--- a/Documentation/devicetree/bindings/arm/trbe.yaml
+++ b/Documentation/devicetree/bindings/arm/trbe.yaml
@@ -36,7 +36,7 @@ additionalProperties: false

  examples:

- - |
+  - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>

     trbe {

> 
> See https://patchwork.ozlabs.org/patch/1425605
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:

I did see the warning, but I thought I fixed it. Sorry about that.

Cheers
Suzuki

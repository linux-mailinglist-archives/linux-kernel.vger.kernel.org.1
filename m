Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9452687BE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 10:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgINI7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgINI7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 04:59:42 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE25FC06174A;
        Mon, 14 Sep 2020 01:59:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so10409089wmi.0;
        Mon, 14 Sep 2020 01:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/MIKedoIOUsFjweTslvur4pBQa9SNFf9T3eSu+x3ZqE=;
        b=JFph4kBzYlVFBa10GDi5JH43OZeeNU4SUMmmwxnl5A/9diq+SmrOMfPD/GLMH3oxDe
         hhOuJgoNfWUovkwB1tKcMiGQTDGPqZEsJjInlTw7pW7SVQNr/d680yEthOrM4IEmJSNE
         hzdp0ZcibpG2ByVJqTWNgHax8h6YshM4TPFcP/gjlXkb1NbkxqQjozb+U3eRzibzBdAH
         hCs6kK1VTuZS+pINj4LH0Q33/Zgbxzb4lvWYQkpUwiDMqdpNVZJV/xV5fLEqhonnjJhW
         1jWCE44sTq0W7LbmYBbBHjScJk28qHgH5DmVJxrcUhAPjm2ja9RNQYm4AucjQAtdwQ2m
         fZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/MIKedoIOUsFjweTslvur4pBQa9SNFf9T3eSu+x3ZqE=;
        b=XcLq8jppoOLG/V5eUKEDwPcAZdPvv0NtB9PraLC0ZLjd9bxdzKlUGDxyCzmelBvjs1
         th/F8t4sVnRfppTMF/UxXK39URNCTBy9sYXp84uf1jaudqNuBvegohVwQZUUSJ4mCX29
         DV1nKkp/kcww1Rv9nH1wnVlXsT4TUQpPZijphwRj0/LHtNqVpuQ5dZGEF6RhHFVpzrka
         TRMBoy97YKTMVGoBJwSqFf1fE93Pb+S8h+bUd/qqyFjExAQW5n4bsSHNUfC/7G7XiVfK
         MSVMiOh2UhgwWfS73fz4xTZWh52iy5iLsKJUX5Hed3D613wcX8CImBv+0eaNoPyIEmVp
         yuNw==
X-Gm-Message-State: AOAM533M/XOCSlh0XbrZzL2dx8SqlMTctuVkdAGHpfM30Gk/i22dP8yC
        CyzaXOJ4du3W9Ljx3R2FVV0=
X-Google-Smtp-Source: ABdhPJxdQrb1I8Rlz09G/IfEfX9kFrBzNcFYdPCZNmq0bpJ7m6Td4pGvrxBHZyfwPP2YvhAb4HCi5g==
X-Received: by 2002:a1c:9654:: with SMTP id y81mr14000152wmd.9.1600073980332;
        Mon, 14 Sep 2020 01:59:40 -0700 (PDT)
Received: from ziggy.stardust ([213.195.113.201])
        by smtp.gmail.com with ESMTPSA id z13sm19391670wro.97.2020.09.14.01.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Sep 2020 01:59:39 -0700 (PDT)
Subject: Re: [PATCH 01/12] dt-bindings: power: Add bindings for the Mediatek
 SCPSYS power domains controller
To:     Rob Herring <robh@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
        Collabora Kernel ML <kernel@collabora.com>,
        fparent@baylibre.com, drinkcat@chromium.org, hsinyi@chromium.org,
        weiyi.lu@mediatek.com, Matthias Brugger <mbrugger@suse.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20200910172826.3074357-1-enric.balletbo@collabora.com>
 <20200910172826.3074357-2-enric.balletbo@collabora.com>
 <20200911230255.GA2972120@bogus>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <7a1c89b6-f483-5d57-f154-b80b72964077@gmail.com>
Date:   Mon, 14 Sep 2020 10:59:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200911230255.GA2972120@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/2020 01:02, Rob Herring wrote:
> On Thu, Sep 10, 2020 at 07:28:15PM +0200, Enric Balletbo i Serra wrote:
>> The System Control Processor System (SCPSYS) has several power management
>> related tasks in the system. Add the bindings to define the power
>> domains for the SCPSYS power controller.
>>
>> Co-developed-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>> Dear Rob,
>>
>> I am awasre that this binding is not ready, but I prefered to send because I'm
>> kind of blocked. Compiling this binding triggers the following error:
>>
>>      mediatek,power-controller.example.dt.yaml: syscon@10006000: mfg_async@7:
>>      '#address-cells', '#size-cells', 'mfg_2d@8'
>>      do not match any of the regexes: 'pinctrl-[0-9]+'
>>
>> This happens when a definition of a power-domain (parent) contains
>> another power-domain (child), like the example. I am not sure how to
>> specify this in the yaml and deal with this, so any clue is welcome.
> 
> You just have to keep nesting schemas all the way down. Define a
> grandchild node under the child node and then all of its properties.
> 
>>
>> Thanks,
>>    Enric
>>
>>   .../power/mediatek,power-controller.yaml      | 171 ++++++++++++++++++
>>   1 file changed, 171 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> new file mode 100644
>> index 000000000000..8be9244ad160
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/mediatek,power-controller.yaml
>> @@ -0,0 +1,171 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/power/mediatek,power-controller.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Mediatek Power Domains Controller
>> +
>> +maintainers:
>> +  - Weiyi Lu <weiyi.lu@mediatek.com>
>> +  - Matthias Brugger <mbrugger@suse.com>
>> +
>> +description: |
>> +  Mediatek processors include support for multiple power domains which can be
>> +  powered up/down by software based on different application scenes to save power.
>> +
>> +  IP cores belonging to a power domain should contain a 'power-domains'
>> +  property that is a phandle for SCPSYS node representing the domain.
>> +
>> +properties:
>> +  $nodename:
>> +    pattern: "^syscon@[0-9a-f]+$"
>> +
>> +  compatible:
>> +    items:
>> +      - enum:
>> +        - mediatek,mt8173-power-controller
>> +      - const: syscon
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +patternProperties:
>> +  "^.*@[0-9]$":
> 
> Node names should be generic:
> 
> power-domain@
> 

Enric correct me if I'm wrong, if we want to see the power domains in debugfs, 
they are listed by their name. If all are called power-domain then the listing 
is pretty much useless.

>> +    type: object
>> +    description: |
>> +      Represents the power domains within the power controller node as documented
>> +      in Documentation/devicetree/bindings/power/power-domain.yaml.
>> +
>> +    properties:
>> +      reg:
>> +        description: |
>> +          Power domain index. Valid values are defined in:
>> +              "include/dt-bindings/power/mt8173-power.h" - for MT8173 type power domain.
>> +        maxItems: 1
>> +
>> +      '#power-domain-cells':
>> +        description:
>> +          Documented by the generic PM Domain bindings in
>> +          Documentation/devicetree/bindings/power/power-domain.yaml.
> 
> No need to redefine a common property. This should define valid values
> for it.
> 
>> +
>> +      clocks:
>> +        description: |
>> +          A number of phandles to clocks that need to be enabled during domain
>> +          power-up sequencing.
> 
> No need to redefine 'clocks'. You need to define how many, what each one
> is, and the order.
> 

Do you mean we have to define each clock for each power domain of each SoC?

>> +
>> +      clock-names:
>> +        description: |
>> +          List of names of clocks, in order to match the power-up sequencing
>> +          for each power domain we need to group the clocks by name. BASIC
>> +          clocks need to be enabled before enabling the corresponding power
>> +          domain, and should not have a '-' in their name (i.e mm, mfg, venc).
>> +          SUSBYS clocks need to be enabled before releasing the bus protection,
>> +          and should contain a '-' in their name (i.e mm-0, isp-0, cam-0).
>> +
>> +          In order to follow properly the power-up sequencing, the clocks must
>> +          be specified by order, adding first the BASIC clocks followed by the
>> +          SUSBSYS clocks.
> 
> You need to define the names.
> 
>> +
>> +      mediatek,infracfg:
>> +        $ref: /schemas/types.yaml#definitions/phandle
>> +        description: phandle to the device containing the INFRACFG register range.
>> +
>> +      mediatek,smi:
>> +        $ref: /schemas/types.yaml#definitions/phandle
>> +        description: phandle to the device containing the SMI register range.
>> +
>> +    required:
>> +      - reg
>> +      - '#power-domain-cells'
>> +
>> +    additionalProperties: false
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/mt8173-clk.h>
>> +    #include <dt-bindings/power/mt8173-power.h>
>> +
>> +    soc {
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +
>> +        scpsys: syscon@10006000 {
>> +            compatible = "mediatek,mt8173-power-controller", "syscon";

The power domain controller is just one funcionality the SCPSYS block can 
provide. I think it should be child of the SCPSYS.

Regards,
Matthias

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C26E28BC0E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390218AbgJLPgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 11:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389121AbgJLPgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 11:36:05 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32A0C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 08:36:04 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kRzrl-0000Wq-U5; Mon, 12 Oct 2020 17:36:01 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than
 "nvmem-cell"
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        ceggers@arri.de, devicetree@vger.kernel.org
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200512141834.GA3023@bogus>
Message-ID: <f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de>
Date:   Mon, 12 Oct 2020 17:36:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20200512141834.GA3023@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,
Hello Srini,

On 5/12/20 4:18 PM, Rob Herring wrote:
> On Tue, Apr 28, 2020 at 01:18:25PM +0200, Ahmad Fatoum wrote:
>> The nvmem cell binding applies to all objects which match "^.*@[0-9a-f]+$",
>> without taking a compatible into account. This precludes extension of e.g.
>> eeprom nodes by any child nodes other than nvmem. Consider following example:
>>
>> 	eeprom@0 {
>> 		reg = <0 64>;
>> 		#address-cells = <1>;
>> 		#size-cells = <1>;
>>
>> 		partitions {
>> 			compatible = "fixed-partitions";
>> 			#address-cells = <1>;
>> 			#size-cells = <1>;
>> 			bits = <64 64 64>; /* to verify it's skipped */
>>
>> 			part@0 {
>> 				reg = <0x00 16>;
>> 			};
>> 		};
>>
>> 		no-cell@10 {
>> 			compatible = "not-nvmem-cell";
>> 			reg = <0x10 4>;
>> 			bits = <64 64 64>; /* to verify it's skipped */
>> 		};
>>
>> 		cell-old@14 {
>> 			reg = <0x14 0x2>;
>> 		};
>>
>> 		cell-new@16 {
>> 			compatible = "nvmem-cell";
>> 			reg = <0x16 4>;
>> 		};
>> 	};
>>
>> Without this series, the NVMEM driver interprets all direct children of eeprom@0
>> as NVMEM cells and driver probe fails, because the partitions node lacks a reg
>> property, e.g.:
>>
>>   nvmem 0-00000: nvmem: invalid reg on /eeprom@0
>>
>> Running dtbs_check on the snippet will skip partitions (it doesn't match above
>> regex), but will flag no-cell@10 and cell-new@16 as invalid.
>>
>> With this series applied, the driver will skip partitions and no-cell@10,
>> because they have a compatible but it's not "nvmem-cell".
> 
> Because you have to support no compatible (forever), there's no point 
> adding this compatible.

IMO nvmem cells should have had a compatible since the beginning and I figured
better late than never.

>> Both cell-old@14 and cell-new@16 will be interpreted as cells.
>>
>> Likewise, running dtbs_check on the snippet will skip partitions (compatible
>> doesn't match and regex doesn't either) and no-cell@10, but accept the other two.
>>
>> This series resolves an existing clash between this nvmem-cell binding and
>> the barebox bootloader binding that extends the fixed-partitions MTD
>> binding to EEPROMs[1]. It's also a building block for getting nvmem cells and
>> partitions in MTD devices to co-exist in the same device tree node[2].
> 
> This violates having multiple nodes at the same address because you are 
> independently overlaying partitions and nvmem cells on same address 
> ranges. It also seems seems pretty fragile if you want to update 
> partitions.
> 
> I think instead, nvmem cells should be contained within a partition. 
> The partition should then have a compatible to indicate it contains 
> nvmem cells.

I thought I had understood what needs to be done, but now that I finally have time
to do it, I see that this only solves the second issue "extending the NVMEM binding
to nodes that already have other child nodes, e.g., MTD and its partitions".

The first issue: "future extension of e.g. eeprom nodes by any child nodes other than
nvmem cells" isn't solved by having a containing partition.


My issue is that the bootloader fixes up a partitions { compatible = "fixed-partitions"; }
child node into the kernel device tree. The NVMEM core driver tries to parse all eeprom child
nodes as cells and will make the driver probe of the EEPROM fail, because it can't parse that
fixed-partitions node as a nvmem cell.

To allow for co-existence of NVMEM cells and other subnodes, would following patch be
acceptable to you and Srini?

---------------------------------------- 8< --------------------------------------
--- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
+++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
@@ -45,7 +45,15 @@ properties:
 patternProperties:
   "^.*@[0-9a-f]+$":
     type: object
-
+    if:
+      not:
+        properties:
+          compatible:
+    then:
+      $ref: "#/definitions/nvmem-cell"
+
+definitions:
+  nvmem-cell:
     properties:
       reg:
         maxItems: 1


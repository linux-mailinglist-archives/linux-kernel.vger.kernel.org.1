Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654802A2E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 16:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgKBPXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 10:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbgKBPXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 10:23:37 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D831C0617A6
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 07:23:37 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1kZbgG-00042X-4N; Mon, 02 Nov 2020 16:23:36 +0100
Subject: Re: [PATCH v3 0/2] nvmem: skip nodes with compatibles other than
 "nvmem-cell"
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     devicetree@vger.kernel.org, ceggers@arri.de,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de
References: <20200428111829.2215-1-a.fatoum@pengutronix.de>
 <20200512141834.GA3023@bogus>
 <f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de>
Message-ID: <3f050e96-8bd3-a77e-b1cf-1739a1be0c2d@pengutronix.de>
Date:   Mon, 2 Nov 2020 16:23:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <f03ecee7-c4b6-7a59-7ab8-42c5dfcaffc4@pengutronix.de>
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

On 10/12/20 5:36 PM, Ahmad Fatoum wrote:
> On 5/12/20 4:18 PM, Rob Herring wrote:

[snip]

>> I think instead, nvmem cells should be contained within a partition. 
>> The partition should then have a compatible to indicate it contains 
>> nvmem cells.
> 
> I thought I had understood what needs to be done, but now that I finally have time
> to do it, I see that this only solves the second issue "extending the NVMEM binding
> to nodes that already have other child nodes, e.g., MTD and its partitions".
> 
> The first issue: "future extension of e.g. eeprom nodes by any child nodes other than
> nvmem cells" isn't solved by having a containing partition.
> 
> 
> My issue is that the bootloader fixes up a partitions { compatible = "fixed-partitions"; }
> child node into the kernel device tree. The NVMEM core driver tries to parse all eeprom child
> nodes as cells and will make the driver probe of the EEPROM fail, because it can't parse that
> fixed-partitions node as a nvmem cell.
> 
> To allow for co-existence of NVMEM cells and other subnodes, would following patch be
> acceptable to you and Srini?

Gentle ping. Would the patch below be acceptable?

> 
> ---------------------------------------- 8< --------------------------------------
> --- a/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/nvmem.yaml
> @@ -45,7 +45,15 @@ properties:
>  patternProperties:
>    "^.*@[0-9a-f]+$":
>      type: object
> -
> +    if:
> +      not:
> +        properties:
> +          compatible:
> +    then:
> +      $ref: "#/definitions/nvmem-cell"
> +
> +definitions:
> +  nvmem-cell:
>      properties:
>        reg:
>          maxItems: 1

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

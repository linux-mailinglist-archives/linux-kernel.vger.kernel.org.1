Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22FD2FF775
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 22:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbhAUVlI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 21 Jan 2021 16:41:08 -0500
Received: from aposti.net ([89.234.176.197]:48654 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbhAUVgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 16:36:19 -0500
Date:   Thu, 21 Jan 2021 21:35:10 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings/phy: ingenic: Add compatibles for
 JZ4760(B) SoCs
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, od@zcrc.me,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Message-Id: <MYZANQ.IGK5L2KYWV23@crapouillou.net>
In-Reply-To: <1611244918.513054.2814838.nullmailer@robh.at.kernel.org>
References: <20210120115945.29046-1-paul@crapouillou.net>
        <1611244918.513054.2814838.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le jeu. 21 janv. 2021 à 10:01, Rob Herring <robh@kernel.org> a écrit :
> On Wed, 20 Jan 2021 11:59:44 +0000, Paul Cercueil wrote:
>>  Add the ingenic,jz4760-phy and ingenic,jz4760b-phy compatible 
>> strings,
>>  and make the ingenic,jz4770-phy compatible string require
>>  ingenic,jz4760-phy as a fallback, since both work the same, and the
>>  JZ4760 SoC is older.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../bindings/phy/ingenic,phy-usb.yaml         | 22 
>> ++++++++++++-------
>>   1 file changed, 14 insertions(+), 8 deletions(-)
>> 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:20:9: 
> [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:27:9: 
> [warning] wrong indentation: expected 10 but found 8 (indentation)
> ./Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml:28:11: 
> [warning] wrong indentation: expected 12 but found 10 (indentation)

I can reproduce, however the indentation in the DTS looks awfully 
correct to me. Could you tell me what it is doing wrong?

Cheers,
-Paul

> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: 
> clock-controller@10000000: usb-phy@3c:compatible: 'oneOf' conditional 
> failed, one must be fixed:
> 	['ingenic,jz4770-phy'] is too short
> 	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 
> 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 
> 'ingenic,x1830-phy', 'ingenic,x2000-phy']
> 	From schema: 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/clock/ingenic,cgu.example.dt.yaml: 
> usb-phy@3c: compatible: 'oneOf' conditional failed, one must be fixed:
> 	['ingenic,jz4770-phy'] is too short
> 	'ingenic,jz4770-phy' is not one of ['ingenic,jz4760-phy', 
> 'ingenic,jz4775-phy', 'ingenic,jz4780-phy', 'ingenic,x1000-phy', 
> 'ingenic,x1830-phy', 'ingenic,x2000-phy']
> 	From schema: 
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
> 
> See https://patchwork.ozlabs.org/patch/1429154
> 
> This check can fail if there are any dependencies. The base for a 
> patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up 
> to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 



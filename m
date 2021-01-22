Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2D3005C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbhAVOnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 22 Jan 2021 09:43:41 -0500
Received: from aposti.net ([89.234.176.197]:55628 "EHLO aposti.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728886AbhAVOnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:43:22 -0500
Date:   Fri, 22 Jan 2021 14:42:28 +0000
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/2] dt-bindings/phy: ingenic: Add compatibles
 =?UTF-8?Q?for=0D=0A?= JZ4760(B) SoCs
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, od@zcrc.me,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <SIBCNQ.SZL9QXM6XX3N2@crapouillou.net>
In-Reply-To: <CAL_JsqLS-oFn4kGm7GeU+W2BvVeon9k9+gzVojypcJCJLwbaEQ@mail.gmail.com>
References: <20210120115945.29046-1-paul@crapouillou.net>
        <CAL_JsqLS-oFn4kGm7GeU+W2BvVeon9k9+gzVojypcJCJLwbaEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Le ven. 22 janv. 2021 à 8:35, Rob Herring <robh+dt@kernel.org> a 
écrit :
> On Wed, Jan 20, 2021 at 5:59 AM Paul Cercueil <paul@crapouillou.net> 
> wrote:
>> 
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
>>  diff --git 
>> a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml 
>> b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
>>  index 0fd93d71fe5a..3c65dfcf352b 100644
>>  --- a/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
>>  +++ b/Documentation/devicetree/bindings/phy/ingenic,phy-usb.yaml
>>  @@ -15,13 +15,19 @@ properties:
>>       pattern: '^usb-phy@.*'
>> 
>>     compatible:
>>  -    enum:
>>  -      - ingenic,jz4770-phy
>>  -      - ingenic,jz4775-phy
>>  -      - ingenic,jz4780-phy
>>  -      - ingenic,x1000-phy
>>  -      - ingenic,x1830-phy
>>  -      - ingenic,x2000-phy
>>  +    oneOf:
>>  +      - enum:
>>  +        - ingenic,jz4760-phy
> 
> This should be 2 more spaces indentation. Indent is always 2 more than
> the above keyword and ignores '-'.

Pretty confusing. But alright.

Cheers,
-Paul

>>  +        - ingenic,jz4775-phy
>>  +        - ingenic,jz4780-phy
>>  +        - ingenic,x1000-phy
>>  +        - ingenic,x1830-phy
>>  +        - ingenic,x2000-phy
>>  +      - items:
>>  +        - enum:
>>  +          - ingenic,jz4760b-phy
>>  +          - ingenic,jz4770-phy
>>  +        - const: ingenic,jz4760-phy
>> 
>>     reg:
>>       maxItems: 1
>>  @@ -48,7 +54,7 @@ examples:
>>     - |
>>       #include <dt-bindings/clock/jz4770-cgu.h>
>>       otg_phy: usb-phy@3c {
>>  -      compatible = "ingenic,jz4770-phy";
>>  +      compatible = "ingenic,jz4770-phy", "ingenic,jz4760-phy";
>>         reg = <0x3c 0x10>;
>> 
>>         vcc-supply = <&vcc>;
>>  --
>>  2.29.2
>> 



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1912F045E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 00:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbhAIXOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jan 2021 18:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbhAIXOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jan 2021 18:14:32 -0500
Received: from m-r2.th.seeweb.it (m-r2.th.seeweb.it [IPv6:2001:4b7a:2000:18::171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9265C061786;
        Sat,  9 Jan 2021 15:13:36 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 4154E3F32C;
        Sun, 10 Jan 2021 00:13:35 +0100 (CET)
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: Add bindings for Awinic
 AW9523/AW9523B
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, phone-devel@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
References: <20210109140204.151340-1-angelogioacchino.delregno@somainline.org>
 <20210109140204.151340-3-angelogioacchino.delregno@somainline.org>
 <CACRpkdaB4ejWUzBpkYWtRC=_On0tw2H1=3beaVmnLkjncUzn_Q@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Message-ID: <3f8e772a-4e2f-2384-e2bf-f71e393d11d6@somainline.org>
Date:   Sun, 10 Jan 2021 00:13:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdaB4ejWUzBpkYWtRC=_On0tw2H1=3beaVmnLkjncUzn_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 09/01/21 23:14, Linus Walleij ha scritto:
> Hi Angelo,
> 
> thanks for your patch!
> 
> On Sat, Jan 9, 2021 at 3:02 PM AngeloGioacchino Del Regno
> <angelogioacchino.delregno@somainline.org> wrote:
> 
>> +#PIN CONFIGURATION NODES
>> +patternProperties:
>> +  '^.*$':
>> +    if:
>> +      type: object
>> +    then:
>> +      properties:
>> +        pins:
>> +          description:
>> +            List of gpio pins affected by the properties specified in
>> +            this subnode.
>> +          items:
>> +            pattern: "^gpio([0-9]|1[0-5])$"
>> +          minItems: 1
>> +          maxItems: 16
>> +
>> +        function:
>> +          description:
>> +            Specify the alternative function to be configured for the
>> +            specified pins.
>> +
>> +          enum: [ gpio, pwm ]
>> +
>> +        bias-disable: true
>> +        bias-pull-down: true
>> +        bias-pull-up: true
>> +        drive-open-drain: true
>> +        drive-push-pull: true
>> +        input-enable: true
>> +        output-high: true
>> +        output-low: true
>> +
>> +      required:
>> +        - pins
>> +        - function
> 
> Is it possible to just $ref /pinctrl/pincfg-node.yaml# for some of this?
> 
Sure, I will try to reference that for V2!

> Yours,
> Linus Walleij
> 


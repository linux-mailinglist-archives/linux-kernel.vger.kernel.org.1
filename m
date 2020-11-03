Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF4B72A3E43
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgKCICk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCICk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:02:40 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECA2C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:02:39 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id l24so17264293edj.8
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 00:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=on12lnH1Og7qmz+xRnqktTqCiwbWf50SHLA4zpKvims=;
        b=BKzShbikBWL3HDFZSwfEJpBnu4NNgpb48xBqHdyKNL1EvUpJJ4kkJx7/ttyuo8rlKY
         UzSTGB77qO/+rDmgnTYWG4tds21kJCoycYDeVAhb2qH+wuocGYrItwz5gmXnZnSDRDKk
         qPtTEGrPsFJUvt9idX2F24uQ2X/jUtpK4zrRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=on12lnH1Og7qmz+xRnqktTqCiwbWf50SHLA4zpKvims=;
        b=QBdA9XCFEJefQTQa6tLAyJlOGEwZxpTCfuJSEe+icUWGLMOFPjCJNTRPBo+pHnZBJl
         qCZnfYanRTXtej5RXJ8VA/eMe9E+Gk0ks5hmiMXRgHfnkMNYS+govF2ZTI2jFGcWCsws
         41CfZZEsCjLwaFu3feh7QHTG5qHqol5Q/PO5f69kX0JEGlGkqKzLY4G+gxIVREXCZfKN
         K95Ade0tY8cRRGm51emlebau6ShC2iwiELVPDRo96hb8QRejlEWfoLggUNF6LaE+5sv7
         L0UWTF5fmZYAJ/VGlXh6ozJXrsXKup/Qp4BIQ0ecV+x21NsLdn7xNOYEMCq7VimAkjm/
         eU0w==
X-Gm-Message-State: AOAM532rvc3b7fmH7ATmvrBA8eIRETnHRbkCYrZ09UeZS37KX2u+xJO/
        AHiP3l8PWtkmhMEVTUlh+oUMaw==
X-Google-Smtp-Source: ABdhPJzEHtMGEkmGSeoKKSvimeKJn/rLaR5KT36LWsJGkPD+IKaHmz3oRW2hoOn1vEPu1CkEKsOIVg==
X-Received: by 2002:a50:d78f:: with SMTP id w15mr14162969edi.227.1604390558278;
        Tue, 03 Nov 2020 00:02:38 -0800 (PST)
Received: from [172.16.11.132] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id e18sm10554586eja.124.2020.11.03.00.02.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 00:02:37 -0800 (PST)
Subject: Re: [EXT] Re: [v2 01/11] irqchip: ls-extirq: Add LS1043A, LS1088A
 external interrupt
To:     Leo Li <leoyang.li@nxp.com>,
        "Biwen Li (OSS)" <biwen.li@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiafei Pan <jiafei.pan@nxp.com>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20201027044619.41879-1-biwen.li@oss.nxp.com>
 <5b1f2911-98b3-511f-404b-7d0fa44cc0c2@rasmusvillemoes.dk>
 <DB6PR0401MB2438ED1C8F629CA1E1F469768F160@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB668790304253EAEEBC1B79F48F160@VE1PR04MB6687.eurprd04.prod.outlook.com>
 <DB6PR0401MB2438DCABBF4892ECF599D4528F100@DB6PR0401MB2438.eurprd04.prod.outlook.com>
 <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
Message-ID: <03dc38bb-b83a-7926-60dc-61152a3ac967@rasmusvillemoes.dk>
Date:   Tue, 3 Nov 2020 09:02:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <VE1PR04MB6687738526B56F3F0E6812C58F100@VE1PR04MB6687.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2020 22.22, Leo Li wrote:
>>>
>>> Where did you get this information that the register on LS1043 and
>>> LS1046 is bit reversed?  I cannot find such information in the RM.
>>> And does this mean all other SCFG registers are also bit reversed?  If
>>> this is some information that is not covered by the RM, we probably
>>> should clarify it in the code and the commit message.
>> Hi Leo,
>>
>> I directly use the same logic to write the bit(field IRQ0~11INTP) of the
>> register SCFG_INTPCR in LS1043A and LS1046A.
>> Such as,
>> if I want to control the polarity of IRQ0(field IRQ0INTP, IRQ0 is active low) of
>> LS1043A/LS1046A, then I just need write a value 1 << (31 - 0) to it.
>> The logic depends on register's definition in LS1043A/LS1046A's RM.
> 
> Ok.  The SCFG_SCFGREVCR seems to be a one-off fixup only existed on LS1021.  And it is mandatory to be bit_reversed according to the RM which is already taken care of in the RCW.  So the bit reversed case should be the only case supported otherwise a lot of other places for SCFG access should be failed.
> 
> I think we should remove the bit_reverse thing all together from the driver for good.  This will prevent future confusion.  Rasmus, what do you think?

Yes, all the ls1021a-derived boards I know of do have something like

# Initialize bit reverse of SCFG registers
09570200 ffffffff

in their pre-boot-loader config file. And yes, the RM does say

  This register must be written 0xFFFF_FFFF as a part of
  initialization sequence before writing to any other SCFG
  register.

but nowhere does it say "or else...", nor a little honest addendum
"because we accidentally released broken silicon with this misfeature
_and_ wrong POR value".

Can we have an official statement from NXP stating that SCFGREVCR is a
hardware design bug? And can you send it through a time-machine so I had
it three years ago avoiding the whole "fsl,bit-reverse
device-tree-property, no, read the register if you're on a ls1021a and
decide" hullabaloo.

Rasmus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D17E72FEED8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 16:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbhAUPbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 10:31:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732158AbhAUPaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 10:30:46 -0500
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2732FC06174A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 07:30:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 3E7D4419AD;
        Thu, 21 Jan 2021 15:30:01 +0000 (UTC)
To:     Arnd Bergmann <arnd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Mohamed Mediouni <mohamed.mediouni@caramail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Stan Skowronek <stan@corellium.com>
References: <20210120132717.395873-1-mohamed.mediouni@caramail.com>
 <20210120132717.395873-5-mohamed.mediouni@caramail.com>
 <CACRpkdZTjUnqOMmc4y5RdxLC+joumPHNpmAr_LKJDO1h+44ouQ@mail.gmail.com>
 <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
From:   Hector Martin 'marcan' <marcan@marcan.st>
Subject: Re: [RFC PATCH 4/7] irqchip/apple-aic: Add support for Apple AIC
Message-ID: <d0eedc9e-2412-048a-9c7c-1e4a79aadb3b@marcan.st>
Date:   Fri, 22 Jan 2021 00:29:58 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3k7p3YK5DY3gTm0UaAgse41J7h_e-dN_NAjThPFE0tyw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: es-ES
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2021 19.37, Arnd Bergmann wrote:
> On Thu, Jan 21, 2021 at 10:48 AM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> However weird it may seem, Apple is not in the file
>> Documentation/devicetree/bindings/vendor-prefixes.yaml
> 
> Since Apple are already using both the "AAPL" and the "apple"
> prefix themselves, I have a bad feeling about reusing either of
> them for defining the devicetree.org bindings that we add to
> linux/Documentation/devicetree/bindings. The question is: if
> not "apple", what else should we use here?

This ties into the larger question of how we should handle devicetrees 
in general on these platforms.

The two extremes are:

1) Have the bootloader outright convert ADT to FDT and make Linux 
support the entirety of Apple's devicetree structure, or

2) Maintain our own devicetrees and ignore Apple's entirely

My feeling is that 1) is a non-starter, because Linux ARM device trees 
and Apple ARM device trees have seen independent evolution from the 
PowerPC era, and many details are completely different. Plus conversion 
is non-trivial, because the endianness is different and the format is 
too ambiguous to do programmatically without complex logic.

On the other hand, cranking out devicetrees by hand for every device 
variant that Apple puts out is a waste of time.

Obviously at the bare minimum the bootloader will need to move some 
dynamic information from the ADT to the FDT, but that can be a very 
specific set of properties (memory layout, MAC addresses, etc).

My current thinking is that we should write offline, automated tooling 
to parse, diff, and automatically convert portions of Apple devicetrees 
into Linux ones. Then we can more easily maintain our own, but still 
ultimately have humans decide what goes into the Linux device trees.

It's worth noting that AIUI Apple does not consider their devicetree 
layout to be stable, and it may change any time. On M1 devices, the 
devicetree is provided as part of the iBoot2 firmware bundle, which 
means it changes from one macOS version to the next (this is paired with 
the Darwin kernel itself, and they are upgraded as a unit). It includes 
placeholder values that iBoot2 then replaces with data from NOR before 
handing control over to the kernel. My goal for our long-term project 
[1] is to keep up with iBoot2 updates so that we do not have to instruct 
users to dig up old macOS versions.

Quick TL;DR on how these things boot:
- Boot ROM boots
- iBoot1 (system firmware) in NOR flash which looks for a bootable OS in 
internal storage (only!) in the form of an APFS container+volume and 
then boots
- iBoot2 (OS loader) which loads a bunch of firmware blobs and the 
devicetree off of storage, customizes it with system data from NOR, and 
then loads a wrapped mach-o file containing
- A Darwin kernel, or in our case a Linux bootloader which then boots
- A standard arm64 Linux blob

The boot ROM is ROM. iBoot1 only ever rolls forward (downgrades 
impossible). iBoot2 downgrades are possible but Apple already proved 
they can break this willingly or not, at least in betas (macOS 11.2 
Beta2 iBoot1 cannot boot Beta1 iBoot2). The secureboot chain goes all 
the way up to the mach-o kernel load, that is the first point where we 
can change boot policy to load anything we want (with user consent).

[1] https://asahilinux.org/

-- 
Hector Martin "marcan" (marcan@marcan.st)
Public Key: https://mrcn.st/pub

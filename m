Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D04286D7C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 06:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgJHER2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 00:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726105AbgJHER2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 00:17:28 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEDBC0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 21:17:27 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id q1so4455813ilt.6
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 21:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6QFGJN3qVhpBRjjOtHOQ/iBClZaJcZiRzcWJlfey2eU=;
        b=pppR9YCcJ6UaOVx5oDj/5io3YajfzfVOVtNLJB7PIZH79K4Rrmn+0Zt3F3aJ2+alNv
         QkLOlYH0zKSzkL3HPNvi7KtTAU8Yk/ZIMinjLeTkfWCxOek03dshSHoo5fXbNlt2Ge5D
         Ed6RtHtXL/CKyxoYUVEijNCaTHdiTAgKNefJ2hFLuy+jG8AkcL+rrnPlgLCFDJJ9uOzp
         kEpmL6M7Qv4cghCMddjOVoBPKtUf97Shq+Y6DFglcmB5HKxm4Em+LQkGPOnCOivnSIU0
         jnI95HWlUEY7WulPio8m6V5w1uF1HMszVlCu5cjOzpsQV+OQJsRwZXiGfDNaN31o4Jcj
         s8mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6QFGJN3qVhpBRjjOtHOQ/iBClZaJcZiRzcWJlfey2eU=;
        b=FBgS/mnvQNM93Y3fBiks5Zc2X80Uyou9DC5W4RS4wmLpfM1MOB7R5KyTfBnZBUy7jl
         zsOD1MqVlcNgWglPElwC9B+nyJ2JgJDS0rQ3LLTZJwVe2OI4dM0G3f0YLGzCzkEMI5c1
         UJ4FAvekNBhO+WqINILO6b9bP+F7PpJXeJizQWw9NBI4hIGasKziQW9C+kNsXa4vjvyD
         usYCH6GSIVk3dGznt/jP0GQTWmp2W9DBMN187blzvIfu/0s2DhT9L98CONLULred2Lsw
         ti+L0i7cddlN2G8er9pG/IqRZi3fjEGyFkfrS1RFNzh7Lb0MHbyp7A5yLAdeeKUVt7MX
         nUxw==
X-Gm-Message-State: AOAM5318wJijIeDbxOvXIQp6JYRrFtoSySxJecm3unjSLD6lYc1n+80h
        TQcxRJ5PcDLkAx2dsatZa7PGY4BZU0Vaebjyr8BOXw==
X-Google-Smtp-Source: ABdhPJwyh7NquIrKK07SdWn1xoELKnJZnAT0IOdkB3ameC8cLKfSBP8VIGIthm08yUg/0h732kDewdix7a9H66Xog6w=
X-Received: by 2002:a92:1b18:: with SMTP id b24mr1198984ilb.83.1602130646908;
 Wed, 07 Oct 2020 21:17:26 -0700 (PDT)
MIME-Version: 1.0
References: <ca2f491fc97bdf6d7fc8d6fee5f702be27db6702.1602084104.git.viresh.kumar@linaro.org>
In-Reply-To: <ca2f491fc97bdf6d7fc8d6fee5f702be27db6702.1602084104.git.viresh.kumar@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 8 Oct 2020 09:47:15 +0530
Message-ID: <CAKohpokqZ0dfRdiEv9_RtTRQh4OLU3LuCe18f4xsChxYkg05Lw@mail.gmail.com>
Subject: Re: [RFC V2] dt-bindings: mailbox : arm,mhuv2: Add bindings
To:     Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>, morten_bp@live.dk
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <Sudeep.Holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated Morten's email id as he is no longer with ARM.

On Wed, 7 Oct 2020 at 20:58, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> This patch adds device tree binding for ARM Message Handling Unit (MHU)
> controller version 2.
>
> Based on earlier work by Morten Borup Petersen.
>
> Co-developed-by: Morten Borup Petersen <morten.petersen@arm.com>
> Signed-off-by: Morten Borup Petersen <morten.petersen@arm.com>
> Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>
> ---
> Morten/Tushar,
>
> I have prepared this based on the best of my understanding about the
> hardware, but since I haven't worked on the actual hardware yet there
> are chances that I may have misunderstood some of it. Please lemme know
> if any of my understanding is incorrect.
>
> Here is the link to the previous attempt by Tushar to get it upstreamed
> long back:
>
> https://lore.kernel.org/lkml/20190717192616.1731-1-tushar.khandelwal@arm.com/
>
> This is very much a new approach and so I am not pointing out the
> differences from the previous one.
>
> I haven't started with redesigning the driver as of now and would like
> to get some feedback on the bindings first. Thanks in advance.
> ---
>  .../bindings/mailbox/arm,mhuv2.yaml           | 170 ++++++++++++++++++
>  1 file changed, 170 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
>
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> new file mode 100644
> index 000000000000..3cbdc97f1f4c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> @@ -0,0 +1,170 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm,mhuv2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM MHUv2 Mailbox Controller
> +
> +maintainers:
> +  - Morten Borup Petersen <morten.petersen@arm.com>
> +  - Viresh Kumar <viresh.kumar@linaro.org>
> +
> +description: |
> +  The Arm Message Handling Unit (MHU) Version 2 is a mailbox controller that has
> +  between 1 and 124 channel windows (each 32-bit wide) to provide unidirectional
> +  communication with remote processor(s), where the number of channel windows
> +  are implementation dependent.
> +
> +  Given the unidirectional nature of the controller, an MHUv2 mailbox may only
> +  be written to or read from. If a pair of MHU controllers is implemented
> +  between two processing elements to provide bidirectional communication, these
> +  must be specified as two separate mailboxes.
> +
> +  If the interrupts property is present in device tree node, then its treated as
> +  a receiver mailbox, otherwise a sender.
> +
> +  An MHU controller must be specified along with the supported transport
> +  protocols. The transport protocols determine the method of data transmission
> +  as well as the number of provided mailbox channels.
> +
> +  Following are the possible transport protocols.
> +
> +  - Doorbell: Each transfer is made up of single bit flag, using any one of the
> +    bits in a channel window. A channel window can support up to 32 doorbells
> +    and the entire window shall be used in doorbell mode.  Optionally, data may
> +    be transmitted through a shared memory region, wherein the MHU is used
> +    strictly as an interrupt generation mechanism but that is out of the scope
> +    of these bindings.
> +
> +  - Single-word: Each transfer is single word, using a single Channel window.
> +
> +  - Multi-word: Each transfer is made of two or more words, using two or more
> +    channel windows.
> +
> +# We need a select here so we don't match all nodes with 'arm,primecell'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,mhuv2
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +        items:
> +          - const: arm,mhuv2
> +          - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  arm-mhuv2-mode:
> +    description: |
> +      The MHUv2 controller may contain up to 124 channel windows (each 32-bit
> +      wide). The hardware and the DT bindings allows any combination of those to
> +      be used for various transport protocols.
> +
> +      This property allows a platform to describe how these channel windows are
> +      used in various transport protocols. The entries in this property shall be
> +      present as an array of tuples, where each tuple describes details about
> +      one of the transport protocol being implemented over some channel
> +      window(s).
> +
> +      The first field of a tuple signifies the transfer protocol, 0 is reserved
> +      for doorbell protocol, 1 is reserved for single-word protocol and 2 is
> +      reserved for multi-word protocol. Using any other value in the first field
> +      of a tuple makes it invalid.
> +
> +      The second field of a tuple signifies the number of channel windows where
> +      the protocol would be used. For doorbell protocol this field signifies the
> +      number of 32-bit channel windows that implement the doorbell protocol. For
> +      single-word protocol this field signifies the number of 32-bit channel
> +      windows that implement separate single-word protocol mailbox channels. For
> +      multi-word protocol this field signifies the number of channel windows
> +      used for a multi-word protocol, it should be 2 or more.
> +
> +      The total number of channel windows specified here shouldn't be more than
> +      the ones implemented by the platform.
> +
> +      mhu: mailbox@2b1f0000 {
> +          ...
> +
> +          arm-mhuv2-mode = <0 2>, <1 3>, <2 5>, <2 7>;
> +      }
> +
> +      The above example defines the mode of an ARM MHUv2 mailbox controller,
> +      where a total of 17 channel windows are used. The first two windows are
> +      used in doorbell mode (64 doorbells), the next 3 windows are (separately)
> +      used in single-word mode, and the last two mailbox channels are used in
> +      multi-word mode of length 5 and 7 channel windows.
> +
> +  '#mbox-cells':
> +    description: |
> +      It contains two fields, the first field represents the channel number,
> +      which may be used in doorbell, single-word, or multi-word mode, and the
> +      second field (only relevant in doorbell mode, ignored otherwise)
> +      represents the doorbell number within the 32 bit wide channel window.
> +
> +      From the example given above for the arm-mhuv2-mode, here is how a client
> +      node can reference them.
> +
> +      mboxes = <&mhu 0 5>; // Mailbox channel 0, doorbell 5.
> +      mboxes = <&mhu 1 7>; // Mailbox channel 1, doorbell 7.
> +      mboxes = <&mhu 2 0>; // Mailbox channel 2, single-word mode.
> +      mboxes = <&mhu 4 0>; // Mailbox channel 4, single-word mode.
> +      mboxes = <&mhu 6 0>; // Mailbox channel 6, multi-word mode with 7 windows.
> +
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#mbox-cells'
> +  - arm-mhuv2-mode
> +
> +additionalProperties: false
> +
> +examples:
> +  # Multiple transport protocols implemented by the mailbox controller
> +  # configured in sender mode
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mhu: mailbox@2b1f0000 {
> +            #mbox-cells = <2>;
> +            compatible = "arm,mhuv2", "arm,primecell";
> +            reg = <0 0x2b1f0000 0 0x1000>;
> +            clocks = <&clock 0>;
> +            clock-names = "apb_pclk";
> +            arm-mhuv2-mode = <1 5>, <2 2>, <2 5>, <2 7>, <0 2>;
> +        };
> +
> +        mhu_client: scb@2e000000 {
> +            compatible = "fujitsu,mb86s70-scb-1.0";
> +            reg = <0 0x2e000000 0 0x4000>;
> +
> +            mboxes =
> +                     //single-word protocol channel 0
> +                     <&mhu 0 0>,
> +                     //single-word protocol channel 4
> +                     <&mhu 4 0>,
> +                     //multi-word protocol channel 6 with 5 windows
> +                     <&mhu 6 0>,
> +                     //doorbell protocol channel 9, doorbell 27
> +                     <&mhu 9 27>;
> +        };
> +    };
> --
> 2.25.0.rc1.19.g042ed3e048af
>

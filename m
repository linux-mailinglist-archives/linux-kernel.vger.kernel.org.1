Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A426287616
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730613AbgJHObM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:31:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:33652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730495AbgJHObM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:31:12 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 42C2521924;
        Thu,  8 Oct 2020 14:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602167470;
        bh=aX3SEFO4u5EdXj08SMMBTfj8pUOkbGsdkLdG2+n+iOs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qWWR+NT3zgKPhMfTa8JVOabodvkssktcPRXCXVcR/smY3jrlh9IcQe8c+SVNfgmTc
         DYl590TKozS+13De3RK50F2UyVG9eoyAKh8YJICAfTCC8pUBq0s4KmWrfvXmWdhR8s
         UD82U88DHc3XQPJ+9ZyhaaMAsG7wkrFUS7y5/QDU=
Received: by mail-ot1-f45.google.com with SMTP id s66so5682868otb.2;
        Thu, 08 Oct 2020 07:31:10 -0700 (PDT)
X-Gm-Message-State: AOAM532YPzhg5cZ0/8DRTELq6P5idB6bvG058QZRWzNsULKZN1ebusCL
        +YPuiPqYgQQPLVqG7RM0J1bRAXrdMY3dB2CxDw==
X-Google-Smtp-Source: ABdhPJywN+FpEMn4a4Nihs6icecV+O3xDk9wUMumA2Pc5vkx4DkJHM0x58qnBwhIMCf6C1BV3mtdjoxRh6esM9WhEkc=
X-Received: by 2002:a05:6830:1008:: with SMTP id a8mr4934900otp.107.1602167469355;
 Thu, 08 Oct 2020 07:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <ca2f491fc97bdf6d7fc8d6fee5f702be27db6702.1602084104.git.viresh.kumar@linaro.org>
In-Reply-To: <ca2f491fc97bdf6d7fc8d6fee5f702be27db6702.1602084104.git.viresh.kumar@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 8 Oct 2020 09:30:57 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJTkeHHKm8ZYM7f1eO_ESPvaG3wnFXK03_ML3uT62rKNw@mail.gmail.com>
Message-ID: <CAL_JsqJTkeHHKm8ZYM7f1eO_ESPvaG3wnFXK03_ML3uT62rKNw@mail.gmail.com>
Subject: Re: [RFC V2] dt-bindings: mailbox : arm,mhuv2: Add bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>, morten_bp@live.dk
Cc:     Jassi Brar <jaswinder.singh@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Sudeep Holla <Sudeep.Holla@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Tushar Khandelwal <tushar.khandelwal@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 10:28 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
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

Just 'maxItems: 1' is fine here as the name is already defined.

> +
> +  arm-mhuv2-mode:

arm,mhuv2-mode.

Needs a type reference.

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

These are based on IP configuration or a software decision?

> +      The total number of channel windows specified here shouldn't be more than
> +      the ones implemented by the platform.

But can be less? Then do you need this to be a mask or range?

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

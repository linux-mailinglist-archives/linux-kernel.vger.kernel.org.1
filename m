Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB3E628C153
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 21:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390172AbgJLTQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 15:16:52 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36793 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729890AbgJLTQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 15:16:51 -0400
Received: by mail-ot1-f68.google.com with SMTP id 32so3648371otm.3;
        Mon, 12 Oct 2020 12:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i8IIzH69/HPl3rcpeUkhDnS02xzvJsTV9WuTw0oLbQ0=;
        b=tcQL0WxQivXSk4u6CAaHKkSFJisZ337wOWfJtieF1XgyCp//ivVoGsIp0sFwXcnjkN
         o3yR9ukK0WzGk0iJdIQF1I4tCPGivveFhZgXn8j3HMeUg7cPtKcseuoruW+bvCjK6VVM
         r8KNAEfM9TDACge+DLQ4axEnbVclbCg7VGprXU9ggbhQf5fUXwuNLOoKinKXMkO93K9q
         +CBunW+LERkqCwetkyEQDZjNTPTXXg6QiyOsMxZa3GMdE5oEeicOoZHZugdITmmrvbjS
         MkzzqZTLij1ltXOEEIG9Uw2nLxlazU55pjskPzshA7aQX+NswRWVT+duKD1FyUtdqW2J
         IU8g==
X-Gm-Message-State: AOAM533tvKcIte4pZ56PEKIOJ2EuqSxm9UKlsUasCmILhf1fcjV03SDu
        tKw6al5Xgr2GF3RG2pSUk0cWG2w37WdU
X-Google-Smtp-Source: ABdhPJxQGH98B+OFyIc9KWjX/icB7NQGrGC2oNSwLvKNPqCg1BJ9Q3Q59QNi+emB/hdhWgGesb7sHw==
X-Received: by 2002:a9d:2c05:: with SMTP id f5mr19866081otb.183.1602530209837;
        Mon, 12 Oct 2020 12:16:49 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id m6sm9152375otm.76.2020.10.12.12.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2020 12:16:49 -0700 (PDT)
Received: (nullmailer pid 1934011 invoked by uid 1000);
        Mon, 12 Oct 2020 19:16:48 -0000
Date:   Mon, 12 Oct 2020 14:16:48 -0500
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jaswinder.singh@linaro.org>, morten_bp@live.dk,
        Tushar Khandelwal <Tushar.Khandelwal@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        devicetree@vger.kernel.org, Sudeep.Holla@arm.com,
        Frank Rowand <frowand.list@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] dt-bindings: mailbox: arm,mhuv2: Add bindings
Message-ID: <20201012191648.GA1908871@bogus>
References: <2084ef6975776cabe7a0509fffaf53040c13bfde.1602243670.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2084ef6975776cabe7a0509fffaf53040c13bfde.1602243670.git.viresh.kumar@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 09, 2020 at 05:12:38PM +0530, Viresh Kumar wrote:
> This patch adds device tree binding for ARM Message Handling Unit (MHU)
> controller version 2.
> 
> Based on earlier work by Morten Borup Petersen.
> 
> Co-developed-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Tushar Khandelwal <tushar.khandelwal@arm.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> 
> ---
> V2->V3:
> 
> - compatible is changed to arm-mhuv2-tx/rx. Later version of MHUv2
>   have an interrupt in the sender mode as well and we can't find if a
>   mailbox is sender or receiver just based on an interrupt anymore. We
>   needed a better way.
> 
> - arm-mhuv2-mode is renamed to arm,mhuv2-protocols to fit the purpose
>   better.
> 
> - Minor formatting otherwise.
> 
> - No longer an RFC.
> 
> Morten: Please let me know if you want me to add your sign-off here from
> some other email id as you no longer work with ARM.
> ---
>  .../bindings/mailbox/arm,mhuv2.yaml           | 194 ++++++++++++++++++
>  1 file changed, 194 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> new file mode 100644
> index 000000000000..a2b8ecd639c7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> @@ -0,0 +1,194 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm,mhuv2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM MHUv2 Mailbox Controller
> +
> +maintainers:
> +  - Tushar Khandelwal <tushar.khandelwal@arm.com>
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
> +  a "receiver" mailbox, otherwise a "sender".
> +
> +  An MHU controller must be specified along with the supported transport
> +  protocols. The transport protocols determine the method of data transmission
> +  as well as the number of provided mailbox channels.
> +
> +  Following are the possible transport protocols.
> +
> +  - Doorbell: Each transfer is made up of single bit flag, using any one of the
> +    bits in a channel window. A channel window can support up to 32 doorbells
> +    and the entire window shall be used in doorbell protocol.  Optionally, data
> +    may be transmitted through a shared memory region, wherein the MHU is used
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
> +        enum:
> +          - arm,mhuv2-tx
> +          - arm,mhuv2-rx
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - description: Sender mode
> +        items:
> +          - const: arm,mhuv2-tx
> +          - const: arm,primecell
> +
> +      - description: Receiver-mode
> +        items:
> +          - const: arm,mhuv2-rx
> +          - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      The MHUv2 controller always implements an interrupt in the "receiver"
> +      mode, while the interrupt in the "sender" mode was not available in the
> +      version MHUv2.0, but the later versions do have it.
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    maxItems: 1
> +
> +  arm,mhuv2-protocols:
> +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
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
> +      the ones implemented by the platform, though one can specify lesser number
> +      of windows here than what the platform implements.
> +
> +      mhu: mailbox@2b1f0000 {
> +          ...
> +
> +          arm,mhuv2-protocols = <0 2>, <1 3>, <2 5>, <2 7>;
> +      }
> +
> +      The above example defines the protocols of an ARM MHUv2 mailbox
> +      controller, where a total of 17 channel windows are used. The first two
> +      windows are used in doorbell protocol (64 doorbells), the next 3 windows
> +      are (separately) used in single-word protocol, and the last two mailbox
> +      channels are used in multi-word protocol of length 5 and 7 channel
> +      windows.

I think in terms of constraints, this would be:

minItems: 1
maxItems: 124
items:
  items:
    - enum: [ 0, 1, 2 ]
    - minimum: 0
      maximum: 124


> +
> +  '#mbox-cells':
> +    description: |
> +      It contains two fields, the first field represents the channel number,
> +      which may be used in doorbell, single-word, or multi-word protocol, and
> +      the second field (only relevant in doorbell protocol, should be 0
> +      otherwise) represents the doorbell number within the 32 bit wide channel
> +      window.
> +
> +      From the example given above for the arm,mhuv2-protocols, here is how a
> +      client node can reference them.
> +
> +      mboxes = <&mhu 0 5>; // Mailbox channel 0, doorbell 5.
> +      mboxes = <&mhu 1 7>; // Mailbox channel 1, doorbell 7.
> +      mboxes = <&mhu 2 0>; // Mailbox channel 2, single-word protocol.
> +      mboxes = <&mhu 4 0>; // Mailbox channel 4, single-word protocol.
> +      mboxes = <&mhu 6 0>; // Mailbox channel 6, multi-word protocol with 7 windows.
> +
> +    const: 2
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#mbox-cells'
> +  - arm,mhuv2-protocols
> +
> +additionalProperties: false
> +
> +examples:
> +  # Multiple transport protocols implemented by the mailbox controllers
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mhu_tx: mailbox-tx@2b1f0000 {

mailbox@...

Direction is not relevant for node name.

> +            #mbox-cells = <2>;
> +            compatible = "arm,mhuv2-tx", "arm,primecell";
> +            reg = <0 0x2b1f0000 0 0x1000>;
> +            clocks = <&clock 0>;
> +            clock-names = "apb_pclk";
> +            arm,mhuv2-protocols = <1 5>, <2 2>, <2 5>, <2 7>, <0 2>;
> +        };
> +
> +        mhu_rx: mailbox-rx@2b1f1000 {
> +            #mbox-cells = <2>;
> +            compatible = "arm,mhuv2-rx", "arm,primecell";
> +            reg = <0 0x2b1f1000 0 0x1000>;
> +            clocks = <&clock 0>;
> +            clock-names = "apb_pclk";
> +            arm,mhuv2-protocols = <1 5>, <2 7>, <0 2>;

A receiver with no interrupt? Should be conditionally required?


> +        };
> +
> +        mhu_client: scb@2e000000 {
> +            compatible = "fujitsu,mb86s70-scb-1.0";
> +            reg = <0 0x2e000000 0 0x4000>;
> +
> +            mboxes =
> +                     //single-word protocol channel 0, mhu-rx
> +                     <&mhu_rx 0 0>,
> +                     //single-word protocol channel 4, mhu-tx
> +                     <&mhu_tx 4 0>,
> +                     //multi-word protocol channel 6 with 5 windows, mhu-tx
> +                     <&mhu_tx 6 0>,
> +                     //doorbell protocol channel 9, doorbell 27, mhu-tx
> +                     <&mhu_tx 9 27>;
> +        };
> +    };
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30B726ADF8
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 21:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbgIOTry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 15:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgIOTmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 15:42:52 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11640C06178A;
        Tue, 15 Sep 2020 12:35:13 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id f82so4130882ilh.8;
        Tue, 15 Sep 2020 12:35:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bEYIZJwFtkYMd++2czsZyfzHNeNAv9o1qIOqHFzs83s=;
        b=JlvHoTyCln7peZxLP/IMUFVMjBLJJHQZG62Fz9ZlfKyucPG8A1wyGrQSr0vhAmb2b5
         DGsaEWuIdLDqUhxlox+1ApD0vItYBDdqUgJxOV4p/STwLtFIhJfucZjwMuE9q4iCRES7
         49u6R/DL0jbYpw2ngL2nZKaTk9lKceLTVNf/AH19ML7dvhhseKNUYYqhYuzvB0zZPdPj
         MRaf5jMopDAql8JdFmR8pcu3KeCtvvLsYZynoDGdx3OQz2LMZOOkIcnzL6BuK0Q2luOD
         u+8IptWjDLBeZuAO0Yv0rvc3vuPveESwNQ/WAMjlC7ud7lgcLy0n7vTcb3ashLFD6Eb+
         cbcw==
X-Gm-Message-State: AOAM532acJeW4yLjFvU/qopoEiMM0ooNtmwItx/BajMbsZjF8k1HUgHO
        yIt9ACZVhGzfBdw3VDO0IQ==
X-Google-Smtp-Source: ABdhPJxEdvAu0HMREPS2cEWjOs1/LLRV65dP5oXmITJa4Nat5+p+35d5hIBgWA7/MBqZGnzpYgIJig==
X-Received: by 2002:a92:8b8d:: with SMTP id i135mr17718234ild.153.1600198512138;
        Tue, 15 Sep 2020 12:35:12 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id f21sm7994348ioh.1.2020.09.15.12.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 12:35:11 -0700 (PDT)
Received: (nullmailer pid 2368750 invoked by uid 1000);
        Tue, 15 Sep 2020 19:35:10 -0000
Date:   Tue, 15 Sep 2020 13:35:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/2] dt-bindings: mailbox : arm,mhu: Convert to
 Json-schema
Message-ID: <20200915193510.GA2362311@bogus>
References: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f50b23d157a97242c79bd8f2ab649a9272b9b59.1599731645.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:25:18PM +0530, Viresh Kumar wrote:
> Convert the DT binding over to Json-schema.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> V3: New patch.
> 
>  .../devicetree/bindings/mailbox/arm,mhu.yaml  | 86 +++++++++++++++++++
>  .../devicetree/bindings/mailbox/arm-mhu.txt   | 43 ----------
>  2 files changed, 86 insertions(+), 43 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> new file mode 100644
> index 000000000000..4e840cedb2e4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> @@ -0,0 +1,86 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/arm,mhu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ARM MHU Mailbox Controller
> +
> +maintainers:
> +  - Jassi Brar <jaswinder.singh@linaro.org>

Ideally, this should be someone familiar with the h/w, not the subsystem 
maintainer. Sudeep or you in this case?
 
> +
> +description: |
> +  The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has 3
> +  independent channels/links to communicate with remote processor(s).  MHU links
> +  are hardwired on a platform. A link raises interrupt for any received data.
> +  However, there is no specified way of knowing if the sent data has been read
> +  by the remote. This driver assumes the sender polls STAT register and the
> +  remote clears it after having read the data.  The last channel is specified to
> +  be a 'Secure' resource, hence can't be used by Linux running NS.
> +
> +# We need a select here so we don't match all nodes with 'arm,primecell'
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: arm,mhu
> +  required:
> +    - compatible
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: arm,mhu
> +      - const: arm,primecell
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    description: |
> +      Interrupt information corresponding to each of the 3 links of MHU,
> +      low-priority non-secure, high-priority non-secure, and secure.
> +    maxItems: 3

items:
  - description: low-priority non-secure
  - description: high-priority non-secure
  - description: Secure

> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: apb_pclk
> +
> +  '#mbox-cells':
> +    description: Index of the channel.
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - '#mbox-cells'
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        mhuA: mailbox@2b1f0000 {
> +            #mbox-cells = <1>;
> +            compatible = "arm,mhu", "arm,primecell";
> +            reg = <0 0x2b1f0000 0 0x1000>;
> +            interrupts = <0 36 4>, /* LP-NonSecure */
> +                         <0 35 4>, /* HP-NonSecure */
> +                         <0 37 4>; /* Secure */
> +            clocks = <&clock 0 2 1>;
> +            clock-names = "apb_pclk";
> +        };
> +
> +        mhu_client_scb: scb@2e000000 {
> +            compatible = "fujitsu,mb86s70-scb-1.0";
> +            reg = <0 0x2e000000 0 0x4000>;
> +            mboxes = <&mhuA 1>; /* HP-NonSecure */
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt b/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> deleted file mode 100644
> index 4971f03f0b33..000000000000
> --- a/Documentation/devicetree/bindings/mailbox/arm-mhu.txt
> +++ /dev/null
> @@ -1,43 +0,0 @@
> -ARM MHU Mailbox Driver
> -======================
> -
> -The ARM's Message-Handling-Unit (MHU) is a mailbox controller that has
> -3 independent channels/links to communicate with remote processor(s).
> - MHU links are hardwired on a platform. A link raises interrupt for any
> -received data. However, there is no specified way of knowing if the sent
> -data has been read by the remote. This driver assumes the sender polls
> -STAT register and the remote clears it after having read the data.
> -The last channel is specified to be a 'Secure' resource, hence can't be
> -used by Linux running NS.
> -
> -Mailbox Device Node:
> -====================
> -
> -Required properties:
> ---------------------
> -- compatible:		Shall be "arm,mhu" & "arm,primecell"
> -- reg:			Contains the mailbox register address range (base
> -			address and length)
> -- #mbox-cells		Shall be 1 - the index of the channel needed.
> -- interrupts:		Contains the interrupt information corresponding to
> -			each of the 3 links of MHU.
> -
> -Example:
> ---------
> -
> -	mhu: mailbox@2b1f0000 {
> -		#mbox-cells = <1>;
> -		compatible = "arm,mhu", "arm,primecell";
> -		reg = <0 0x2b1f0000 0x1000>;
> -		interrupts = <0 36 4>, /* LP-NonSecure */
> -			     <0 35 4>, /* HP-NonSecure */
> -			     <0 37 4>; /* Secure */
> -		clocks = <&clock 0 2 1>;
> -		clock-names = "apb_pclk";
> -	};
> -
> -	mhu_client: scb@2e000000 {
> -		compatible = "fujitsu,mb86s70-scb-1.0";
> -		reg = <0 0x2e000000 0x4000>;
> -		mboxes = <&mhu 1>; /* HP-NonSecure */
> -	};
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

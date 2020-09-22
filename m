Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539F9274918
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 21:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgIVT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 15:27:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:38510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgIVT1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 15:27:31 -0400
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3437238D6;
        Tue, 22 Sep 2020 19:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600802850;
        bh=y4Fd+VRM7UpDSLqyMTN3OBbvyJnJFNwNQbYAe8OBzSM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=wJfuNKf9Fxjix5TRnUu3VV/mdftdtMtbbVPUTttslBQnSagSVOMyUItXbc9pSdhtS
         XevikvDfGdiMxhOGyZNt3Pc57lHVubf0Etd9sspW7oOP4OGgcD5neN/xdtGtB5mBh1
         vBoVRPA5YmQlUfSYQ5NE0ZaM9ayOUk7g/3X2VvOQ=
Received: by mail-oi1-f177.google.com with SMTP id c13so22298919oiy.6;
        Tue, 22 Sep 2020 12:27:30 -0700 (PDT)
X-Gm-Message-State: AOAM531TtvmDqfGi7GhZmLWPlE9Xcip2/8l28a7OCRymBGanAgdIeh8C
        /WmSXkr1IYUQHo0fcohq692GT5zJVH7s1gIRfQ==
X-Google-Smtp-Source: ABdhPJwhJMX8D3+trJZN/+08Gl+SD0tqa/EL4rPKkiuDbtL7YuTlvwm7x2n7VkNZnRT9wiHG5Sriw9wPMJIdmEwApBI=
X-Received: by 2002:aca:4d58:: with SMTP id a85mr3701800oib.147.1600802850151;
 Tue, 22 Sep 2020 12:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <1598633743-1023-1-git-send-email-sagar.kadam@sifive.com>
 <1598633743-1023-2-git-send-email-sagar.kadam@sifive.com> <20200914180000.GA4136408@bogus>
 <DM6PR13MB3451786E8B73D50D36A89FD097200@DM6PR13MB3451.namprd13.prod.outlook.com>
In-Reply-To: <DM6PR13MB3451786E8B73D50D36A89FD097200@DM6PR13MB3451.namprd13.prod.outlook.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 22 Sep 2020 13:27:19 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4i-zq1Ro90h6XEbwhyqWKKj+MQ5KW6U-qFSViWh3SNA@mail.gmail.com>
Message-ID: <CAL_Jsq+4i-zq1Ro90h6XEbwhyqWKKj+MQ5KW6U-qFSViWh3SNA@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
 convert bindings to json-schema
To:     Sagar Kadam <sagar.kadam@openfive.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Paul Walmsley ( Sifive)" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Yash Shah <yash.shah@openfive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 15, 2020 at 9:17 AM Sagar Kadam <sagar.kadam@openfive.com> wrote:
>
> Hello Rob,
>
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: Monday, September 14, 2020 11:30 PM
> > To: Sagar Kadam <sagar.kadam@openfive.com>
> > Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org;
> > devicetree@vger.kernel.org; Paul Walmsley ( Sifive)
> > <paul.walmsley@sifive.com>; palmer@dabbelt.com;
> > aou@eecs.berkeley.edu; Yash Shah <yash.shah@openfive.com>
> > Subject: Re: [RESEND PATCH v2 1/1] dt-bindings: riscv: sifive-l2-cache:
> > convert bindings to json-schema
> >
> > [External Email] Do not click links or attachments unless you recognize the
> > sender and know the content is safe
> >
> > On Fri, Aug 28, 2020 at 10:25:43PM +0530, Sagar Kadam wrote:
> > > Convert the device tree bindings for the SiFive's FU540-C000 SoC's L2
> > Cache
> > > controller to YAML format.
> > >
> > > Signed-off-by: Sagar Kadam <sagar.kadam@sifive.com>
> > > ---
> > >  .../devicetree/bindings/riscv/sifive-l2-cache.txt  | 51 ------------
> > >  .../devicetree/bindings/riscv/sifive-l2-cache.yaml | 92
> > ++++++++++++++++++++++
> > >  2 files changed, 92 insertions(+), 51 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-
> > cache.txt
> > >  create mode 100644 Documentation/devicetree/bindings/riscv/sifive-l2-
> > cache.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > deleted file mode 100644
> > > index 73d8f19..0000000
> > > --- a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.txt
> > > +++ /dev/null
> > > @@ -1,51 +0,0 @@
> > > -SiFive L2 Cache Controller
> > > ---------------------------
> > > -The SiFive Level 2 Cache Controller is used to provide access to fast
> > copies
> > > -of memory for masters in a Core Complex. The Level 2 Cache Controller
> > also
> > > -acts as directory-based coherency manager.
> > > -All the properties in ePAPR/DeviceTree specification applies for this
> > platform
> > > -
> > > -Required Properties:
> > > ---------------------
> > > -- compatible: Should be "sifive,fu540-c000-ccache" and "cache"
> > > -
> > > -- cache-block-size: Specifies the block size in bytes of the cache.
> > > -  Should be 64
> > > -
> > > -- cache-level: Should be set to 2 for a level 2 cache
> > > -
> > > -- cache-sets: Specifies the number of associativity sets of the cache.
> > > -  Should be 1024
> > > -
> > > -- cache-size: Specifies the size in bytes of the cache. Should be 2097152
> > > -
> > > -- cache-unified: Specifies the cache is a unified cache
> > > -
> > > -- interrupts: Must contain 3 entries (DirError, DataError and DataFail
> > signals)
> > > -
> > > -- reg: Physical base address and size of L2 cache controller registers map
> > > -
> > > -Optional Properties:
> > > ---------------------
> > > -- next-level-cache: phandle to the next level cache if present.
> > > -
> > > -- memory-region: reference to the reserved-memory for the L2 Loosely
> > Integrated
> > > -  Memory region. The reserved memory node should be defined as per
> > the bindings
> > > -  in reserved-memory.txt
> > > -
> > > -
> > > -Example:
> > > -
> > > -     cache-controller@2010000 {
> > > -             compatible = "sifive,fu540-c000-ccache", "cache";
> > > -             cache-block-size = <64>;
> > > -             cache-level = <2>;
> > > -             cache-sets = <1024>;
> > > -             cache-size = <2097152>;
> > > -             cache-unified;
> > > -             interrupt-parent = <&plic0>;
> > > -             interrupts = <1 2 3>;
> > > -             reg = <0x0 0x2010000 0x0 0x1000>;
> > > -             next-level-cache = <&L25 &L40 &L36>;
> > > -             memory-region = <&l2_lim>;
> > > -     };
> > > diff --git a/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > > new file mode 100644
> > > index 0000000..e14c8c6
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/riscv/sifive-l2-cache.yaml
> > > @@ -0,0 +1,92 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +# Copyright (C) 2020 SiFive, Inc.
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/riscv/sifive-l2-cache.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: SiFive L2 Cache Controller
> > > +
> > > +maintainers:
> > > +  - Sagar Kadam <sagar.kadam@sifive.com>
> > > +  - Yash Shah <yash.shah@sifive.com>
> > > +  - Paul Walmsley  <paul.walmsley@sifive.com>
> > > +
> > > +description:
> > > +  The SiFive Level 2 Cache Controller is used to provide access to fast
> > copies
> > > +  of memory for masters in a Core Complex. The Level 2 Cache Controller
> > also
> > > +  acts as directory-based coherency manager.
> > > +  All the properties in ePAPR/DeviceTree specification applies for this
> > platform.
> > > +
> > > +allOf:
> > > +  - $ref: /schemas/cache-controller.yaml#
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +     - enum:
> > > +        - sifive,fu540-c000-ccache
> > > +    description: |
> > > +      Should have "sifive,<soc>-cache" and "cache".
> >
> > That's not what the schema describes or the example has (the 'cache'
> > fallback).
> >
> Thanks for your suggestions.
> I see that if we include the standard 'cache' property here, it injects  error's in other yaml's as reported here [1]
> In plain txt format of this binding the standard "cache" property is mentioned to be also included along with soc specific compatible string.
>
> Please correct me if I am wrong here:
> So in order to retain the earlier description as Should have "sifive,<soc>-cache" and "cache",  I excluded "cache" property from example
> as I assumed it is implied for cacheinfo infrastructure to work properly.
> I will retain the earlier description (from.txt) which was "sifive,fu540-c000-ccache" and "cache"

You will need a custom 'select' schema to only match on
"sifive,fu540-c000-ccache". There's numerous examples in the tree.

Rob

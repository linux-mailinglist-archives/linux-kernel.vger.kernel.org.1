Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA1F27CFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 15:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730249AbgI2Nwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 09:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728617AbgI2Nwu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 09:52:50 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05836207C4;
        Tue, 29 Sep 2020 13:52:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601387569;
        bh=pYsc5cZZIzjD7FvvqYNgn121yKTXFjoRl6+H8VM055s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nzy13enxPFatTrQ4Mos6ndxvfND1TQ94gXxPCnj+xBTl+rHkyNV1hwephuzqwsQnR
         sIPh0bYfNWDv4fNoJtSIQQIh93k927cBpPb+wQxe6WjQ0ZMn0zOCsMLO+RtSFPjlJZ
         gsw3pVthIilG5nQ4vFDuQYSUhCUFDOvPYHkhgLC4=
Received: by mail-oi1-f182.google.com with SMTP id 26so5511047ois.5;
        Tue, 29 Sep 2020 06:52:48 -0700 (PDT)
X-Gm-Message-State: AOAM532sbdPmaBSlGLguT1rFOzQWvVCRvcblBkL9i04HEtq2gkdhSf8E
        1s2ajVGqAYui+E3L5rGrCAFVrCVyj7iyLu30Mw==
X-Google-Smtp-Source: ABdhPJyXONNDaN98Wxtkgi5lscM774CxDnMFwYXpEoqZnqTpG1+Bz7UGZxAstO0/LlvsGJZhyet6fTSTnrmquVNKf0s=
X-Received: by 2002:aca:fc07:: with SMTP id a7mr2653496oii.106.1601387568135;
 Tue, 29 Sep 2020 06:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200928151324.2134-1-thunder.leizhen@huawei.com>
 <20200928151324.2134-13-thunder.leizhen@huawei.com> <20200928191425.GA3099266@bogus>
 <0568ed90-c6ac-ae1c-45ee-cdc6526d3fcf@huawei.com> <30a08e22-f8bb-1e42-087b-995dc525eaa4@huawei.com>
 <2d382466-5b91-7b43-2d12-8f7ceafe3691@huawei.com>
In-Reply-To: <2d382466-5b91-7b43-2d12-8f7ceafe3691@huawei.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 29 Sep 2020 08:52:36 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+zwCsgnyARCW6cdWWgefoWYd374r1OejP5B4aJ8Hivwg@mail.gmail.com>
Message-ID: <CAL_Jsq+zwCsgnyARCW6cdWWgefoWYd374r1OejP5B4aJ8Hivwg@mail.gmail.com>
Subject: Re: [PATCH v4 12/20] dt-bindings: arm: hisilicon: convert
 hisilicon,hi3798cv200-perictrl bindings to json-schema
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Wei Xu <xuwei5@hisilicon.com>, Libin <huawei.libin@huawei.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 8:25 AM Leizhen (ThunderTown)
<thunder.leizhen@huawei.com> wrote:
>
>
>
> On 2020/9/29 17:21, Leizhen (ThunderTown) wrote:
> >
> >
> > On 2020/9/29 11:18, Leizhen (ThunderTown) wrote:
> >>
> >>
> >> On 2020/9/29 3:14, Rob Herring wrote:
> >>> On Mon, Sep 28, 2020 at 11:13:16PM +0800, Zhen Lei wrote:
> >>>> Convert the Hisilicon Hi3798CV200 Peripheral Controller binding to DT
> >>>> schema format using json-schema.
> >>>>
> >>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
> >>>> ---
> >>>>  .../controller/hisilicon,hi3798cv200-perictrl.txt  | 21 ----------
> >>>>  .../controller/hisilicon,hi3798cv200-perictrl.yaml | 45 ++++++++++++++++++++++
> >>>>  2 files changed, 45 insertions(+), 21 deletions(-)
> >>>>  delete mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> >>>>  create mode 100644 Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> >>>> deleted file mode 100644
> >>>> index 0d5282f4670658d..000000000000000
> >>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.txt
> >>>> +++ /dev/null
> >>>> @@ -1,21 +0,0 @@
> >>>> -Hisilicon Hi3798CV200 Peripheral Controller
> >>>> -
> >>>> -The Hi3798CV200 Peripheral Controller controls peripherals, queries
> >>>> -their status, and configures some functions of peripherals.
> >>>> -
> >>>> -Required properties:
> >>>> -- compatible: Should contain "hisilicon,hi3798cv200-perictrl", "syscon"
> >>>> -  and "simple-mfd".
> >>>> -- reg: Register address and size of Peripheral Controller.
> >>>> -- #address-cells: Should be 1.
> >>>> -- #size-cells: Should be 1.
> >>>> -
> >>>> -Examples:
> >>>> -
> >>>> -  perictrl: peripheral-controller@8a20000 {
> >>>> -          compatible = "hisilicon,hi3798cv200-perictrl", "syscon",
> >>>> -                       "simple-mfd";
> >>>> -          reg = <0x8a20000 0x1000>;
> >>>> -          #address-cells = <1>;
> >>>> -          #size-cells = <1>;
> >>>> -  };
> >>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> >>>> new file mode 100644
> >>>> index 000000000000000..4e547017e368393
> >>>> --- /dev/null
> >>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml
> >>>> @@ -0,0 +1,45 @@
> >>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>>> +%YAML 1.2
> >>>> +---
> >>>> +$id: http://devicetree.org/schemas/arm/hisilicon/controller/hisilicon,hi3798cv200-perictrl.yaml#
> >>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>>> +
> >>>> +title: Hisilicon Hi3798CV200 Peripheral Controller
> >>>> +
> >>>> +maintainers:
> >>>> +  - Wei Xu <xuwei5@hisilicon.com>
> >>>> +
> >>>> +description: |
> >>>> +  The Hi3798CV200 Peripheral Controller controls peripherals, queries
> >>>> +  their status, and configures some functions of peripherals.
> >>>> +
> >>>> +properties:
> >>>> +  compatible:
> >>>> +    items:
> >>>> +      - const: hisilicon,hi3798cv200-perictrl
> >>>> +      - const: syscon
> >>>> +      - const: simple-mfd
> >>>> +
> >>>> +  reg:
> >>>> +    description: Register address and size
> >>>> +    maxItems: 1
> >>>> +
> >>>> +  '#address-cells':
> >>>> +    const: 1
> >>>> +
> >>>> +  '#size-cells':
> >>>> +    const: 1
> >>>
> >>> That implies child nodes. You need some sort of schema for them.
> >>
> >> OK, I will drop #address-cells and #size-cells in this binding.
> >
> > I think I misunderstood. I shoud describe child nodes here.
> >
> > It's National Day the day after tomorrow, total eight days off. It's so hurry.
> > I'll give up this patch! And do it for v5.11
>
> I searched the dtsi, these two properties are required by property "ranges", so
> I will add it.

'ranges' also implies there are child nodes as does 'simple-mfd', so
whatever child nodes you have are missing and need to be documented
too. Also, 'ranges' implies the child nodes are memory-mapped, but
'simple-mfd' implies they are not. 'simple-bus' is what should be used
for memory-mapped children.

Rob

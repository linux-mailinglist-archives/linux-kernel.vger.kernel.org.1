Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9572A2329
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 03:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbgKBCqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 21:46:04 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22990 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbgKBCqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 21:46:03 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201102024558epoutp0474ffc99b4ed93bd0235b03531b874c50~DkNolAH7K2540325403epoutp04O
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 02:45:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201102024558epoutp0474ffc99b4ed93bd0235b03531b874c50~DkNolAH7K2540325403epoutp04O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604285158;
        bh=XVGcPifSFh7P2qC7KRnT9MItGbQhV0RaAub8F07Y3zI=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=kTTBuWzrIomZZDXa28+qBLyehoDoXCclUIVFe0Xju6+7locg5CMXvzri06d68N1Vn
         Rv0e+JXlt5jvg0u/318UnCB05MG8QKeipzNZBBrEbAePEEFwc/uYIUR4/RsvpdVNSq
         47SHYD5nziDabOWHEdmy7jSG+oHDY6bhY1aTJDlA=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20201102024558epcas1p31e3ebb8e0b0512e27a7acabf01470a0b~DkNoJETHR1272812728epcas1p3F;
        Mon,  2 Nov 2020 02:45:58 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.157]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4CPcjb1y1lzMqYlh; Mon,  2 Nov
        2020 02:45:55 +0000 (GMT)
Received: from epcas1p1.samsung.com ( [182.195.41.45]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        6F.5A.02418.2E27F9F5; Mon,  2 Nov 2020 11:45:54 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201102024553epcas1p3dedcbb6b82d0ae97f68d4b1cae4ff3c4~DkNj1K5sL0583105831epcas1p3X;
        Mon,  2 Nov 2020 02:45:53 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201102024553epsmtrp29397436ccc5e48642f9ffc310a7b936d~DkNj0gEn01660616606epsmtrp23;
        Mon,  2 Nov 2020 02:45:53 +0000 (GMT)
X-AuditID: b6c32a35-c23ff70000010972-87-5f9f72e2efe2
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        6D.FA.08745.1E27F9F5; Mon,  2 Nov 2020 11:45:53 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201102024553epsmtip29cbe66f05aaa0fe522995f2d103cb394~DkNjqmTG71554315543epsmtip2a;
        Mon,  2 Nov 2020 02:45:53 +0000 (GMT)
Subject: Re: [PATCH 1/2] extcon: fsa9480: Rewrite bindings in YAML and
 extend
To:     Linus Walleij <linus.walleij@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <ae62b1b2-87ab-4d87-519a-ea341a729995@samsung.com>
Date:   Mon, 2 Nov 2020 11:59:52 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201101004357.1076876-1-linus.walleij@linaro.org>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHKsWRmVeSWpSXmKPExsWy7bCmru6jovnxBhOvSFrMP3KO1WLKn+VM
        Fpd3zWGzuN24gs2BxePOtT1sHn1bVjF6fN4kF8AclW2TkZqYklqkkJqXnJ+SmZduq+QdHO8c
        b2pmYKhraGlhrqSQl5ibaqvk4hOg65aZA7RNSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKr
        lFqQklNgWaBXnJhbXJqXrpecn2tlaGBgZApUmJCd0f9tK2vBNfmKp1fvMDYwbpDsYuTkkBAw
        kVjxaTdjFyMXh5DADkaJs5PbWCGcT4wSl47/ZYZwPjNKnLnRwwbTcnDxI6iqXYwSr2b+ZQJJ
        CAm8Z5TYdD4OxBYW8Jc4dvgkWIOIQLjEvmMHmEFsZgEbiY7f51hAbDYBLYn9L26A1fALKEpc
        /fGYEcTmFbCT+HlrGVicRUBF4s6/Y2BxUYEwiZPbWqBqBCVOznwCNodTwEFixr8tUPPFJW49
        mc8EYctLbH87hxni6K/sEo1NkRC2i8Sbd38ZIWxhiVfHt7BD2FISn9/thXqyWmLlySNsIE9K
        CHQwSmzZf4EVImEssX/pZKAFHEALNCXW79KHCCtK7Pw9lxFiL5/Eu689rCAlEgK8Eh1tQhAl
        yhKXH9xlgrAlJRa3d7JNYFSaheSbWUg+mIXkg1kIyxYwsqxiFEstKM5NTy02LDBEjuxNjOCE
        qGW6g3Hi2w96hxiZOBgPMUpwMCuJ8NZEzosX4k1JrKxKLcqPLyrNSS0+xGgKDN+JzFKiyfnA
        lJxXEm9oamRsbGxhYmhmamioJM77R7sjXkggPbEkNTs1tSC1CKaPiYNTqoHJZvJx7lebzq2X
        9l8uOeFpopF966KXt/LnS3dtqmlSuduv2S80592lDw5+GxQE7we8OBY2Zcb2ibbqtoydC5mO
        MpXkvY2/xLKqtlM0xP6r8+uZdt0RU8TOhZSwnD+3T1NMNfXPkn3rk83MnPdOP+pUVf7lcAYD
        79OFn+5P3xJ3v9py/sqEnU9m6F7fc/Dp3zNXOTeItXStZPwVo1x5cbWure0L8bX39PjscnWZ
        u1TOZfkfuLswRHm/tY6Ku36++MTZgY4749qfBf5aGMpptElwT8X2+baPPnmHF9h8mekm/n1D
        wSxVnb75Ugnziz52PFOpzNPnMJOU6mmNNuNsOqn9VMA9JuxF0zn5590brnMpsRRnJBpqMRcV
        JwIAjQBglhEEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsWy7bCSvO7DovnxBqfvaVnMP3KO1WLKn+VM
        Fpd3zWGzuN24gs2BxePOtT1sHn1bVjF6fN4kF8AcxWWTkpqTWZZapG+XwJXR/20ra8E1+Yqn
        V+8wNjBukOxi5OSQEDCROLj4EWsXIxeHkMAORol5hy6wQiQkJaZdPMrcxcgBZAtLHD5cDFHz
        llHizOyfYDXCAr4Sm5deZQexRQTCJWYveM8MYjML2Eh0/D7HAtEwmVFiXddjsASbgJbE/hc3
        2EBsfgFFias/HjOC2LwCdhI/by0Di7MIqEjc+XcMLC4qECaxc8ljJogaQYmTM5+wgNicAg4S
        M/5tgVqmLvFn3iUoW1zi1pP5TBC2vMT2t3OYJzAKz0LSPgtJyywkLbOQtCxgZFnFKJlaUJyb
        nltsWGCUl1quV5yYW1yal66XnJ+7iREcHVpaOxj3rPqgd4iRiYPxEKMEB7OSCG9N5Lx4Id6U
        xMqq1KL8+KLSnNTiQ4zSHCxK4rxfZy2MExJITyxJzU5NLUgtgskycXBKNTCZvZyxs/+kxIeb
        jsFmLnPP8hyUW8xTJ8RhEpx7p2lJ5PuWzm2LQ5bHzmG4r3vXMLXx46Ha9DeiPs7b3I/W97bt
        2PO+aYl6ynzPMi07i7oT9zat4lZMu7Z/uZ+G2TE7gYz5T7mzlv7YWKK5evOfBdvO1u0Jcklz
        /L9s7fobp9Rl39zLXXwm2Wb15IV2ymEPD/W2fBPvUF+55yBLZWnEHN6d+xmDvReHyoh5Bm9/
        LfqUo2FbiltWEOd9H686wXMf3TgMj0zd2fp4ftzp3qsf9k4403dLsGC6r+nSiY7yxYtKpx10
        2PHLdl/u9ASxjF0vDGu+XTtk8Vho+tFV7tuOGbLITc4Tqb0iyBx9dLH+d9HNSizFGYmGWsxF
        xYkAb+E3uP0CAAA=
X-CMS-MailID: 20201102024553epcas1p3dedcbb6b82d0ae97f68d4b1cae4ff3c4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201101004410epcas1p36f8a3469611fbc27eed6803d383df06e
References: <CGME20201101004410epcas1p36f8a3469611fbc27eed6803d383df06e@epcas1p3.samsung.com>
        <20201101004357.1076876-1-linus.walleij@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 11/1/20 9:43 AM, Linus Walleij wrote:
> This rewrites the FSA9480 DT bindings using YAML and
> extends them with the compatible TI TSU6111.
> 
> I chose to name the file fcs,fsa880 since this is the
> first switch, later versions are improvements.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../bindings/extcon/extcon-fsa9480.txt        | 21 --------
>  .../bindings/extcon/fcs,fsa880.yaml           | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
>  create mode 100644 Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt b/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> deleted file mode 100644
> index 624bd76f468e..000000000000
> --- a/Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
> +++ /dev/null
> @@ -1,21 +0,0 @@
> -FAIRCHILD SEMICONDUCTOR FSA9480 MICROUSB SWITCH
> -
> -The FSA9480 is a USB port accessory detector and switch. The FSA9480 is fully
> -controlled using I2C and enables USB data, stereo and mono audio, video,
> -microphone, and UART data to use a common connector port.
> -
> -Required properties:
> - - compatible : Must be one of
> -   "fcs,fsa9480"
> -   "fcs,fsa880"
> - - reg : Specifies i2c slave address. Must be 0x25.
> - - interrupts : Should contain one entry specifying interrupt signal of
> -   interrupt parent to which interrupt pin of the chip is connected.
> -
> - Example:
> -	musb@25 {
> -		compatible = "fcs,fsa9480";
> -		reg = <0x25>;
> -		interrupt-parent = <&gph2>;
> -		interrupts = <7 0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml b/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
> new file mode 100644
> index 000000000000..ef6a246a1337
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/v1/url?k=da7a3fd4-85e106de-da7bb49b-0cc47a31384a-f57ab7f026383135&q=1&e=f8ca331d-3c11-4257-8322-d97ac13418ef&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fextcon%2Ffcs%2Cfsa880.yaml%23
> +$schema: https://protect2.fireeye.com/v1/url?k=0449819e-5bd2b894-04480ad1-0cc47a31384a-07ad90468a2ed371&q=1&e=f8ca331d-3c11-4257-8322-d97ac13418ef&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: Fairchild Semiconductor FSA880, FSA9480 and compatibles
> +
> +maintainers:
> +  - Linus Walleij <linus.walleij@linaro.org>
> +
> +description:
> +  The FSA880 and FSA9480 are USB port accessory detectors and switches.
> +  The switch is fully controlled using I2C and enables USB data, stereo
> +  and mono audio, video, microphone, and UART data to use a common
> +  connector port. Compatible switches exist from other manufacturers.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - fcs,fsa880
> +      - fcs,fsa9480
> +      - ti,tsu6111
> +
> +  reg:
> +    maxItems: 1
> +    description: The I2C address for an FSA880 compatible device is
> +      usually 0x25.
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        usb-switch@25 {
> +            compatible = "fcs,fsa880";
> +            reg = <0x25>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
> +        };
> +    };
> 

Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

I'm waiting the reply from DT maintainer for a while.
After that, I'll merge them.

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

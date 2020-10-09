Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E374A287F93
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbgJIAtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:49:21 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:27438 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIAtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:49:20 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20201009004917epoutp0463e7f97381f84187491f59d62a5257b3~8LI5lJ7d02988929889epoutp04J
        for <linux-kernel@vger.kernel.org>; Fri,  9 Oct 2020 00:49:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20201009004917epoutp0463e7f97381f84187491f59d62a5257b3~8LI5lJ7d02988929889epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1602204557;
        bh=XVBtzJu2xASv0WKu7fdnokfSQnWDTlw2HCWwZ+tMiJc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=TXcOYweWBfap0JOa3Jdt9c5pxZUqKkYBZQp5o0gC+LD9YYG7bslZwhcAjcLKz9E2X
         n4wJ1k4GJfeS4OMPgD5YFycXIh4GZXS/v0hPqkqtn9QT/Q+dskTGWFjAAqbTqC18Wd
         8OEIcFlk/P8cCzlVEvFdUTZ9Rt96ztUhdQuTPwrE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201009004916epcas1p15ad34ad9a2ea29ed9ca9e9e131035ca4~8LI4ygpmM1961019610epcas1p11;
        Fri,  9 Oct 2020 00:49:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.152]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4C6qG14NXgzMqYkV; Fri,  9 Oct
        2020 00:49:13 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        4B.08.09582.983BF7F5; Fri,  9 Oct 2020 09:49:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201009004912epcas1p3978dad9ce71eb37b7cd37cd899bb4ba7~8LI1OecMx3244632446epcas1p3U;
        Fri,  9 Oct 2020 00:49:12 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201009004912epsmtrp13aae56932c8c07c2ef7a64f62335dbcd~8LI1N4tmv0340703407epsmtrp1e;
        Fri,  9 Oct 2020 00:49:12 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-97-5f7fb389d91f
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        37.49.08745.883BF7F5; Fri,  9 Oct 2020 09:49:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201009004912epsmtip21ec3fdb09422c4c8f975e9b26742122e~8LI1BfF8T0255102551epsmtip2W;
        Fri,  9 Oct 2020 00:49:12 +0000 (GMT)
Subject: Re: [PATCH 2/2] dt-bindings: extcon: add binding for TUSB320
To:     Michael Auchter <michael.auchter@ni.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
From:   Chanwoo Choi <cw00.choi@samsung.com>
Organization: Samsung Electronics
Message-ID: <6a5d3504-4af7-75b7-f92e-be80be70ac8d@samsung.com>
Date:   Fri, 9 Oct 2020 10:02:35 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
In-Reply-To: <20201008223929.399791-2-michael.auchter@ni.com>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdlhTX7dzc328wdsrChbzj5xjtbi8aw6b
        xbPnP1ktbjeuYLNo3XuE3YHVY9OqTjaP62e2M3n0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaCq7dZC+YIVHx5M5Op
        gbGdt4uRk0NCwETiwLb5TF2MXBxCAjsYJV6ebGGBcD4xSuw4OYcdwvnMKHGjYwEbTMuRJ6tZ
        IRK7GCVW3L0L1fKeUWL3rjWsIFXCAq4S31o+M4LYIgKVEsfWn2UBsZkFbCQ6fp8Ds9kEtCT2
        v7gBNpVfQFHi6o/HYPW8AnYSvw8vBqrh4GARUJE4cM0NJCwqECZxclsLVImgxMmZT8DGcArY
        Spxb/ZUJYry4xK0n86FseYntb+cwQxzdyiGx8YsMhO0isXDeOai4sMSr41vYIWwpiZf9bVB2
        tcTKk0fYQP6SEOhglNiy/wIrRMJYYv/SyUwgtzELaEqs36UPEVaU2Pl7LiPEXj6Jd197WEFK
        JAR4JTrahCBKlCUuP7jLBGFLSixu72SbwKg0C8k3s5B8MAvJB7MQli1gZFnFKJZaUJybnlps
        WGCMHNmbGMFJUst8B+O0tx/0DjEycTAeYpTgYFYS4U33rokX4k1JrKxKLcqPLyrNSS0+xGgK
        DN6JzFKiyfnANJ1XEm9oamRsbGxhYmhmamioJM778JZCvJBAemJJanZqakFqEUwfEwenVAOT
        8fctvLO3Lgx/pn/I4P9pm891tzVPfXpg9dNc6e8hvqIHK94va951y+HVIzfzbadOTzPOexX/
        ZsO0xUfSaw2/vSo5ocOQq+Un0bJYek3PwXm2q48uSbvg/DrxZz5LfI3Ak7LkRXZZ++3bK9j7
        Dl4tLjv/f+YLjWlZ97brZ00MNnDhTJjDnDH3i5b/Uye3vil5PQFmuXnFGknZJ6bZubNuTHFs
        Y72S6a7x60tsyz2p2683hh46yj5T/g97yML4R2E5Ao+2d9fLz571oPXu2dfVgp9ZXprtPHD6
        wYPwzzbbZW98FBfaYF+W8n6DfQdHU0vv+bjio4v1pm2eeXprXZh2j4v9iUdNmYu5v635meUh
        oMRSnJFoqMVcVJwIAMWxxeobBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMLMWRmVeSWpSXmKPExsWy7bCSvG7H5vp4gz0vdC3mHznHanF51xw2
        i2fPf7Ja3G5cwWbRuvcIuwOrx6ZVnWwe189sZ/Lo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jAVXb7MWzBGo+PJmJlMDYztvFyMnh4SAicSRJ6tZuxi5OIQEdjBKzL+2hQ0iISkx7eJR5i5G
        DiBbWOLw4WKImreMEu/33gSrERZwlfjW8pkRxBYRqJSY0jUZzGYWsJHo+H2OBaLhMKPEm32n
        mEESbAJaEvtf3ABr5hdQlLj64zFYA6+AncTvw4tZQJaxCKhIHLjmBhIWFQiT2LnkMRNEiaDE
        yZlPWEBsTgFbiXOrvzJB7FKX+DPvEjOELS5x68l8qLi8xPa3c5gnMArPQtI+C0nLLCQts5C0
        LGBkWcUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJERwvWlo7GPes+qB3iJGJg/EQowQH
        s5IIb7p3TbwQb0piZVVqUX58UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUa
        mPwnnReXODLrzH7re/PePcxMmPPgxtSahDpmt287nJmvTbwzZ1fbFh1Od2XvJ4XsC9u8X7ae
        mj9d9++LB0qPeH2PcqnqNN+9/2+G/e/sJ58+z/4yI6/Ve2n70SPivFuLqk4cO/RvyfGf4Q/s
        ayXWc11LvdqvE67ytV+k+ZHP/vANXaasFYUX3oeabOrevPXYfMeeV9knXfYXdLzMcrX6+/Du
        8h82sv9MAv5emPH28KanXC8npxg8ymraJ5euHxjFZfqUc+kambMTnNdI+3/QEWln6z7xP76/
        1u2b05LnP1hSKhdUHbxyO0rr5rfOaWtd5roqOPxq+nrlUm5RUP9JBdX6RXU+Qc5f27feNef5
        XKGuxFKckWioxVxUnAgA4oHPCQYDAAA=
X-CMS-MailID: 20201009004912epcas1p3978dad9ce71eb37b7cd37cd899bb4ba7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201008224000epcas1p35c470d955b060702f59419875939677c
References: <20201008223929.399791-1-michael.auchter@ni.com>
        <CGME20201008224000epcas1p35c470d955b060702f59419875939677c@epcas1p3.samsung.com>
        <20201008223929.399791-2-michael.auchter@ni.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/20 7:39 AM, Michael Auchter wrote:
> Add a device tree binding for the TI TUSB320.
> 
> Signed-off-by: Michael Auchter <michael.auchter@ni.com>
> ---
>  .../bindings/extcon/extcon-usbc-tusb320.yaml  | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> 
> diff --git a/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> new file mode 100644
> index 000000000000..57f1bcbf1295
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: https://protect2.fireeye.com/v1/url?k=24582026-79962192-2459ab69-000babdfecba-1931f18c81ab64e5&q=1&e=8094c8b6-bc5c-4c39-b23a-4f81a9cccae3&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fextcon%2Fextcon-usbc-tusb320.yaml%23
> +$schema: https://protect2.fireeye.com/v1/url?k=8c20f14c-d1eef0f8-8c217a03-000babdfecba-6159bd3aeb5a40ca&q=1&e=8094c8b6-bc5c-4c39-b23a-4f81a9cccae3&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
> +
> +title: TI TUSB320 USB Type-C CC Logic controller
> +
> +maintainers:
> +  - Michael Auchter <michael.auchter@ni.com>
> +
> +properties:
> +  compatible:
> +    const: ti,tusb320
> +
> +  reg:
> +    maxItems: 1
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
> +    i2c0 {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        extcon@61 {

Better to use 'tusb320' instead of 'extcon' word
because extcon doesn't represent the hardware.

> +            compatible = "ti,tusb320";
> +            reg = <0x61>;
> +            interrupt-parent = <&gpio>;
> +            interrupts = <27 1>;
> +        };
> +    };
> +...
> 


-- 
Best Regards,
Chanwoo Choi
Samsung Electronics

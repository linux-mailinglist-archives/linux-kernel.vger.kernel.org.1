Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4636B26890A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 12:14:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgINKOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 06:14:46 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:27097 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgINKOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 06:14:42 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200914101436epoutp01574eff57e16eace6f61611d333008d4a~0nuWMY3Ov1147211472epoutp01R
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 10:14:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200914101436epoutp01574eff57e16eace6f61611d333008d4a~0nuWMY3Ov1147211472epoutp01R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600078476;
        bh=JFHh/aJHJSOEUE3wBLBZ6+XAzqIP08cbJ7dL1Svgqao=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=rAs2IW9v784QA/xtKYnVMbpBeje2nT3hMDCjmkHwvpseauIqiTGs+14SDbRIo/uKr
         EGm5nEkOnfpJ8qUawlUKPuRYlYsSPNjFgoL7vrKy/Ec4XTaWXpM3IhBa7U6wy+cf97
         dQaU3T1MYv1rrn84C7I9vO6hQsO6OeKgtES+qp38=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200914101435epcas1p29a76292724b3aebe9fa62a6978516562~0nuVfGzO20504705047epcas1p2T;
        Mon, 14 Sep 2020 10:14:35 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.153]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Bqhzr3GkYzMqYkb; Mon, 14 Sep
        2020 10:14:32 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        32.66.20696.8824F5F5; Mon, 14 Sep 2020 19:14:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200914101431epcas1p1bacd96c32698402f3cf7f548e2c56671~0nuR0b0M90884808848epcas1p1d;
        Mon, 14 Sep 2020 10:14:31 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200914101431epsmtrp12098a071dd1bd3eac40dd1efb35af723~0nuRywuSy0253402534epsmtrp1D;
        Mon, 14 Sep 2020 10:14:31 +0000 (GMT)
X-AuditID: b6c32a39-eebff700000050d8-39-5f5f4288194f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        68.9B.08303.7824F5F5; Mon, 14 Sep 2020 19:14:31 +0900 (KST)
Received: from [10.113.111.64] (unknown [10.113.111.64]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200914101431epsmtip10d235e40b1f3db804a825a4cd432d310~0nuRaqj8U2917329173epsmtip1D;
        Mon, 14 Sep 2020 10:14:31 +0000 (GMT)
Subject: Re: [PATCH v5 00/80] drm/vc4: Support BCM2711 Display Pipeline
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Eric Anholt <eric@anholt.net>, devicetree@vger.kernel.org,
        Tim Gover <tim.gover@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?B?64KY7ISx6rWt?= <sungguk.na@samsung.com>,
        Hoegeun Kwon <hoegeun.kwon@samsung.com>
From:   Hoegeun Kwon <hoegeun.kwon@samsung.com>
Message-ID: <3e113525-aa89-b1e2-56b7-ca55bd41d057@samsung.com>
Date:   Mon, 14 Sep 2020 19:14:11 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200908120019.3rmhzoijoijrbb7d@gilmour.lan>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfUwbZRzHeXrX6zFTdsCAJ+i0HBu6aaEFCgeBbbo5b9EYiHFTcSkHvVGk
        tF2Pt7mYVQhL7VZeMg1bAcE4BCodWBApjjBeJmGLEAPB2MkIeyGCq8AQZoYMW45F/vv8Xr73
        ve89z+FIwAwWimdr81iDltGQ2Da0c2BPlNT0mlIpu303mLJbrqOUu/ZrlKobHBFS48vzGHXt
        0zFAzTeaMco5bkcpx90JITXWXYNRlbfaRNTFf54AqtPaiFFXXH9iVGnPoIh6MvEdSnV92Qeo
        O19MgQP+dPH8TxhtnfoZo38fGcVop3VSRDtsn2H01LkhAd1++Qxdev0xSpd12ADdfvM0veR4
        PuWZD3KS1CyjYg0SVpupU2Vrs5LJN99RHlQq4mRyqTyBiiclWiaXTSYPvZUiPZyt8YQiJQWM
        Jt/TSmE4jozal2TQ5eexErWOy0smWb1Ko0/QR3JMLpevzYrM1OUmymWyaIVnMT1HPVM/iemH
        w4vKvqlBjGBgpxn44pCIhQ3FDpEZbMMDiC4AV1onN4uHAP5g78b4YgnArrV58FTSYl5H+EE3
        gGttPShfuAH8fHpMaAY4Hki8AY2OeK9gB7Ebjlt6NgQIsYDC0sejiHeAEVK4fP5XgZfFxD44
        1taCeRn1CFr/rdngIOJ96Lw/K+J3/OHwpXuo9/m+RCJ8VLbf20aIF2DJ99UIzyHQda9O4PWC
        xDoOb9rNGP/Wh+DIeq+Q50A4N9Qh4jkUzpaf3WQOjl+aQ3mxEcDyyurNQQzsbbgg8BojxB7Y
        2h3Ft8Ogc7UW8MZ+8K/l8xvZISGGprMB/EoEnDFe27R9Dt6wNAp4pqGtbwapAGHWLcmsW+JY
        t8Sx/m9cD1AbCGb1XG4Wy8n1iq2n7QAbF35vQheoci9E9gMBDvoBxBFyh/h11XFlgFjFnPqY
        NeiUhnwNy/UDhedbVyKhQZk6zx+jzVPKFdExMTFUrDxOIZeTIeJpl0QZQGQxeWwOy+pZw1Od
        APcNNQqOujJsrcJnqxca1DeizzTFL9VUjZraM77ys4tPWF6633suMvpdS1qhAOtVf2J/mOh0
        R2Gpc0Wdp08ZzcPli6slyH6JRPJ31e7SldAjxa92lqmOFzyqNLkjjVdnXeDKUnDYe78JdrVF
        YIUpFesfCpvSWpNWHvQPFBZJmvtuxwIjoyl3Uf63/kgIyfglPfXFobcD+09EG1d36eqSG6Wy
        rlS3f5+sY/ngaPOxwXafYVLl95F76XL2zpQj4RU5dySugqbtLdLpme5jr6jCXVFxuRGTa7aT
        eOei0WR6cNRZMlFW6zpg69h+Qds30Jzmk94bG/Sjz8hK2krhyfr1+auLL3/rQ6KcmpHvRQwc
        8x8nIOcreQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMIsWRmVeSWpSXmKPExsWy7bCSnG67U3y8wcRmeYu1vUdZLN7OXcxi
        Mf/IOVaLK1/fs1kcaLzMaPF+eRebxc4ra1ksNj2+xmpxedccNouJtzewW8z48Y/RYtus5WwW
        6269ZrNo3XuE3eLftY0sFjvmHWS0eDT1PqODoEfT+2NsHrPun2XzuHPuPJvHzll32T02repk
        87jffZzJY/OSeo/Wo79YPPq2rGL02Hy62uPzJrkA7igum5TUnMyy1CJ9uwSujGcL7rIVnFSu
        6Fs2h7mB8bBsFyMnh4SAicSarv/MXYxcHEICOxgleg4eYoJIyEis6t/C2sXIAWQLSxw+XAxR
        85pR4kjbY0aQuLCAu0TDJnOQchEBVYkrvXvB5jALfGCRuN35nA2iYS6TxJ2nc1hAqtgEdCW+
        9lwHW8ArYCdxecMaNhCbBah7/Z85bCBDRQUiJXbusIQoEZQ4OfMJC0iYU8BK4nufPUiYWcBM
        Yt7mh8wQtrxE89bZULa4xK0n85kmMArNQtI9C0nLLCQts5C0LGBkWcUomVpQnJueW2xYYJSX
        Wq5XnJhbXJqXrpecn7uJERzPWlo7GPes+qB3iJGJg/EQowQHs5IIr2tKbLwQb0piZVVqUX58
        UWlOavEhRmkOFiVx3q+zFsYJCaQnlqRmp6YWpBbBZJk4OKUamGxy2s4FTl5bv4dx/YUZN9le
        7BOc3TL7Z6vw1HdpLdnqli84zVaxXzPfKiDpuyRmvcQJxj8tb/PuVi6svckrmV2aGtfOo1X1
        4nDqMasi5py5QWUiHX+rguRer9Ve939u7fRNHOeuhX7UnnvSuHOLfT1b7RWjrjr/LxvXOzTb
        hxTn/F/CdOhRl4Xfy4tzzB0k9rzbvHCPuepKY62CzwuWr9xxcq/NTJ/YXptjEq58z9SZ5/lv
        Pu39fPUzu9KyI57MDYdMVcq/P5RtqkmV2cf+2anNqlajVWVC0bJ7W/5IrX/+KvjXhfnvjJof
        VGR1izhZ+t7/Js0RFpbRqL249YHwRvnNb2xnSxXt416/Z17/bCWW4oxEQy3mouJEAMFcw5dW
        AwAA
X-CMS-MailID: 20200914101431epcas1p1bacd96c32698402f3cf7f548e2c56671
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200904071259epcas1p3de4209531c0bc5ed6ea9ef19827b6ed5
References: <CGME20200904071259epcas1p3de4209531c0bc5ed6ea9ef19827b6ed5@epcas1p3.samsung.com>
        <cover.dddc064d8bb83e46744336af67dcb13139e5747d.1599120059.git-series.maxime@cerno.tech>
        <cca5234f-e1e8-b642-048b-b710f402409d@samsung.com>
        <20200908120019.3rmhzoijoijrbb7d@gilmour.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maxime,

On 9/8/20 9:00 PM, Maxime Ripard wrote:
> Hi Hoegeun,
>
> On Mon, Sep 07, 2020 at 08:49:12PM +0900, Hoegeun Kwon wrote:
>> On 9/3/20 5:00 PM, Maxime Ripard wrote:
>>> Hi everyone,
>>>
>>> Here's a (pretty long) series to introduce support in the VC4 DRM driver
>>> for the display pipeline found in the BCM2711 (and thus the RaspberryPi 4).
>>>
>>> The main differences are that there's two HDMI controllers and that there's
>>> more pixelvalve now. Those pixelvalve come with a mux in the HVS that still
>>> have only 3 FIFOs. Both of those differences are breaking a bunch of
>>> expectations in the driver, so we first need a good bunch of cleanup and
>>> reworks to introduce support for the new controllers.
>>>
>>> Similarly, the HDMI controller has all its registers shuffled and split in
>>> multiple controllers now, so we need a bunch of changes to support this as
>>> well.
>>>
>>> Only the HDMI support is enabled for now (even though the DPI and DSI
>>> outputs have been tested too).
>>>
>>> Let me know if you have any comments
>>> Maxime
>>>
>>> Cc: bcm-kernel-feedback-list@broadcom.com
>>> Cc: devicetree@vger.kernel.org
>>> Cc: Kamal Dasu <kdasu.kdev@gmail.com>
>>> Cc: Philipp Zabel <p.zabel@pengutronix.de>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Stephen Boyd <sboyd@kernel.org>
>>>
>>> Changes from v4:
>>>     - Rebased on top of next-20200828
>>>     - Collected the various tags
>>>     - Fixed some issues with 4k support and dual output (thanks Hoegeun!)
>> Thanks for your v5 patchset.
>>
>> I tested all patches based on the next-20200812.
> Thanks again for testing all the patches
>
>> Everything else is fine, but the dual hdmi modetest doesn't work well in my
>> environment...
>>
>> In my environment, dsi is not connected, I have seen your answer[1].
> Can you share a bit more your setup? What monitors are being connected
> to each HDMI port? Do you hotplug any?
Yes, Monitors are being connected to each HDMI ports. (did not use hotplug)

When booting, both HDMI-0 and 1 are recognized and the kernel log is output.
But after run modetest on HDMI-0(works) and modetest on HDMI-1(works),
crtc timed out occurs on HDMI-0 and does not work.

When HDMI-0 is not working we do a modetest on HDMI-0, it will work agin
after about 40 sec.

Below is the log for modetest.


root:~> modetest -Mvc4 -s 32:1280x720         - HDMI-0 works
setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
failed to set gamma: Invalid argument

root:~> modetest -Mvc4 -s 32:1280x720         - HDMI-0 works
setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
failed to set gamma: Invalid argument

root:~> modetest -Mvc4 -s 38:1280x720         - HDMI-1 works
setting mode 1280x720-60Hz@XR24 on connectors 38, crtc 69
failed to set gamma: Invalid argument

                                   - Crtc timed out occurs on HDMI-0 and 
does not work.

[   71.134283] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
[   81.374296] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
[   91.618380] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CONNECTOR:32:HDMI-A-1] flip_done timed out
[  101.854274] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[PLANE:60:plane-3] flip_done timed out

[  112.094271] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
[  122.590311] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out

root:~> modetest -Mvc4 -s 32:1280x720
[  132.830309] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CONNECTOR:32:HDMI-A-1] flip_done timed out
[  143.070307] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[PLANE:60:plane-3] flip_done timed out
[  153.310303] [drm:drm_atomic_helper_wait_for_flip_done] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
setting mode 1280x720-60Hz@XR24 on connectors 32, crtc 64
[  163.550340] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CRTC:64:crtc-3] flip_done timed out
[  173.790277] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[CONNECTOR:32:HDMI-A-1] flip_done timed out
[  184.030286] [drm:drm_atomic_helper_wait_for_dependencies] *ERROR* 
[PLANE:60:plane-3] flip_done timed out
failed to set gamma: Invalid argument         - HDMI-0 works


Best regards,
Hoegeun



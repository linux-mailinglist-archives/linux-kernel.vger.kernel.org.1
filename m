Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 737202D7140
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Dec 2020 09:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405472AbgLKINu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 03:13:50 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:43161 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387443AbgLKIN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 03:13:29 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20201211081246epoutp021462d0c348fb27c7df0b858bba25ab47~Pm1GU8smc3149331493epoutp02h
        for <linux-kernel@vger.kernel.org>; Fri, 11 Dec 2020 08:12:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20201211081246epoutp021462d0c348fb27c7df0b858bba25ab47~Pm1GU8smc3149331493epoutp02h
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607674366;
        bh=gTJUVMBEIH68T9kTKdpH3Os5f51ggZiY41qPyBbWEmI=;
        h=To:Cc:From:Subject:Date:References:From;
        b=gPGaWCsce+YNkOjGtavj+oGCTt9HfbauHsDgPwPHgAVjw3ENcucU1cC4j0uxjtd1v
         dQyEbtVm8Eprd7l9DJ8xgPnv0574GCEUxi08kCml8mGiKqyBYHQ0Uk7iUTPBBbRBTt
         oVSOGHrTjReqm9mN3qcirD0akICaNcw3iN3kvZ00=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201211081246epcas1p195d5a8bee271abc01e64bdb98807bbcb~Pm1FyXyEG1366413664epcas1p1B;
        Fri, 11 Dec 2020 08:12:46 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Csk6c3JLhzMqYkd; Fri, 11 Dec
        2020 08:12:40 +0000 (GMT)
Received: from epcas1p3.samsung.com ( [182.195.41.47]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.2F.02418.8F923DF5; Fri, 11 Dec 2020 17:12:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20201211081239epcas1p4809436b16fc6d6595ea8ce4e2343aecb~Pm0-3wxKc0570505705epcas1p49;
        Fri, 11 Dec 2020 08:12:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201211081239epsmtrp149c01bac8a0094dcda87ef7da726b773~Pm0-3Lh0V0495704957epsmtrp1Q;
        Fri, 11 Dec 2020 08:12:39 +0000 (GMT)
X-AuditID: b6c32a35-c0dff70000010972-98-5fd329f8d552
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        3F.7B.13470.7F923DF5; Fri, 11 Dec 2020 17:12:39 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201211081239epsmtip215d93611764f2b6124bdb8fa7cb4af44~Pm0-rn9Hy3032130321epsmtip2r;
        Fri, 11 Dec 2020 08:12:39 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.11
Organization: Samsung Electronics
Message-ID: <ad016689-0ffd-e398-1ce0-a3c20dd030ee@samsung.com>
Date:   Fri, 11 Dec 2020 17:27:24 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnk+LIzCtJLcpLzFFi42LZdlhTX/eH5uV4gylfxC0m3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAlqhsm4zUxJTUIoXUvOT8
        lMy8dFsl7+B453hTMwNDXUNLC3MlhbzE3FRbJRefAF23zBygvUoKZYk5pUChgMTiYiV9O5ui
        /NKSVIWM/OISW6XUgpScAssCveLE3OLSvHS95PxcK0MDAyNToMKE7Iw/z/YzFhwVqrj1fz9T
        A+NDvi5GTg4JAROJCzuPsHQxcnEICexglJh7YTMbSEJI4BOjxI17dRCJb4wSPW9/McF0HO6e
        ywSR2MsocWLrYTYI5z2jxJWJF5lBqkQENCReHr0FNpdZ4A2jxL7PnawgCTYBLYn9L26A7RAW
        0JToOfqVBcTmF1CUuPrjMSOIzStgJ7Fw+g/2LkYODhYBVYmumRYgYVGBMImT21qgSgQlTs58
        AtbKLCAucevJfCYIW15i+9s5zBCXfmSXWLCHA2SMhICLxMlWbYiwsMSr41vYIWwpiZf9bVB2
        tcTKk0fAfpEQ6GCU2LL/AitEwlhi/9LJTCBzmIFOXr9LHyKsKLHz91xGiLV8Eu++9rBCrOKV
        6GgTgihRlrj84C403CQlFrd3skHYHhJbn+5mnMCoOAvJM7OQPDMLyTOzEBYvYGRZxSiWWlCc
        m55abFhgiBzXmxjBKVLLdAfjxLcf9A4xMnEwHmKU4GBWEuGVZbkUL8SbklhZlVqUH19UmpNa
        fIjRFBi6E5mlRJPzgUk6ryTe0NTI2NjYwsTQzNTQUEmc9492R7yQQHpiSWp2ampBahFMHxMH
        p1QDU7wbn/jpvUrWm7f4vtNPW1Z0fOb3mXPc3vHcYnqYLWC9apXYY8tDcfPzFh3sP9Qe7rrE
        6OzuB8ypxpEJ3kXmvTMLT0dM/nXxVPL0h3+mnt37W3Gn5pydnlcXbcw+tVHgUPNEw0qzhPKi
        +Uqu92fbLfrPsXeraIfEvTMyCXpT/loKpEcGL//B4xnUefXJfalKZ9kkxbg63+vL2wRPrzAy
        W1SdZT6/99x61mnl1mGWJ89+F76x69bWes8pH+16Yl9w5en/7lB1XxnOwlDSX90XMXuC2YK1
        O6qVRflWi9x7P8u8ZGXOtGCdPV8e/3r3cOGs1PUCaxte++h+atGM/PD7uEnbyl1/uOvk10ZM
        3qG40U6JpTgj0VCLuag4EQD8cXFCGgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO53zcvxBt++alhMvHGFxeL6l+es
        Fs2L17NZXN41h83iduMKNgdWj02rOtk89s9dw+7Rt2UVo8fnTXIBLFFcNimpOZllqUX6dglc
        GX+e7WcsOCpUcev/fqYGxod8XYycHBICJhKHu+cydTFycQgJ7GaUmPl1EStEQlJi2sWjzF2M
        HEC2sMThw8UgYSGBt4wS/bPyQWwRAQ2Jl0dvsYD0Mgu8AYqv2cIOkmAT0JLY/+IGG4gtLKAp
        0XP0KwuIzS+gKHH1x2NGEJtXwE5i4fQf7CDzWQRUJbpmWoCERQXCJHYuecwEUSIocXLmE7BW
        ZgF1iT/zLjFD2OISt57MZ4Kw5SW2v53DPIFRcBaSlllIWmYhaZmFpGUBI8sqRsnUguLc9Nxi
        wwLDvNRyveLE3OLSvHS95PzcTYzg4NfS3MG4fdUHvUOMTByMhxglOJiVRHhlWS7FC/GmJFZW
        pRblxxeV5qQWH2KU5mBREue90HUyXkggPbEkNTs1tSC1CCbLxMEp1cC0XFOSdzbLkpVuy2ao
        r3xq7X4iJekRg8Uyrl36vxdur7zNqnPVzPWt8/RtJ247ZEecfyVtfMXb6pDdnZc7xUyjZO4u
        7bvwL1LQaoKTv5WoW1TOw/32GRdvTDt22upp0rQHBQbL3nD9nHxlcqhcj/jleQbbelYvefFu
        9p4adV4flZwu62XlX9/PVip25EupSXsjbnZyVfuZGo99Zkt+lltzJr9cKHdm4naPmxkLgtgn
        zks/ve7KRKbaft+c2/dKHwte/7BTINfodjmHf3R+lJ2amrWrRV3/jWmG7Qy/jNYZW11XzTrk
        qiP+OU0sh6/9RZl1OfP5H0xxR/R3bvousXKZ/YGHYgVv3y/UtwkxK7mhxFKckWioxVxUnAgA
        l4375O0CAAA=
X-CMS-MailID: 20201211081239epcas1p4809436b16fc6d6595ea8ce4e2343aecb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201211081239epcas1p4809436b16fc6d6595ea8ce4e2343aecb
References: <CGME20201211081239epcas1p4809436b16fc6d6595ea8ce4e2343aecb@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.11. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 0477e92881850d44910a7e94fc2c46f96faa131f:

  Linux 5.10-rc7 (2020-12-06 14:25:12 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.11

for you to fetch changes up to e1efdb604f5c9903a5d92ef42244009d3c04880f:

  extcon: max77693: Fix modalias string (2020-12-11 17:18:10 +0900)

----------------------------------------------------------------

Update for extcon-next v5.11

1. Add new TI TUSB320 USB-C extcon driver
- The extcon-usbc-tusb320.c driver for the TI TUSB320 USB Type-C device
support the USB Type C connector detection.

2. Rewrite binding document in yaml for extcon-fsa9480.c
and add new compatible name of TI TSU6111 device.

3. Fix moalias string of extcon-max77693.c to fix the automated module
loading when this driver is compiled as a module.

----------------------------------------------------------------
Linus Walleij (2):
      extcon: fsa9480: Rewrite bindings in YAML and extend
      extcon: fsa9480: Support TI TSU6111 variant

Marek Szyprowski (1):
      extcon: max77693: Fix modalias string

Michael Auchter (2):
      extcon: Add driver for TI TUSB320
      dt-bindings: extcon: add binding for TUSB320

 .../devicetree/bindings/extcon/extcon-fsa9480.txt  |  21 ---
 .../bindings/extcon/extcon-usbc-tusb320.yaml       |  41 +++++
 .../devicetree/bindings/extcon/fcs,fsa880.yaml     |  52 ++++++
 drivers/extcon/Kconfig                             |   8 +
 drivers/extcon/Makefile                            |   1 +
 drivers/extcon/extcon-fsa9480.c                    |   1 +
 drivers/extcon/extcon-max77693.c                   |   2 +-
 drivers/extcon/extcon-usbc-tusb320.c               | 184 +++++++++++++++++++++
 8 files changed, 288 insertions(+), 22 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-fsa9480.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-usbc-tusb320.yaml
 create mode 100644 Documentation/devicetree/bindings/extcon/fcs,fsa880.yaml
 create mode 100644 drivers/extcon/extcon-usbc-tusb320.c

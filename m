Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFD84282F12
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 05:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJEDb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 23:31:26 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:21929 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbgJEDbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 23:31:24 -0400
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20201005033121epoutp032eda6cf34b6d04412a22a972ccf94bd6~6_xQTs8Kc1535715357epoutp03K
        for <linux-kernel@vger.kernel.org>; Mon,  5 Oct 2020 03:31:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20201005033121epoutp032eda6cf34b6d04412a22a972ccf94bd6~6_xQTs8Kc1535715357epoutp03K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601868681;
        bh=6t9ZfOMnOTguA/t6196s3zHYsrWIl/QmLpQD/EG72g8=;
        h=To:From:Subject:Cc:Date:References:From;
        b=B/+Bu9GLJqFPhRJE10pJjsT6XPEX9EHeki/vbhP+3dzNqN7vSwOwhN1SKWBOeKwJy
         Kpf9YbIXH1SufhJbSOPpXOSapCfJoaodHL4VZlM51/sKZWrbA5hkvfcpM+L3Cd/yGa
         HTsawQ0icz+iY14LyXd8aTjrbYs25sYsekzuL/V0=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201005033120epcas1p2d180af448fc7881c29a88212d93ad6f8~6_xPn656u1119911199epcas1p2a;
        Mon,  5 Oct 2020 03:31:20 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.156]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4C4R2s1d0NzMqYkc; Mon,  5 Oct
        2020 03:31:17 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        B0.69.09577.3839A7F5; Mon,  5 Oct 2020 12:31:15 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201005033115epcas1p212c497829985ba7f9d1e6a43bb73f74a~6_xKvn7r12166121661epcas1p2p;
        Mon,  5 Oct 2020 03:31:15 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201005033115epsmtrp2763ad1089b560d87eaefab2b5f9b97d2~6_xKu9ioW2239722397epsmtrp2g;
        Mon,  5 Oct 2020 03:31:15 +0000 (GMT)
X-AuditID: b6c32a39-bfdff70000002569-b1-5f7a9383727b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        F9.00.08745.3839A7F5; Mon,  5 Oct 2020 12:31:15 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201005033114epsmtip23cfdec319fa63ec57210ba29ed59ad95~6_xKk8uzr0507705077epsmtip2Z;
        Mon,  5 Oct 2020 03:31:14 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL v2] extcon next for v5.10
Organization: Samsung Electronics
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
Message-ID: <a9869e42-474d-a016-fa9c-c8d6d6cd3cc0@samsung.com>
Date:   Mon, 5 Oct 2020 12:44:36 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupik+LIzCtJLcpLzFFi42LZdlhTT7d5clW8wYrbRhYTb1xhsbj+5Tmr
        RfPi9WwWl3fNYbO43biCzYHVY9OqTjaP/XPXsHv0bVnF6PF5k1wAS1S2TUZqYkpqkUJqXnJ+
        SmZeuq2Sd3C8c7ypmYGhrqGlhbmSQl5ibqqtkotPgK5bZg7QXiWFssScUqBQQGJxsZK+nU1R
        fmlJqkJGfnGJrVJqQUpOgWWBXnFibnFpXrpecn6ulaGBgZEpUGFCdsaDQ1/ZC9YpVHw7fIGx
        gbFLsouRk0NCwETiR/885i5GLg4hgR2MEm13NrJAOJ8YJW733mSFcD4zSqxr72aDaek88ZAJ
        xBYS2MUocWJFLkTRe0aJaQ9uMIIkRAQ0JF4evcUCYrMJaEnsf3EDrFlYQEeiobUdrJlfQFHi
        6o/HjCDNzAJvGCX2fe5kBUnwCthJtDfPBWtgEVCR6P3cDmaLCoRJnNzWwghRIyhxcuYTsAXM
        AuISt57MZ4Kw5SW2v50D9pCEwFt2iT0frjNCnO0i8bp/CjuELSzx6vgWKFtK4vO7vVCvVUus
        PHmEDaK5g1Fiy/4LrBAJY4n9SycDbeAA2qApsX6XPkRYUWLn77mMEIv5JN597WEFKZEQ4JXo
        aBOCKFGWuPzgLhOELSmxuL0TapWHxIkdv1gnMCrOQvLOLCTvzELyziyExQsYWVYxiqUWFOem
        pxYbFpgiR/cmRnCi1LLcwTj97Qe9Q4xMHIyHGCU4mJVEePXCKuKFeFMSK6tSi/Lji0pzUosP
        MZoCA3gis5Rocj4wVeeVxBuaGhkbG1uYGJqZGhoqifM+vKUQLySQnliSmp2aWpBaBNPHxMEp
        1cDE/M5jXcP6fSYtkpP+6E7ZMGOm1Y6pjY3+rl9m29z7kbmlrb5K8P3E6q3mv3Sv3uhLnimp
        G5+wICtp3+H+OXpMbxnnbdpgv6Vj8o1dfw/a31h0O6hU+bLm5b1SPALHDm/UYC0UFTB8PuVn
        XPlFm0bNq7HRitMr4sPP9iztvj37En/6yfwHdzatm7LkVtoXb/klv2SfaP/nrNqjojM570Fu
        rn+k2qTWJTIr8gQv/U+cMF/B71m++ULuYP0XwiysJWXL737i4jgo9HjnpeggczmW2oTWQwpm
        HHnLzyzh55d5YXPnv9gzkdm9/54vOnan6dVU+ys2ySr8LhHvP7TavzRZJfo3RK13y/++nHaL
        pt/zlViKMxINtZiLihMBvnDXcR0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvG7z5Kp4gz+vWSwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jAeHvrIXrFOo+Hb4AmMDY5dkFyMnh4SAiUTniYdMILaQwA5GiRUzHCDikhLTLh5l7mLkALKF
        JQ4fLoYoecsoceUtH4gtIqAh8fLoLRYQm01AS2L/ixtsILawgI5EQ2s72Eh+AUWJqz8eM3Yx
        cnEwC7xhlOhfs4UdJMErYCfR3jwXrIFFQEWi93M7mC0qECaxc8ljJogaQYmTM5+ALWAWUJf4
        M+8SM4QtLnHryXwmCFteYvvbOcwTGAVnIWmZhaRlFpKWWUhaFjCyrGKUTC0ozk3PLTYsMMpL
        LdcrTswtLs1L10vOz93ECA5+La0djHtWfdA7xMjEwXiIUYKDWUmEVy+sIl6INyWxsiq1KD++
        qDQntfgQozQHi5I479dZC+OEBNITS1KzU1MLUotgskwcnFINTGX1rPVroy5+uvvwMf/D+dE/
        T+SdXuEy662W6n632T3phf1vZu/7kcmx682WTxecFl2oaZiTWct9Zpq29dKXd8PTHj5jlZl4
        1odr1yqu5Wa6Z8unmZYYxW3KvH5e794eny+zTnlsFnyTorfaJC35RkIdwy7maZM8Nhll3X//
        8uuLQ5dr9V3mMfZldoldbruRNq/4sMFPnlvJc/7VrZx/IiDMx1TwrvQJ0eJPjuvzXLnCOFY3
        Wa3YWi/IH5Z5raJT0CpcZEqxeDWPxG57E6eFB4//NJu2ynrXjqMf/D+cUbQwfxb8b6bzrszc
        nVVp9SZBvwv0//JcOClivcBKzojj24mYkAc3XS8uf/HdTv1FzkolluKMREMt5qLiRADQgC7F
        7QIAAA==
X-CMS-MailID: 20201005033115epcas1p212c497829985ba7f9d1e6a43bb73f74a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201005033115epcas1p212c497829985ba7f9d1e6a43bb73f74a
References: <CGME20201005033115epcas1p212c497829985ba7f9d1e6a43bb73f74a@epcas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.10. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Changes from v1:
- Fix the wrong commit id of patch.

Best Regards,
Chanwoo Choi


The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.10-v2

for you to fetch changes up to dbc888072a976c2a7f74ad2df1ca3e6894f96002:

  extcon: axp288: Use module_platform_driver to simplify the code (2020-09-30 00:40:06 +0900)

----------------------------------------------------------------

Detailed description for this pull request:

1. Update extcon driver with minor updates:
- Covert the devicetree binding format from txt to yaml and edit
  the bidning document for extcon-ptn5150.c.

- Clean-up the code of extcon-ptn5150.c without any behavior changes.

- Replace HTTP links with HTTPS ones on extcon-palmas.c and extcon-usb-gpio.c.

- Return the proper error code on extcon-max14577/max77693/max77843.c.

- Simplify with dev_err_probe() on extcon-palmas.c.

- Use module_platform_driver to simplify the code on extcon-axp288.c.

2. Update MAINTAINERS
- Add Krzysztof Kozlowski as maintainer of NXP PTN5150A CC/extcon driver
to provide review, feedback and testing.

----------------------------------------------------------------
Alexander A. Klimov (1):
      extcon: Replace HTTP links with HTTPS ones

Andy Shevchenko (1):
      extcon: ptn5150: Deduplicate parts of dev_err_probe()

Krzysztof Kozlowski (20):
      dt-bindings: extcon: ptn5150: Convert binding to DT schema
      dt-bindings: extcon: ptn5150: Use generic "interrupts" property
      dt-bindings: extcon: ptn5150: Make 'vbus-gpios' optional
      extcon: ptn5150: Fix usage of atomic GPIO with sleeping GPIO chips
      extcon: ptn5150: Use generic "interrupts" property
      extcon: ptn5150: Simplify getting vbus-gpios with flags
      extcon: ptn5150: Lower the noisiness of probe
      extcon: ptn5150: Check current USB mode when probing
      extcon: ptn5150: Make 'vbus-gpios' optional
      extcon: ptn5150: Reduce the amount of logs on deferred probe
      extcon: ptn5150: Convert to module_i2c_driver
      extcon: ptn5150: Convert to .probe_new
      MAINTAINERS: Add entry for NXP PTN5150A CC driver
      extcon: max14577: Return error code of extcon_dev_allocate()
      extcon: max77693: Return error code of extcon_dev_allocate()
      extcon: max77843: Return error code of extcon_dev_allocate()
      extcon: max8997: Return error code of extcon_dev_allocate()
      extcon: palmas: Simplify with dev_err_probe()
      extcon: ptn5150: Use defines for registers
      extcon: ptn5150: Do not print error during probe if nothing is attached

Liu Shixin (1):
      extcon: axp288: Use module_platform_driver to simplify the code

Ramuthevar Vadivel Murugan (2):
      extcon: ptn5150: Switch to GENMASK() and BIT() macros
      extcon: ptn5150: Set the VBUS and POLARITY property capability

 .../devicetree/bindings/extcon/extcon-ptn5150.txt  |  27 ---
 .../devicetree/bindings/extcon/extcon-ptn5150.yaml |  60 ++++++
 MAINTAINERS                                        |   7 +
 drivers/extcon/extcon-axp288.c                     |  13 +-
 drivers/extcon/extcon-max14577.c                   |   2 +-
 drivers/extcon/extcon-max77693.c                   |   2 +-
 drivers/extcon/extcon-max77843.c                   |   2 +-
 drivers/extcon/extcon-max8997.c                    |   2 +-
 drivers/extcon/extcon-palmas.c                     |  20 +-
 drivers/extcon/extcon-ptn5150.c                    | 226 ++++++++++-----------
 drivers/extcon/extcon-usb-gpio.c                   |   2 +-
 11 files changed, 185 insertions(+), 178 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.txt
 create mode 100644 Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml

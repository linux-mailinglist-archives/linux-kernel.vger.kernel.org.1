Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F2827C094
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgI2JLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:11:22 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:35864 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727892AbgI2JLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:11:21 -0400
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200929091116epoutp04ef9ffb5029cf37aad72d305b8abbb60d~5NiVkkH2M3219332193epoutp04a
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 09:11:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200929091116epoutp04ef9ffb5029cf37aad72d305b8abbb60d~5NiVkkH2M3219332193epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1601370676;
        bh=OPwaZYlDpxl3Vw8krtpP46zTI9LaKvmmOmQL+jK8pTA=;
        h=To:Cc:From:Subject:Date:References:From;
        b=eYKQjz/9fbKCdCQYN6w1jLaPKAXDKleJRkLdYf8ZIVVB4x8n3nIs/eIYWsfbaQ2l5
         nqJo16vbbdE7istCS0kb4+2YaLbQNHxgpiqG75VdCkRM2G3/A5V99YctltVNjyrzAy
         zvRLh6StU6wEwMQO7ky9ZLc25SmRE02CiDKyN+vY=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200929091116epcas1p35e6cd590be99adb55cea6a449f66e118~5NiVOq07t2680226802epcas1p3I;
        Tue, 29 Sep 2020 09:11:16 +0000 (GMT)
Received: from epsmges1p3.samsung.com (unknown [182.195.40.155]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4C0tss261WzMqYkZ; Tue, 29 Sep
        2020 09:11:13 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        57.7D.09582.13AF27F5; Tue, 29 Sep 2020 18:11:13 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200929091112epcas1p47da3938ff71bcacaa2691f158a471289~5NiR_HvmT0682606826epcas1p4x;
        Tue, 29 Sep 2020 09:11:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200929091112epsmtrp1c9d87fd0f99cc130ff42d5151c0632d9~5NiR9gvg12184921849epsmtrp1a;
        Tue, 29 Sep 2020 09:11:12 +0000 (GMT)
X-AuditID: b6c32a37-899ff7000000256e-55-5f72fa31ffb8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CA.94.08604.03AF27F5; Tue, 29 Sep 2020 18:11:12 +0900 (KST)
Received: from [10.113.221.102] (unknown [10.113.221.102]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200929091112epsmtip2c97c770a2991ff2ad5709af2e7905078~5NiRsE2As1993819938epsmtip2a;
        Tue, 29 Sep 2020 09:11:12 +0000 (GMT)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Chanwoo Choi (samsung.com)" <cw00.choi@samsung.com>,
        "Chanwoo Choi (chanwoo@kernel.org)" <chanwoo@kernel.org>,
        =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@samsung.com>
From:   Chanwoo Choi <cw00.choi@samsung.com>
Subject: [GIT PULL] extcon next for v5.10
Organization: Samsung Electronics
Message-ID: <64750b49-15be-7d51-7ae9-cb1dd4092fa4@samsung.com>
Date:   Tue, 29 Sep 2020 18:24:23 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:59.0) Gecko/20100101
        Thunderbird/59.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgk+LIzCtJLcpLzFFi42LZdljTQNfwV1G8QdM1TouJN66wWFz/8pzV
        onnxejaLy7vmsFncblzB5sDqsWlVJ5vH/rlr2D36tqxi9Pi8SS6AJSrbJiM1MSW1SCE1Lzk/
        JTMv3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwdor5JCWWJOKVAoILG4WEnfzqYo
        v7QkVSEjv7jEVim1ICWnwLJArzgxt7g0L10vOT/XytDAwMgUqDAhO+P5w5+MBV/kKzaf7WFq
        YLwr0cXIySEhYCKxY+1+li5GLg4hgR2MEm0Tf7BCOJ8YJd5ufMQIUiUk8I1RovMBF0xHy9Xp
        jBBFexklzq6dCuW8Z5SYt3MuG0iViICGxMujt8DmMgu8YZTY97mTFSTBJqAlsf/FDaAiDg5h
        AU2Jx/OFQcL8AooSV388BtvGK2Ansf72Z7A5LAKqEjs2/gdrFRUIkzi5rQWqRlDi5MwnLCA2
        s4C4xK0n85kgbHmJ7W/nMIPslRD4yC6x7/ZCsF0SAi4Sr1rSIT4Qlnh1fAs7hC0l8bK/Dcqu
        llh58ggbRG8Ho8SW/RdYIRLGEvuXTmYCmcMMdPP6XfoQYUWJnb/nMkLs5ZN497WHFWIVr0RH
        mxBEibLE5Qd3mSBsSYnF7Z1sELaHRNe6H+wTGBVnIflmFpJvZiH5ZhbC4gWMLKsYxVILinPT
        U4sNC4yRI3sTIzhJapnvYJz29oPeIUYmDsZDjBIczEoivL45BfFCvCmJlVWpRfnxRaU5qcWH
        GE2B4TuRWUo0OR+YpvNK4g1NjYyNjS1MDM1MDQ2VxHkf3lKIFxJITyxJzU5NLUgtgulj4uCU
        amBy5t90QPyQvpjGz66Gw7mP/cRf1FyWzZvM5OmRYFroJRlwxPHUu51+Jt9WXM3vkrzyUM2p
        NN7XrKvO7QObaVuB7sV3H2u01goq8re5tCY4HEtceX3ztHCOMvvNs1Ljd8UvNZM8dzt1wZzn
        3btd1p51E3ip/nZuWUGXa7JwRZiSYD6zY8H7Jd47X5n+Dmmtjw5dsVYhUYR1/bqKUHcbxhu1
        GgEyX730d+ya89VK+WuTnZZRS+3uF4cPX1iY+SHE0CtMRVaiQVrj7NSiMvMJu76wagly/Hmq
        GP8p9KfoXfEVvvem7OQqVtosziLxRij1E3PjHdf27NSsRtfIm/s6HDgNpv2Rj13UMqtdymWl
        EktxRqKhFnNRcSIAwBqelhsEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNLMWRmVeSWpSXmKPExsWy7bCSvK7Br6J4g4nbdCwm3rjCYnH9y3NW
        i+bF69ksLu+aw2Zxu3EFmwOrx6ZVnWwe++euYffo27KK0ePzJrkAligum5TUnMyy1CJ9uwSu
        jOcPfzIWfJGv2Hy2h6mB8a5EFyMnh4SAiUTL1emMXYxcHEICuxklGq+fYYJISEpMu3iUuYuR
        A8gWljh8uBii5i2jROvNdrAaEQENiZdHb7GAJJgF3jBK9K/Zwg6SYBPQktj/4gYbSLOwgKbE
        4/nCIGF+AUWJqz8eM4LYvAJ2Eutvf2YDsVkEVCV2bPzPCmKLCoRJ7FzymAmiRlDi5MwnLCA2
        s4C6xJ95l5ghbHGJW0/mM0HY8hLb385hnsAoOAtJyywkLbOQtMxC0rKAkWUVo2RqQXFuem6x
        YYFhXmq5XnFibnFpXrpecn7uJkZw+Gtp7mDcvuqD3iFGJg7GQ4wSHMxKIry+OQXxQrwpiZVV
        qUX58UWlOanFhxilOViUxHlvFC6MExJITyxJzU5NLUgtgskycXBKNTB5fF4X68powHhB42a7
        uukdb+XLewuZV1ltT3+4oNju1sbHDifls+ZfzkrYH7iya7pq4Wph7+s7+XuqN//4Zpu872vb
        9EUBqj9O/1B9kv3ab89zm/i1LjWzr/fk7sorvD7RJywjM0kq16a5d/7TzXa7ZXe+aW7/Lrro
        ccytf0FvFjM2mBR9Ws85+/nve73v6zc2X1xq+m61xXpfnrkHXx9k2fqumuv1yurzD7aeqAxe
        9H/2qQuvW56cEJxzNHbOjjhHbutnhvu/sb6/+KdebZdkrBFr72yZVaGMwusS1j07rufOlqWQ
        bb/lRuf9r4IF7jnvJnR37jskydCZL/7YMKwgYlltmFDQQcujPpcVdDLfKbEUZyQaajEXFScC
        AAs3Da/uAgAA
X-CMS-MailID: 20200929091112epcas1p47da3938ff71bcacaa2691f158a471289
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200929091112epcas1p47da3938ff71bcacaa2691f158a471289
References: <CGME20200929091112epcas1p47da3938ff71bcacaa2691f158a471289@epcas1p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

This is extcon-next pull request for v5.10. I add detailed description of
this pull request on below. Please pull extcon with following updates.

Best Regards,
Chanwoo Choi


The following changes since commit 856deb866d16e29bd65952e0289066f6078af773:

  Linux 5.9-rc5 (2020-09-13 16:06:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-5.10

for you to fetch changes up to 8ce177237d9005b315a6e1c88427f9dff2ce5e4a:

  extcon: axp288: Use module_platform_driver to simplify the code (2020-09-24 19:20:50 +0900)

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

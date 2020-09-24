Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7EC2770F8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727716AbgIXM2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:28:05 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:46993 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727556AbgIXM2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:28:04 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08OCQnBU001967;
        Thu, 24 Sep 2020 14:27:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=v0+6la6mEAINSXjq/A8KgH4UYDVPzmj5JSfbyrt53hA=;
 b=O5hwpsJvzgYiLk6XjufBBovUYZIM5PoEPh5nfl5+2PBmfKot2i4e4OEA23gbrxEXOXWL
 d6tZkkpfA6+oMyRHQ7VI564W+W/adQJ0XZfROGtSzvSXvMVYcLoTBJ3+awUbG7MKAeiC
 aUpkQPHsxhyS2sy2xWsIlcw0lRBVqMVoNcYOYZpjhVA15l4cF5ZKNuLpeehxZ8uAWgnI
 16bsjRjUjavO+LdPb9oeZa8O3l3MOOS0yD+xWNwqZkiTUmViwL8Y2pR2P6cwPWRq+Qi4
 E4aVvbeBQQ6EOLJqe5Xpj3unU+15xWUhcjb+zKxIfhRCm8/B+u6MEo74JaoIuef9n8Ff PA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n7f03tgk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 24 Sep 2020 14:27:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id A158E10002A;
        Thu, 24 Sep 2020 14:27:48 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8BABC2AD2BE;
        Thu, 24 Sep 2020 14:27:48 +0200 (CEST)
Received: from lmecxl0995.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 24 Sep
 2020 14:27:47 +0200
Subject: Re: [PATCH v6 0/3] Add USB role switch support to DWC2
To:     Minas Harutyunyan <hminas@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        Fabrice GASNIER <fabrice.gasnier@st.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20200909093511.4728-1-amelie.delaunay@st.com>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <542ec140-fd49-04a1-bc66-e473858caa67@st.com>
Date:   Thu, 24 Sep 2020 14:27:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909093511.4728-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-24_08:2020-09-24,2020-09-24 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle reminder on the whole series instead.

Thanks,
Amelie

On 9/9/20 11:35 AM, Amelie DELAUNAY wrote:
> When using usb-c connector (but it can also be the case with a micro-b
> connector), iddig, avalid, bvalid, vbusvalid input signals may not be
> connected to the DWC2 OTG controller.
> DWC2 OTG controller features an overriding control of the PHY voltage valid
> and ID input signals.
> So, missing signals can be forced using usb role from usb role switch and
> this override feature.
> 
> This series adds support for usb role switch to dwc2, by using overriding
> control of the PHY voltage valid and ID input signals.
> 
> It has been tested on stm32mp157c-dk2 [1], which has a Type-C connector
> managed by a Type-C port controller, and connected to USB OTG controller.
> 
> [1] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html
> 
> Amelie Delaunay (3):
>    dt-bindings: usb: dwc2: add optional usb-role-switch property
>    usb: dwc2: override PHY input signals with usb role switch support
>    usb: dwc2: don't use ID/Vbus detection if usb-role-switch on STM32MP15
>      SoCs
> ---
> Changes in v6:
> - Select USB_ROLE_SWITCH if USB_DWC2, and not only if USB_DWC2_DUAL_ROLE:
>    drd.c is built whatever DWC2 mode (DUAL, HOST, PERIPHERAL) as it is used also
>    to detect attach/detach (so a-valid/b-valid sessions).
> Changes in v5:
> - Use device_property_read_bool instead of of_read_property_bool in params.c
> Changes in v4:
> - Simplify call to dwc2_force_mode in drd.c
> - Add error_drd label in probe error path in platform.c
> Changes in v3:
> - Fix build issue reported by kernel test robot in drd.c
> Changes in v2:
> - Previous DT patch already in stm32-next branch so removed from v2 patchset
>    "ARM: dts: stm32: enable usb-role-switch on USB OTG on stm32mp15xx-dkx"
> - DWC2 DT bindings update added
> - Build issue reported by kernel test robot fixed
> - Martin's comments taken into account
> ---
>   .../devicetree/bindings/usb/dwc2.yaml         |   4 +
>   drivers/usb/dwc2/Kconfig                      |   1 +
>   drivers/usb/dwc2/Makefile                     |   2 +-
>   drivers/usb/dwc2/core.h                       |   9 +
>   drivers/usb/dwc2/drd.c                        | 180 ++++++++++++++++++
>   drivers/usb/dwc2/gadget.c                     |   2 +-
>   drivers/usb/dwc2/params.c                     |   2 +-
>   drivers/usb/dwc2/platform.c                   |  20 +-
>   8 files changed, 215 insertions(+), 5 deletions(-)
>   create mode 100644 drivers/usb/dwc2/drd.c
> 

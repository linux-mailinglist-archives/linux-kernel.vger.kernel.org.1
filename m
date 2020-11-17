Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13CEC2B5BD2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 10:32:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbgKQJbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 04:31:42 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23798 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725747AbgKQJbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 04:31:40 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AH9MkWl009037;
        Tue, 17 Nov 2020 10:31:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=QgTkKp6Apid8d0jq4IgVPNwjoMNl+sjg731lBhVRUXk=;
 b=hk3OHCq0UH8aBOJ+kEVkGzkw4wtq+49yBF/1aNFO3Le19QZ6Qf9QPAaC4zChB4uzSMsQ
 M+y/eAfh8RQq6Nqk6E8SNy5i/EfRVVewr6hTuc4hr1rEp3C34mNo0OUrZ6wVaPorGTSA
 8bjtfZhXvT3kh5Qa0SnKAQUELCYEmZPP6uAUVX2VD2L3elFKdQZmC4nx3X24w6kZ3Rj7
 G0NJNiRiJgpwG/yblI4m8yFDFHp7Z2sIRRGQ1ZryEqErq/ASSVGMKPe7lofSLGh62tRE
 F2rlg/PYwiLpwhV7Dvu4AuuluebW4SG4LraY6IWU54RUtI9o6mATXJYh+4LLnQ6jbovr lg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t58cgkq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Nov 2020 10:31:11 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id D0DD010002A;
        Tue, 17 Nov 2020 10:31:08 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A9E8A231F92;
        Tue, 17 Nov 2020 10:31:08 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 17 Nov
 2020 10:31:07 +0100
Subject: Re: [PATCH v5 0/5] STUSB1600 support on STM32MP15xx-DKx
To:     Amelie Delaunay <amelie.delaunay@st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Jun Li <lijun.kernel@gmail.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20201106165805.31534-1-amelie.delaunay@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <bfc72326-9de1-10dc-d40f-8b75a3b048dc@st.com>
Date:   Tue, 17 Nov 2020 10:30:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106165805.31534-1-amelie.delaunay@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-17_03:2020-11-13,2020-11-17 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 11/6/20 5:58 PM, Amelie Delaunay wrote:
> This series adds missing bindings for Type-C typec-power-opmode property
> and STUSB160x Type-C port controllers [1].
> STUSB160x driver requires to get power operation mode via device tree,
> that's why this series also adds the optional DT property
> typec-power-opmode for usb-c-connector to select the power operation mode
> capability.
> Tested on stm32mp157c-dk2 [2], which has a Type-C connector managed by
> STUSB1600, and connected to USB OTG controller.
> 
> [1] https://www.st.com/en/interfaces-and-transceivers/usb-type-c-and-power-delivery-controllers.html
> [2] https://www.st.com/en/evaluation-tools/stm32mp157c-dk2.html
> 
> 
> Amelie Delaunay (5):
>    dt-bindings: connector: add typec-power-opmode property to
>      usb-connector
>    dt-bindings: usb: Add DT bindings for STUSB160x Type-C controller
>    usb: typec: stusb160x: fix power-opmode property with
>      typec-power-opmode
>    ARM: dts: stm32: add STUSB1600 Type-C using I2C4 on stm32mp15xx-dkx
>    ARM: multi_v7_defconfig: enable STUSB160X Type-C port controller
>      support
> 

Device tree and bindings patches ([1],[2],[4],[5]) have been applied to 
stm32-next (and will go through arm-soc tree).

Greg, I let you apply patch [3] into usb tree.

Thanks
Alex



> ---
> Changes in v5:
> - add additionalProperties to st,stusb160x yaml
> - add Heikki reviewed-by on stusb160x driver patch 3/5
> Changes in v4:
> - power-opmode DT property renamed to typec-power-opmode and mutually
>    exclusive condition with new-source-frs-typec-current added
> - Due to DT property renaming, patch 3/5 is added to update stusb160x
>    driver.
> ---
>   .../bindings/connector/usb-connector.yaml     | 24 +++++
>   .../devicetree/bindings/usb/st,stusb160x.yaml | 87 +++++++++++++++++++
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  7 ++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 30 +++++++
>   arch/arm/configs/multi_v7_defconfig           |  2 +
>   drivers/usb/typec/stusb160x.c                 |  2 +-
>   6 files changed, 151 insertions(+), 1 deletion(-)
>   create mode 100644 Documentation/devicetree/bindings/usb/st,stusb160x.yaml
> 

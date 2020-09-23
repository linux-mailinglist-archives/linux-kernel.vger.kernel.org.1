Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DA0275C16
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgIWPjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 11:39:13 -0400
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:60015 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbgIWPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 11:39:13 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08NFQnIP031488;
        Wed, 23 Sep 2020 17:38:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=7HKGO3zCoMWYyI4iU86SgeX3rOp+UHEyIpuERuB++hA=;
 b=dED3XeJEjoJeKty4oJ6s8NhE4KSiyCWqeaBrR1zv8V4ZRqpD47qB83Q86MXO5hl12dyo
 kMp65B1FELamVIQjQ+cW7RUiuGKOc6LAtnQwLHEibW59z2834LI1fszFYMQYNQFMZv9j
 WLm966WRrAYl+8UJype/WdEyTk1o2QWWsihY+FSOIqgQKikmB5HE7VthrPwdolBcoMTA
 RG0tj0qSOZWpwJgANzBdMbacVWsbezMXuq9MTDw1gb/sk2FUxzkgzwgZJtCcYsiTn4yj
 el+4ANrSmIf/O0bsGiSfpeOBIRFIeqDGwVBx/8W3haJrodXRDmZTxBJCPp9QFdjnwBzA 9A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 33n7eyx2gt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Sep 2020 17:38:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42531100039;
        Wed, 23 Sep 2020 17:38:57 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 326CE2BE221;
        Wed, 23 Sep 2020 17:38:57 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.50) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 23 Sep
 2020 17:38:56 +0200
Subject: Re: [PATCH 0/2] add FMC2 EBI controller support
To:     Christophe Kerello <christophe.kerello@st.com>,
        <robh+dt@kernel.org>, <linux@armlinux.org.uk>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <1599225643-5558-1-git-send-email-christophe.kerello@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <f2aa40b2-6868-9f8d-ed9d-1283b230c367@st.com>
Date:   Wed, 23 Sep 2020 17:38:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1599225643-5558-1-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-23_10:2020-09-23,2020-09-23 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 9/4/20 3:20 PM, Christophe Kerello wrote:
> This patchset enables FMC2 EBI support on STM32MP1 SOCs.
> 
> Christophe Kerello (2):
>    ARM: multi_v7_defconfig: add FMC2 EBI controller support
>    ARM: dts: stm32: add FMC2 EBI support for stm32mp157c
> 
>   arch/arm/boot/dts/stm32mp151.dtsi     | 43 +++++++++++++++++++++++------------
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 16 +++++++------
>   arch/arm/configs/multi_v7_defconfig   |  1 +
>   3 files changed, 39 insertions(+), 21 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex

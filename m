Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 611351F94B9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jun 2020 12:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729539AbgFOKjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Jun 2020 06:39:48 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:37159 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728885AbgFOKjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:39:47 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FAWmbh003202;
        Mon, 15 Jun 2020 12:39:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=+F4jY1HeRhewZM8MzbOTtBBvHoX7iWPMn/pDhsYtkiM=;
 b=uBocQdrSSSMoeRwxrI5NC2KcwfBXV8R+joFckdr9h6lID30OI0WKQ58EuGTsUgLPN+Eb
 a4RZAyYxPgrZm0PEWmnJZsAwAUX6fRwGmgucsYVJvNuU4azLblG+PZjnSr5jCdtqLRAi
 UxTcsJPrSQEgn1kdgCqB/MYkhndfq7JMebfav5j5vMDNXndEj5YEjWb5PWB64kwPCbsT
 4f+ZAlBJ1ACsDu99IzspOmQOCALzMLQWycO1YQwuXHmak7pbg6sDnVOEkwpBHMowYf9C
 5A19as0A0DbrgT9BAJcCUGhrEll+vVMv8+Gnw+MQPj7f1b5wkgLDijIQuuX6/8YLU//+ Ag== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mmjvs5c4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 12:39:34 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4DBF210002A;
        Mon, 15 Jun 2020 12:39:34 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1D8BD20EAA2;
        Mon, 15 Jun 2020 12:39:34 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jun
 2020 12:39:33 +0200
Subject: Re: [PATCH 0/2] STM32 Fix uart nodes in stm32mp15-pinctrl
To:     Erwan Le Ray <erwan.leray@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200528074003.24875-1-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <b0c3a1f8-217c-968d-dfeb-484afd8eefd5@st.com>
Date:   Mon, 15 Jun 2020 12:39:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528074003.24875-1-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG8NODE3.st.com (10.75.127.24) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_02:2020-06-15,2020-06-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan

On 5/28/20 9:40 AM, Erwan Le Ray wrote:
> Fix uart nodes ordering and uart7_pins_a comments in stm32mp15-pinctrl.
> 
> Erwan Le Ray (2):
>    ARM: dts: stm32: fix uart nodes ordering in stm32mp15-pinctrl
>    ARM: dts: stm32: fix uart7_pins_a comments in stm32mp15-pinctrl
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 130 +++++++++++------------
>   1 file changed, 65 insertions(+), 65 deletions(-)
> 


Series applied on stm32-next.

Regards
Alex

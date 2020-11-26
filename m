Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F37632C5603
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390717AbgKZNlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:41:36 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:45490 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390709AbgKZNle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:41:34 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AQDauWQ014866;
        Thu, 26 Nov 2020 14:41:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=C3D7d5sJHZxc5cS/imefA7F5mnEiTGKp+VWMyJUmNnk=;
 b=KyH5jBzr9r45M7XDUOrjEOEadr2Y8CZP1jr1dDJ1W+qlebq4Ihv+65mqGRYQJQ4GR1SH
 qLfILS0xoNNDFTdWYHwAAlrXXiMUNDyb9sX2f5n9l/D35qVOs1v5EIuTSSiWWYTLsu/g
 sAKD80azRFqAWBe79YsHFOanR4AM/kW7zjBxxnoO0/7xA5DnW18iOTp0LdQZhj1SJUdf
 9s//DvNUcI6B0pkv+dSg6i4fTqFozgsyvo8XItlWqf2Om2kWhHq4a5GrweVXorsWt2wg
 geLPaHGzuO/Crwik+BNsW9O2Qwpht7TgFTlJ7ZhlL515OBM0B+tNKlsvdcZiMaoi59jl 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0fh7uym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 14:41:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B07F410002A;
        Thu, 26 Nov 2020 14:41:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7ADEF205D11;
        Thu, 26 Nov 2020 14:41:16 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 14:41:15 +0100
Subject: Re: [PATCH v2 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx
 support
To:     Olivier MOYSAN <olivier.moysan@st.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "olof@lixom.net" <olof@lixom.net>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        Amelie DELAUNAY <amelie.delaunay@st.com>,
        "aisheng.dong@nxp.com" <aisheng.dong@nxp.com>,
        "prabhakar.mahadev-lad.rj@bp.renesas.com" 
        <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "christian.gmeiner@gmail.com" <christian.gmeiner@gmail.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        Lionel DEBIEVE <lionel.debieve@st.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201120091506.18326-1-olivier.moysan@st.com>
 <c80be2f8-8568-1dae-df31-1134ccea759a@st.com>
 <5bec2267-5ce6-87c3-38bd-a00f5b124a7a@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <632d4421-bf30-6311-f6d1-dbdb5937875d@st.com>
Date:   Thu, 26 Nov 2020 14:40:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <5bec2267-5ce6-87c3-38bd-a00f5b124a7a@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_04:2020-11-26,2020-11-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/26/20 2:38 PM, Olivier MOYSAN wrote:
> Hi Alex
> 
> On 11/26/20 12:25 PM, Alexandre Torgue wrote:
>> Hi Olivier
>>
>> On 11/20/20 10:15 AM, Olivier Moysan wrote:
>>> Add STM32 SPDIFRX and DFSDM audio support to multi_v7_defconfig
>>>
>>> Change in v2:
>>> - Add targeted SoC in commit message for DFSDM config
>>>
>>> Olivier Moysan (2):
>>>     ARM: multi_v7_defconfig: enable spdifrx support
>>>     ARM: multi_v7_defconfig: enable dfsdm audio support
>>>
>>>    arch/arm/configs/multi_v7_defconfig | 2 ++
>>>    1 file changed, 2 insertions(+)
>>>
>>
>> Targeted platform (STM32) should be added in the commit title for both
>> patches as you enable STM32 dfsdm and STM32 spdifrx support. No ?
>>
>> If you agree, I'll add it during merge. No need to send a v3.
>>
>> Regards
>> Alex
> 
> It's okay for me.
> 

Thanks. Series applied on stm32-next.

Regards
Alex

> BRs
> Olivier
> 

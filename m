Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0A12C52EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 12:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgKZL1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 06:27:16 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:14136 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729812AbgKZL1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:27:16 -0500
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AQBMENa028889;
        Thu, 26 Nov 2020 12:26:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : references
 : from : message-id : date : mime-version : in-reply-to : content-type :
 content-transfer-encoding; s=STMicroelectronics;
 bh=YYUIwm6ViAWSAw4FFy/gkPe4NS7CBVjvIeEuWkOA6ZQ=;
 b=Bf7HqjoLXz6mJxSJTQnhyqfuVXk0zieUoVjIpSpxmwOLBH2SNbfexDiEC2dpR1lXW/bM
 JoFYNU+3FkkNlc58lLi9pfG87SuiZp0xfnkTIhHkBL3gzaHnM+w+WlBhoY4UCgxzWAxZ
 zy6fkAifO+HKoVL4t0nOHZMawvhFBHflS33gI5Y79JpRhbYTNZ2AYVGscFIm4LzXftYj
 575vrXvHTPv5dfNgOTdVGwj2y0u3MKWb/I0cwMpx49rROp7N9I5twV5OLKTt3GMSxaX6
 DXPsyVNH+EuW4rTA1Rf/LSmmEyoN8hxsQNOLBFScxJoT19Oo+RN8eDCxjqIkDqX7GRPK Mw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y01cvfb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Nov 2020 12:26:29 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 58179100034;
        Thu, 26 Nov 2020 12:26:26 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3A4EE23C1AD;
        Thu, 26 Nov 2020 12:26:26 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 26 Nov
 2020 12:26:24 +0100
Subject: Re: [PATCH v2 0/2] ARM: multi_v7_defconfig: enable dfsdm and spdifrx
 support
To:     Olivier Moysan <olivier.moysan@st.com>, <linux@armlinux.org.uk>,
        <shawnguo@kernel.org>, <olof@lixom.net>, <krzk@kernel.org>,
        <geert+renesas@glider.be>, <amelie.delaunay@st.com>,
        <aisheng.dong@nxp.com>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <christian.gmeiner@gmail.com>, <enric.balletbo@collabora.com>,
        <lionel.debieve@st.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20201120091506.18326-1-olivier.moysan@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <c80be2f8-8568-1dae-df31-1134ccea759a@st.com>
Date:   Thu, 26 Nov 2020 12:25:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201120091506.18326-1-olivier.moysan@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-26_03:2020-11-26,2020-11-26 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 11/20/20 10:15 AM, Olivier Moysan wrote:
> Add STM32 SPDIFRX and DFSDM audio support to multi_v7_defconfig
> 
> Change in v2:
> - Add targeted SoC in commit message for DFSDM config
> 
> Olivier Moysan (2):
>    ARM: multi_v7_defconfig: enable spdifrx support
>    ARM: multi_v7_defconfig: enable dfsdm audio support
> 
>   arch/arm/configs/multi_v7_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 

Targeted platform (STM32) should be added in the commit title for both 
patches as you enable STM32 dfsdm and STM32 spdifrx support. No ?

If you agree, I'll add it during merge. No need to send a v3.

Regards
Alex

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542691BD7EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 11:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726575AbgD2JHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 05:07:43 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:59690 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgD2JHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:07:43 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03T8wSHn005185;
        Wed, 29 Apr 2020 11:07:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=e9NwN/IhCOM3jYLOzfdAEssprCoON8TaVJUaQG+tcnY=;
 b=J+GPW50HYzS2dnXExZqnZ0XHPX4HJhPak2/+H/VoXthCvYrz3BF1nP/uko5izwrQMNrv
 wzs46w4f3d+w94AXcFAmi/Sn0y2zTTLH7HbtwL3gYNS285nPHK/AKxJHNb/NVW3lhXhR
 T2kTZS6oyyPzvOu8DFUZQUhnFsEtEcoyvnDoMDHoOsOmxbjE2gV6PXTvpWMdJA+kAxjP
 hBOCr4gJ9hAiFo5EXXhQnWFVTWLITdlztngvL8b9CnozBWDP18OBf3Rre6DMTfrx/zQv
 KsnOasx7zbGbEwn+21S0q6vY6vbOKZEhyJqVQ9HDfeCaZUpNu0HeQwE4apqCgH3oyzwT 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30n4j61dnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 29 Apr 2020 11:07:13 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3325C10002A;
        Wed, 29 Apr 2020 11:07:09 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1819920749E;
        Wed, 29 Apr 2020 11:07:09 +0200 (CEST)
Received: from [10.211.9.35] (10.75.127.44) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 29 Apr
 2020 11:07:07 +0200
Subject: Re: [PATCH v2 04/12] mtd: rawnand: stm32_fmc2: manage all errors
 cases at probe time
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <tony@atomide.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <1586966256-29548-1-git-send-email-christophe.kerello@st.com>
 <1586966256-29548-5-git-send-email-christophe.kerello@st.com>
 <20200427194747.224a2402@xps13>
 <40a9bac7-9ed4-b781-f2c2-2d90b4e82749@denx.de>
 <20200427200848.722f4c56@xps13>
 <3527f3b8-225d-6e5a-dd8a-0421d475f70b@denx.de>
 <20200427220806.13741ec0@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <75a430de-54af-c4db-9d93-6b3d5e65874c@st.com>
Date:   Wed, 29 Apr 2020 11:07:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200427220806.13741ec0@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-29_03:2020-04-28,2020-04-29 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquèl,

On 4/27/20 10:08 PM, Miquel Raynal wrote:
[...]
>>>> btw would it make sense to split the first three patches of this series
>>>> into a separate series ? This rawnand part seems more like an unrelated
>>>> cleanup.
>>> As it seems that the MFD discussion can take longer, then I would say
>>> yes, at least for the cleanup/misc changes part.
>> Right
>>

I think that it is better to only have one set of patches as there is 
different maintainers that will review the whole set of patches.
I expect to be able to propose a v3 next week to add the EBI driver and 
the updates on NAND driver (as some patches are linked)
A proposal could be to put all the NAND patches that you have started to 
review at the beginning of the set of patches (patch 4/5/6/7/8).
You will be free to apply them after the review and I will only resubmit 
the patches that have not been applied in the next version.

Regards,
Christophe Kerello.

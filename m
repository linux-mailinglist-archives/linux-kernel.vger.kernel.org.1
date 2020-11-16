Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0E1D2B3E40
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgKPIDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 03:03:21 -0500
Received: from mx07-00178001.pphosted.com ([185.132.182.106]:58009 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727132AbgKPIDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 03:03:20 -0500
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AG7vGmE008820;
        Mon, 16 Nov 2020 09:03:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=15L4NF4LrzMNBlJydk+RLjlHfpFcgIJ1T7hYPjOtdB0=;
 b=uhmJkTYquLQ7inyGjOM+A9gv0C9X54l1e483VYjVV0tBkCMF3BpuJRMZCIYCdPYbKEfL
 /rGCoUqKV/XQso7aB1IM4IzvDBQOzfTH6EpQHRm55UCXwAcSw87I+bpd7f86+Ho3dXJ8
 DPxObVRCFUI5IlBu2H5s4OfK1NYou+DoHJwNbobvmGAZXgXERIa8050wqvFJ0++fHb2k
 o4j6gT00+lGTGZT3oJHZ+vNJ+XkGlfk4KYPL+zZGb81q1/LxqbBKr5ObqDjN/q8rQC0T
 oMJYDn7ZOdS6g7BLDk8RPMqWlRPqPt0SQaSpYbdIMAI1unquI/yKxrqbXe7jaIygaviw MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34t5k4sb7a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Nov 2020 09:03:00 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1D332100038;
        Mon, 16 Nov 2020 09:02:57 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0CA3922E841;
        Mon, 16 Nov 2020 09:02:57 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.51) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 16 Nov
 2020 09:02:55 +0100
Subject: Re: [PATCH 1/2] phy: stm32: don't print an error on probe deferral
To:     Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Etienne Carriere <etienne.carriere@st.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20201110102305.27205-1-amelie.delaunay@st.com>
 <20201116073756.GL7499@vkoul-mobl>
From:   Amelie DELAUNAY <amelie.delaunay@st.com>
Message-ID: <1b91bea5-ffbf-37fb-98ac-6abc5f373375@st.com>
Date:   Mon, 16 Nov 2020 09:02:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201116073756.GL7499@vkoul-mobl>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-16_02:2020-11-13,2020-11-16 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11/16/20 8:37 AM, Vinod Koul wrote:
> On 10-11-20, 11:23, Amelie Delaunay wrote:
>> Change stm32-usbphyc driver to not print an error message when the device
>> probe operation is deferred.
> 
> Applied all, thanks
> 

I'm sorry for the mess, I sent a v2 for the patch 1/2: 
https://lore.kernel.org/patchwork/patch/1336206/
Indeed, I forgot the "return" before dev_err_probe.

Do you want me to send a fix?

Regards,
Amelie

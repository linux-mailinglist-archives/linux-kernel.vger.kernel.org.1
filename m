Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE2E2C6727
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730585AbgK0Nqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:46:53 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:5764 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729402AbgK0Nqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:46:53 -0500
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ARCSE1w021982;
        Fri, 27 Nov 2020 14:46:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=FtHst8KJqUhtN1ezELC4mvYFe4JDkzMGdOLWhYhD3DM=;
 b=EYiAjnTIbQmSTC+3lv1SNN/SMlbOtToz/2C8Cd2jA+fhmHzvWyn8W77eEYCCv/RWHJua
 Eqv4YGHWzTjd8ED54ZfWfPChp4MX7Uh6FbC5tt40HUFXhqQ6DUvZ9cDuOmflpLhAemsD
 aLmPtl4NbIUuYrppOaAmcar7l9YPHHbtUVblN1xOOT1rAOsG9p6bj8RbH5gJhdUce2B8
 jqUwJEdlT5oEG1SqOKGR/lKXzSI/G3q4FdvtWj3u8xzPUMAa0Pipw5MVf6FVfC4F5vRG
 6uIVlOIleQWFbBofvN/5C2Qt0G2M2u4dmviCMiUEyQNWC2Mso4+Lt3NyOAo6ZZx4sbGl QQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 34y0hjwyr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Nov 2020 14:46:46 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6F87410002A;
        Fri, 27 Nov 2020 14:46:45 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node3.st.com [10.75.127.6])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58B2724CBA6;
        Fri, 27 Nov 2020 14:46:45 +0100 (CET)
Received: from lmecxl0995.lme.st.com (10.75.127.47) by SFHDAG2NODE3.st.com
 (10.75.127.6) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 27 Nov
 2020 14:46:44 +0100
Subject: Re: [Linux-stm32] [PATCH v5 1/1 RESEND] usb: typec: stusb160x: fix
 power-opmode property with typec-power-opmode
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
CC:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-usb@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>,
        <linux-kernel@vger.kernel.org>
References: <20201127131735.28280-1-amelie.delaunay@st.com>
 <X8EC6BL98dm+u+8C@kroah.com>
From:   Amelie DELAUNAY <amelie.delaunay@foss.st.com>
Message-ID: <cb19b270-4917-4783-5e16-41961d4954a4@foss.st.com>
Date:   Fri, 27 Nov 2020 14:46:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <X8EC6BL98dm+u+8C@kroah.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG2NODE3.st.com
 (10.75.127.6)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_06:2020-11-26,2020-11-27 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/27/20 2:45 PM, Greg Kroah-Hartman wrote:
> On Fri, Nov 27, 2020 at 02:17:35PM +0100, Amelie Delaunay wrote:
>> Device tree property is named typec-power-opmode, not power-opmode.
>>
>> Fixes: da0cb6310094 ("usb: typec: add support for STUSB160x Type-C controller family")
>> Signed-off-by: Amelie Delaunay <amelie.delaunay@st.com>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
>> ---
>>   drivers/usb/typec/stusb160x.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Now applied, sorry for missing it before.

Thanks!

Amelie

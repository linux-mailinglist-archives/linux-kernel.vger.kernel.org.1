Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDE523C227
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 01:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgHDXVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 19:21:20 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38252 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725904AbgHDXVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 19:21:20 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074NIbZb030203;
        Tue, 4 Aug 2020 23:21:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=H135zvtEAzXbolPThwPCDvRBY1IcuIZhqA58376mAzA=;
 b=ClodJWCgLTzJCxFrMksszeahSOEnwsEagGVl1HRDKEeX5WG5jN/Bn2oqc0Tli+ZQa8WJ
 2ZaWvBjrI8nBRsr1qEz+T1d7TOYMqr8lmZtt6hiVMdJuJ8pJ3dVQjR6QLJPN+gcNgR2K
 ftDgskoEyu5sDliPNxRdBj1FQ2zcT12FbL89Lq013yAFAWeZtNykqTODaDzCmANvEt1i
 aTSVafUcpu3fJ5HHb6hNAKPEYTWWBXAR9q0SAcwA0DbIBEgiOouTeemRCiOjj21x2ReH
 qO984uIEHXZ7pZ1ubJTc5juL+QBhCSkDgJKy+D3YxWDxuECCxpMBTVjlyRSQwlf6d7bH Dg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 32nc9ynpya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 04 Aug 2020 23:21:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 074NJ8lZ118157;
        Tue, 4 Aug 2020 23:21:08 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 32p5gswv73-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 04 Aug 2020 23:21:08 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 074NL784005815;
        Tue, 4 Aug 2020 23:21:07 GMT
Received: from [10.74.104.59] (/10.74.104.59)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 04 Aug 2020 16:21:07 -0700
Subject: Re: [PATCH] soc: ti: k3-socinfo: Add entry for J7200
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, ssantosh@kernel.org,
        t-kristo@ti.com
Cc:     nsekhar@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nm@ti.com
References: <20200803105359.16744-1-peter.ujfalusi@ti.com>
 <f13b8e17-308f-fdf2-885e-318710d4d836@ti.com>
 <a3ea4e4f-1c7e-b7b1-798e-4fda0ce73cba@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <e4fc0d2c-6440-378c-0184-f42777594c9c@oracle.com>
Date:   Tue, 4 Aug 2020 16:21:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <a3ea4e4f-1c7e-b7b1-798e-4fda0ce73cba@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9703 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 mlxscore=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008040160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/4/20 2:39 PM, Grygorii Strashko wrote:
> Hi Santosh,
> 
> On 03/08/2020 17:41, Lokesh Vutla wrote:
>>
>>
>> On 03/08/20 4:23 pm, Peter Ujfalusi wrote:
>>> Update K3 chipinfo driver to support new TI J7200 SoC.
>>> It's JTAG PARTNO is 0xBB6D.
>>>
>>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>>
>> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>
>>
> 
> Reviewed-by: Grygorii Strashko <grygorii.strashko@ti.com>
> 
Thanks for reviews. Will add it to the queue.

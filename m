Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D98F2677EB
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 06:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgILEz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 00:55:26 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60360 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgILEzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 00:55:21 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08C4oR5A164101;
        Sat, 12 Sep 2020 04:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=4f0RuRAZDDbsi3oHblLgwZFUQJR8UkvWGpu2o8MVEH0=;
 b=zvzWbMXn+TbMCyOQ7GM5nGfwf4otjyxDWcep5rY+d7MSd+yMNO+TugRKvbZcBpUiMX9w
 dBeVtzdA7dxPF64V18CLeax6mir76asA3OYNJTxr8Hd7JI/kz0ACx5sE6kWXsNhBfX7l
 u62r6qMOUqX/3SQVtxtcXP8G1m4XiCvXrT3w3ggeimykdv1iP7109O5JQo/PV/+g3VCi
 chaQgeg/ybXnZNPiHOWwFS2wpcXjN2tWG5J/XTNoXmT3GAPQ80P+4mf8EthPnwrZL3sx
 RlLnpIX4IIm+7+ko3SFeG8ED6V0R4kg374hWXIutV0DdVPngKcL8SKMCHcaVT3Pg2eTO 9w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 33gpym8254-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Sep 2020 04:55:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08C4nkw7134852;
        Sat, 12 Sep 2020 04:55:10 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 33gmc8e0ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 04:55:10 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08C4t9DC009193;
        Sat, 12 Sep 2020 04:55:09 GMT
Received: from dhcp-10-159-138-230.vpn.oracle.com (/10.159.138.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 21:55:09 -0700
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To:     Suman Anna <s-anna@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
 <1661043e-15a3-b8de-b16c-ef6ff88f18e5@ti.com>
 <39eeac89-b87b-e3ef-e061-20021e9bb0b9@oracle.com>
Organization: Oracle Corporation
Message-ID: <a4bca7aa-b0b6-e033-6453-415600c638a7@oracle.com>
Date:   Fri, 11 Sep 2020 21:55:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <39eeac89-b87b-e3ef-e061-20021e9bb0b9@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=3 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 mlxscore=0 impostorscore=0
 bulkscore=0 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999
 suspectscore=3 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/8/20 7:40 PM, santosh.shilimkar@oracle.com wrote:
> 
> 
> On 9/8/20 3:09 PM, Suman Anna wrote:
>> Hi Santosh,
>>
>> On 8/31/20 1:34 PM, santosh.shilimkar@oracle.com wrote:
>>> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
>>>> Hi Santosh,
>>>>
>>>> I've rebased on top of  linux-next and identified merge conflict of 
>>>> patch 3
>>>> with commit 6da45875fa17 ("arm64: dts: k3-am65: Update the RM 
>>>> resource types")
>>>> in -next.
>>>>
>>>> ---
>>>> This series adds support for the TI AM65x SR2.0 SoC Ringacc which 
>>>> has fixed
>>>> errata i2023 "RINGACC, UDMA: RINGACC and UDMA Ring State 
>>>> Interoperability
>>>> Issue after Channel Teardown". This errata also fixed for J271E SoC.
>>>> The SOC bus chipinfo data is used to identify the SoC and configure
>>>> i2023 errata W/A.
>>>>
>>>> This changes made "ti,dma-ring-reset-quirk" DT property obsolete, so 
>>>> it's
>>>> removed.
>>>>
>>>> Changes in v2:
>>>>    - no functional changes
>>>>    - rebased on top of linux-next
>>>>    - added ask from Rob Herring
>>>>
>>> Thanks. Can you please followup DT acks for PRUSS series so that I can
>>> apply PRUSS + $subject series.
>>
>> PRUSS dt binding is acked now, so can you pick up the PRUSS v2 series 
>> for 5.10
>> merge window.
>>
> Yes, I saw ack from Rob. Will try to get to this over coming weekend.
> 
Applied. Should show up in linux-next

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 202092677EC
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 06:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725845AbgILE4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 00:56:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54798 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgILE4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 00:56:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08C4oLw6132880;
        Sat, 12 Sep 2020 04:56:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=sU8yInr32sKZhUYmAxIrqe2arDVd5tCpKd4tRyj29bM=;
 b=YtwsN/Z61Wc9AEuumj5nxbElDHAGrRcqIwrkNci+fagvPjn3URegfHTW0dIAnHw165Xh
 QKB9C/0gQGkpVeJWVeFLjGvOnYKaxKkPU1XbRMkeROVQmkVwS15DiXKpj7sXojrEMSPr
 iAR0OPMvBZ1NWHGAuEsjO6G1Q6AZVxj0rDRbTAmci1vD1MA04UDsZvHNS8JWH8T7d4Dj
 ekHYkP9xNyWUlIYQY4NIW30C+uWXGDbh+gfoWLbDVKkimt3sSumZCAoyNjtz2z2Hx+8x
 IwWIX8b7dyMgMXHnHSZ/nqDVHb7KC5smO8LYfsLnngFWSFTzfAOSPuA28kRvOG0hD59W bA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33gnrqg55w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 12 Sep 2020 04:56:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08C4oW1q127088;
        Sat, 12 Sep 2020 04:54:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 33gkeqt4ve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 12 Sep 2020 04:54:30 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08C4sTKK025406;
        Sat, 12 Sep 2020 04:54:29 GMT
Received: from dhcp-10-159-138-230.vpn.oracle.com (/10.159.138.230)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 11 Sep 2020 21:54:28 -0700
Subject: Re: [PATCH next v2 0/3] soc: ti: k3: ringacc: add am65x sr2.0 support
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sekhar Nori <nsekhar@ti.com>
References: <20200829184139.15547-1-grygorii.strashko@ti.com>
 <b9310d10-46c5-2c63-a921-88be23363d44@oracle.com>
 <20200902140834.5fficxrxy6t572um@kahuna>
 <0b24a619-060a-1abb-76d9-218b5db18f11@oracle.com>
Organization: Oracle Corporation
Message-ID: <4db58974-691d-aae6-adc5-09f0611b7251@oracle.com>
Date:   Fri, 11 Sep 2020 21:54:07 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <0b24a619-060a-1abb-76d9-218b5db18f11@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120047
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9741 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=3
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009120047
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/9/20 9:52 AM, santosh.shilimkar@oracle.com wrote:
> On 9/2/20 7:08 AM, Nishanth Menon wrote:
>> On 11:34-20200831, santosh.shilimkar@oracle.com wrote:
>>> On 8/29/20 11:41 AM, Grygorii Strashko wrote:
[..]
>>
>>
>> Santosh, in this series, may i suggest that the dtsi changes[1] be hosted
>> on my tree? else we are going to create a mix of rc1 and rc3 branches
>> which is going to be irritating, to say the least.
>>
>> I will pick [1] the day after I see the patches 1 and 2 in linux-next 
>> tag.
>>
> Sure !!

Applied. Should show up in linux-next

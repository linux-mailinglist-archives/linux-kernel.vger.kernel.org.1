Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7732A239E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 04:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgKBDox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 22:44:53 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:47998 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgKBDow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 22:44:52 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A23ZkiY025956;
        Mon, 2 Nov 2020 03:44:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=kKyJkgynxn24CC0jYpNbijVTfwLzyOkpA84cYglx5s8=;
 b=dfV+1Kq5CxhIhQPxCK00qh3qheuE/OVSQ/jIaFhBDImIBLwZTZ6BmL5vKe2Nt1fPFHUB
 WcDqw7aWmM03LJxM4X/J9z3kTIb1A6XgkQwbqGN+8w3t3ck54XPi7dVJ9u+F/q62jY5x
 O6TmEPu/o6mEcWEq1P+4pn0yUXoj7yc5UzryE7rOtS4MTk3WYpN9A5iA6DsaUFquHnTR
 uhEMWqwrug/IGIHIqrPer4EYoI5QNIL7FmYNgFEex4R1VFefYeSZ1o+4GIrrAyCk+4G/
 Xyg4lMMyfLkSQ5rbRnR9ltiST7Xh52v/NwLr9rrEqdwuJX3e9EM6a1OpDK+szHU27rzn jA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 34hhvc1v7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 02 Nov 2020 03:44:38 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A23eg7w142691;
        Mon, 2 Nov 2020 03:44:37 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 34hvrmpasn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 02 Nov 2020 03:44:37 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A23iZTE004895;
        Mon, 2 Nov 2020 03:44:36 GMT
Received: from dhcp-10-159-134-92.vpn.oracle.com (/10.159.134.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 01 Nov 2020 19:44:35 -0800
Subject: Re: [PATCH v2 00/11] firmware/soc: ti_sci, ringacc/inta: Preparation
 for AM64 DMA support
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, ssantosh@kernel.org,
        lokeshvutla@ti.com
Cc:     nm@ti.com, t-kristo@ti.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, grygorii.strashko@ti.com
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
 <c113a16a-b611-bca2-2a62-3199b71acd7f@oracle.com>
Organization: Oracle Corporation
Message-ID: <b7f3a344-e494-854d-69ec-27d1131ce71f@oracle.com>
Date:   Sun, 1 Nov 2020 19:44:29 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <c113a16a-b611-bca2-2a62-3199b71acd7f@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 suspectscore=4 spamscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9792 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=4
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011020028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On 10/8/20 5:56 PM, santosh.shilimkar@oracle.com wrote:
> On 10/8/20 4:52 AM, Peter Ujfalusi wrote:
>> Santosh: if you plan to take this series for 5.11, then can you create an
>> immutable branch which I can refer to Vinod for the DMA patches I'm 
>> going to
>> send soon.
> 
> I will set it up right after the 5.10-rc1 is tagged.
> 
Series is pushed to soc branch.

git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git 
for_5.11/drivers-soc
Regards,
Santosh

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF59287FAA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 02:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730433AbgJIA5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 20:57:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:40068 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgJIA5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 20:57:07 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0990trQi084812;
        Fri, 9 Oct 2020 00:57:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=p1b6qscBsAX/SJBM6qJQM/Rus2NTue25enXOeIVMRsI=;
 b=FejCyN0E53yM+M1qtXmJnu7cdeazKM+eaH58A5ZpbTpDdEIZSBYcngradT8E3s0Ckn0g
 9HqaXGNFA9QFkkro77qia4MLHWP4BKondg7FxPnNST5Rz613jCorkA50YpGID60qs3LZ
 MdlpynxYfprCDt9ZeI16ykmqGq3jUBQBps+bX2xCnvNi1OfPFnT5UQ1BWVc6dxEb+im9
 7a81Nd6qNBJlQHNjiWaS7q8o4VATGgWkuNrnHqhuqV7iYaKAn02+go/7vK/cWGVf3FtH
 1VMl4datEdD38guE190cXUJiHNOZxZj1uDOTHVIvVTRDbKYM4XQWhvWDc4dqP7jjFgWa hw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 3429jygyne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 09 Oct 2020 00:57:02 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0990pO6g141774;
        Fri, 9 Oct 2020 00:55:02 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3429kk6mj1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 09 Oct 2020 00:55:02 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0990t193006474;
        Fri, 9 Oct 2020 00:55:01 GMT
Received: from [10.74.105.196] (/10.74.105.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 08 Oct 2020 17:55:01 -0700
Subject: Re: [PATCH v2 00/11] firmware/soc: ti_sci, ringacc/inta: Preparation
 for AM64 DMA support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, nm@ti.com, t-kristo@ti.com,
        ssantosh@kernel.org, lokeshvutla@ti.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        grygorii.strashko@ti.com
References: <20201008115224.1591-1-peter.ujfalusi@ti.com>
From:   santosh.shilimkar@oracle.com
Organization: Oracle Corporation
Message-ID: <6f88b897-c575-0744-a4f7-7b75b7ee2fea@oracle.com>
Date:   Thu, 8 Oct 2020 17:54:59 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20201008115224.1591-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9768 signatures=668681
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 priorityscore=1501
 phishscore=0 suspectscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090007
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/8/20 4:52 AM, Peter Ujfalusi wrote:
> Santosh: if you plan to take this series for 5.11, then can you create an
> immutable branch which I can refer to Vinod for the DMA patches I'm going to
> send soon.

I will set it up right after the 5.10-rc1 is tagged.

regards,
Santosh


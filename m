Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 857ED271960
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 04:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbgIUCiB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 22:38:01 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36588 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgIUCiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 22:38:01 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2ZhRT008276;
        Mon, 21 Sep 2020 02:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=iNEQvWYqSjtoZGC6fGoYKZehKNUyQw+A4D+j6+OcPMI=;
 b=VSX2yLn44TGwnQWnfWokdzmmP+pDefa2W7TEI/fVicrtQm7wAJffk6OGB8Derq25NX4T
 0T+sJy7N+Jfdil0SezKHGYolKnCcntUWU27Vv1WEqFKE/vaHwfcVfDO8CHrtB9H2bCgT
 m3x+MEq2IN69F+X4dqN9drFisPT4yPij43EH7/2O2FqpxjkwoXuDaPCwoFIiX7qJDBAW
 syq0g5m/AiR5tJHEz2SrL/AsRUEESjVFddIy6BP4ZAE/DSIIaV3wS6pxT2lrr8mwFn6v
 YsYJSj7UUyUARmflXxK9r2GzAI90xBFVAZ0HV4BFheMAUXkA+LDVpfVpK1UQviq+WrdR 3A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33n9xkk58s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 02:37:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08L2ZifL185586;
        Mon, 21 Sep 2020 02:37:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33nuvyf8fw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 02:37:40 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08L2beXx031263;
        Mon, 21 Sep 2020 02:37:40 GMT
Received: from santoshs-mbp-3.lan (/69.181.241.203)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 20 Sep 2020 19:37:40 -0700
Subject: Re: [PATCH -next v2] soc: ti: Convert to DEFINE_SHOW_ATTRIBUTE
To:     Qinglang Miao <miaoqinglang@huawei.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20200919025207.17798-1-miaoqinglang@huawei.com>
From:   "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>
Organization: Oracle Corporation
Message-ID: <32fde6aa-058f-6031-8488-65d90585b6e8@oracle.com>
Date:   Sun, 20 Sep 2020 19:37:32 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200919025207.17798-1-miaoqinglang@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210017
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9750 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1011
 mlxlogscore=999 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210017
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/20 7:52 PM, Qinglang Miao wrote:
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
> ---
> v2: based on linux-next(20200917), and can be applied to
>      mainline cleanly now.
> 
Applied. Thanks !!

Regards,
Santosh

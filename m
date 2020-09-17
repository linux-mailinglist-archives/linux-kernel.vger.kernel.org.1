Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB38526E67D
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgIQUTR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:19:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39428 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726475AbgIQUTQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:19:16 -0400
X-Greylist: delayed 12557 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 16:19:15 EDT
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGXhhA148832;
        Thu, 17 Sep 2020 16:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=jPn0/XY5IOGo+IYmlhGxIPpCwCN5Gs5hW39ZfBTuBys=;
 b=C+zGRgmOu7PauWqc7CzicotswSxxZ8ohmezMsNMMUogRMNhPpnE+baRIB/r5KxAPS8iY
 yVPGv8zXWaJALXvDhoQ3RlXpOCj/AG4YBhYoPOlWNWBR6Te/xwv6/FSGJ8lrmW78sRV1
 l+xpuVyzXH4zPkNP3brwg841EpBQ7wftxdvX3hlpRAw6VFZKpK3apeLRmlBgv7nOBH6/
 cElCL8H0o8ZZFbbrmj8/XmJyO/nFjq3zM9dCCSqqDDRIypm2Yl0IU1nCrZGyP53EpxIi
 iRFV8Cu06oA+oM6/A0yTfYpb9Ot7aQTYrv92vxVBHUDXhhuNXa/nHskTEhAa07DzVOgz 0g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33gnrraj5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 16:49:45 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08HGZZRD061681;
        Thu, 17 Sep 2020 16:47:44 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33h88bven0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Sep 2020 16:47:44 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08HGlgsv014673;
        Thu, 17 Sep 2020 16:47:43 GMT
Received: from [10.39.232.73] (/10.39.232.73)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Sep 2020 16:47:42 +0000
Subject: Re: [PATCH V2] dma-direct: Fix potential NULL pointer dereference
To:     Christoph Hellwig <hch@lst.de>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1600289466-23805-1-git-send-email-thomas.tai@oracle.com>
 <20200917164420.GA5959@lst.de>
From:   Thomas Tai <thomas.tai@oracle.com>
Message-ID: <ec490dc9-f284-c1ed-9657-aa23276ee0cc@oracle.com>
Date:   Thu, 17 Sep 2020 12:47:40 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200917164420.GA5959@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009170126
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9747 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 bulkscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170126
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-17 12:44 p.m., Christoph Hellwig wrote:
> Thanks,
> 
> applied to the dma-mapping for-next tree.

Thank you, Christoph for suggesting and applying the fix.

Thomas

> 

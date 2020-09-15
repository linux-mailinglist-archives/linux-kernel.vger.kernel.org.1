Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E72D26B799
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 02:26:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgIPA0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 20:26:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58550 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgIOOMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 10:12:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FE8qmv187090;
        Tue, 15 Sep 2020 14:11:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=o5BZWz9vRhtIAktJp49EpkK+zy4zUK2pibMnUrf2Mns=;
 b=nOBe57CBEUTcNmIJtHHfCILHlFVj6V5Awsxahsz2IqjX/KL1CCtydwCulpy44bF5sZVf
 iBjtvH6EscDmGwBIFET+hPOhiObANn6A6bNzW/OEjCi+2BELj12CYIYUdeAgSuOYn2+U
 SvYM7sL0BUImRYsYdHenTX3e4l6F5/hSxdmLNCubumHmUrsCGpi+lVYEtUBn4rpQk4pc
 SSAp63frc4Cti75NVsDen+h8VLUCBLf2sUNM//dhqI+C31ICll662XCByQv4tBuMeQb0
 JSNJUN2HKp6tCPq+Acs75ZmaXjOS0mvu24j3GAH7fVSXsvGZ/t7FvbT28ys3w76xAxXs Qg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33gp9m592s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Sep 2020 14:11:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08FE9qdF054985;
        Tue, 15 Sep 2020 14:11:54 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 33hm30k4sx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Sep 2020 14:11:54 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08FEBpVa026881;
        Tue, 15 Sep 2020 14:11:51 GMT
Received: from [10.39.253.102] (/10.39.253.102)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 15 Sep 2020 14:11:50 +0000
Subject: Re: [PATCH] dma-direct: Fix potential NULL pointer dereference
To:     Christoph Hellwig <hch@lst.de>
Cc:     konrad.wilk@oracle.com, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <1600178594-22801-1-git-send-email-thomas.tai@oracle.com>
 <20200915140719.GA14831@lst.de>
From:   Thomas Tai <thomas.tai@oracle.com>
Message-ID: <f5cba632-421a-f375-3697-51a182a53a32@oracle.com>
Date:   Tue, 15 Sep 2020 10:11:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200915140719.GA14831@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150118
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9744 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009150118
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020-09-15 10:07 a.m., Christoph Hellwig wrote:
> On Tue, Sep 15, 2020 at 08:03:14AM -0600, Thomas Tai wrote:
>> When booting the kernel v5.9-rc4 on a VM, the kernel would panic when
>> printing a warning message in swiotlb_map(). It is because dev->dma_mask
>> can potentially be a null pointer. Using the dma_get_mask() macro can
>> avoid the NULL pointer dereference.
> 
> dma_mask must not be zero.  This means drm is calling DMA API functions
> on something weird.  This needs to be fixed in the caller.
> 

Thanks, Christoph for your comment. The caller already fixed the null 
pointer in the latest v5.9-rc5. I am thinking that if we had used the 
dma_get_mask(), the kernel couldn't panic and could properly print out 
the warning message.

Thomas

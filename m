Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C23724DEED
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 19:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHURxq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 13:53:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:43040 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgHURxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 13:53:40 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHpnhR122754;
        Fri, 21 Aug 2020 17:52:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=QXawLVP6mU6d0n9H5D3i3kKivyf++OjS6AL4G5gYPVg=;
 b=xjD0YNa5YhxJPt0WJTpjk+LadbNo2d7FMenSTrPuETPZd7f/r/IrdEUTYMB6zjBoZPR2
 u0Gbt5dQsnBGRBHppUYMOtOLiNoG5diikc8EI5niRU5dGlMPhvjziRQpZSNErz1u9upU
 Wq8p7dpX4CoNxOvIx21kuNKLBAOOwPNcMzi2bnjJZQwzbDNznyPiT3oL2BAOfgaMMIN6
 Wll2kJGkWltQLjboVupRBBbXpcwJ/nVPH25WgFpRlaPV/q6tC1ok7TspzzN6qWnRrg5U
 6veJeGoLX+90LLkoIxl7SKSYaWcB3CZgDSGo8/2z5d5760+HuElRQHW99SZq6AH74yMQ Jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 3322bjkud5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Aug 2020 17:52:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07LHluAE016656;
        Fri, 21 Aug 2020 17:52:56 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 330pvsa5cy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Aug 2020 17:52:56 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07LHqp6b011145;
        Fri, 21 Aug 2020 17:52:51 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Aug 2020 17:52:51 +0000
Subject: Re: [PATCH v7 0/3] make dma_alloc_coherent NUMA-aware by per-NUMA CMA
To:     Barry Song <song.bao.hua@hisilicon.com>, hch@lst.de,
        m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
        ganapatrao.kulkarni@cavium.com, catalin.marinas@arm.com,
        akpm@linux-foundation.org
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        prime.zeng@hisilicon.com, huangdaode@huawei.com,
        linuxarm@huawei.com
References: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <e47f4bfd-3af7-f682-23a1-51800f992d35@oracle.com>
Date:   Fri, 21 Aug 2020 10:52:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821113355.6140-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210168
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9720 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 adultscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 clxscore=1011 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008210169
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,
Sorry for jumping in so late.

On 8/21/20 4:33 AM, Barry Song wrote:
> 
> with per-numa CMA, smmu will get memory from local numa node to save command
> queues and page tables. that means dma_unmap latency will be shrunk much.

Since per-node CMA areas for hugetlb was introduced, I have been thinking
about the limited number of CMA areas.  In most configurations, I believe
it is limited to 7.  And, IIRC it is not something that can be changed at
runtime, you need to reconfig and rebuild to increase the number.  In contrast
some configs have NODES_SHIFT set to 10.  I wasn't too worried because of
the limited hugetlb use case.  However, this series is adding another user
of per-node CMA areas.

With more users, should try to sync up number of CMA areas and number of
nodes?  Or, perhaps I am worrying about nothing?
-- 
Mike Kravetz

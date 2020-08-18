Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25C8C248F12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 21:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726694AbgHRTws (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 15:52:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43206 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726630AbgHRTws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:52:48 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07IJWkru076478;
        Tue, 18 Aug 2020 15:51:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=references : from : to :
 cc : subject : in-reply-to : date : message-id : mime-version :
 content-type; s=pp1; bh=k8HiwGiI6W+IU4siScj8bisxpCGNJQYvS818WjWSBx8=;
 b=ID1kX5r7z9b2F+dQ0eaYWDhW4tnH+1f3xG5cpXtToPGwUU2xh6O+8aX3U8qQyByfu+e8
 fznS1whhb2jApj/6+BBYc9SBG4fJdBsS8koVm7lsin4oJo/MvzKuCAVdAyFNpqyDbgKg
 Baa0NTpt+05nkp3+vQ17mO+il09gmdprxFYXRCL3tEcCwpnbyaW4Oa/Qlshzg9HpE0uX
 3Iw+9b/JFO4RPHGywpu944OzycrL/6aSGgb5oN2J264pxZG0sPHtiSHnMnJ+Kt7LcVus
 ovN+zeXcCwe+3mhxvrj0Sd3wJHOHgJbYYpsd5XVRiu45BhXWcDuCdFrbXSfRlZ0ceSG+ RQ== 
Received: from ppma01wdc.us.ibm.com (fd.55.37a9.ip4.static.sl-reverse.com [169.55.85.253])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3304swngd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 15:51:59 -0400
Received: from pps.filterd (ppma01wdc.us.ibm.com [127.0.0.1])
        by ppma01wdc.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 07IJilcg019873;
        Tue, 18 Aug 2020 19:51:58 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma01wdc.us.ibm.com with ESMTP id 3304tked05-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 18 Aug 2020 19:51:58 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 07IJpw4127001310
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 19:51:58 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D1BB112062;
        Tue, 18 Aug 2020 19:51:58 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46F8F112065;
        Tue, 18 Aug 2020 19:51:55 +0000 (GMT)
Received: from morokweng.localdomain (unknown [9.163.41.251])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTPS;
        Tue, 18 Aug 2020 19:51:54 +0000 (GMT)
References: <20200817214658.103093-1-bauerman@linux.ibm.com> <20200818065911.GA2324@lst.de>
User-agent: mu4e 1.2.0; emacs 26.3
From:   Thiago Jung Bauermann <bauerman@linux.ibm.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Ram Pai <linuxram@us.ibm.com>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] powerpc/pseries/svm: Allocate SWIOTLB buffer anywhere in memory
In-reply-to: <20200818065911.GA2324@lst.de>
Date:   Tue, 18 Aug 2020 16:51:52 -0300
Message-ID: <877dtvn353.fsf@morokweng.localdomain>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-18_13:2020-08-18,2020-08-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 adultscore=0
 mlxscore=0 malwarescore=0 spamscore=0 mlxlogscore=778 lowpriorityscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig <hch@lst.de> writes:

> On Mon, Aug 17, 2020 at 06:46:58PM -0300, Thiago Jung Bauermann wrote:
>> POWER secure guests (i.e., guests which use the Protection Execution
>> Facility) need to use SWIOTLB to be able to do I/O with the hypervisor, but
>> they don't need the SWIOTLB memory to be in low addresses since the
>> hypervisor doesn't have any addressing limitation.
>> 
>> This solves a SWIOTLB initialization problem we are seeing in secure guests
>> with 128 GB of RAM: they are configured with 4 GB of crashkernel reserved
>> memory, which leaves no space for SWIOTLB in low addresses.
>> 
>> To do this, we use mostly the same code as swiotlb_init(), but allocate the
>> buffer using memblock_alloc() instead of memblock_alloc_low().
>> 
>> We also need to add swiotlb_set_no_iotlb_memory() in order to set the
>> no_iotlb_memory flag if initialization fails.
>
> Do you really need the helper?  As far as I can tell the secure guests
> very much rely on swiotlb for all I/O, so you might as well panic if
> you fail to allocate it.

That is true. Ok, I will do that.

-- 
Thiago Jung Bauermann
IBM Linux Technology Center

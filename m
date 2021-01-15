Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C22622F76C8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 11:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbhAOKgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 05:36:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728455AbhAOKgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 05:36:31 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10FAXIKY050288;
        Fri, 15 Jan 2021 05:35:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=uMFKz03h1DX2pC5sxsmXxwVVWxuuWyUP4nN3/edQMuI=;
 b=M47PKe4gtZbrCjLMNeyo+IzV3vyXdPWb5TD2OewNLbkchUgKtzQXISRxnxoYGHj58as0
 TPSOf8gkQIyDELS2xN6rTLjLMxOIzLSlWH47P6BPrxcNFSXjQImjvcDUXUFPcb9GMq8J
 WQVgZHCVD+/EoCeWNF4bvh+bdv463LA5uI0FHf3IuphS78vH+r1kqE6TLTbSNPfZq14U
 2PDyo2hKQ7J3aQN9IGmb5xBy31W7JSboBmo/7EsSzABrPNs3T6yFL3AWhnfc5WG2yXK4
 td07nawRcrKAjehpc1A6o4h/YXAM/WyfjojKziJyoz//w7QXFcM0OzWBeO8Lg1ZFQNIg uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3639cnr324-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 05:35:36 -0500
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10FAXMWG050701;
        Fri, 15 Jan 2021 05:35:36 -0500
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3639cnr317-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 05:35:36 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10FAWVxY030484;
        Fri, 15 Jan 2021 10:35:34 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma04ams.nl.ibm.com with ESMTP id 35y448fkg0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 15 Jan 2021 10:35:33 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10FAZVKB45613484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jan 2021 10:35:31 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1AB2852054;
        Fri, 15 Jan 2021 10:35:31 +0000 (GMT)
Received: from osiris (unknown [9.171.39.233])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTPS id 86FC95204F;
        Fri, 15 Jan 2021 10:35:30 +0000 (GMT)
Date:   Fri, 15 Jan 2021 11:35:29 +0100
From:   Heiko Carstens <hca@linux.ibm.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Robert Richter <rric@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, oprofile-list@lists.sf.net,
        William Cohen <wcohen@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        anmar.oueja@linaro.org, Christoph Hellwig <hch@infradead.org>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/18] arch: s390: Remove CONFIG_OPROFILE support
Message-ID: <20210115103529.GA10194@osiris>
References: <cover.1610622251.git.viresh.kumar@linaro.org>
 <d898acaf9320125e9c23b18a16ecd88d70f24170.1610622251.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d898acaf9320125e9c23b18a16ecd88d70f24170.1610622251.git.viresh.kumar@linaro.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-15_06:2021-01-15,2021-01-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 phishscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101150063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 14, 2021 at 05:05:25PM +0530, Viresh Kumar wrote:
> The "oprofile" user-space tools don't use the kernel OPROFILE support
> any more, and haven't in a long time. User-space has been converted to
> the perf interfaces.
> 
> Remove the old oprofile's architecture specific support.
> 
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  arch/s390/Kconfig                 |  1 -
>  arch/s390/Makefile                |  3 ---
>  arch/s390/configs/debug_defconfig |  1 -
>  arch/s390/configs/defconfig       |  1 -
>  arch/s390/oprofile/Makefile       | 10 ---------
>  arch/s390/oprofile/init.c         | 37 -------------------------------
>  6 files changed, 53 deletions(-)
>  delete mode 100644 arch/s390/oprofile/Makefile
>  delete mode 100644 arch/s390/oprofile/init.c

Acked-by: Heiko Carstens <hca@linux.ibm.com>

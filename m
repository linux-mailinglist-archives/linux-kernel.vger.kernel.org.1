Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8BF2AE1C3
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 22:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731807AbgKJVaM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 16:30:12 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:49112 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJVaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 16:30:12 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALNqu0133383;
        Tue, 10 Nov 2020 21:30:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=lER9kZ6gtiFR/ZbdtUi5Fs5safSxUNLDEPkk5yWRhOk=;
 b=i4YXiZOM/kZNiNeGIJ1heNpquOyTiCZe/5RyC9+Zu79371vzPB9Dw9VZI+QgrHqc1vpo
 musQoQTPO9FfjpqRKFf7sv1V4pi0tFAJNxQNyqnYSEOhlyTZXkG7JJGBkCjYLcDX2kU6
 SiwI5CITbgzYuvJX9YZEwXQ8RKSg+5q5raroX4UDtLS0uz8xQMZNI2Qmpc42011F4TEF
 Yagmy3UZPHSJhpHFmmMRnEyLZqFhhhOgxeBYOghQ6QpoNEok4TVXNOSPJqom4QYFe1GZ
 +Ael1Y3YfHrZdi2Sbh3vrfMojBsmdNcIm+2OrJXn+Z3qACKeFimCZ1OWSyt0nDoDbbTA 0A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34nkhkx1u5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 10 Nov 2020 21:30:10 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AALOq0p194794;
        Tue, 10 Nov 2020 21:30:09 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34p5g0wape-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Nov 2020 21:30:09 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AALU9ql023478;
        Tue, 10 Nov 2020 21:30:09 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Nov 2020 13:30:09 -0800
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 01E9B6A0109; Tue, 10 Nov 2020 16:31:57 -0500 (EST)
Date:   Tue, 10 Nov 2020 16:31:57 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] (swiotlb) stable/for-linus-5.10-rc2
Message-ID: <20201110213157.GB16458@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 malwarescore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100146
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9801 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011100146
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Linus,

Please git pull the following branch:

 git pull git://git.kernel.org/pub/scm/linux/kernel/git/konrad/swiotlb.git stable/for-linus-5.10-rc2


which has two tiny fixes that make drivers under Xen unhappy under certain conditions.

Thank you!

Christoph Hellwig (1):
      swiotlb: remove the tbl_dma_addr argument to swiotlb_tbl_map_single

Stefano Stabellini (1):
      swiotlb: fix "x86: Don't panic if can not alloc buffer for swiotlb"

 drivers/iommu/intel/iommu.c |  5 ++---
 drivers/xen/swiotlb-xen.c   |  3 +--
 include/linux/swiotlb.h     | 10 +++-------
 kernel/dma/swiotlb.c        | 22 +++++++++++-----------
 4 files changed, 17 insertions(+), 23 deletions(-)

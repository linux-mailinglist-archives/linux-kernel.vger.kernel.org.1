Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4E429A52E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507101AbgJ0HEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:04:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37876 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389459AbgJ0HEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:04:43 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R6x77f133327;
        Tue, 27 Oct 2020 07:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=MoJnc7fpNcxcIDKLzoP8QllWHmSTzy69tYst281zTM0=;
 b=nS7wNtwoVKf8eYvPpO+lmH0MWeR5qbypI4qXAqXIHwl2QjVKkn2+KSKhb/wL4WTCsAdJ
 x38p9aHWYjirLw45lCEeU2s7rnnWqV0LQLpfO7ZesG7g+D0U0hyR3PhzorB8ek4/wvsN
 1/8Q8gPuNng1RG2+vD009g6DTgsnU7xzYsBTcNPjxXae/lp25Wn9uOekbF5WydaSTt06
 HW0Bu1HZZeR4IKgxI8t1NJABvK1t830xS/Gl5tOFk+Z7KRdlrUHW2GwRQMMtnoV9xLtn
 TyPcZ9HHohQntLJRYmIBCjNhJdz7/CGl57Et/yEGHZpzyh4S8Jey9CCm0Sihx8ANrdbX Fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 34cc7kr7ft-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 07:04:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09R703L4053829;
        Tue, 27 Oct 2020 07:02:34 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 34cx5ws8e8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 07:02:34 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09R72XQQ005169;
        Tue, 27 Oct 2020 07:02:33 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 00:02:32 -0700
Date:   Tue, 27 Oct 2020 10:02:26 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sujeev Dias <sdias@codeaurora.org>,
        Siddartha Mohanadoss <smohanad@codeaurora.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [kbuild] drivers/bus/mhi/core/boot.c:222:3: warning: Variable 'i' is
 modified but its new value is never used.
Message-ID: <20201027070226.GI18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: WZM5JHUVEETOS6DT6UDL7SOWRYJ65CWY
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270045
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9786 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 clxscore=1011 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010270045
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   4525c8781ec0701ce824e8bd379ae1b129e26568
commit: cd457afb16670501f00354eb0e705a7d8a50d79d bus: mhi: core: Add support for downloading firmware over BHIe
compiler: powerpc64le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/bus/mhi/core/boot.c:222:3: warning: Variable 'i' is modified but its new value is never used. [unreadVariable]
     i++;
     ^

vim +/i +222 drivers/bus/mhi/core/boot.c

cd457afb166705 Manivannan Sadhasivam 2020-02-20  203  static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
cd457afb166705 Manivannan Sadhasivam 2020-02-20  204  			      const struct firmware *firmware,
cd457afb166705 Manivannan Sadhasivam 2020-02-20  205  			      struct image_info *img_info)
cd457afb166705 Manivannan Sadhasivam 2020-02-20  206  {
cd457afb166705 Manivannan Sadhasivam 2020-02-20  207  	size_t remainder = firmware->size;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  208  	size_t to_cpy;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  209  	const u8 *buf = firmware->data;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  210  	int i = 0;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  211  	struct mhi_buf *mhi_buf = img_info->mhi_buf;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  212  	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  213  
cd457afb166705 Manivannan Sadhasivam 2020-02-20  214  	while (remainder) {
cd457afb166705 Manivannan Sadhasivam 2020-02-20  215  		to_cpy = min(remainder, mhi_buf->len);
cd457afb166705 Manivannan Sadhasivam 2020-02-20  216  		memcpy(mhi_buf->buf, buf, to_cpy);
cd457afb166705 Manivannan Sadhasivam 2020-02-20  217  		bhi_vec->dma_addr = mhi_buf->dma_addr;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  218  		bhi_vec->size = to_cpy;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  219  
cd457afb166705 Manivannan Sadhasivam 2020-02-20  220  		buf += to_cpy;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  221  		remainder -= to_cpy;
cd457afb166705 Manivannan Sadhasivam 2020-02-20 @222  		i++;
                                                                ^^^^
Delete i.

cd457afb166705 Manivannan Sadhasivam 2020-02-20  223  		bhi_vec++;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  224  		mhi_buf++;
cd457afb166705 Manivannan Sadhasivam 2020-02-20  225  	}
cd457afb166705 Manivannan Sadhasivam 2020-02-20  226  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

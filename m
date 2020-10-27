Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60B2829C428
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 18:54:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1822855AbgJ0RxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:53:11 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:45998 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1822841AbgJ0RxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:53:06 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHiaC8183065;
        Tue, 27 Oct 2020 17:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=c4gAxZC/xvFviGGMjForU/y7XYcv/Kx/wPYkvbb97vg=;
 b=iSiG0v67leeoBndABoCYaMCfiyn7FrEMa1/MFrl7qI82SlxcfiFIp4LjpLv2RzHJ9Ip1
 ASgTvnnByHr4rPar/+ZTvdFf492Kqy6BWsS7eJDfrKiS3JSVRwLmn8vNak7sZxJyR818
 ksrZ16RY/0PflPaqXfywLcwWL3wqSFnRoGbhRb1SPRlvSM6UKMIuW8q0EHbRwT92NXO7
 Q58QDZC9pcuSQsnZQ6VJHTUulUjkll1XD2if5cNCFy7v/jvydAbWEiOKjofmdaTPb5S0
 Z0lN+6HyqESpApnOt8mVbG0olbQrFVd2BNJL5BtdDRu106KuQHYEp98e9iyTclI3JlHA ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 34dgm414cv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 27 Oct 2020 17:53:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09RHo3Pw123771;
        Tue, 27 Oct 2020 17:53:00 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34cx5xe9wf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Oct 2020 17:53:00 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 09RHqwvb009169;
        Tue, 27 Oct 2020 17:52:58 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Oct 2020 10:52:58 -0700
Date:   Tue, 27 Oct 2020 20:52:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [kbuild] drivers/gpu/drm/aspeed/aspeed_gfx_drv.c:80:9: warning:
 Identical condition 'ret', second condition is always false
Message-ID: <20201027175252.GN18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: 7ONRF2QZVTLYASOIX6NNPZF7NC3QGTC4
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270107
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9787 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 mlxscore=0 malwarescore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010270106
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   4525c8781ec0701ce824e8bd379ae1b129e26568
commit: c2c25c1cf96927a0b6ddb6aaa063f1fdcc90d749 drm/aspeed: Use managed drmm_mode_config_cleanup
compiler: nds32le-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/gpu/drm/aspeed/aspeed_gfx_drv.c:80:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c:71:6: note: first condition
    if (ret)
        ^
   drivers/gpu/drm/aspeed/aspeed_gfx_drv.c:80:9: note: second condition
    return ret;
           ^

vim +/ret +80 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c

c2c25c1cf96927a Daniel Vetter 2020-09-04  66  static int aspeed_gfx_setup_mode_config(struct drm_device *drm)
4f2a8f5898ecd80 Joel Stanley  2019-04-03  67  {
c2c25c1cf96927a Daniel Vetter 2020-09-04  68  	int ret;
c2c25c1cf96927a Daniel Vetter 2020-09-04  69  
c2c25c1cf96927a Daniel Vetter 2020-09-04  70  	ret = drmm_mode_config_init(drm);
c2c25c1cf96927a Daniel Vetter 2020-09-04  71  	if (ret)
c2c25c1cf96927a Daniel Vetter 2020-09-04  72  		return ret;
4f2a8f5898ecd80 Joel Stanley  2019-04-03  73  
4f2a8f5898ecd80 Joel Stanley  2019-04-03  74  	drm->mode_config.min_width = 0;
4f2a8f5898ecd80 Joel Stanley  2019-04-03  75  	drm->mode_config.min_height = 0;
4f2a8f5898ecd80 Joel Stanley  2019-04-03  76  	drm->mode_config.max_width = 800;
4f2a8f5898ecd80 Joel Stanley  2019-04-03  77  	drm->mode_config.max_height = 600;
4f2a8f5898ecd80 Joel Stanley  2019-04-03  78  	drm->mode_config.funcs = &aspeed_gfx_mode_config_funcs;
c2c25c1cf96927a Daniel Vetter 2020-09-04  79  
c2c25c1cf96927a Daniel Vetter 2020-09-04 @80  	return ret;

This should just be "return 0;"

4f2a8f5898ecd80 Joel Stanley  2019-04-03  81  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

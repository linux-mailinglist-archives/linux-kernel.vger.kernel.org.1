Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 161722B0346
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKLLB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:01:58 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:56794 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbgKLLBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 06:01:00 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACAoHvt070013;
        Thu, 12 Nov 2020 11:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=Jt1Ser9xD/P+Xtzvfs0YIIJR3Im0VNfVTQRzd3HQ6fk=;
 b=BWkrO7EhJId/l4yvvLHS8OlkIZvs8E6efw5ghWaXHkh8baM8WjQun0+IQNheMCyqVdO6
 QVZVkVdPB1CFbcZpt0WKmOAmrD5jex9x8wah/1/7KSdLPzjPg8kfcaZapeTGWaJOusmo
 9+8rD2GS3BoLyCVNqx3jgFySV9bxLrVTqq4klF8cuO57Z39+E1NxS2XRp/Mm/npvQ6O+
 vkr+ZLrR79/W/ZKuPi4bqAyR3krmxuUUvqa3OLoZkATgI9qgISpkJYiZlH6zsNyYdWIr
 C+02IeivUvgER9qB/ZlZFXZTeB1Nyn1nAXcIl67GG03DaN4RhGEH2ISG5dwHE+kvuo0h tQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 34nkhm4nqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 12 Nov 2020 11:00:21 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0ACAjCRi157176;
        Thu, 12 Nov 2020 11:00:21 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 34rt55u4ax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Nov 2020 11:00:21 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0ACB0I7l001413;
        Thu, 12 Nov 2020 11:00:18 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 12 Nov 2020 03:00:18 -0800
Date:   Thu, 12 Nov 2020 14:00:11 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Aya Levin <ayal@mellanox.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>
Subject: [kbuild] net/core/devlink.c:4415:9: warning: Identical condition
 'err', second condition is always false
Message-ID: <20201112110011.GX18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: M4XSBONQKZEZ4ICGUQR2NK453I6BCDNK
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120066
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9802 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 mlxscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 spamscore=0
 malwarescore=0 adultscore=0 clxscore=1011 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011120066
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   3d5e28bff7ad55aea081c1af516cc1c94a5eca7d
commit: 573ed90aa5e23b512168400ba6d65e592081944e devlink: Force enclosing array on binary fmsg data
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> net/core/devlink.c:4415:9: warning: Identical condition 'err', second condition is always false [identicalConditionAfterEarlyExit]
    return err;
           ^
   net/core/devlink.c:4411:6: note: first condition
    if (err)
        ^
   net/core/devlink.c:4415:9: note: second condition
    return err;
           ^

vim +/err +4415 net/core/devlink.c

573ed90aa5e23b Aya Levin       2020-02-11  4405  int devlink_fmsg_binary_pair_nest_start(struct devlink_fmsg *fmsg,
573ed90aa5e23b Aya Levin       2020-02-11  4406  					const char *name)
573ed90aa5e23b Aya Levin       2020-02-11  4407  {
573ed90aa5e23b Aya Levin       2020-02-11  4408  	int err;
573ed90aa5e23b Aya Levin       2020-02-11  4409  
573ed90aa5e23b Aya Levin       2020-02-11  4410  	err = devlink_fmsg_arr_pair_nest_start(fmsg, name);
573ed90aa5e23b Aya Levin       2020-02-11  4411  	if (err)
573ed90aa5e23b Aya Levin       2020-02-11  4412  		return err;
573ed90aa5e23b Aya Levin       2020-02-11  4413  
573ed90aa5e23b Aya Levin       2020-02-11  4414  	fmsg->putting_binary = true;
573ed90aa5e23b Aya Levin       2020-02-11 @4415  	return err;

Just "return 0;"

573ed90aa5e23b Aya Levin       2020-02-11  4416  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

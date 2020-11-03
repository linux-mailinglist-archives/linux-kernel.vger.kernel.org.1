Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C33B2A4391
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 11:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgKCK5d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 05:57:33 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:53256 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726058AbgKCK5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 05:57:32 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3AnVlA081704;
        Tue, 3 Nov 2020 10:57:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=2X1DUNb7To2PAAzGAe4OVTg1saE+DpGcHkMxTZvhejc=;
 b=lhatHrAZ27vTwLGDvdySIM4TkXbcTkRBQxsciVmT3ZFsOF9i7uQj8p3D4EkwVvIbkVL7
 xams4Y+M0UlhYgIUUjDhz64N9DqQiyxV7Y1VzkABlyw5uvTQ4T7tEI3BVo3rqK8e+Ldz
 b6t54hPGJVvVaxCUir3uJbNdbZjjTeYSS799xL6cV73fg54rAmIEO9x1d5W/A1GXWjNQ
 D03LRhtC/CI6QenahRQsOC6sXFvbXkER00gwQSDnmZHJuvUCWyBoIx+cRwlsUd3ps9sy
 kA2Ol1ai3s7OTpp4SIdr5+6wc1Vx1hUIc8885l0RF/1s9a/yUrOkIwNkME73lTCo8s21 xA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34hhb20nx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 03 Nov 2020 10:57:25 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A3AuaPQ113472;
        Tue, 3 Nov 2020 10:57:24 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 34hw0gsn2a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Nov 2020 10:57:24 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A3AvKt6017566;
        Tue, 3 Nov 2020 10:57:20 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Nov 2020 02:57:20 -0800
Date:   Tue, 3 Nov 2020 13:57:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Stephen Boyd <sboyd@kernel.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [kbuild] sound/soc/codecs/wcd934x.c:1571:9: warning: Identical
 condition 'ret', second condition is always false
Message-ID: <20201103105713.GC18329@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: E7S6N33ZAPIYBPXD4MTHB3JGUIZFI3ZE
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030074
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9793 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011030073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   b7cbaf59f62f8ab8f157698f9e31642bff525bd0
commit: bbd7ffdbef6888459f301c5889f3b14ada38b913 clk: Allow the common clk framework to be selectable
compiler: ia64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> sound/soc/codecs/wcd934x.c:1571:9: warning: Identical condition 'ret', second condition is always false [identicalConditionAfterEarlyExit]
    return ret;
           ^
   sound/soc/codecs/wcd934x.c:1568:6: note: first condition
    if (ret)
        ^
   sound/soc/codecs/wcd934x.c:1571:9: note: second condition
    return ret;
           ^

vim +/ret +1571 sound/soc/codecs/wcd934x.c

a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1561  
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1562  	ret = wcd934x_set_prim_interpolator_rate(dai, (u8)rate_val,
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1563  						 sample_rate);
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1564  	if (ret)
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1565  		return ret;
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1566  	ret = wcd934x_set_mix_interpolator_rate(dai, (u8)rate_val,
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1567  						sample_rate);
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1568  	if (ret)
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1569  		return ret;
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1570  
a61f3b4f476eceb Srinivas Kandagatla 2019-12-19 @1571  	return ret;
                                                        ^^^^^^^^^^^
Just "return 0;"

a61f3b4f476eceb Srinivas Kandagatla 2019-12-19  1572  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

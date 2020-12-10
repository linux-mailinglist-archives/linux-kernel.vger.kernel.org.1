Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C662D558C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 09:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388080AbgLJIib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 03:38:31 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38856 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730288AbgLJIia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 03:38:30 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BA8TSmX007419;
        Thu, 10 Dec 2020 08:37:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=X0opqCi36nQXTFJ3zk4g4+dG85M7cdjq8HMky/7Chgs=;
 b=pdESCnqzL7P9pFgJcNtYR+0oN49CxVeJ5J+ykvII2n165xnJhzNpNvmstWKJkjDzAi0p
 HEBsbwC+lJV5tmouviqYD24DUBlQGksu7K/o+hoA7CuD71G5jlbEJ9ziuzcIGiJv5qvE
 SnZGJrVi75KlKDGiBENRI1PTSqMVqnfnsK/5dCJX4UNpfOB7seBq84zcV0sHXniIImR1
 VZajG2bd3yyauxxAs7LKSNMAMJk0w1P/omllSlC5+BnDTi2+TYazy7SI1WgGYU3R/7xO
 6MqBQLBDVfq1SouCnC8PhuODSl8ynWannay2GVekFRPeWbL1ZYd8m+/Iumc4jfc6xOT4 TQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825mc4ne-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 08:37:44 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BA8TnMm178153;
        Thu, 10 Dec 2020 08:37:44 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 358m51v6t5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Dec 2020 08:37:43 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0BA8bgP5017895;
        Thu, 10 Dec 2020 08:37:42 GMT
Received: from kadam (/102.36.221.92)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 10 Dec 2020 00:37:42 -0800
Date:   Thu, 10 Dec 2020 11:37:35 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Elliot Berman <eberman@codeaurora.org>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: [kbuild] drivers/firmware/qcom_scm.c:181:12: warning: Redundant
 condition: cpus. '!cpus || (cpus && cpumask_empty(cpus))' is equivalent to
 '!cpus || cpumask_empty(cpus)'
Message-ID: <20201210083735.GK2789@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: QEBKNI57QQTN5ROLDJMYCADR3DGYE4SI
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100055
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9830 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012100055
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   a2f5ea9e314ba6778f885c805c921e9362ec0420
commit: 57d3b816718c1cf832e2929a754da3564c6127cc firmware: qcom_scm: Remove thin wrappers
compiler: aarch64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/firmware/qcom_scm.c:181:12: warning: Redundant condition: cpus. '!cpus || (cpus && cpumask_empty(cpus))' is equivalent to '!cpus || cpumask_empty(cpus)' [redundantCondition]
    if (!cpus || (cpus && cpumask_empty(cpus)))
              ^

vim +181 drivers/firmware/qcom_scm.c

65f0c90b7d4685 Elliot Berman 2020-01-07  164  int qcom_scm_set_cold_boot_addr(void *entry, const cpumask_t *cpus)
2ce76a6ad32fa0 Lina Iyer     2015-03-02  165  {
57d3b816718c1c Elliot Berman 2020-01-07  166  	int flags = 0;
57d3b816718c1c Elliot Berman 2020-01-07  167  	int cpu;
57d3b816718c1c Elliot Berman 2020-01-07  168  	int scm_cb_flags[] = {
57d3b816718c1c Elliot Berman 2020-01-07  169  		QCOM_SCM_FLAG_COLDBOOT_CPU0,
57d3b816718c1c Elliot Berman 2020-01-07  170  		QCOM_SCM_FLAG_COLDBOOT_CPU1,
57d3b816718c1c Elliot Berman 2020-01-07  171  		QCOM_SCM_FLAG_COLDBOOT_CPU2,
57d3b816718c1c Elliot Berman 2020-01-07  172  		QCOM_SCM_FLAG_COLDBOOT_CPU3,
57d3b816718c1c Elliot Berman 2020-01-07  173  	};
57d3b816718c1c Elliot Berman 2020-01-07  174  	struct qcom_scm_desc desc = {
57d3b816718c1c Elliot Berman 2020-01-07  175  		.svc = QCOM_SCM_SVC_BOOT,
57d3b816718c1c Elliot Berman 2020-01-07  176  		.cmd = QCOM_SCM_BOOT_SET_ADDR,
57d3b816718c1c Elliot Berman 2020-01-07  177  		.arginfo = QCOM_SCM_ARGS(2),
57d3b816718c1c Elliot Berman 2020-01-07  178  		.owner = ARM_SMCCC_OWNER_SIP,
57d3b816718c1c Elliot Berman 2020-01-07  179  	};
57d3b816718c1c Elliot Berman 2020-01-07  180  
57d3b816718c1c Elliot Berman 2020-01-07 @181  	if (!cpus || (cpus && cpumask_empty(cpus)))
                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This could be written as:  if (!cpus || cpumask_empty(cpus))

57d3b816718c1c Elliot Berman 2020-01-07  182  		return -EINVAL;
57d3b816718c1c Elliot Berman 2020-01-07  183  
57d3b816718c1c Elliot Berman 2020-01-07  184  	for_each_cpu(cpu, cpus) {
57d3b816718c1c Elliot Berman 2020-01-07  185  		if (cpu < ARRAY_SIZE(scm_cb_flags))
57d3b816718c1c Elliot Berman 2020-01-07  186  			flags |= scm_cb_flags[cpu];
57d3b816718c1c Elliot Berman 2020-01-07  187  		else
57d3b816718c1c Elliot Berman 2020-01-07  188  			set_cpu_present(cpu, false);
57d3b816718c1c Elliot Berman 2020-01-07  189  	}
57d3b816718c1c Elliot Berman 2020-01-07  190  
57d3b816718c1c Elliot Berman 2020-01-07  191  	desc.args[0] = flags;
57d3b816718c1c Elliot Berman 2020-01-07  192  	desc.args[1] = virt_to_phys(entry);
57d3b816718c1c Elliot Berman 2020-01-07  193  
57d3b816718c1c Elliot Berman 2020-01-07  194  	return qcom_scm_call_atomic(__scm ? __scm->dev : NULL, &desc, NULL);
2ce76a6ad32fa0 Lina Iyer     2015-03-02  195  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 
_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

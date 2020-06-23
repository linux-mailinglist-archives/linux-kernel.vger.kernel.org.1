Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41718204DDA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 11:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732224AbgFWJWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 05:22:44 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2355 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731912AbgFWJWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:22:43 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 06EDE80076BFC7DAFC81;
        Tue, 23 Jun 2020 10:22:42 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 23 Jun
 2020 10:22:40 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     kernel test robot <lkp@intel.com>,
        "will@kernel.org" <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        <rikard.falkeborn@gmail.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "maz@kernel.org" <maz@kernel.org>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
Date:   Tue, 23 Jun 2020 10:21:12 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <202006230905.3HpPgtSC%lkp@intel.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.2.88]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 02:07, kernel test robot wrote:

+ Rikard, as the GENMASK compile-time sanity checks were added recently

> Hi John,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on iommu/next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/John-Garry/iommu-arm-smmu-v3-Improve-cmdq-lock-efficiency/20200623-013438
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
> config: arm64-randconfig-c024-20200622 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> In file included from include/linux/bits.h:23,
> from include/linux/ioport.h:15,
> from include/linux/acpi.h:12,
> from drivers/iommu/arm-smmu-v3.c:12:
> drivers/iommu/arm-smmu-v3.c: In function 'arm_smmu_cmdq_issue_cmdlist':
> include/linux/bits.h:26:28: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))

I'd say that GENMASK_INPUT_CHECK() should be able to handle a l=0 and 
h=unsigned value, so I doubt this warn.

Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it, but it looks 
like GENMASK_INPUT_CHECK() could be improved.

> |                            ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
>>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro 'GENMASK'
> 1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
> |                  ^~~~~~~
> include/linux/bits.h:26:40: warning: comparison of unsigned expression < 0 is always false [-Wtype-limits]
> 26 |   __builtin_constant_p((l) > (h)), (l) > (h), 0)))
> |                                        ^
> include/linux/build_bug.h:16:62: note: in definition of macro 'BUILD_BUG_ON_ZERO'
> 16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
> |                                                              ^
> include/linux/bits.h:39:3: note: in expansion of macro 'GENMASK_INPUT_CHECK'
> 39 |  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
> |   ^~~~~~~~~~~~~~~~~~~
>>> drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro 'GENMASK'
> 1404 |  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);
> |                  ^~~~~~~
> 
> vim +/GENMASK +1404 drivers/iommu/arm-smmu-v3.c



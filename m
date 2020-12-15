Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7F402DAA54
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 10:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbgLOJoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 04:44:07 -0500
Received: from mga03.intel.com ([134.134.136.65]:33092 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728274AbgLOJns (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 04:43:48 -0500
IronPort-SDR: wAfYFWDhJZNemo318IBP9lZhqHDXCCzryiHOcIKaMriswibz7Mn1gFVbibf5bO3fLki8jy/vY0
 l2wjk7JYcAug==
X-IronPort-AV: E=McAfee;i="6000,8403,9835"; a="174961846"
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="174961846"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 01:43:06 -0800
IronPort-SDR: mTHtB6rWBVWNkZrA0YykfSPuXbJ+B3VEC0skdBj1aqS2B9weKZgDOLKkthRL4cTRsjNSIW+UDQ
 +KMlgxFqo0BQ==
X-IronPort-AV: E=Sophos;i="5.78,420,1599548400"; 
   d="scan'208";a="336752969"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.117]) ([10.239.13.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2020 01:43:02 -0800
Subject: Re: [kbuild-all] Re: [PATCH] usb: cdns3: Adds missing __iomem markers
To:     Peter Chen <peter.chen@nxp.com>, kernel test robot <lkp@intel.com>
Cc:     Pawel Laszczak <pawell@cadence.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "rogerq@ti.com" <rogerq@ti.com>,
        "a-govindraju@ti.com" <a-govindraju@ti.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kurahul@cadence.com" <kurahul@cadence.com>
References: <20201214125043.29710-1-pawell@cadence.com>
 <202012142359.ZshcbBoP-lkp@intel.com> <20201215055812.GA18223@b29397-desktop>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <9bdcfed8-a48a-075b-0a1e-9a00c817824a@intel.com>
Date:   Tue, 15 Dec 2020 17:42:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20201215055812.GA18223@b29397-desktop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/15/20 1:58 PM, Peter Chen wrote:
> On 20-12-14 23:35:56, kernel test robot wrote:
>> Hi Pawel,
>>
>> I love your patch! Perhaps something to improve:
>>
>> [auto build test WARNING on next-20201211]
>> [cannot apply to peter.chen-usb/ci-for-usb-next v5.10 v5.10-rc7 v5.10-rc6 v5.10]
> Sorry, I changed the branch name to reflect the branch does not only queue
> chipidea USB patches.
>
> next branch: for-usb-next
> fixes branch: for-usb-fixes
>
> Peter

Hi Peter,

Thanks for the feedback, we'll update it on the CI system.

Best Regards,
Rong Chen

>
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit-scm.com%2Fdocs%2Fgit-format-patch&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Cy3huYNzWiJ57OKmzmaleCT14gcFr8RyYDnqTfZWNG4%3D&amp;reserved=0]
>>
>> url:    https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommits%2FPawel-Laszczak%2Fusb-cdns3-Adds-missing-__iomem-markers%2F20201214-205353&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=x5XoDUUskeGteTFaPjgS24Hrbb712XqMqaIkqwXWu14%3D&amp;reserved=0
>> base:    3cc2bd440f2171f093b3a8480a4b54d8c270ed38
>> config: riscv-allmodconfig (attached as .config)
>> compiler: riscv64-linux-gcc (GCC) 9.3.0
>> reproduce (this is a W=1 build):
>>          wget https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fraw.githubusercontent.com%2Fintel%2Flkp-tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=jAavg0T3itnjkbHXADvePHHgtYeqiVTBt%2BoatHT0VHU%3D&amp;reserved=0 -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux%2Fcommit%2F315bfcf1e0604de6ecfc1856cf5820876390f16c&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=SQ75IXxfld6HMRIFkZ%2F8Z4YqxnFP%2F%2BZ%2BsYZIycNeO%2FA%3D&amp;reserved=0
>>          git remote add linux-review https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgithub.com%2F0day-ci%2Flinux&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=ZVS4723WbEO03hbsLXJ%2B%2FmB5EZElulY7lAsMEMatiko%3D&amp;reserved=0
>>          git fetch --no-tags linux-review Pawel-Laszczak/usb-cdns3-Adds-missing-__iomem-markers/20201214-205353
>>          git checkout 315bfcf1e0604de6ecfc1856cf5820876390f16c
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=riscv
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     In file included from arch/riscv/include/asm/io.h:23,
>>                      from include/linux/io.h:13,
>>                      from include/linux/irq.h:20,
>>                      from include/asm-generic/hardirq.h:17,
>>                      from ./arch/riscv/include/generated/asm/hardirq.h:1,
>>                      from include/linux/hardirq.h:10,
>>                      from include/linux/interrupt.h:11,
>>                      from drivers/usb/cdns3/drd.c:13:
>>     drivers/usb/cdns3/drd.c: In function 'cdns_otg_disable_irq':
>>     drivers/usb/cdns3/drd.c:159:31: error: dereferencing pointer to incomplete type 'struct cdns_otg_irq_reg'
>>       159 |  writel(0, &cdns->otg_irq_regs->ien);
>>           |                               ^~
>>     arch/riscv/include/asm/mmio.h:93:76: note: in definition of macro 'writel_cpu'
>>        93 | #define writel_cpu(v, c) ((void)__raw_writel((__force u32)cpu_to_le32(v), (c)))
>>           |                                                                            ^
>>     drivers/usb/cdns3/drd.c:159:2: note: in expansion of macro 'writel'
>>       159 |  writel(0, &cdns->otg_irq_regs->ien);
>>           |  ^~~~~~
>>     drivers/usb/cdns3/drd.c: In function 'cdns_drd_init':
>>     drivers/usb/cdns3/drd.c:409:22: error: assignment to 'struct cdns_otg_irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-Werror=incompatible-pointer-types]
>>       409 |   cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem  *)
>>           |                      ^
>>     In file included from include/linux/byteorder/little_endian.h:5,
>>                      from arch/riscv/include/uapi/asm/byteorder.h:10,
>>                      from include/asm-generic/bitops/le.h:6,
>>                      from arch/riscv/include/asm/bitops.h:202,
>>                      from include/linux/bitops.h:32,
>>                      from include/linux/kernel.h:11,
>>                      from drivers/usb/cdns3/drd.c:12:
>>>> drivers/usb/cdns3/drd.c:421:33: warning: passing argument 1 of '__raw_readl' makes pointer from integer without a cast [-Wint-conversion]
>>       421 |   if (readl(cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
>>           |             ~~~~~~~~~~~~~~~~~~~~^~~~~
>>           |                                 |
>>           |                                 __le32 {aka unsigned int}
>>     include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__le32_to_cpu'
>>        34 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
>>           |                                                   ^
>>     arch/riscv/include/asm/mmio.h:140:47: note: in expansion of macro 'readl_cpu'
>>       140 | #define readl(c) ({ u32 __v; __io_br(); __v = readl_cpu(c); __io_ar(__v); __v; })
>>           |                                               ^~~~~~~~~
>>     drivers/usb/cdns3/drd.c:421:7: note: in expansion of macro 'readl'
>>       421 |   if (readl(cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
>>           |       ^~~~~
>>     In file included from arch/riscv/include/asm/io.h:23,
>>                      from include/linux/io.h:13,
>>                      from include/linux/irq.h:20,
>>                      from include/asm-generic/hardirq.h:17,
>>                      from ./arch/riscv/include/generated/asm/hardirq.h:1,
>>                      from include/linux/hardirq.h:10,
>>                      from include/linux/interrupt.h:11,
>>                      from drivers/usb/cdns3/drd.c:13:
>>     arch/riscv/include/asm/mmio.h:63:60: note: expected 'const volatile void *' but argument is of type '__le32' {aka 'unsigned int'}
>>        63 | static inline u32 __raw_readl(const volatile void __iomem *addr)
>>           |                               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
>>     drivers/usb/cdns3/drd.c:422:23: error: assignment to 'struct cdns_otg_irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-Werror=incompatible-pointer-types]
>>       422 |    cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>>           |                       ^
>>     drivers/usb/cdns3/drd.c:426:23: error: assignment to 'struct cdns_otg_irq_reg *' from incompatible pointer type 'struct cdns_otg_irq_regs *' [-Werror=incompatible-pointer-types]
>>       426 |    cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>>           |                       ^
>>     cc1: some warnings being treated as errors
>>
>> vim +/__raw_readl +421 drivers/usb/cdns3/drd.c
>>
>>     383	
>>     384	int cdns_drd_init(struct cdns *cdns)
>>     385	{
>>     386		void __iomem *regs;
>>     387		u32 state;
>>     388		int ret;
>>     389	
>>     390		regs = devm_ioremap_resource(cdns->dev, &cdns->otg_res);
>>     391		if (IS_ERR(regs))
>>     392			return PTR_ERR(regs);
>>     393	
>>     394		/* Detection of DRD version. Controller has been released
>>     395		 * in three versions. All are very similar and are software compatible,
>>     396		 * but they have same changes in register maps.
>>     397		 * The first register in oldest version is command register and it's
>>     398		 * read only. Driver should read 0 from it. On the other hand, in v1
>>     399		 * and v2 the first register contains device ID number which is not
>>     400		 * set to 0. Driver uses this fact to detect the proper version of
>>     401		 * controller.
>>     402		 */
>>     403		cdns->otg_v0_regs = regs;
>>     404		if (!readl(&cdns->otg_v0_regs->cmd)) {
>>     405			cdns->version  = CDNS3_CONTROLLER_V0;
>>     406			cdns->otg_v1_regs = NULL;
>>     407			cdns->otg_cdnsp_regs = NULL;
>>     408			cdns->otg_regs = regs;
>>     409			cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem  *)
>>     410					     &cdns->otg_v0_regs->ien;
>>     411			writel(1, &cdns->otg_v0_regs->simulate);
>>     412			dev_dbg(cdns->dev, "DRD version v0 (%08x)\n",
>>     413				 readl(&cdns->otg_v0_regs->version));
>>     414		} else {
>>     415			cdns->otg_v0_regs = NULL;
>>     416			cdns->otg_v1_regs = regs;
>>     417			cdns->otg_cdnsp_regs = regs;
>>     418	
>>     419			cdns->otg_regs = (void __iomem *)&cdns->otg_v1_regs->cmd;
>>     420	
>>   > 421			if (readl(cdns->otg_cdnsp_regs->did) == OTG_CDNSP_DID) {
>>     422				cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>>     423						      &cdns->otg_cdnsp_regs->ien;
>>     424				cdns->version  = CDNSP_CONTROLLER_V2;
>>     425			} else {
>>     426				cdns->otg_irq_regs = (struct cdns_otg_irq_regs __iomem *)
>>     427						      &cdns->otg_v1_regs->ien;
>>     428				writel(1, &cdns->otg_v1_regs->simulate);
>>     429				cdns->version  = CDNS3_CONTROLLER_V1;
>>     430			}
>>     431	
>>     432			dev_dbg(cdns->dev, "DRD version v1 (ID: %08x, rev: %08x)\n",
>>     433				 readl(&cdns->otg_v1_regs->did),
>>     434				 readl(&cdns->otg_v1_regs->rid));
>>     435		}
>>     436	
>>     437		state = OTGSTS_STRAP(readl(&cdns->otg_regs->sts));
>>     438	
>>     439		/* Update dr_mode according to STRAP configuration. */
>>     440		cdns->dr_mode = USB_DR_MODE_OTG;
>>     441	
>>     442		if ((cdns->version == CDNSP_CONTROLLER_V2 &&
>>     443		     state == OTGSTS_CDNSP_STRAP_HOST) ||
>>     444		    (cdns->version != CDNSP_CONTROLLER_V2 &&
>>     445		     state == OTGSTS_STRAP_HOST)) {
>>     446			dev_dbg(cdns->dev, "Controller strapped to HOST\n");
>>     447			cdns->dr_mode = USB_DR_MODE_HOST;
>>     448		} else if ((cdns->version == CDNSP_CONTROLLER_V2 &&
>>     449			    state == OTGSTS_CDNSP_STRAP_GADGET) ||
>>     450			   (cdns->version != CDNSP_CONTROLLER_V2 &&
>>     451			    state == OTGSTS_STRAP_GADGET)) {
>>     452			dev_dbg(cdns->dev, "Controller strapped to PERIPHERAL\n");
>>     453			cdns->dr_mode = USB_DR_MODE_PERIPHERAL;
>>     454		}
>>     455	
>>     456		ret = devm_request_threaded_irq(cdns->dev, cdns->otg_irq,
>>     457						cdns_drd_irq,
>>     458						cdns_drd_thread_irq,
>>     459						IRQF_SHARED,
>>     460						dev_name(cdns->dev), cdns);
>>     461		if (ret) {
>>     462			dev_err(cdns->dev, "couldn't get otg_irq\n");
>>     463			return ret;
>>     464		}
>>     465	
>>     466		state = readl(&cdns->otg_regs->sts);
>>     467		if (OTGSTS_OTG_NRDY(state)) {
>>     468			dev_err(cdns->dev, "Cadence USB3 OTG device not ready\n");
>>     469			return -ENODEV;
>>     470		}
>>     471	
>>     472		return 0;
>>     473	}
>>     474	
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.01.org%2Fhyperkitty%2Flist%2Fkbuild-all%40lists.01.org&amp;data=04%7C01%7Cpeter.chen%40nxp.com%7C6ce79474794448ae12b008d8a045f9ce%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637435572341553421%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=v9fQGKZKobtIysXu43lCekV%2FoXCc2EZZXIxoTtQpSdw%3D&amp;reserved=0
>
>


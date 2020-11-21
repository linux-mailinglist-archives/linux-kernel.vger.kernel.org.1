Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE56C2BC1E8
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 21:06:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgKUUDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 15:03:44 -0500
Received: from mga18.intel.com ([134.134.136.126]:55285 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728443AbgKUUDn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 15:03:43 -0500
IronPort-SDR: uI6Wo6NIADoIPmpIXyvSWfFttYY9EORnNncz7hNTaQKtAHigNaxg3vzkLATwg1kyO8u3Fdf8XF
 /wapqZZH63RQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9812"; a="159379047"
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="159379047"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2020 12:03:40 -0800
IronPort-SDR: PWgwFJ63zRKLIMEx1vlQEsQh/Gxy5du2lxGZAtr/1akTHI41cB+IFzaNCvJFKefo/KkqGTaocj
 UoeZUkmRrfPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,359,1599548400"; 
   d="gz'50?scan'50,208,50";a="360894867"
Received: from lkp-server01.sh.intel.com (HELO 00bc34107a07) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 21 Nov 2020 12:03:38 -0800
Received: from kbuild by 00bc34107a07 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kgZ6f-0000PQ-Fe; Sat, 21 Nov 2020 20:03:37 +0000
Date:   Sun, 22 Nov 2020 04:03:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: drivers/soc/qcom/smsm.c:152:22: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202011220406.tQqih6zj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bp/iNruPH9dso1Pn"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bp/iNruPH9dso1Pn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   27bba9c532a8d21050b94224ffd310ad0058c353
commit: e5fc436f06eef54ef512ea55a9db8eb9f2e76959 sparse: use static inline for __chk_{user,io}_ptr()
date:   3 months ago
config: sh-randconfig-s032-20201122 (attached as .config)
compiler: sh4-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.3-134-gb59dbdaf-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e5fc436f06eef54ef512ea55a9db8eb9f2e76959
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sh 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/soc/qcom/smsm.c:152:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *local_state @@
>> drivers/soc/qcom/smsm.c:152:22: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:152:22: sparse:     got unsigned int [usertype] *local_state
   drivers/soc/qcom/smsm.c:164:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *local_state @@
   drivers/soc/qcom/smsm.c:164:9: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:164:9: sparse:     got unsigned int [usertype] *local_state
>> drivers/soc/qcom/smsm.c:174:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:174:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:174:23: sparse:     got unsigned int [usertype] *
>> drivers/soc/qcom/smsm.c:206:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] *remote_state @@
   drivers/soc/qcom/smsm.c:206:15: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:206:15: sparse:     got unsigned int [usertype] *remote_state
   drivers/soc/qcom/smsm.c:245:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:245:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:245:23: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:247:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:247:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:247:17: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:272:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:272:23: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:272:23: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:274:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:274:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:274:17: sparse:     got unsigned int [usertype] *
   drivers/soc/qcom/smsm.c:569:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *ptr @@     got unsigned int [usertype] * @@
   drivers/soc/qcom/smsm.c:569:17: sparse:     expected void const volatile [noderef] __iomem *ptr
   drivers/soc/qcom/smsm.c:569:17: sparse:     got unsigned int [usertype] *

vim +152 drivers/soc/qcom/smsm.c

c97c4090ff72297 Bjorn Andersson 2015-09-24  129  
c97c4090ff72297 Bjorn Andersson 2015-09-24  130  /**
c97c4090ff72297 Bjorn Andersson 2015-09-24  131   * smsm_update_bits() - change bit in outgoing entry and inform subscribers
c97c4090ff72297 Bjorn Andersson 2015-09-24  132   * @data:	smsm context pointer
c97c4090ff72297 Bjorn Andersson 2015-09-24  133   * @offset:	bit in the entry
c97c4090ff72297 Bjorn Andersson 2015-09-24  134   * @value:	new value
c97c4090ff72297 Bjorn Andersson 2015-09-24  135   *
c97c4090ff72297 Bjorn Andersson 2015-09-24  136   * Used to set and clear the bits in the outgoing/local entry and inform
c97c4090ff72297 Bjorn Andersson 2015-09-24  137   * subscribers about the change.
c97c4090ff72297 Bjorn Andersson 2015-09-24  138   */
c97c4090ff72297 Bjorn Andersson 2015-09-24  139  static int smsm_update_bits(void *data, u32 mask, u32 value)
c97c4090ff72297 Bjorn Andersson 2015-09-24  140  {
c97c4090ff72297 Bjorn Andersson 2015-09-24  141  	struct qcom_smsm *smsm = data;
c97c4090ff72297 Bjorn Andersson 2015-09-24  142  	struct smsm_host *hostp;
c97c4090ff72297 Bjorn Andersson 2015-09-24  143  	unsigned long flags;
c97c4090ff72297 Bjorn Andersson 2015-09-24  144  	u32 changes;
c97c4090ff72297 Bjorn Andersson 2015-09-24  145  	u32 host;
c97c4090ff72297 Bjorn Andersson 2015-09-24  146  	u32 orig;
c97c4090ff72297 Bjorn Andersson 2015-09-24  147  	u32 val;
c97c4090ff72297 Bjorn Andersson 2015-09-24  148  
c97c4090ff72297 Bjorn Andersson 2015-09-24  149  	spin_lock_irqsave(&smsm->lock, flags);
c97c4090ff72297 Bjorn Andersson 2015-09-24  150  
c97c4090ff72297 Bjorn Andersson 2015-09-24  151  	/* Update the entry */
c97c4090ff72297 Bjorn Andersson 2015-09-24 @152  	val = orig = readl(smsm->local_state);
c97c4090ff72297 Bjorn Andersson 2015-09-24  153  	val &= ~mask;
c97c4090ff72297 Bjorn Andersson 2015-09-24  154  	val |= value;
c97c4090ff72297 Bjorn Andersson 2015-09-24  155  
c97c4090ff72297 Bjorn Andersson 2015-09-24  156  	/* Don't signal if we didn't change the value */
c97c4090ff72297 Bjorn Andersson 2015-09-24  157  	changes = val ^ orig;
c97c4090ff72297 Bjorn Andersson 2015-09-24  158  	if (!changes) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  159  		spin_unlock_irqrestore(&smsm->lock, flags);
c97c4090ff72297 Bjorn Andersson 2015-09-24  160  		goto done;
c97c4090ff72297 Bjorn Andersson 2015-09-24  161  	}
c97c4090ff72297 Bjorn Andersson 2015-09-24  162  
c97c4090ff72297 Bjorn Andersson 2015-09-24  163  	/* Write out the new value */
c97c4090ff72297 Bjorn Andersson 2015-09-24  164  	writel(val, smsm->local_state);
c97c4090ff72297 Bjorn Andersson 2015-09-24  165  	spin_unlock_irqrestore(&smsm->lock, flags);
c97c4090ff72297 Bjorn Andersson 2015-09-24  166  
c97c4090ff72297 Bjorn Andersson 2015-09-24  167  	/* Make sure the value update is ordered before any kicks */
c97c4090ff72297 Bjorn Andersson 2015-09-24  168  	wmb();
c97c4090ff72297 Bjorn Andersson 2015-09-24  169  
c97c4090ff72297 Bjorn Andersson 2015-09-24  170  	/* Iterate over all hosts to check whom wants a kick */
c97c4090ff72297 Bjorn Andersson 2015-09-24  171  	for (host = 0; host < smsm->num_hosts; host++) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  172  		hostp = &smsm->hosts[host];
c97c4090ff72297 Bjorn Andersson 2015-09-24  173  
c97c4090ff72297 Bjorn Andersson 2015-09-24 @174  		val = readl(smsm->subscription + host);
c97c4090ff72297 Bjorn Andersson 2015-09-24  175  		if (val & changes && hostp->ipc_regmap) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  176  			regmap_write(hostp->ipc_regmap,
c97c4090ff72297 Bjorn Andersson 2015-09-24  177  				     hostp->ipc_offset,
c97c4090ff72297 Bjorn Andersson 2015-09-24  178  				     BIT(hostp->ipc_bit));
c97c4090ff72297 Bjorn Andersson 2015-09-24  179  		}
c97c4090ff72297 Bjorn Andersson 2015-09-24  180  	}
c97c4090ff72297 Bjorn Andersson 2015-09-24  181  
c97c4090ff72297 Bjorn Andersson 2015-09-24  182  done:
c97c4090ff72297 Bjorn Andersson 2015-09-24  183  	return 0;
c97c4090ff72297 Bjorn Andersson 2015-09-24  184  }
c97c4090ff72297 Bjorn Andersson 2015-09-24  185  
c97c4090ff72297 Bjorn Andersson 2015-09-24  186  static const struct qcom_smem_state_ops smsm_state_ops = {
c97c4090ff72297 Bjorn Andersson 2015-09-24  187  	.update_bits = smsm_update_bits,
c97c4090ff72297 Bjorn Andersson 2015-09-24  188  };
c97c4090ff72297 Bjorn Andersson 2015-09-24  189  
c97c4090ff72297 Bjorn Andersson 2015-09-24  190  /**
c97c4090ff72297 Bjorn Andersson 2015-09-24  191   * smsm_intr() - cascading IRQ handler for SMSM
c97c4090ff72297 Bjorn Andersson 2015-09-24  192   * @irq:	unused
c97c4090ff72297 Bjorn Andersson 2015-09-24  193   * @data:	entry related to this IRQ
c97c4090ff72297 Bjorn Andersson 2015-09-24  194   *
c97c4090ff72297 Bjorn Andersson 2015-09-24  195   * This function cascades an incoming interrupt from a remote system, based on
c97c4090ff72297 Bjorn Andersson 2015-09-24  196   * the state bits and configuration.
c97c4090ff72297 Bjorn Andersson 2015-09-24  197   */
c97c4090ff72297 Bjorn Andersson 2015-09-24  198  static irqreturn_t smsm_intr(int irq, void *data)
c97c4090ff72297 Bjorn Andersson 2015-09-24  199  {
c97c4090ff72297 Bjorn Andersson 2015-09-24  200  	struct smsm_entry *entry = data;
c97c4090ff72297 Bjorn Andersson 2015-09-24  201  	unsigned i;
c97c4090ff72297 Bjorn Andersson 2015-09-24  202  	int irq_pin;
c97c4090ff72297 Bjorn Andersson 2015-09-24  203  	u32 changed;
c97c4090ff72297 Bjorn Andersson 2015-09-24  204  	u32 val;
c97c4090ff72297 Bjorn Andersson 2015-09-24  205  
c97c4090ff72297 Bjorn Andersson 2015-09-24 @206  	val = readl(entry->remote_state);
c97c4090ff72297 Bjorn Andersson 2015-09-24  207  	changed = val ^ entry->last_value;
c97c4090ff72297 Bjorn Andersson 2015-09-24  208  	entry->last_value = val;
c97c4090ff72297 Bjorn Andersson 2015-09-24  209  
c97c4090ff72297 Bjorn Andersson 2015-09-24  210  	for_each_set_bit(i, entry->irq_enabled, 32) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  211  		if (!(changed & BIT(i)))
c97c4090ff72297 Bjorn Andersson 2015-09-24  212  			continue;
c97c4090ff72297 Bjorn Andersson 2015-09-24  213  
c97c4090ff72297 Bjorn Andersson 2015-09-24  214  		if (val & BIT(i)) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  215  			if (test_bit(i, entry->irq_rising)) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  216  				irq_pin = irq_find_mapping(entry->domain, i);
c97c4090ff72297 Bjorn Andersson 2015-09-24  217  				handle_nested_irq(irq_pin);
c97c4090ff72297 Bjorn Andersson 2015-09-24  218  			}
c97c4090ff72297 Bjorn Andersson 2015-09-24  219  		} else {
c97c4090ff72297 Bjorn Andersson 2015-09-24  220  			if (test_bit(i, entry->irq_falling)) {
c97c4090ff72297 Bjorn Andersson 2015-09-24  221  				irq_pin = irq_find_mapping(entry->domain, i);
c97c4090ff72297 Bjorn Andersson 2015-09-24  222  				handle_nested_irq(irq_pin);
c97c4090ff72297 Bjorn Andersson 2015-09-24  223  			}
c97c4090ff72297 Bjorn Andersson 2015-09-24  224  		}
c97c4090ff72297 Bjorn Andersson 2015-09-24  225  	}
c97c4090ff72297 Bjorn Andersson 2015-09-24  226  
c97c4090ff72297 Bjorn Andersson 2015-09-24  227  	return IRQ_HANDLED;
c97c4090ff72297 Bjorn Andersson 2015-09-24  228  }
c97c4090ff72297 Bjorn Andersson 2015-09-24  229  

:::::: The code at line 152 was first introduced by commit
:::::: c97c4090ff72297a878a37715bd301624b71c885 soc: qcom: smsm: Add driver for Qualcomm SMSM

:::::: TO: Bjorn Andersson <bjorn.andersson@sonymobile.com>
:::::: CC: Andy Gross <agross@codeaurora.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bp/iNruPH9dso1Pn
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICHZtuV8AAy5jb25maWcAnDxbb+M2s+/9FUILHGwftvXdCQ7yQEmUxVoUtSJlK3kRvIm3
G3xJnM922t1/f4bUjZSoxDgLLBDPDIfkcO6k/dsvvzno7Xx43p0f73dPTz+dv/cv++PuvH9w
vj0+7f/X8ZkTM+Fgn4g/gDh6fHn78efpuzP/4/qP0efj/cRZ748v+yfHO7x8e/z7DcY+Hl5+
+e0Xj8UBWRWeV2xwygmLC4FzcfPr6fvs85Pk8vnv+3vn08rzfneu/5j+MfpVG0J4AYibnzVo
1bK5uR5NR6MaEfkNfDKdjdS/hk+E4lWDHmnsQ8QLxGmxYoK1k2gIEkckxi2KpF+KLUvXAIGt
/easlJSenNP+/PbabtZN2RrHBeyV00QbHRNR4HhToBRWTCgRN9NJMyujCYkwSIeLdkjEPBTV
S/+1EY2bEdgxR5HQgCHa4GKN0xhHxeqOaBPrGBcwEzsquqPIjsnvhkZocjOn/s0xwWpe5/Hk
vBzOUl49Ajn7e/j87v3RTEdXSB8HKIuEkrwmqRocMi5iRPHNr59eDi/73xsCfss3JPH0bWyR
8MLiS4YzbF1HxnFEXMsalLxQCoNRBtYDrOFIo1qDQKOc09vX08/Tef/cahBFt+VAnqCUY6l4
mhXgGKfEU9rIQ7a1Y0j8F/aE1Bsr2gt1DZEQn1FEYhPGCbURFSHBqdzTrYkNEBeYkRYNm4j9
CPS3Q8dSD/uFCFOMfBKvWuxH+/Wxm60Crk5m//LgHL51RNgd5IEJrfEGx4LXMhePz/vjySZ2
Qbw1mC0GqWpGGN4VCfBiPjE0ImYSQ2B7llNXSI0FWYVFijnMQEtpNMvvraYek6QY00QAK+WC
mnlr+IZFWSxQemvVx4rKsrR6vMdgeC0TL8n+FLvTf5wzLMfZwdJO59355Ozu7w9vL+fHl787
UoIBBfIUj/IA25k5MVdUbfSCKVomkj3hLEJSg3V2arWplzncdnzxbQG4Vu7wocA5nJ52nNyg
UGM6IMTXXA2tlMiC6oEyH9vgIkVejWg210EV0goK6lqlZm61MaJ1+YfOtYbBATPPqhNkHcJM
oH8WrYiYDCsBOBQSiJvxstUWEos1xJoAd2mmXVvjXghWrSyu1it+/33/8Pa0Pzrf9rvz23F/
UuBqcxZsEw9XKcsSrm+QYuqtLEsvScvZW/kHiKSFiWm1K+CFC55pS3wRWkWVCn3s8KQJ8Y01
VuDUN4OZiQ3AAu9wqqUcJdzHG+LhHhhsASxN9OCg1oGFBzhIY0Uh9tYJg1OUDkiw1OauypND
mWCKiz4eAhZIy8fgNjwkTFm04sIRurXwdaO13JUKwKl2OOozosCYswxigRacU7+TvQCgTlra
+fzhfAFwA7mCGmXLExRi1pngjgvbwbuMSd9ZWV+bM7IEfDu5wzK4qaNhKUWxZ7juLhmHP4ZS
hoz440U7Q+PFWnOAFIZA2pHaznOFBQUvU7TpRudAK4RlbFDGbMOlM07yKnZZI4r0Ee1aK58R
U6IzAb20iRNBuA8ytcR6ARmUCJ2PYGidFLQEezTJvVA7CZwwnRcnqxhFgaZ6ahc6QCUHgeEf
ELFpCWFFlnaCHfI3BDZQSdMmHPBaLkpTotv7WtLeUt6HFEhffQNVUpJGJsjGOBk3Cd45Spga
+77uFZXopHYWTU5UH5oEgjoVGwrMmBb0Em88mtUOvSrzkv3x2+H4vHu53zv4n/0LxHEEPt2T
kRzSmTYmm3M161ZuqjenNQJeOGPLe0PLCcsMp6OyrRlEmVsuw+aooRpDAgq5tWE5EbJl+JKT
ScbcgSmRC/qQrnBdgli5AZGMEBHh4LLBFpmWg5vYEKU+xF7tfHmYBQGUkQmCSZRMEbj8Fk8p
ShR8W2Sx9MIEReCEdA63kMPTwkcCyaKZBMRDZhkB+UVAotoQqlMyS+GGWQZHHPZT+XCLISPW
kzKBvHWZEcGYhKVmEbyG+NNHQJJNmARBvaQFjGQlkAsyiEALIn4zqTIRlUE555+ve60tAWkm
D6eGj5agzBW3CSwlXC7G19az1Mn+she2HU6T0fgysullZIuLyBaXcVvMLiP7WBg0X13Cajma
X0a2sJlnl2j5zgkuR1eXzfTx3iTZeHQZ2UU6Acd4GdlFqrOcX8RtdH0pt/RCOruH7dFdOO34
smkXl2x2VkxGF57ERYaynFxkKMvpZWTz5WVbvWxty8uU6epCsssM9OoSP5RftIHp7MIzuOhE
pwtjZSoI0P3z4fjTgSxi9/f+GZII5/AqG9VlVdrEyMyW5MqIyoKAY3Ez+jEamU1m1dGCMJQX
dyzGDMJyejOeaTkgS29lkEvV4CtzcI2GQCyxnf71dOISLeipVmIAmSCMKnAsI10HWfbQLkBX
SUgXjyPsiXpRlPlYy0iVFORCi9naSHpaxNXanv20FOPFhySLWZekyjOGT7A8wt39971zP3AJ
gaDMLbYpEdhFnpHaaSgRQgm8srcFSjLQAnuHyzK5WlVyPNzvT6dDpwui6W1EhICUBcc+QbFF
+ySNKzN6RaDne0UAKEwzA4Z8LX+XY+WNBhRleCP6cJ4WqavncpblqvW6h93xwTm9vb4ejudW
rDCfl3HBaOFFa52PSd/2XlXz7/7pcP+foZMClgkwk5nul5t5x9bkfJHsQK6MPVcwSPtWyLvt
tVgHJ637n05w3P/3bf9y/9M53e+eypbnu0jjBOVSh/qettHvoxV32URqpd2WEWHhd3sfFTN9
RDnk8Py6e4FtOt73x1ej+dZFKRx6eHiUUoFMnr+97o+h4+//eYSSyz8+/mMUdiEGZ+ZipClU
ksHS+JYIL7x5bif6mGfTD9RydL3atFlNeFeMRyOLqQBiMh/pxg2Q6cge9EoudjY3wMZskIWp
7H1rFpQieRiZfsuXhLccSqao7+3bA8SeLDAtk64yrl3ByU+laZYVTCm8Px0efqaHr49PtQQd
1gSxVkXA2r3mlkmWyMe317NU/fPx8CRbrofuIDlCVuMpka0jo7UsMVBjJVD09Wvm9vg+XmCn
qO/6l8O5v6w7nDJL9B1rHkH15KAiXeskV4bTwLGAaNbnoDmrQyeWuG8nIz2oCTVw6d0P/8IW
+xHJ+aSadoTC3Cj6XeuJUCNy0sE2RFK71Orz9kuRsC1OCxxAWU5kj6ON4Y2rIg9PnRKX+HoW
UEOKFdsUEfJ9oxWtI2HlWbeyapACs0F/Vy6hiScXCsi4U98d778/nvf3Uj8+P+xfgddAvsbK
hsRgJ7XGG7fSAHOxrV9X3m+X6O6td4qFFVF2OnWIyqRUPyNkTDvB5qqEJqUkyztQy2WnRMpe
JngLkSWdHE3lhFKbC9GZOMUrXqDYLzsq8ooOcwD02qfhtnBh5vJmoIOjJAdn16K54tpZQr3x
8mqo14dVNFsEGkoSryhvdeuHDBZRVS6xgHMSujqWl+ByKyB4AXmp3sy6DA4fU6bfMUNKm0WY
q8YjjgLVV22xTL6sICue8QSSrR4cde7Uq05heSCyt2yaUsw0Ww0CTYiyq6X3KZvr6ZXHNp+/
7k77B+c/pZd8PR6+PXZzDklWvX6waHF1RLwkqwygqG8C6p7dezN1G3sf2GNzlQKVg+zM6zai
utdctnjb5zfVIXRPpSqkIqbbRIXK4grcVmr6mBJt68Azv9K8/nQ89ep3SZ1rkpqA2NtZFVoe
fwoWZp82K2XOtmBSnMvgKZ+bQAEGyyVUdi61FWUxKCTo2C11WdRbqbwvxlIwbG3ez7lSkWwa
wOOxzrx8ywTVH4mVqPQ8pr2QVBqGf+zv3867rxC/5esvR/Xdz4bPdUkcUKHMJ/ATYr9vroi4
lxLrS4RGSStCWdUaW2vBtpujEguSNZ5leCzFMiOzxqahnenNAWprDjSZ2zu1cV2UUxRnyLxy
a0ruEme7dSsHm9zAffi4KMdpIaBlB55O6O8TeAKFZJEI5VzA//Cba/XPKN9TLDXPeHYTM0qz
oroPAE0jtMC5jBw344YEg3JCtFZuba0t1IswilVh3MLuEsYiVQPUADez3xzfTQPwrLbcB6eq
oQM7NG6OVllSuDj2QopSq97XSpUIqe3YI8hwesOn3M4RY9FrHfXqoDaB8zyU+r0BynE+3g/m
6Fnp/EMcJXrEM8BwYCI0Xq5tBE30MFJDQBmz2LxQiX0UMf35IngqxTsgKd2iFJfvCGurDx6P
z//ujnvn6bB72B/bhQZb5Y9hkc89kNIoX74K0a+qIfFpJtFW346SVUZv51Z0EYADrbo1Pbra
++rn291GoxfKD8vHCLWH0IUobyP9lGz09VRQvEkx70LlM81qANgTZRtNzAqH+G3s1RQqaWyl
x5kHEtN4QnplGHj5uSATrx1UwbieyVUwSgnrD9af0NWwqcbQpwjqRDghdXyB2nl7PwvIAKwM
l0ms1ZkOKHhTOz0oi9E0HqVUNaFWqbyULCKjDHLFGNJU2/2qwuR6Aks4iQh8KCLzkeYXUIgC
u2RiC8chqYRuVHL1IjUHE3P7fQYVdhfGgiE3ROUlZ3XnrpJg8/5yCFAkng0GJhUws+faoNRF
q/XVQk2E8qur5fWiz3g8uZr1oTGrlqGOM95QLMv7phVVSdCAl0H08XTfP3mOY85SDjU6n0ab
0cRv1RD588k8L/yECSuwsgLtxUWLAmOwnghYN72VFmB/Bufx6+mEz8z72Jo9RGGoubh2AmAG
EeMZ+EtwS/KFFu/pnAdlkofNNxgmhXwamyb2PAklPr++Gk1QZFc8wqPJ9ci8FzZQk5HmXCpR
C8DM5xaEG46Xy5Eu0hqj1nE9yu2dMuotpnP7zYvPx4srm9FBDgP5CZRZXjKtH021C0qRlkbk
8klBXnA/wJqT8iaVhZSJKQZPSvsd6BIOZzeZtUNb4Fw/rwpcdoltb2ZKPEX54mo577G7nnr5
QhdeA8/zme2uusITXxRX12GCeW4ZjfF4NJrZU1Zzz2UXff9jd3LIy+l8fHtWT2FO3yHkPTjn
4+7lJOkcKOL2zgMY4+Or/FM32v/HaJsdq1DU0y6FKU22bCg/naF8dIJkhSDlrkLzw+HfFxme
neeDfP7pfJL978fjHlY18bRGGZLNACRzmSSqGcpe5pNDoeT4H+e4f1LfUbE0yTcske7eKtL3
WGhH44X2Bpfh4srOrMdJBbFcjwBSlgp65LENMFoeiXx+k4D5yGeETRsXY+yMp9cz5xNkOfst
/P/dtndIvfCWpPao/S6TSsKvb+fB7ZA4ybSQpT6CNfm81YUSFgSycolkeqYpfImTjS1IrOze
TlGUNc4ashab11MkFEGhkq/LzEmtPDvtj0/ynudRNry/7e7NK4NqGJN19ruT/8Vu3yfAmw6+
g5VvcJ91aQ5XD+WQNb51WaeKsK17cE5YMjcvJ2pIgWKoA1Y2xFSLwy3UJxZaj7kpslCvgsna
Bk71J7wGuKBG/6LFQTESQSptq/UbIpk+QkIqLLw58UHrY6NOaZCC6jeiLTvVOtL1s4MqJlN7
yGvotvJxJ7M/WWmIKFRJUWS92W3XL9tCLHUtq1coVzaoLDhZyetlS7vnLfHhg3V3dyGOw8z2
Rr0h8d1r+zkhij327lZElroMsvwgt2kdn4/GY8tOpNXJsqyP2aJoDcc+Wo7GFoYJzxPkV5VR
f70tuuje23dJA07QwlaClDamnhUaHaoSIvNC2TfZIsj0ZsPDWeaF3Esx1vrHGlCWifKRNzET
TJ0C+Xx5ZU0zTKrl1XKpn3sPa3/rZpLZk1WDRiXLNLeZrEGXsSIhuUc009TxbjYZj8bTd5CT
azvSu73yBEXj2eg9/Go8HsQLwRPVEniXwCjFLXgjF+rjZ/UMVjHWNDDJB4KsKcvprMz82xiB
In3AKEQ04SHkCHZNxFgMTgCJc4TySuc/mAbn3nQ0GpB9kP1FBM/syBVjPsntuBA8PU7sOKgi
QF0GBhL51Sj7jvmC3y4X44HFZPHd4OnhtQgm48nyI1GA+7dzxxGzr0n5k2J7NdLdXp+gUyDr
BFDFjMdX1kLXIPP4fPCYKOXj8WwAhyMobAtKkiEC9cG+ekLzRRZBoTpwJCTGORkQDV0vxxP7
lAmOy16oXdhQhwVino8WgzIjK2b7To1Oo/5O1RN26yzqb0hGhuYQpEB0Op3ncvcfzPWe49z6
4mqZ58PuieZQkqXyOdjQbr3xdHllay309kPEZMhHwy6UQxg4LUBPRqP8HTdbUswG5aXQ849W
qaiW782wLAhhQ9E1pUD1wRycRPK+fmCdnPALvDgXY0grB3kIGny8jCwNICecDgcenl8t5gNW
KRK+mI+WA17yDovFZDJw0nd1xmyTHwtpFa6nQ7sjX/g8t3eYqjKHWC0ipaQfRBWwI28TOdQh
LJHUluspVDCaat3zClKpeHcBwdj+sL1C2uuHEjm1vTyrUOb3ERVsbliAqiLD3fFB9VTIn8yR
lbrRdTUsUn2UDd61ayhwCY+Im3BbD69Ep2irN3skqOrOwKg+NwDSzvebOhQo9Yr3JmRR4hUo
4Ul3Wp7FM6Jm7exslZQTtwOy+sCqz7J0qfqJbbu/ghUxn8+vLMtpCKKZ/qrRJvi2wWTpoJRF
//fdcXd/3h+1HnlrJ8LWkKyKC3lzZVwaqW9Z6sVuJPPYmDP9rVeSwDitM5NQUv8mg9GVkfAE
xcQrn6TY7VMSld9RLuvwoHczpFOaPwNgYDgJOmtSP6/hs1UHrF67saBLvfZ44VIt5CGeyOtp
CVcEJbK9z008KsOkjrc+mVBcXKEzaed1e5tv0eG2/ape2zKvgeWXTgmjmNpenDVkLppNxxam
MlUq0nilJUotDuLFdGKflmJuLdQ1Cv17uy0Y57cx4zaMFKUNvsZQQ8vb5vZ+EW/KBw3tNQHe
rO0iEB78T4aElwwOgXCrYsLPLtS4JtWAhZeab4NrHESRspx9ZypJQwASY6an8ho2zjZMMDPt
A/QGtiCr+9z+Wx3N+sR0epdMhkNaj7AX3uo3mD03o4WSSqppxoV6OVtepvcii1xEv/urJ5py
x6prCULR4owEl8/iOjD1ddWNOZ5med0ppW9P58fXp/0PWLacXD5Lt64AYodbentgGUU4XuEe
U4W3QcsJO+BIeLOpWRLUqMRD1/OZrYIyKX70uSYk9kQa9REpXtmmolHuJZFvPdF3hWOyqh5O
yF9zGFg1JD4ZbxrUwA09/X04Pp6/P586go5WTH776LkLTLzABkR6hOwwbiZrIqe8f7eeb0jy
eehP9BWWP4DifJVX9mUT3fn0fDidn346++ev+4eH/YPzZ0X1+fDy+R7k83tnM8q9d5Ytrsfd
o5Aw+UXrDS7098n2SCfp85zYf4pCGYhHy77DwFlI/JrFqGNWqUe5cE2gB6dm0Wsf/R9l19Yc
t62k3/dXzNOWU6eyIcH7Qx44JGeGETmkCM6I8gtLx5EdVWTJJcm18f76RQO84NIY+VQlZU1/
TVwbjQbQaJyZoJUasYDQB9zLR111aSCvpzpOJXQ5gdKaKC/3ZdZUlm1v4Ch2tWXnnKN1ccZM
P8DMCvKhPkfy+kNz9hXysj9Uqbr1z5V1bYwzmEmr1qZgOUfTeuoKRQL/+OhHsaPmclXUbNRq
o7wP2TJHp0UhcTXaOfQHg3GgKmGyX1RiA/2qMTZwGKbVuLnB5jRA2HiVe1hGaiZ+Rkrt0dYs
7aDJLyMsoqWkIdwlMtQ2ZHBXltoEQ72M+K7W5PQw1kwxVZpc07LuC/37stNUFe3130xUdz5G
jPQmoP3JdpWIw7fH6xMzDO3jgns/WSrPsXHb1kbLn45lC0HVLB/O8KjVFFyb095opptaawHh
e6HRqk4vxVC1iXVkdFnazQq7+IeZHnDfiwG/scmGKe27P+++cXtEv0fGpWVyhJo+b97+ErPc
9K2k9NXvpglTn3TQCcboR/ScByBTI06TAffE0DUpeANONqiqIjkC06JVFgSL1UtBsr+WLGUH
viw/UqCMNYTdk1RffoOSFZsYbOE5VpREmr5RfJfLUTPahc8DMz3ru1fo02y9VIYccEMCYqsA
W9wC2CWeP6jlSPtDlChFB+/BNE9HL3IcnZfN1yeadr32wVDyf5l9qETxBBqbdUnsBeoHEzE9
DQZz6A2K345EHg/Utss0cY3XGoMMl/02VWMKcfKphzVmhW4IwDKGmexacClOrloauS6+vya6
fJ7bLQkXbYJUdUcrNmteqiZwMNWX22sKXpsj3TGt5MlTGUDHoR13VTGoHkUMUG0BoLApnf27
K/USsnndWraqjpyxqlo7QxvHvjt2PWakzbXLjfHDl9fw1y7TiyPmf2uGwhSwZFZD7CzlPhM0
ETMBxtZoIGb19OU191dU6E3GIxtqRGYdEF9v/L7k8qmLEjDD3VjMx57jXSmvgoHUlpm6rb0Q
R3ptEwtmKRC9SMxavlIDlHKqUXtmG4RGfWjmxiUNHaKRmclAy2anU/V6wxVm1DyZwIN29srJ
5a4820aUmDzqnoAFp1SItl1uZM9o4IJjFR1umFxAQRYwHwSOwtapkeNFm4UL5FDi5jIXn2HA
nQkAHJi1V9tRbnZYysqMDb2kQ18cacr+4d6E+GcfWW1QeQagbse9rovVeao273HwiU5afZsO
ftBE6zYG8Lcvz2/Pn54fpxnyVWVm/yv7IHwgN00L1xxEAGhNvvqqCMmAnRUsAqZJFpc5fh1R
F1WOTEG+GL3vGmx5wOeK22NaqzFvaVtjQ+NApYHJfii7QuKYgpbS3fPXObICJz8+gBOqFFmA
JQB7RWuSbav4ELKf1ivTx77l7FO+7M85A8xTElLKKn4584rv0SIpSjyrnWpi01S15DpFUH9+
kTMWaN9OgSg0oHjiN9Pawy2EkgY/xmPRQ7xxCCrAe5P2aQ2X8Ddvz6yI9xtmKDPLegmvwFN9
/R/Z2dfMbCn7tDv1QyLUsukDDOyvlTDfTV4BaWuXx/MTSaLDa8L0IaahddYSjzqxutFooMpU
rKPKFYkJg1kmwOdjmSXCtNHMAEFJdpmZr6ALAcDA3eloQ+E7vheCQ12cRl7q28HId9DaLjC2
yWJyeZcTwaYTkyu4VMzIuYSm7uUCbPEDVpMxw5fmJmPxkylGeOw4kw+fAw2+BFPiJtfl9kjw
+d/kw8NpmXw/1cFJcKkPk+CdMlvCtSGMP9k1SYj5g5hs0eUhksQ/1yXJO8kk75VGxHa0JWIG
YbQxJXgvQMSz1FrGC7EGDbb3dIaIlncxJzz6nc5mCZKnswWYa53OFFvUjwhRZ8MGbzYU6vs/
H+76+7833x6ePr29PEobTkvBCgiizVZn+AGNLQFjmoLTttQsUUb9qHKRanAAqx8HEmnuWANz
TAG5+M65HH+V/Wa2hUHg19PgrvH0LkngEp2j7K7VJZmY8tV5jefHA0xrNCOSPqfW6RB5znoA
OMd2+/bt/s8NcJjbfvy7eXdodeLgh4HI5oeM5zdpu8XLJV+1keGyafUib+OQRoNObbN4GAzq
YFR4UO+yc4+VAVvLcIjvqWqNWzbSepeTBqjESLdGytb1FUc/6sVlltm4yw7yPaULPbKczHHq
/T/fmL2K9FTeBkEcG30leh7TvCtMBuMzftTqWavE4cjR2qfNdnEQ6a3Wt2VGYtcx8uipn+hb
/NKWrFZdIbi7/J1m6MqPyhkfp25zVlq3vjlrdP1AaWoSVW0s7RSFgV5j4d8Xh2bdAEhcTMML
/LoekM9u6jhJ8OuJSNWXVfDFJmFF99zE1btFCIarUzPPi2OjY0vaUH2ADB3cBvDkMwGkLGrv
7PddseeBsrVsmwyirUjNcWMxTnhUrvSM398VaFfQAnesEjiEt65wB5HDTa368aweIYeiqy1n
07NPlbGjwXczPn9n0xRE/5vc1AxNy3pWc64BivC+27fCpVgClF34pQyAbLM6SBz04IjD0ihQ
vkuHljiDxZ8WGJYhoXwmqO9+pnrO8souE7CSHid7mHW3oDH+EWrsryjRP8rTxAmI1Wd1Zglx
83+BMWfuCXQDR29l4eo1Vm2KRzGCBstcb1APBSSyXl6EQ1nMc6AloXylh9MWV3W9QwcSMK2s
XUiah0YPx4e0zDxVTstrGpJBzWHRq0rycdzWMToVrWigFTUdXD+IIoM6K2NNIIEeY7e2Vjjx
jMTixImMtPrQC21lBTAxPymOO+JqHo+rTfuROzDhZyNcVi+iXdFjwZIBYtNuwIRRqtdMGRXl
sVCnHTQlfdb4g1VzdH3geFq70dKPQv2mAQeubmPWaUSjZrAtz7JR9znT7RA4Dk/FkjfTg2E5
tp3sDcnptzST48MBTbntgQh41XqJJfT19HmFhqSG2dx1AtmNn0/8ymU3w9WfJ4kYCHNWbRyh
FtbyXeISJDVGNcf5ghjK9qZySeQh/VTVXuB5RsG4YWIp1Wxd/UCI+u0oGbIrLq6gia+meFMH
rmMobaC6thHJDafI/IRR8Y2lCfbcS2pVmGN6rWh/48eWo1+B1x5h3Wvb5155pkfqvmrIzpgB
rg5pDte/Mkw6O/F+4eocIXsy2qyP5eNif6rUp0sWku63sAI7Hrjy3FR9KruErgznsutPacX9
5E91gaYOlwZEiL6FC0mJzQv7OBwwKM0DL4lR5Mj+aTEEWQpI9U0Toi5UNAw7SZZaJT0GXhAE
WNIcUyzrFVOX9iu9pFXiOWhyDApJ5KZ4WUHPRZa7MioTtkCRWeJIXRyqWIAZaxJLn3lBnGDl
ByiMQgyS5nwkW0ADy1MIChe3EN5ni0M/uVgJzhOi/YaYDhoYXG5fySKxVSImmDKWmCbLT9Xv
Kh7Fng2KE4JCbRwHaMcBgo9GMIpc11IVhlne/VCZAlxbq0wJtk+5srTbMqVYCWHXwg/QrpRs
KCTTdnf6WOBB0CWmMxveuKBwKLYoFg6iKxiJ56bG0uU+nl1bH6wgrXNgsOOt+nacBp/odjwb
fnMGr7APL9YA7D/PxbOaLcZ3cqHVPtBjyGNsfGrdNg042F0uE+c8d8VOCauoM7Q3naXcwhAY
zzV6y0liZPVzwhTrBQbFxEcHFIeiIwYxcy9wQ9UHSEG5uXqxTMBEPFxehdVKUK0h2bmWrMHe
faePOJtrca/R2Fjr/Awbvtm2Mi22HC7pVbott8rObpcZy5LVJivyMh2zIpvfSsPMPM4zv6X2
Vf94AqZA3Bdyoadt3p35LRMRFdfcZoITkdnAgzcd5M0lUdK05jsx+sNuAhVxi8b+bGOAWwg9
xKu1cnRpzm+MoiDNOxs0HwfYcB7ic8XUQyC1ylJTfHp+uUdjlZV50Yx4RKmpoYSjTqWEJz1v
1wvRSv5KPkr+9scf9HwgebNmSAoiOO7Dl4e3u8dNfzZThnLCw0hsqdDCa4y/u6EMTV5GY10e
G/mdcI4VcC2KinfMx6qhdBSRrFa/E8YFUbbtj1IgRZOlU9/1PPvV2vsifKtUKNFTiPMtlEP/
DHOrYiKHpK7Lj3zEIkh3T58eHh/vXn4g+7RisPR9ys9upI9gBZkKv3v1waEhJ2xyF05e3Rlt
NiQFbQicjsXi8J99f317/vrwf/fQzG/fn7QMpS/gjkZbXVJfgq3PUzcmAbqwVtlikkizhQEq
Wx9GBpFrRZM4jixgkQZKrBgTtHxZ98TRNlI1FN/c05k8a/IkDC8k73r48ktmu+5dx/LIocw2
ZMQh2H15lWmKK2NJwsff3lFKPVQsjYBaaszRCJnIJjzzfRqjoVMVtnQgbhjYUhGy4r5X213m
KJHNDIzYMuDoe4WcSmFNpI7jjoasRfFTJiWpU5o4aFggdagSN7BIctknbIVnK0oXE8dufCxd
5zkuv5yFy2Ht5i5rF9SHzWDcOnP4mPkKNKKSZF31er9hSnuze2FTGvtkcUnl21Ovb3dPf8Lj
ZR9e797uHx8f3u5/2XyWWCW1T/utw2w4uRoTOcTXZgI9s8XVP+ZHjGwZfBMeuq7zjz1VBksS
yOdeNkRkH3lOi+Ocei4/JsVq/Yk7ov5rA89G3b++vTzcPar1V0qVdwN2SwCgWctmJM/VIoBw
qSOOF+wYxz66/bOiS6EZ6Vf6M12UDcRXQsAtRDVQDc+j9ywhWwD9WLE+9fB1xIrjzoC81sHB
9cklqSBxrDUUEyQlONfCmSQGMXTVjcJV1mx5wiTpxEYzQMc5thXT/B0JMRUC6Lmg7iCfafFP
Js2Ru9qksIKipzBNuOY56KmmMND09ERK2C7VikaYRJjtxyTVcpeH50/ZRGhrXTbKjL4DF6LU
DbVa8Pbm5sgi2/3mg3UAyuVrmaVilhqo2Fp7qimJ9HIJItFkCgRWXdFPQx5z4waoCv0odnF5
8m0FOg69KeRsKAZGzjDCvMAmIXm5hQavt0aBJwDbEZnwCHC1BBO1NaiJUdipgtrgTXeJEtgS
aEWGiCsMUi/EdhBF1zCLnTidKeSM7rvohhLgXV+R2NNKKoh6P4M6jo3Gzl02R8M6rMFDEy+F
UL1oFxHOprnkwuwBqiK2DiDRrMQiT8QmB0I/RvNoSiHM3ocjWw//tUm/wqsVd0+/XbFl8t3T
pl+H2G8Zn/fy/mwdbExQIZSdXpymC1z8HGZGXb3Ft1ntBaa2rvZ573mObaBMsDFxTvQQD0Qh
OFgPXzAtYKBb3kDnknyKA0JG1ja2JocE3EWBlTT/eQ2WENcYYjGuOIlDlSxUA+C//6N8+wwc
bgwVw80MXz0EV7Y5pLQ3z0+PPyb78re2qtQMWjlk8zrLsdoxXa8rkBXiC1rhRldk86bLHMoH
Hq0Spo+aF1PJXjLc/mFIxnF7INiJ2AJqZgSjtXp/cJomwHDY55uSyMno5dYV1TQirOE1UrWn
8b5CxJyRUYcQnk6/ZZatru+YqgjD4B+t8AMJnOCsCRisoIghd6DEPa18h6Y7US/VGGnW9KTQ
OIuq4HGx/mt6kPfr85N4kRUC1G8+FMfAIcT9Rd5cQ5zPZ03rJNjBoJjxCbIAMtY54gWJ5+fH
V7hFxoTq/vH52+bp/n8vGPj8PZUd/qCAbYNKPIL1cvftr4dPWJyfehjL9nRefECEou5qJTLe
/ISwRBaPVb3cfb3f/Pv7588QdMAMpbfDojvUdcvGlxrXZKZJW5+WL9v0WFRj3zaH8z6VN+3Q
sohXkO4+/f348OWvN6aXqiy3vqnAsDGrUkqnCHOrAAFS+Ts20/mkdzwNqCmbyPc7dQxypD97
gXONqWqAy6pMiOwdNxM9+SUZIPZ5Q/xapZ33e8JMwtRXyVisIKCnNfXCZLd3MFt8qkbguFc7
x9M/PQyxh97+ALCBUzASSEMQ7s9W/MklpTF/mLjpZLRi7Q1+Y3nl4CczN1WBWcArV5rDmbSD
Z8LBCJ+NpaJMx78X82F1CT0nxfPhIKYwJJY2DoIB/xw7AjWYVD8RKeFzQJyoavGktzlbtUXv
NEDaZUN2xEIYrjyTn5E8It8bd8sLZrp2Wvbpm9NRjZF6NC+GH8ocO80Bss7Ko9Lg7CJ+FR70
zfhsCT4qEecyw6F4c8jKsSr7virG4piX6VE+pACOCweDtXRbhf0QN9HnA4U6+43m7L+y2Rye
X9/wmC/Sx7OPlqRoRXiq8YC6GTN031T5rqSS1wAvRQ1Xe1Q/dEam+aE0KeB+CW/XZQjEo3Ye
IZKqgec3+m+mzfpdbVC31anYlUWV6zVjmHCkxrdeBceh9KIkzs7E4iwwsV1ZXEFrEfeqzkrs
wTmAD/RabTwjzE1d1OKZGIOy9Jh0FYu+PXz6Gztxmj45Hfnjz10BbnLYp++KyrG4EY8HLS0N
v4T+VmaDhQoPo9IDNiesLBB6WMSnk6YogLc8ZvsRnsQ+3ECQgeO+WB7ABIWOGF78w7QrC/yW
BYf5fIItYVeUGNURk9CFj5ihrJVfOCxpRHEpykx/onP9bC+6jiplAMdkX8sOiIElN9S5Y4FD
9cCA0/M0c4lPnRhboYgvb2rjq8VLwl6vbU5iB9/IFU1pBr5XGfosBY8SW7H6KgsSV95YF8ka
N7KWvpaXIJzYwFbCbPmu0scXeP9+fHj6+wNbFTClven2281kbnyH+0sb+u3+Eyw+YR5YwmGy
H2N/KI/7+hdDfrdVebzCwuiKQleDCEkqE8EP1mh44YsO4V1tN5IEG+Lqs9Syf3n48kXRAuIb
Njb383k4AoyG4zLO1rDhfWjwMzCF8VCkXb8t0p9gXayN91mz9vQ+E7wify57/LaXwnl58M5c
eSHCY6p9wlv84Rt/75ot9kSzr0J0vH/7/ADP88HK8/PDl80H6J23u5cv92+/4J0Dr8EeKcQ7
0RT2Unvu0WOKzQS3EGL8/eq0KUQ/w8w+tRVPuXpjJM3gzepyy5YyaCj1rs9G5fozEMRcI3tY
MeIh6xtmS+AeXn3GA+gwY8uK28LTAHac4mLz7uExx9DX6oCV2Sw7cZ/amhNn0ePLmhy29+x4
YbszN/ZQsxUKaFgA81fpdht8LKjqn7pgRfMRdWJeGIZY3UmdkSn67YVvc+p68ksfKn3MmISe
ulu1o2c88tHvwoiYdHgGNJH3gyRgcrI2AX7by0Q6GmReRLAKl7RyiYP5F6gcBCnihCAZDowe
mGR+H5qgfcYh/AahwuLJHigKYgViNMPad/vY4jo7C8O1R7Dj5RmnzIpKnNTMdld7rod0XcfE
TrtOsSJBbLmgIH2s7qYaLEXtOQRf2S6pnD3NeQZhiTW/FYOFBtiMvqA5Gwnx71JUsotDGXoi
QTqP031dPy5jzeIrK7OgtzEkBh+VDI5cbkVgwT3U5dHrhqYa6BLlKcG1c/1APbpckRC/5aUM
bvn0T9UgyLhlo4K4xDNLUWdtlGjjlscZP+bTPbqlRyFG2LtKOqee9tyQWoSfENUkI8bk0D7e
vTFL9et7mbsEU4aMHrhoUwOCnu/KujoOxl1al9WtRTDD+PIY5Sz4YZfEEhF0WSJz+OrdbxmK
3/8YEYucEt9Bxxvtr9yoTy/NErUf9zEi70D3kKkA6EGC8NM6JD4qM9trX1tX6QLTBpnjYhUA
Sbqs68V13EtKrS3kwICSIM/3ZLhsPj/9Cna4KpmmhULrhKAOl0tn6KH1F2AOgG+2HcSK3fX1
mFZpV2PNYHuVRcHHM/tpJk7lANDLhDPH7NWZDybt3PmuHKhmphsBepYPemYROEhJTsehNMn9
4CceJlFnrClETGcvvtTlu579pdxpnpGsOYB3hYeqEdrX+LX1Vc3yK2oXcq7azCO8sUzNadxL
RyxqLdK7WYJmSNGt2IWhJ/DModmYxkX/FYlCcnlO5uGCLg2x6T0hfVj3uesmw7xugZ0Hev/0
+vyijTJxUF6n29NOuguwbqTfHjO4XIKV4CQ+k+4A8N+snc7FeGz6cndrYLSodrB2oQbClvet
hTrFP5WPDLQSz1+lpwFOB6tUyvmQ+9MjEEutrigTUEwxQ7jqlGZlCUdWqwRPgUTFmaIU2Isf
Mc5RRh2N3DXQbr8Ha7YCENuYoDZousfaFYKpwonZthrhLS1JnGUE386ROGwbr6ISX7Xc5Gzg
2jV2K0JhgHg7xRHfPDnnLRYk63xoaM+/kq5ocFrWwWURcQQyVsU+zW6X/emHTy/Pr8+f3zaH
H9/uX349b758v399U85m5qPtd1jnPPddcau8zUb7dF+qUd2zBnyWzSV22Wxe3+6+PDx9+X/W
rqW5cSRH3/dXOPo0G9E9LVLU6zAHiqQktkmKZlIuVV0Ubltd5Rjb8voR0zW/foHMJAUkka6e
jT3ZApAP5hOZCXxwJ1F8e3t8OL6cHo+uA0cMYzKYhqJZu+VFI2oL4GRlsn+6eTh91TYA1qzl
9vQE5XO8YowWTW0V4Xc4H9GZ82E+tKSO/fv9L3f3L0fj/y+X2c7GvFBN4CgSHbEDeODV+VFh
pjlvnm9uQewJvbU87UAafRZ4XLeBNYscU9nOCuOHRVjLIqxjb2Ckvj+9fTu+3rNGWcy5Fq8p
MiqXNztdWHV8+9fp5Z+6qb7/+/jy80X++Hy803VMxP6YLMYMUesv5mCH8RsM6wuEQ/76/UKP
QBzseUILyGbzScQ/TpO8odA6vi8Cmr9Uc+12fD094F37X+j2EI4wrk2+LeVH2fQPucIsJ3ui
WS2MU8NghYif7l5O93fMHMaSzlms1QFB0TGcm9hcuyqHPU/B1iIsGXb50sHgWISTjrHKmxJj
RtAO6niDa3GXT4M6nokG7Zxgt1kOxhkdEK/zZcPBQPoqN3m6zlIEyB6W4gIKdXQZGqzjMqf2
jqhSOSsfVlfHR0ROaUuu82jcY4+ub17/eXyT7J4cTpdaP0Fj9gZG/vxEjNA1sPMdMnnSJBvo
3nNUL89jdVYUcbXd92JC9XVw1v02mBFUUoM7WpA+hR8YtRQ6G1H0uKDZk7n85hM0Z1Vs9bg4
21P0VG0/INSGSKBpjpShEwaKMpwgDJTlhlroRFRWHnb2WGTWCo2wrk7vLxKSnn64AtXrXDFD
AY1umbHmUk1yKEseodq+4X/w/NWFkBuKdLqvOcYaPlGJu0Nsz+izTD8d4nrpzXDVtmUDKu8w
Yb6vo/3+g8rq0+3Um/P2UzHMtEmFbzsvnxqS0M83YbV8BZrz7bDMLmasP197ffCBhO3R1KCJ
IViYBJTU4dYO6xC3oHLPPmrMvfJ+WN3kZRwKHwbju8k+yBQNZdaNASyqvdnbb6tzhY7H1ALM
ctr8MA7ZTLaMqpYXHsvucKr8ZZYs+HOsyyqZn/aZdphGGMCSNmpj4/Gii8xIhqAGmetZqY+J
eSI9PuhQsfDxPGdNVPIO3H1dXMJ4XXutDLvbI3/3bPdVDPtkLfT8eVy0l96O0xFmnJUAzaas
ZZhCI6O2JCcq/K3bKynZ5/b0st35IDOqTEFl4UQm7SJ9Bqa4PlnWd1Ar7662Lfvwdh8JOfDK
53V+PsZpXzbyM0zPDmQXOMv3PPab6qOJM7Zs0n64PCi0wRTjUbcJjLCArE5d9+awyyMaN45A
GOD0OCZuRX3COC+WW3ajhZUsgSbdCNkwTJpPJpeJ+66JRPnQVrFxrUNsS1+Du1SdJk5mOFKT
Mr1yyAZesVTrJYW71kO3ZCRdKhSY9A/qx8fT2/H55XTLrn57hX3ANameH1+/Cq8YNVSBXDzi
T1PkGg1q/ByLbnSeCS5fyYGwiZwqWWBDXkPzArRNLv6mTGDc7ZMOCfzfF69oGvTH/a0Uig83
17o8pKBH5RVbhM1J4xFOzpBSncRrc3MvncTVdSyacBp2cQn/xWrHDDY1aw2zYZvYqEBOrmXP
k09zQs1MleFzj3dOjbvRsu1j/p7HrgnxjuqrDc1MtvOepSo4n0gT0ojUYXxO3dVwWJHzNMZ4
wlCZPOW7hSWr1TD49vLldHN3e3r09QWmE6wkzhbQUnpz+N/Xv65ejsfX25uH48XV6SW/GhTS
nfJ/IGrsi/5e7v3tD6vLnN2zDsTNLRhojX/+6ftYq1NelWuPwmL4VS07qAiZn0FSMGKDWPtu
YeJLFYzQJk5W3LIZ6CqpHXMhwixL4A1gXtySdZ2u3m8eoNu8/W5WkKzKD0o6Vhq2WpKHGQMj
VSQMdbZHaPPlAbw6dVZZZcyWOMnBcesF8VKjzQbidVgPhNUgV7tKcMFPSaXUYN6JDcbnidVC
Ptrg1g27Fu/p8mLJcrcKnaTebG1I33DUYZIeku2uZihOvdBYEmIleZShnT5cmPVlsI7s7x/u
n9yJZROa8BCH62RHx6aQgtb1S8vAXP/aFtQfSUq8sVg12VW3W9ufF+sTCD6daPUs67DeXlvQ
oMO2SrMyriiSBBGqswavK+KK+vwwAcTZV05QairQQ79KZ2iaUaxUfp25HzGwbsejhsVXt7c1
+tvppgMSqIERtnSU69vtkF0z40tG7sqqtkk9bCImUtegcntE+tGfrhgIY7ZvE/HhGqb7lhrb
pSkbu8s2OBQhzFwx0KA+7a3KJDxkSxre056TqFOKqfskQjfkkqE6269SzVZSqnJ6Os0x8MZu
taKT8Ew7JEuRnJaxj+6GFyZc9DEYIA0j/3KVr7QUJ1vDVlAxpBqaf2loHZJmIKpLVTgpepGQ
iqhPA2dDSz7nKD9DdUPXPkIRT+GOtKCkfTGOJgOCi8vdkWXUa82dhYMEs0G0BIfLEMmXZRxQ
qGP4HYb8dzQa/B7kgTT2ErUsk2Ay0tbHhUx18yAcJ5xsGodiQLI0HjNgnzJu0hGD+jIk0TkY
OdSAQnd0ayswjve58vDQ7OwjPiLIOfzLvUoZGJImeC/KDVe+kb/cJ79dBgw/o0zGIbXpLMt4
Fk3ILbQlOFD0lsjCRiKRISgDYR5xzxYgLSYTD2aa5nl8tTS0mWyCBrxpOJF5KonHMiSaai/n
Ywq8j4RlPPl/e+aFPXZdxrAmgA5CzkvpbLQIGjZ/ZwFFxsffLAZZOnMw6JCykPAANIMB6muK
ZEcBjGg2ZaVMR4Pfh3yFuO113MRFQQ0rGJuNAny6nU6dOsym84OnwrP5iCfmsRo1RX6WnzE8
Qfi9oMaf+Dta8N+LPZVfRNMZ5ZsA9044CX2olCOlmPNmXMaTNLTJuvUowSuUBo/LlJwgTs0o
4EQTRKYPAMRuonX0Frf0841ZPo/EMDqb/Swgxrh5hQHBeYyQvMIzT+IQy/0s5bWzFltcrmiT
MKJAj5ownziEBRlOhkCh7+J9MAp5JAcgBTLCm2HNefIwYnZqSBrLsXri/WLKcASTehyO2K0d
kiIxUiNyFgMUwja71DHpZzM0aWJtZmLx8Car4h0MdLLa6PDzTpdjdLrD+nOz9Xa5ja4ij0dt
yunmadTBdKXS0g9zTIU8eUtRqlo9W0bzQKBRi7eOFqkRhUEx5CAMxnNXNhjNVTBiO0cnPVcj
0X3e8qeBmobTQULILZCmimHaUKw0SVsk0SSS1ix7ytt3Df2fWu1o4JCLzEEFQS2gyWC7ci/f
efYksb1hfH6Ak6Gz9czHUzL3NmUShRNmYXROZerw7fh4f4t2LdoAkeaFD2aHenNQWaW2zH3R
sLIvW8uTbqjLbMr1Q/zt6m6a5mhtSaLmgawm5PGVJ4xQXarZaET2AJWk49E5Xgqj+uxgDBfO
rbknChx+bd4gfrJa16KPsqoVVamuv8wXezpUBs1tDEDv7zoDULRuMbg29PZQFqBqZKlsXyjb
xuZWW9Vduj5Tqnuquk9l3FBd5bQX2OyW9DuGGTs6La+MzGPKg8OzPcehok4XN2YuyGrXZDSN
6C4/Qez77/Q3HZHwOwoD/jtylC2gSIcAYEwWIbqyqowVgFSuwgBpLM0P5HDXBKBMw6jxHsIm
0zlT0vC3bUKWx2L6gaHXZObRljVLfr5DlieQtGZJkZaRMRu5bTFb+LKZjT0GmPM5939IVRSF
UomgZgRT2t+od0wpUFw5Dcfsd7yfUNhK2O2jWTjhhEXIzgl6s6SQFz1psNbATgLk0Tz0OOQb
/mQy4/si0GbseGpp04AhUn04J3pr2Lv3x8cORcrdcuw9oMajku/63QwsWtTxf96PT7ffe0vI
f6PHfJoqC9lGjHjWaDJ483Z6+TW9R4i339/RdJTZYXbOk+zF1ZPOuEp9u3k9/lKA2PHuojid
ni/+BuUiLF1Xr1dSL1rWClRmNv+BMAvo5vif5n1GrfqwTdgi9vX7y+n19vR8hMbudlwyEfDS
ZyTeWhie8cJ0EgQeFF17hyS65cTpvlERjUO/LNfBdPDb3bI1ja3cq32sQgSQTCQaT0/o/AKh
3o1HtHcsQdw/tJ4sX6Volv+mRbOFi5a8XY/D0UiaYMP+Mlv28ebh7RvRmjrqy9tFc/N2vChP
T/dvXKFaZVHEo9YbkrScYUjfUUBv0CyFrQJieYRJq2gq+P54f3f/9p0Mvq4qZTgOyOKXblru
U7hB3VzE0ty0KgzJqdP85l1naazTN+2Og5GqfOa76UGW6/DWfaf7TWb5gyXkDXE9Ho83r+8v
x8cjaM/v0EbChIvEk6flTdmaoUmzyXAORh7X62WZ21n0EVve9Ff7rZozbOGO4l759nQ5o8ty
T2Ms5NX1IU/KCFYGMt8p1Zl3lMO1NuDAVJ3qqcqeBijDzatjSApgocppqvaDqWvp4oLQ8dhN
sptuzM5sHwwPmgH2rYa5eJSo56cFA8iiYdKGMyv9LT0otqfH6Q7vQOjIQgB/vrQXoK2MZIOr
uE7VQo75rlkLOmiXm2DGI+kiRdxjElBmgjmpKBK4pwRQxiJUMDCm0wmLNh7G9YjefBgKfNRo
RAyIdXjhAL6XoVT1BwhVhIuRGC+Ci4QMcVnTAhGr9TcVByG9/m3qZjShR4Eu4x7asFcpmwl9
oymuoc+ihNUblunIF4rDsMiLTrWNAxb+cVu30K1sUayhtuFo7ISYIAtjEIjIV8igj0WqvRyP
+RCD6bG7zpXYSm2ixlFAzlOaQHE9ulZqoakZVoUmzB3CjCYFQjQZk5bcqUkwD8lj9HVSFZED
bW9o4r3ndVYW0xE7emsKx3K/LqaBOO6/QLuHoW13u0Lw2WysXG6+Ph3fzJOAMM8v54sZvd2/
HC3Y7aF9qyrjdSUS3UWdsjwRbOP1mAVjKMtkPDEOa3wZ1JnISlFX9EdsQWfqun9TJpN5NPYy
+IrtMtmS3TGbcsxUH053m8nh+ryYxM77rz5gx/PD8U92YNC3Kjt2e8MErZZx+3D/NBgRZJsR
+FqgQ+66+OXCxAp5OD0deembxpr0Ss/SGoKx2dWtzGYRinsRukD2QkxEvnfDt3H0TUJfox9K
aowlWcq2ivztdg99Ap1Wg3HcPH19f4D/n0+v99rlcDDj9M4RHeqt4hP3x1mwI9nz6Q12/3vR
OXQSyhFUFCwkPLJ2vJ9EnnCHmjcXQwRpDnmLwjuHEXvuAELA3fKRNBmL2aGwo0e0dYHHBrEj
PC0gtg701BvFmSvrRR97xJOdSWKO7S/HV9SzxFPvsh5NR6Vk97Us65BfI+Nv90yqaWwlSYsN
rP7UuKlWY7pQbmrefXlSY8OJ23ZdBPRkZH47r+KGxkOz18XYJDz3nJpMPXfbyBpLCIl2Ga6b
TKmBtqypok5sOM79YDuJxHu2TR2OpmxR/VLHoPjJfriDvjxrv0/olTncGdV4MZ4MNlcmbEfJ
6c/7RzzL4ey901GUbo/CxEftbsL1pCJP4wYBe7PDtWcaLoNQdEKr0b/8rA6u0AWZP0GpZiUe
09V+4epUe6iY+DQAWZB5jcrMmB0BrovJuBjtXSfsH7TJ/8EFV8R5Mr65I+aO/oNszT52fHzG
yzrP3NZL9CiGXSorJTNwvKVdzMnDDayIeXloN1lTbo3xJptAxX4xmgbijYlm8cNKW8IBRL4b
0ywZrqmFHcyjbWtWKIGV4/VMMJ9MaddJbdOPuU/EVBd+mG2TkzoYYULq/BPPw8ZSOTaxJmZN
kVdOcmPnzgU7pzlOtUg4LPkmX163nJSX+4AnBEo4G5BgH3I+2A4NdtYBclEnwXwPh/lEcoW2
EhpLhhWBxuE2IAGl2gd7XrIG0J07zVXvB1XBV3lxGGimdchy/JaohDX+dPrZWGPywrXnrFO6
z2W250FD8Ky18TNd7zUxzxLR1dcyN81gKFqcIlbDLz1cTd5cXdx+u3+WENjj4rDKJSuCMk7R
0QnSnovqWhBU2QQ5dc4g1nt2cyXH3jbs5kscaBm20alojieF5kpWU60NTJvsvDJd/pu5qaFQ
hexLVavDOmdFQ34IEVBvcoRVzdNM9mHUMTuaK9VmomehZlctHkAcm11dQLItl3lFlX5Qzas1
uv/UyQY2tISu44Me60up4+QSDabp2APFIWs9MTzMLr35fKHef3/VpurnTdnCXmn8ADoGN59x
fZrCYoKo+ZKbRO90DfxQSr/Jp3A8R7Y0jrXAeDrVAmTUajqsdrq1GKqBZSGQfbXVpXIerAWH
cF7Bgqcojhdj6VQDFtbAqXxZ1mO36kxAu2RgQIGN0ll7vrEX4xC7yGpi7Qjnbx9jX5RVuiJj
/rFnD40kzzjLjrgyh+O/jtfsFtyZlmNjeIrGR300T4JDzAhzcvvhzI86/nfOx6UOCoAfTl/o
9S5YwAkw3PFM03huhts5gQ6YYEe1O8baHKZMnckGqJgfnraLQ1aW8i0+iljjoC+fqysXLa3T
5Ni86auLnhSwQhPdPi0yKPG3LGE+wmWyHE7F4wviRmqN8NG8AEngSx+JkYkfC36MBDGlW+Or
tNl6omz0aCrdsSsm23QH1kx/umqPIerVLx/IIhmUwrZ28ux1hiyrGegK52JCJ0c0tTQ5Ok5o
2WqnZIs5PQ2vVrXsH9FPJp0B2846DpQmZmxqhGuhrpGQuW0xPSEQfYQ0UL/jmHKdFrheTWHy
dU13/tDOX3TwtbzA6hpDFaxrihZpIsUMWtyaKTq10M7GHc08RH66eHu5udUnQDeEE3wgvbYu
Edyj3aK1TZ5IDPQLZ1GrkSXYNRCu2u6aJNO+HVuPzzsR86Dbd++Pw0/p6og4QuTxDn4dynWD
zl8fcw5xwN6GtJN43cB+3UX4chN2MorfQfR8XJZ81bErl5ywjJPNfhsKXIMXNKjmqsmyL9mA
awupEWC/c8rj+TXZOt9WtB81OV1Jvk7sw8q6+7Tzip5J41kHM4Gi97pw9/JXdNTeoc3terYI
JdA8y1VBNGKvT0j3RhtAJgLTyLfUQnX6nQJWhposYSpnbv7w69BDNVGjxyIvgS4pmXiHDP9X
ZqcRqLjkkqslhzMvy4+YrC+HbMk7j0nplXarYAFnRhMwelBKvtA00alS6ge8un+A47fedFnX
Xsd4ZdRmh5VCNwclo/MovF7OoZuTgmriCO9B962OclgadKWa6WgINnlARi56t64QXjFpPtct
ToDvhHwNGnXLVJWe6I2LcJZY7nIY7xW6o1RxuwPFnmbeo4CejesMSewXzTGBTGhtYm+Sq92W
er/UDfStIR4+xU3lQDoahu+TDLeFleWc4dWqbA/XgUsgOrlOlbTUd2XXblcqOtCeMzRGwo0K
CedncLNznYeOwdhcSZNqC41fxJ9ZhmcarHJp3uDohj8fC8TFpxh2thUcwrafRNG8SrO9yCkz
+PJt3QN1Jje3347kAnWlEljXMz6wNEk7m8su2p0EHqq2oHn7UHeMlH94Gv52iQruochVS8+q
tqZGu309vt+dLv6ACXyev/142iasjTXhunTNMAnZOmmiaiBrYFoWtAnHvZbzQYcr0iaTnHcv
s6aiVXJ0WwSwO2xivDFYx1WLR+V4TUHL9J9uLJ6V92Er9PtPrgwCsAHhpSOuQSBbZ1xneo1h
I7snWcxbMy27CkEfsyaGfqfah/mNEXMKXEdhuTavFK5A8WX7ETP6kLlJKPvcF0ZgHoU9WzqA
Gqkvqk3PuTjf42e4H9bFBmLja/iJnZg8hoZf/RflSUP8lRTsm6UEciP03/jT3fGPh5u3408D
Qa0zC22AeDv+AmAskWNJQc98BSn1/vU0n08WvwQ/kZNRgQ4BaYbT5RCJr2RMZDae8dzPHIqy
yDhzagrrcEJWccrx5zbzpZl6y5kGXg571XB40oOeIxJ5KzPxcpgjp8OToz0wocVYilHLRbxN
vqA+ZJwTLXw1nkU8Ta62OJIOc0+CIPSWD6zAbXENPe797q4w6VWe8kO3VTuGrxc7vtOFHXki
kwed1zF8c6fjL9zP7j/sRxUMPDUMnDlyuc3nh4bLatqOy8HBEy854mpITjKMScmzMHQ4GOya
rZCi2cYthnB1vk7zPjd5UYivFp3IOs4KqcA1aKSXUp6gZhRxlXqHi5apdrm0ILOPN3V2OKDK
X7LgrsjYtSviTLmrchzNA8KhQliXIv8St9qPzUL+k2Pc9vDpiqof7PhkvMqOt+8v+CB9jknQ
K0Cf2bkHf4NCe7XLEEc+9uD3Zo0CJRDhUkAejglrlkfb7ICZ6rykNxhzcLIC5++FX4d0Awex
rNGfyvJUWbIzZyjQevSLR9vkibyddrKisq/xdzdxk2YV1ABPR6h1g+oOhz2Lsnw2oHfFJCMB
UL5BL0SJEnprkxU1QziS2Bjib/OPn359/f3+6df31+PL4+nu+Mu348Pz8aXfvLuohucvp15M
hSr/8RO63tyd/vX08/ebx5ufH043d8/3Tz+/3vxxhAre3/2MofW+Yr///PvzHz+ZoXB5fHk6
Plx8u3m5+9/Kjm25bR33vl/h6dPuzJ5O4iY96UMeKIm2VEuiooud5EWTpj6Jp22SiZ3Z0/36
BUBdeIHc7kMnNQDxAoIgQILElsI5RpH4x5jAdrZ72mGw9e6/d/YFoCRPauwUeMy5sh5+QQTI
JzHSSMnoU+B2k01gPA3GVt6jp9s+3HJ0BX00jEHk1OBcvf58OTzP7p9ft7Pn15nm/NhJTQxd
WQoz3t0Cz324FBEL9EmrVZgUsSknDsL/BLyQmAX6pKXtEfQwltAwkJ2GT7ZETDV+VRQ+9crc
/+pLQNPVJwXlKZZMuR3cWohtFMYRiCCVlMiRm/UOubyu8VFkO3NKR7NcnM4vsib1EHmT8kC/
J/THiGXr+93UMWg/j9zW5x1weFlJO9ZvX77v7v/4tv05uyfhfcDs7T89mS0r4RUf+YIjQ78V
MmQJy6gSXuNAJa3l/Pz89FPfQPF2eMQQwntwQL7O5BO1EgM4/7M7PM7Efv98vyNUdHe4Mzf1
+hJD7nCmH5Mw83kcw+ok5ieFSm8oJN+fessE86/5k0xeJWtGmCSUB0rKShWq36OkO46opPce
w8MgZIoKF9y5bo+sS+6TY4Irw4D5JC037ALYodWxRhS64TbwmpkPsCxvSuFP4jye5jwmnqkb
f8wwP+26l5j4bv84MNXjBlhN042PdRJ796Nr6NP0R2v9UR8qu90f/MEsww9mZKYJNo3Gvr7r
2EkK5FIEqVjJOR9IYJEcGXuovT49iZKF164luyhMDksWnTEwhi6BiSBT/OtVWWbR6fyCBZtu
8gien3/kqD/MfeoqFqccEItgwOenzMIaiw+MYFQZe/+pQ+IudWAm6ujV8rK0HnfqwJtC16yl
dvfyaF1CGJSPP5MA1tYJI0cib4Jk4ln4jqIMuQjKQYTUZmG5Fw6ieyuCqRpTVoMrxR2VDRTo
CfTf+7hzFuoPeiQrZmQW9PdY11exuBVc/GY/fCKthBmV66wPnDhIeaxAWRb6mUlfjPgH84dl
/Agb641ih6iDjxzWYvX84wVjti3be2Ak7XF6JaW3ihngizMuzGf45Iwp5iz25z3uTfYyX949
fX3+McvffnzZvvZX/3fd+yeuZFdJGxYle4jW96cMlk4aMxMzoes17hfql4icB+h9Cq/ezwlm
YJcYeFTceFistO0e8ja9ie+7L6934L28Pr8ddk+MqYD3TwU7C+hm6q/WASTSQu3nq/RIeNRg
tR0vYTTuPOEAdMSoNoT36w7YoMmtvDw9RjJWz7GiJzs2tGNXRxPwOO8mVpJ448udXKMfu0ny
nHFHEFs1+QUItjyKdKPBPRL7fIRBTx7JGbRFEqrrUDK+CWK7eMCSwpfZqs7ZXCMGIyivx5Tr
YlCwkj3ia5Cb36mpYoR3xCaMeTZi0a2ZxqIAnJz5zgxSXIW+Qu3gprfOdQ9JZE7uJwjN8S4a
tL9fKrT716VWG7zQ0KYyvwTzhCXCl81z38xBZJItaxnymwyI72J2cIy5z4egfQ5ZiYVEAWUL
ppjeSk4IVpaqZRK2y+uUH9YRP8w1VsbFvOEGRlQ3WSZxI5E2H+ubwnwcakQWTZB2NFUT2GTX
5yefYK6XdbJIQjx61IEpxsnkKqwuMJhijVgsg6P4s89gOoHFLQL82AqaS5a4OVlIHa2CISTU
hsR+p1qvUfh4wl/kne9nf2Ew6e7hSd9zuX/c3n/bPT0Y4Xx0Nm3u45bWKbOPry7fvXOweo/F
4Iz3vUfR0sJxdvLpo7WZq/JIlDduc7i9WF0urKThCqMUJls+UtBiThEN794ZIQ2/wa3uCt3U
mp8mOb7wSIf6dvS3mAoqChLwRDCtj8GqPkQfnJQ8LG7aRUkh5aaAmCQw/b2In1CVEXtWgjmy
ZJs3WWClj8Lc0f3r2MasDNswBLvIAp1aZn7Y+n5q2CZ109pffZg7P5lDjQ4O004GNxf2vDYw
U/Y4kYhyA0J1hCJgT3MA9/HMqZF3vkIrCzXYGHr/gKc19qH0voFZBYhJpDKDE0wZt2jEgN2Z
WnPpVptkjkvAx28gFGM5fTgX0OFFchjURiljS/iQDQJz9Ne3CDY5qCHt9QV3EN0hKfi+sCzH
DpOIj7w4dHjBJnMckXUMM4EpF/OGcmPaoYPws9snZ0N37Hy7vDUvlxmIABBzFoM+mjfXzeOq
XoQwOU+lUmU56iYUT94u+A+wQgMlKsxCAivJGmyasrTyf+P9LjuSPVd2hoCcCqaX19EeWdax
g0ME3u1wsqRE9AJ3mAqKWYnJA7Oxucp7BL5AXthYUSS+GWAhWjbcpVqmmqEGn1MV2L8YHTUM
Rq2yROuMfrqnt20tzGQK5RV6NYYNlBUJvlI0/FZJRPHUoMUNblcYiZ/aifZAHDPBBbOp4LNY
Wp3HQ9J8ySoV42K3s4TZx4S9aUDQl9fd0+Gbvtb8Y7t/4HLcU9ioTsA3EZJH+FC4N9WG5Yqi
lTB1bgqrYTqcUP05SXHVJLK+PBtY21lSXgkDRXSTCxgy10GzwP3zkIPlkAUKrUBZlkBl5YGZ
ZMuwl7P7vv3jsPvRmQ97Ir3X8Ff/UL6z+7MGd95iaWYKXpRQN4XjXp6ezM/soS4wKye2lE33
I0WknZQqM2UklnjRE0NTYTqy/ks3dWRIAQhZUmWiDo057WKoea3KUztUmUpZKLyesWhy/YlI
E3zlZs4dVOiuFooizE3VOJazkWJFST7Cwkrj89sspwGiHazdfS/z0fbL2wMlq06e9ofXN3xo
zEyNJdDlAEPSvBhrAIejbT2Klyd/n45MMOn8Z4vtHlYM9ypSVJsJR3MgwuNQossw8v5IOXiG
PxUkQcGvq2VkrYn4m/mgCSoz7Id+gsFuamgNC6BBUeVCMSrWrIW8HUKxKuu3BsxmCgb6kgvq
cAJr9pylLgxhKNeIYUa9An4LPittxjbowhDbLyROPQOqn9xH40GxFrXJ+cy25CSqpFK55drY
cFyUgX36KgJPcStL5TdUB3lzCqRKm0DHmpvWwFr2HAabIIX56DLlV3BMoAStUqn2/k4/npyc
TFB2y6/T4gE9xJQsFixbHXK8RoA5R7iltFN5FOfSVFbMdwUaOepQMo8GBe1Us+aMTY3KVZY1
3eWpymWLTidFwTKGPUFbM+1K4GTxt241dqPKlR55GnhgZiuiqLO53RCbUbadLsf6wr8+JUWi
mXp+2f97hm/svr1oNRrfPT2Ygf0Cb+aDNlf6Eg0Hxrs7jbEprJFoJKimvhwGHG/cNOh91iCE
pnVbqUXtIweeB0rVmPgkMwmpDs7PniTuWnliDiZW1sZ4ZboWFZcNeXMFCx4se5EyZiNpMF30
pfne0lGO6lg9WK++vuEixegfLXyO2aKB3YmECesn6xgexZRtjz+OyErKQqsWvceBwQ+jjv3n
/mX3hAER0IUfb4ft31v4z/Zw//79+38Z2x94p4qKXJIFqtMrW2ZsqdbHrlh1SehF7c6QEmz/
ppbX0ps7fe56b07x5JuNxoBmUxsKyXNr2lTWFQ0NpYY5/gLCIln4aqBDTOoC7TtAC+TU18g+
dGB6I55TzdQkmBJ4Y0xryaFlYydH/2W0/f+PoR23h0DzwdJu7g6RwQcsaZscz1ZBGvWGhqfz
9erCrh/wby3LQFXSVj/f9CL/9e5wN8PV/R634axMicSppPIEpeCA1dKF0H24xNoCo4UQnGJR
C3QD8NG+xI5UPNo2dxjDEniS12Dt+df1y7DhJrozmONGUdhQqsd2YpMI8ce+LeWipcQlXgEW
GY3vJFZeMSdT4xtUVo9cXoC21LZ7SVY7WwfuZeXhTc2mISaRGRwIamjpCNSAXYIFGvM0va+3
cERZF0DANqOLq8Az3EJ1SPDSGUo8UZKTYsgPAifU3mKatZXA9/19Edk/shJCTYTVepGKZcVV
VcU4WXHzPGqDRE1kcSVDhhnNftSarKBrFjwWZv4CZv0GLzbyLy9BK8AWDfDRuzzhtyCsDprb
D/V2f0DFhEtkiElS7x625l7Dqsn5gPxuSqOzrsruZY7E3BcrMp7IuOFOtuT4qXWHNkmrVPBh
XYjUpjatEZxjixQLVMqGX2/XxvqA9F2WhX18Plu0XcyorPGMyPKjO6sRbMVQrTtpsvdVSxB+
PCFATYHSjDEaTJ1gsQ6axg7U5ofPi+buz1P6emk1AceswkojFTZQsb3s/Q9kMj1Is0EBAA==

--bp/iNruPH9dso1Pn--

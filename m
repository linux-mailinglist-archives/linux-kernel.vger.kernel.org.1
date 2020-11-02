Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133F12A3485
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgKBTsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:48:42 -0500
Received: from mga17.intel.com ([192.55.52.151]:10852 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgKBTse (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:48:34 -0500
IronPort-SDR: KnUd446+DC4rI/1wAlkX2g7mUUiu2tTazX7JHUuCC/UAMQLzqgUO764oU9vir7wPMXoW6sHtuB
 1e9j9HwTt84g==
X-IronPort-AV: E=McAfee;i="6000,8403,9793"; a="148796756"
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="gz'50?scan'50,208,50";a="148796756"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2020 11:48:32 -0800
IronPort-SDR: 8IlfX9kAtbHNl/WKc6QbjeLqt/v8Wv+1qbxegexJbnoiQhpd3eGmwUTZGEo1xNtK7ub38hnjYv
 dT0H2JApSOIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,445,1596524400"; 
   d="gz'50?scan'50,208,50";a="363352966"
Received: from lkp-server02.sh.intel.com (HELO 9353403cd79d) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Nov 2020 11:48:30 -0800
Received: from kbuild by 9353403cd79d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kZfob-00007x-EU; Mon, 02 Nov 2020 19:48:29 +0000
Date:   Tue, 3 Nov 2020 03:47:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Marek <jonathan@marek.ca>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
Message-ID: <202011030351.iq9CBMO3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3cea11cd5e3b00d91caf0b4730194039b45c5891
commit: 09309093d5e8f8774e4a3a0d42b73cf47e9421cf soundwire: qcom: fix SLIBMUS/SLIMBUS typo
date:   8 weeks ago
config: openrisc-randconfig-r005-20201102 (attached as .config)
compiler: or1k-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=09309093d5e8f8774e4a3a0d42b73cf47e9421cf
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 09309093d5e8f8774e4a3a0d42b73cf47e9421cf
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=openrisc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: drivers/soundwire/qcom.o: in function `qcom_swrm_probe':
>> drivers/soundwire/qcom.c:767: undefined reference to `slimbus_bus'
>> or1k-linux-ld: drivers/soundwire/qcom.c:771: undefined reference to `slimbus_bus'

vim +767 drivers/soundwire/qcom.c

02efb49aa805cee Srinivas Kandagatla  2020-01-13  756  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  757  static int qcom_swrm_probe(struct platform_device *pdev)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  758  {
02efb49aa805cee Srinivas Kandagatla  2020-01-13  759  	struct device *dev = &pdev->dev;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  760  	struct sdw_master_prop *prop;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  761  	struct sdw_bus_params *params;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  762  	struct qcom_swrm_ctrl *ctrl;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  763  	int ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  764  	u32 val;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  765  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  766  	ctrl = devm_kzalloc(dev, sizeof(*ctrl), GFP_KERNEL);
02efb49aa805cee Srinivas Kandagatla  2020-01-13 @767  	if (!ctrl)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  768  		return -ENOMEM;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  769  
09309093d5e8f87 Jonathan Marek       2020-09-08  770  #if IS_ENABLED(CONFIG_SLIMBUS)
02efb49aa805cee Srinivas Kandagatla  2020-01-13 @771  	if (dev->parent->bus == &slimbus_bus) {
5bd773242f75da3 Jonathan Marek       2020-09-05  772  #else
5bd773242f75da3 Jonathan Marek       2020-09-05  773  	if (false) {
5bd773242f75da3 Jonathan Marek       2020-09-05  774  #endif
d1df23fe688b58e Jonathan Marek       2020-09-05  775  		ctrl->reg_read = qcom_swrm_ahb_reg_read;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  776  		ctrl->reg_write = qcom_swrm_ahb_reg_write;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  777  		ctrl->regmap = dev_get_regmap(dev->parent, NULL);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  778  		if (!ctrl->regmap)
02efb49aa805cee Srinivas Kandagatla  2020-01-13  779  			return -EINVAL;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  780  	} else {
82f5c70c26511ba Jonathan Marek       2020-09-05  781  		ctrl->reg_read = qcom_swrm_cpu_reg_read;
82f5c70c26511ba Jonathan Marek       2020-09-05  782  		ctrl->reg_write = qcom_swrm_cpu_reg_write;
82f5c70c26511ba Jonathan Marek       2020-09-05  783  		ctrl->mmio = devm_platform_ioremap_resource(pdev, 0);
82f5c70c26511ba Jonathan Marek       2020-09-05  784  		if (IS_ERR(ctrl->mmio))
82f5c70c26511ba Jonathan Marek       2020-09-05  785  			return PTR_ERR(ctrl->mmio);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  786  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  787  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  788  	ctrl->irq = of_irq_get(dev->of_node, 0);
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  789  	if (ctrl->irq < 0) {
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  790  		ret = ctrl->irq;
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  791  		goto err_init;
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  792  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  793  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  794  	ctrl->hclk = devm_clk_get(dev, "iface");
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  795  	if (IS_ERR(ctrl->hclk)) {
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  796  		ret = PTR_ERR(ctrl->hclk);
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  797  		goto err_init;
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  798  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  799  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  800  	clk_prepare_enable(ctrl->hclk);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  801  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  802  	ctrl->dev = dev;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  803  	dev_set_drvdata(&pdev->dev, ctrl);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  804  	spin_lock_init(&ctrl->comp_lock);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  805  	mutex_init(&ctrl->port_lock);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  806  	INIT_WORK(&ctrl->slave_work, qcom_swrm_slave_wq);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  807  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  808  	ctrl->bus.ops = &qcom_swrm_ops;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  809  	ctrl->bus.port_ops = &qcom_swrm_port_ops;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  810  	ctrl->bus.compute_params = &qcom_swrm_compute_params;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  811  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  812  	ret = qcom_swrm_get_port_config(ctrl);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  813  	if (ret)
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  814  		goto err_clk;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  815  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  816  	params = &ctrl->bus.params;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  817  	params->max_dr_freq = DEFAULT_CLK_FREQ;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  818  	params->curr_dr_freq = DEFAULT_CLK_FREQ;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  819  	params->col = SWRM_DEFAULT_COL;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  820  	params->row = SWRM_DEFAULT_ROWS;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  821  	ctrl->reg_read(ctrl, SWRM_MCP_STATUS, &val);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  822  	params->curr_bank = val & SWRM_MCP_STATUS_BANK_NUM_MASK;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  823  	params->next_bank = !params->curr_bank;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  824  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  825  	prop = &ctrl->bus.prop;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  826  	prop->max_clk_freq = DEFAULT_CLK_FREQ;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  827  	prop->num_clk_gears = 0;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  828  	prop->num_clk_freq = MAX_FREQ_NUM;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  829  	prop->clk_freq = &qcom_swrm_freq_tbl[0];
02efb49aa805cee Srinivas Kandagatla  2020-01-13  830  	prop->default_col = SWRM_DEFAULT_COL;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  831  	prop->default_row = SWRM_DEFAULT_ROWS;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  832  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  833  	ctrl->reg_read(ctrl, SWRM_COMP_HW_VERSION, &ctrl->version);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  834  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  835  	ret = devm_request_threaded_irq(dev, ctrl->irq, NULL,
02efb49aa805cee Srinivas Kandagatla  2020-01-13  836  					qcom_swrm_irq_handler,
4f1738f4c24b448 Samuel Zou           2020-05-06  837  					IRQF_TRIGGER_RISING |
4f1738f4c24b448 Samuel Zou           2020-05-06  838  					IRQF_ONESHOT,
02efb49aa805cee Srinivas Kandagatla  2020-01-13  839  					"soundwire", ctrl);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  840  	if (ret) {
02efb49aa805cee Srinivas Kandagatla  2020-01-13  841  		dev_err(dev, "Failed to request soundwire irq\n");
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  842  		goto err_clk;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  843  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  844  
5cab3ff2489ede5 Pierre-Louis Bossart 2020-05-19  845  	ret = sdw_bus_master_add(&ctrl->bus, dev, dev->fwnode);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  846  	if (ret) {
02efb49aa805cee Srinivas Kandagatla  2020-01-13  847  		dev_err(dev, "Failed to register Soundwire controller (%d)\n",
02efb49aa805cee Srinivas Kandagatla  2020-01-13  848  			ret);
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  849  		goto err_clk;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  850  	}
02efb49aa805cee Srinivas Kandagatla  2020-01-13  851  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  852  	qcom_swrm_init(ctrl);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  853  	ret = qcom_swrm_register_dais(ctrl);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  854  	if (ret)
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  855  		goto err_master_add;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  856  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  857  	dev_info(dev, "Qualcomm Soundwire controller v%x.%x.%x Registered\n",
02efb49aa805cee Srinivas Kandagatla  2020-01-13  858  		 (ctrl->version >> 24) & 0xff, (ctrl->version >> 16) & 0xff,
02efb49aa805cee Srinivas Kandagatla  2020-01-13  859  		 ctrl->version & 0xffff);
02efb49aa805cee Srinivas Kandagatla  2020-01-13  860  
02efb49aa805cee Srinivas Kandagatla  2020-01-13  861  	return 0;
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  862  
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  863  err_master_add:
5cab3ff2489ede5 Pierre-Louis Bossart 2020-05-19  864  	sdw_bus_master_delete(&ctrl->bus);
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  865  err_clk:
02efb49aa805cee Srinivas Kandagatla  2020-01-13  866  	clk_disable_unprepare(ctrl->hclk);
91b5cfc0209b63b Pierre-Louis Bossart 2020-04-30  867  err_init:
02efb49aa805cee Srinivas Kandagatla  2020-01-13  868  	return ret;
02efb49aa805cee Srinivas Kandagatla  2020-01-13  869  }
02efb49aa805cee Srinivas Kandagatla  2020-01-13  870  

:::::: The code at line 767 was first introduced by commit
:::::: 02efb49aa805cee643a643ab61a1118c2fd08b80 soundwire: qcom: add support for SoundWire controller

:::::: TO: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
:::::: CC: Vinod Koul <vkoul@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ZPt4rx8FFjLCG7dd
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAdaoF8AAy5jb25maWcAnDzbcts4su/7FaxM1andh8zoYjt2nfIDBIIiIpJgCFCS/cJS
ZCVRjW25JHlm8vfbAG8A2bRzzj7sRN2NW9+7Afq3f/3mkdfz4Wlz3m83j48/ve+7591xc949
eN/2j7v/9XzhJUJ5zOfqdyCO9s+v//xxeNk9H/enrXf5+83vo4/H7dhb7I7Pu0ePHp6/7b+/
wgz7w/O/fvsXFUnA5wWlxZJlkoukUGytbj8cjuM/Pz7qyT5+3269f88p/Y938/v099EHawyX
BSBuf9ageTvP7c1oOhrViMhv4JPpxcj8r5knIsm8QY+s6UMiCyLjYi6UaBexEDyJeMIslEik
ynKqRCZbKM++FCuRLQACJ/7NmxsWPnqn3fn1peXBLBMLlhTAAhmn1uiEq4Ily4JkcA4ec3U7
ncAszZJxyiMGbJPK25+858NZT9wcXFAS1Wf78AEDFyS3jzfLOXBLkkhZ9D4LSB4psxkEHAqp
EhKz2w//fj487/7zod2fvJNLnlJ7aw0uFZKvi/hLznKG7H1FFA0Lg7VYnAkpi5jFIrsriFKE
hi0ylyziM/jdLEFyUEx7biMBkIh3ev16+nk6755aCcxZwjJOjcDSTMysZW2UDMUKx/DkM6NK
sxpF05Cnrlr4IiY8cWGSxy0gJIkP0i3pNLpFyZRkkrkwezWfzfJ5IA03ds8P3uFb59zYoBjE
yatVs/68FBRnwZYsUfJNpFZm4lMiVa30av+0O54writOF6D1DNiq2kkTUYT3Wrtjw81GoABM
YTXhc4qoTDmKw+Y7M1kc5fOwyJiEdWOWOezp7bEek2aMxamCqYy1twpcwZciyhNFsjtczUsq
ZLv1eCpgeM0pmuZ/qM3pT+8M2/E2sLXTeXM+eZvt9vD6fN4/f+/wDgYUhJo5eDK39zeTvlZk
ysBkgEKh21NELqQiSmIblLzlHPxoLN7nkswi5tvs+4WNmwNmNPckpgfJXQG4dkH4UbA1iNvS
C+lQmDEdkD6OGVrpJYLqgXKfYXCVEfo2AjSJ+EU8s/ngnq8x7UX5D8vYF40aCGqDQ5hTq+ZT
6661Xw7A8/BA3U5Grf7wRC3AWQesQzOelryW2x+7h9fH3dH7ttucX4+7kwFXO0WwjZ+dZyJP
LStPyZyVimo7BnDE1DpSOaqQNDSqUUEDwrMCxdAAXAU4mxX3VWhrbqbsAYhmViul3Je95TM/
JvZkFTgAa7tnGWoEFYnPlpxisajCg4prO+qtOEsDZEHjgZHJpNBWW9EQ5exVh1Hw7GCy2C5C
RhepAKFrDwZZhuXmDKNMLDcT23NCDAY++wzcDSUKZWfGInJnJQHRQvPCxPvMkpf5TWKYTYo8
o8zKBTK/mN9zZ10AzQA0wdbzi+jeSKkFrO+dn9G96EwW3V/gU91LZW1yJoR2qa6xQdYmUnD5
/J4Vgch0EIH/xCShjkfvkkn4BybBO0lVZIfpJSty7o+vrG0Ynah+dN1Yh9aEXcheLMuSc6Zi
cDZmLRJZi5Xi7IGDMmpbFmvSqybMOT7DzvcsLs0IZBRB7kybQ0be+QlmZx0tFc7u+DwhUWDJ
w+zABpgcwQbIEPyIk7ZxgXCdiyLPOiGO+EsOe664IVHjhslnJMu4a/sVcqGH3cUWh2pI4bC3
gRoeaXtRfMkccVsyadbWQjUhM/DRvcHWmO8zHJnS8eiil71WpVS6O347HJ82z9udx/7aPUOk
JeDWqY61kMbYfv4XR7QLL+NSSLXDR50RVB5EQaa3cHxNRGboWWSUzzBLisTMUgQYDeLKINRU
mYYzd5gHAWTDJhQBn6GIAR+Im6disfGturDjAQdK7iaSEHQDDuUb5qBNeDd+1skP3cKtJhYp
SzIurQiuE7KZlm3ic2Jl93FsJRJ11hyuGGSkbubLRSogAsbEKhfKlANy9CAiczD/PNU0SBYu
c6t+gMSOLsqhvRE6XYegYCGMzqTHw3Z3Oh2O3vnnS5nHWblDfehsvCjGk9HIZikk/BCEilXG
FVMhRKF5iDC35pepNCGBK3w103GkTH4fN6eTx7nHn0/n4+tWtwlKVe6ONi6XQ71dBMH4rWUs
wmhsbxehAD+MKi9C6vOlS1pnwegJLCWOU2S3ULWMXWYCZHI5QncDqOloEAXzjNAVbsdt06PM
FsJMFxAoT0ALZQrxLyt8uf4FnsiQ+GJVzFPcV8S+6ZTUYvZ3X1+/f4eKwDu89ET8OY/TIk9F
UuRJGdN8iJ9gkNqE35I0g902hDqwlQmTbcLIwjXqLb13+jab4/bH/rzbatTHh90LjAdfap3E
TgpIRsPSdkMhFn1zBXUw9WoBBgNpf0tgBupGEySzhWQKmGHMa4iERoxkQ0TTyYyrQgRBoRx3
VMyJClmmpZ2RZG6Fs1j4eQRVMsSvgkWBCXhWEjFXuvwrIogSkbyddGJCuZyO+65ThGVYAM6Y
69ASBNL1RXbIkU2zjIrlx6+b0+7B+7OMYi/Hw7f9o1MGa6JiwbKERY6/fmts16m/I9Um29RO
AlIgZm3eZAQy1pF/1OFfl6E6qaS6WLNFXaHyBAWXIxpkm9UIv+rgDWQ95XCojptGX4R7t5qS
z99Ca9lC1YGZd0WhQ/KqiLmUEFbbSqbgsY4vFi/yBNTKhzAdz0TU45Eur5nmkVi4dcxMawmy
PJHJ2J68bMuC/+KJ4RtddMxBK7XpK/qGSFPIYZJsVRMYjWT/7Lav583Xx51pgXsmpTpbdj/j
SRArbTVWyhsF1CnXKiJJM56qHjgu8wmry5sxP3cjR6PBQxsyu413T4fjTy/ePG++755QPwUJ
hSrzbwsAtuoznTm7WUjVeOVSRMRtdMo0AptPlbFkMHZ5e+F4hU5f1ORwGdOKUWb09QJ8nnVm
hv8oLRad8Fn5uLR2XLelYtgsTAGq7vvZ7cXo5qrJqhhIEmow44cWTrGhPWfpNtHI5bYSwNP2
yvo+NsCDIAHdYkTefqpB96kQVo1xP8st+7+fBiLy2y7QvXExwlGMGtZ4ZGBAiie1Dalu9lkl
vV9n1DpKLRxhAL80u0x30F51rlseLKFhTLIFqpPDatcKpMk4k93578Pxz4F0AFRnwbDuKRj6
2jH7NZiTI1kDgxwcl5YaKBfXQRabug3Fwr4h1OCd3rWfmuYOQ5upvDxyQ83Tsu7XbXJ0OiCA
8la3KMAJCYg6WK0DRGliXyuY34Uf0rSzmAbr3kg6tJgmyEiG4/W5ecrfQs4zXbbF+RrZZklR
qDypg3RTqyVg4WLBGS6NcuBS8UFsIPK3cO2y+AJaLAUJh3EQxYaRPNXebUDa7XFtoFbIDkjR
tAa70+d+OqzAhiIjq3coNBbkIlUmcLXVq8M/5422YSVxTUPzmd1Trz1vjb/9sH39ut9+cGeP
/ctOdtFo3fLKVdPlVaXr+nYkGFBVICrbdBLMB+p8vH2iT3/1lmiv3pTtFSJcdw8xT6+GsR2d
tVGSq96pAVZcZRjvDTrxy7LMZ+ouZb3Rpaa9sVXtaVJdZ+gwMWAJhtBwfxgv2fyqiFbvrWfI
ID7gN7+lmNPo7YniFHRnGFMscn03rm++B12HvneHvdB+oOrQpOGdKVgg1sXdAGoTBzxSA5Fh
lr6BBCfk04HTcH3NMeCWMx8/mxq6VIdcDoVHk4EVZhn351jqY+pX40Cke0VRgtDJlhFJiuvR
ZPwFRfuMJgwPdlFEJwMHIhEuu/XkEp+KpHgPMg3F0PJXULqkJMHlwxjTZ7q8GNKK/jWV1RTD
2p5+IvUVjtCPMCDDa4UB4iM6fV2ik+lWx1KuuKK4U1si2Ye9T6iLFsPRIk4HQqQ+YSLxJUM5
nCeVO/UZfhhNEU0hY5Xa2w9RfcnU8AIJlXheUN2uaZo0cy8TMBoaEShaMd9rQuy6mOXyrnAv
OmZfnDzG9P+hcCVxYR5mOJu201zvvDtVt/jOWdKFmjNcAY3FZQLiqACPJzr8qFLu3vQdhJ1e
W+IjcUb8IQ4NGMQMtyESAKuyIb8UFAsaIxxe8YxBRHIKDBrMtcGNezxsEM+73cPJOx+8rzs4
py5+H3Th60HEMQRteVtDdBmju2UhQNbmYu921K644gDFPXCw4G7jxJLKjZV5l7+LJYeSVnQd
5g1yHWzxmeOZDmVpWEQc92ZJMPCsSkIIi/AQblLWAMdhsbh2VxJsRFfIVgMzE7C9KHLkFhAe
iSVapzAVKih2ay9U137+7q/9duf5x/1f5aVVfQhKSWYVvymNKSfd36aRVlDeNGdS+nG7OT54
X4/7h+/mwqJt3e631TKe6LZA8rL1GLIote9gHTCYtQqdx29LFad2E7OGgJmW73nqEkeRxCdR
//GQmT3gWbwiUDqZl3c9jQ/2x6e/N8ed93jYPOyOVttmZU5v77cBmYLe1+9B7CtoKPCb1ayD
tKN00dsyoZUqRgCyjqIZoXhobodgbcPGNXUP1/gEAozRDxDqxpdz5WvajDZ2INfQNwB+xpcD
KVlFwJbZQD5cEuj8spoGQnYM6o2VR5qIQC1La9LyAWGjr831XJpXr0wsxcnY3Omylb8LPqE9
mIx4DMGonbiG21fyFWw17pHFMRf9dewnhPV8oMK+ds196iltpzWXEyHok1G2wFZGjQoYlJPl
9UfvIrVvjkbfZ68n78E4Bcs+Y7FWzL66CHlRcqGZ0x5nN07Bo1H8lnieSLv3bD8hgR9lXQEr
lH5lczzv9S69l83x5HgqTUuyTzrqK3e++tqrQj3ZKBE0A9r8C+DASfN+xSBRm+lvxewwh396
8UE/5yqv9dVx83x6NA+tvWjzs7dnIdLe6npVrruvIM8yL+v5o4zEf2Qi/iN43Jx+eNsf+xfv
oeu8zdkD7jLjM4Psv/OsVsPBMprXts5mYAadCJtKv3PJYVFplZwRSGvNG7Ji7E7ewU7exF50
pAfr8zECm2A75YmCNGaNNSqbw8S+7GqZhkN8IK52aGiueOTSAus7ABG748hMskTZpvaGuMr7
gc3Li84MK6DJoQzVZqtvQzsyFTqxWNdN5r76hHcScAMsaEK4O6YM5CQRyR3EzSExpxHRL89s
i39v6+UDyN3jt4/bw/N5s3+GFBGmqrwErrX6yUgAxUDoMroBl48bykcld0M0QqUdPaNhOpku
JpdXLlxKNbnsCFlGPTGnYX1ye07lA7Rnnv7+9OdH8fyRakYMJVdmu4LOp1Y1Q8Py84Uivh1f
9KHq9qLl/PtMLQseSHvcRTWkcC/CjCtKmMZ0j1iBK26XrB9Qj5q0fvM7MFOn+Y1QTNbaGc17
MjBIRinUtLpmijvP0AZIChljz9RLY16ZEcPLzMynDaXT3fz9B3j7zePj7tGw1ftW2jPI4HgA
aFe6Zh4fjhRxZIESUfgKwcVru73bgOcpJA5PyIG1YeqXlHhHoZE55IIJ+rK2ISEZkea1VOmX
9qctciT9f84HEu2ZuFyIxP3EAkGWoabpdP8ara8TWOtuf5BUf1yAqoVFOZuptzQZErlaL9oK
XhuSYUuUwma8/yn/O4FyJ/aeyqs21J0ZMjdEfOFJIJrstFni/Yl7mxRZ96gV2FyeX5i+q/4S
alAz8hnWINeY8A4qDJ3gtdmksrRSOK+tIZXSjeCBL6AAq++z9ZMCe4KCkSy6w1ELMfvsAPy7
hMTc2UCjFTbMSaThd2LnrEI/ooH6aalzK/u6vUToVqAD03W08ygbkrPqnZ51N2pABVlfX3+6
uUKOX1OMJ9cXzX3rMmaefH15ORzP9jNRB95YYT8bhxxDglyLiMtptBxNrDKd+JeTy3Xhp0Kh
QFPToAhdwFj+Bcq6+E4zFLsPofJmOpEXI+c5H/iXSMgcCmnNZI6/oCepL2+uRxPi9i24jCY3
o9EUW8ygJiN7czUDFOAuBx7p1TSzcPzpE/YgryYwW7oZWVfZYUyvppcTq8qS46trK3fVSgsH
hECRTnsv3aUTu9b6jeu6kH7ALP1NlylJbIWmE6NaVbXDGPiH2DtZKlIz2WAKoibYU/wWe9lu
vgJGbE7oXQ8ck/XV9adLq01Rwm+mdH3Vo76ZrtcXVz1iyN6L65swZXJti6nCMjYejS7QWqpz
0PJLtd0/m1P1evPJPJI+/dgcIc0564JK03mPkPZ4D2Ab+xf9T5tBSqfz6Fr/j3n72qRNTpvK
G/pkSFwz07dSRJcZaVT7AP58hlQCnBr4/OPu0XzRi8h7KVJdaKMHemuKRkA0FHYkcxxKmaDr
Fn6VPbYbqM8ESP0qzJ4CG2C1YHvNFdPfL1POtoEtEn/oks94HhSj2yHznGQDL/m/5JBUDX1g
ZG75GRlIkwjVF2dDV6VDqOV6CKPT4CXe5Z2RjOU+3jKbD1wRwv4glg+dSxcIYqDfrHJ8gwAv
lkYy5nvegdFLpgbuuUyPvRi6zEuiWODrkqx7AVlXTefj/uurVmH59/68/eER6z2olVy1L4l/
cYjV/9YPVJWrmEuW+JAwTaGyduJ6WRRP6eUn/M6xJbi+GbiaqKYmEaE63aROYlq5BCWxNNQe
HZN7+y2eg/KRLScx7SglMhIsJVGc4NNmFIfnmcice+gSUiSz62v0xbs1uPwc2eXx7AJn7YzG
2nxwzSq/LNGx8u0Fq3rHSZAJehPsDFpy++MNG2XeSTrHnzOoMHmjV7gvS9CXc9bE7L4qmVo/
ZiBFkkrYckJgGX1L0eVIf6Yg/8yVzBGdCOLl5/H10KuwavhciLnz2XaLCnOyYhxF8WtIINc4
SjfkUExMIAl3P9OKl7GPfnNmD4MxJBFrZ1y0hkpdhxfccUbrYPXOrJxm7ou4hby+vhyj85Uo
mHboPtKaVPQEm9DJ9ecrPF0F5HpyAdh3LMnMLEH1UM4mRA3jmMpEImJcxgl3bkx5sZ6z/5v+
XU9vRojykfWQcVQE6eCTFDAtgf6VgXbRFJIuKM4FeiadEOi/YGDv6gsln0ajUTeHs/A6Yx16
N5XF77IhA05JItENZfp1SIaiJIll7va05Ho+Y0UnBCMjGfuCTykikkGBneESl7H7xr0Sh4zp
zZje4G+B9Jib8fgdVyIF1VcYazzWSmV02DmpioHjv3DUu0SkEALssf6KFuto3pFYf+ySO94b
fgImgp2qu7cHrvh95+FwCSlWl+OBr8Aagul75lyWh/bkVcFI1nxYDSuaKIKU9t2Dr3mGZzca
MUkH2kPgjZGv8dspwruhZxGlQ9Wu8ubmMsafqaXRwEPmNMXhsjPAZILh4XT+eNo/7Lxczupa
xFDtdg/VexSNqV/mkIfNy3l37Jc5q4gkroDLJzHFyseaGJq8SYv8WDHr+xYH5/5NBfg5+CcJ
3GGxHThtlJVHIVjKJRU4qhOMu6hMcicE6j8ohN4j2QPbMI4hmc/JIGfs+IigM1I9UcFwTOfO
Q0j776XYiP8ydiVdbuNI+q/42H2oKQLcjxRFSawkRZqgUkxf9LLt7Lbf2E4/O6u7+t8PAgBJ
LAFqDl4UX2DfIoCIIBtx+ujh//C01/dwHRLCc3U2hUG1pIbiqWTOPK2EfdS76xcwcfqbaw72
d7Cj+vXy8u7t88ylKzxzHTy6ptS5WY2rtsIIH7EK0q7e9menxvX3H3++eW8F6nN/Me2ngcCV
SHS1SPBwgEtXYWf2zUTAqo83wCbL8EoPYJdhIW0xDvWkkOXt/Ss4jH4BR/p/Pn98MXpOJevA
6c20cjQY/uiekHpUjygRwjZ80zvL99YnEzxUT7uu0EN5zBS+g2hXRRq1j+Ms8yI5howPO6yE
9yMJYuMC1YDQ21GNg5IET7xX5qxDkuGGwAtn88BrtlWKet7CyGKCVHsEHcsiiUiC1o1jWUSy
7WrJmbRVr6bNQhoiZQMQhmjRfP2mYZzfKbrE1soK9wOhBCn3XF3H7owAYJoMehBDsFm4RDq4
a/aHmp1uKqgYknbsrsW1eMKgyxkmHNYHXKLrcclhYanfs4Rudn7Hl3jkGd2QLwHcXnRlault
7C7lyecutnJemygIcVluYZpGaw67LGXRc+F4s027ssUnzfhw6+EuF92j1w1sA+f7F7jjYB66
kkG4nhgbt6TcuJB0K8qq9Pjx6Fx1zw/fe1yn4sxPK4/X38r2sBs9wUo0pr46Fgw1S1FMrBrq
ouHHI5eLInujFuPPuEBaaZdoGhEeYiEyUF0ZSoXOUexZmkXY257JlWZpqg+tg+I7gsmGj7/B
M5CAEnhguFcjECNv7aQ9BBrwhe+s9VTWA47vLpQEJNwAaY6DINdx9e9Wl+csJJmH6Skrx7Yg
UeDrM8lxJAQ7nkzGcWS9fGPwlCUYjDcZBJcvoF48mkvw1Fby3B+XmdNb3L7IA/310cCezgWf
sjh4KtqenWp/JasKdYkzWI5FU0x4/hJTC87DMpVc5/WOqbqjvDvJj123Rw9mo7n1vqp6vB5c
QeYzdPLVgyXsKU3wOz6jHpczGn/MaPLDeKCEetd+hd/HmyydL7XY1m7XLAiwIDsup3eSc6mE
kCwgHrRksRw3DGwZIZGvhnyXORQMfDGxJ2mDU/zwDFg7JZfmNjJP9etzNdWeed8+pMSzXrhQ
JJ0BfIOz56rJGE/Bvf1d/H8QkaLQgsT/r/XZg4LxaRjGk2ogWhe5G98b5f2YpdPkH+crF0yJ
d+LDiQpWpB3DLaDMOUHCNPOcAOL/NdcNfDgrxUbhGTIO0yCYNrdUyXNvUkmueDuT9E4mfSmU
STSHob2h4QSM/aRuIHgQ2lRWM/9osZHQ0DN3uQx9GJl3C/NK2AbXZThwyc5ns2CwTlkSR57h
6lkSB6l3Wn2oxoTS8G51PohgOnfZhu7UKhkDMwky9oX3DB6gvjnCcs2wg3ho68iSFATJGCBB
seyhJK3FXhAFdAg0Y96ZsqwAM5sDwU8eBeJX7xIMMWFIQZFdgTierU1Ozz8/CT+f+vfuHVzm
GNZkg+6TIn7C37atmwT6YsBVeQk39a5n1E02FNgznMTUWzik+2YinAR+8za5GEqMu+h3CFVe
Iej0i7UvHYu2UtZX6+Ouot3OLI7xW4SFpcFtm7A+X013kPs1eWX1+fnn80e4pXbM/sbxyXjB
8MVkybNbPz7pwb2E6ZeXqMJf03gJ1tOIWAcQy1YFvVKm/D+/PH91DV2VAiYMOksjJJEEMhoH
KFELiTs7meB8JInjoLg9Fpx0Nn12dLYDXGVj6q/OVEprGV8eJf4eorO04mxEg2lqXOfhdhEO
RhGGDhAsvK0WFrSgahqrsy82qc5YsB7CKz1CbneZ99e7LMNIswy/XVFs4D6FGJ5L89bX779B
NpwiJox4lUFs21RWXDANfQ9pBstmhbj8uMzALT7oogaXfRSH6R6hETemDqsPtcfea+Yoy/Pk
eduaOUhSs3TabKbaK/8Yi+O9wVas99jqw5RMHqMExaKeG3t2NzO+M2/BB9bcmv5eJoKrPh+a
arrHWsIzs/BVrY91yXcr/I1jnkYggZAQv6ueR6G3zQsXnxtj97PmR1uOQyNvsd3ZcQYPHnBB
9lguLpew44hfVHJFlHmedy7wCOxJpuLO1mf8wk7VDhx5HRPT9chRAauR9SKASrs+anpticxM
PTyfGA/vwnSwdI0WZ/mtb9cvYHwzqLDlOBHbJQLm1PIS25elfM2Wz50gE1t5s9om8EVtkcQX
Ufbd0a5Wd62G7mBy7zYKPF0h3Odef8ddSDJcd91ZEblXfFdEIS4/rjyyk+8wlXzOmpe0yoUf
njLffUQEkXXqPJ1L8fjjOS4hdgDEUYnwWLgrbF7/cZmeRvj+V/fzozy6Or2VXnPgw8H7FKkN
Bx6s3h5L/qfHlxzfDZsnn022K74tIrka3eHCRhEGbgkeIB8RaYk8tOoO6PzHTbwVgAORsQA4
IAO/YlMfwBNPJVahRmwv01x2++fXty8/vr78xasN9RC+i8iBDcmKYSdFap5p01Tno+dFQpYg
WD21krCshkVuxjIKg8RuJEBcU8/jCLsLMzn+0hbjDNRn2KWxXIfKE7+N4yKi3px4s7FtM5V9
gx8fm31sZqXiO4D47Wkma6Vv1jJziq//ev355e3zt1/G5OEywLHb1aPZw0Dsy4PdD5JcoLW3
yljKXXQc8P5fZ8w6o8U3WN79A2IDKC/hv317/fX29b/vXr794+UTWOn8rrh+42IjuA//3Z5y
JW+sM5GsIYKvHoggHphUqnFWbfVI7ZZvTNKHquUjavZfJ59ZrUx41237YgLT8BBit9piTOt2
rEpz1i7WYSrwLd9XvnMZhEO/8ynAO/VZWTQ5OpmokeuvBuSx6Bg/KV25vXv7LCenylwbNTPj
A6t1hxDvRDCaN152ZuNYU+gedwtJuQ0ZVzpijEVAcZ+l78oC8/gOi9ejRtuEl3qFZiRgiBzG
aUh4hvk4uWq4pkjoAULAUVNUxSQhaZSrolTA+/pd+/wLBrxcHI9dixNIJYV/42wF6lSLf/m2
XZ9RFYiDfL/YFWerZrvLCFJM82SSETN72bR5PeKCJ2c5MNSHChxYp/4Gsr/sMCORZ6EC1LRp
cGua3m4yKBMefy2OdqX4hJV2Z8SJYKUrbNOsrLiCltUsCbDv6QhcKIHW6ElvbiOfCWySPXks
K16jfXg6v2/72/G9dSUpRrR1IxaJaaIdN5jqDVUz48QuSfufr2+vH1+/qqlmTSz+x7CHEn3f
dT1EIhIhW+wajk2V0MmjX0KGsOY9aIuN20mX1PkPQyiSt518bpme+Sv56xdw/dM+EsAzAPlo
zbLvjTt3/tO12pSCcs/m/FzRDZJxERlM5x+ERG/nqUBx1YY2X2NSOzmmg61MyoRqqZr6Uujr
T+dk7seeV/z14/9iU4ODNxJnmfycoNNoZcuo7H/B5s4bwVMzanz+9EmEzOGHlyj41//orlxu
fZbmLSLbrCqrME4KuDlfSavPhkSp8YOEdricS+ueEXLi/8OLMAB5djhVmqsCz/YJdelt2dOQ
BZn5xuCghjmAjboIhPg39OyZPpFY92Ve6GN7MOzMZ2B4yIIYm1kK78qq0T8MuVQNtJfCrVjJ
orQhsZtAAJkGwISVnws1CbcDPwYh2Jv63GpMlu9bdIf5jsVKUg/vbXcbOVyeI0OoMOJDXmZe
7kcLBVWY9AlzAj2o/7fnHz+4ACuKcAQlkS6NpsmK+SXo6ng2ifNhqj9DAH1/9cVTFfBhhH8C
1ExGb9IinToFHIetXjo1171V06Y71uWjNptlJ+2yhKXGJJP06vyBUOwJVo5C0RbxnvJ50u0u
VpbwQS/ja65AvJb7PIwmpxny7PR3FD8rbwc7cKsZLx8b0UWZEdSXv37wTc8dacdeV1HPvdMf
x+vN0hLdqRY4rRN0utE8ofei6sUKp4FVQa4HZnE6WdSxr0uakcCW8q0ekGvhsN/umd0+DWKa
OQ3a7Xl9SHvFDLLlvJd2UHb3SZXMl6jpszSc7PnKiXESI30Ke9jWSKRJ7A6F/+ld9t6Gcarq
XnhNzzCTkxWnJHOaLoDcv9IVTq3mK/NWe5CvTQL3b9bims1HbCLSD5yc5/jjJzIrFgHTmS1m
rnzPJAlm9TEPSkhyguwyYt3gF6OSoQzDLMMFUbkWatYxNFCh2F0GMFYM3TkkQiPiTwZuY+0t
6XgcqqPnK3oq+1J+hUcRRUxJ0Wfkt/98UQq3I6lfyRLWmdEoo3qtdYxc0YjAC4dplr/S2VFq
IqqhSFX0KrKvz/9+MWsnNX1wnW6tukmEWVe1Lgc0LMCfckyeDG/hyqGbMJlJEw9APSmyIPak
0FefCRAf4KtVGN5K3UffBDO0OzkUB9jRoHOkmaeSaeapZFYFkQ8hKTJD1EzQpFB4OrkVj+jH
rwUGMZvMmEsr2X8raDOJ7/UWuAqlsTZjSfNYF+I1sB0T8AVBMZW9r55SjrlbU8m2vCfhWrHk
GSoRprTt9p5A0/DY4eMyiobPT+r3Ojp1uaSyqqvQ09UX56PfF5IV29eUPFrsS4i3z/cT7QKG
b+NZTmOZ2JjL4mC6wT3DBX9HVxy+YuUhpjLW33ogdLAvEVwNHGGGcvEuSLRloCp+K8oxy6O4
cJHSNipcgCsNCKZyzQyw5EyXKx3JsOPfYECqKeiGLDUjTXXsbtUjZmc3s7CdGRxe9QknI4lk
zIDBTjTntXtP0wl1kVmqapm/z3QwYE7lgyGOaMvWQKguz8yV54IvH1DTg2vGxBxEg5HNHI5E
NQMgadJ0rYhOzzKsMI/qtdZFdCdS0hgmMfFUn0RxmqKLZGbaV6OIDii5kxgTRrUMpSDsNIuP
ZkTiyQOY8SB0iMbbtQOeNMTWiMYRQ8lOvwDAR88FWLsLoxSrkZTH8611dSwux0oeDxHB5vVs
w7GRxzDGgX6qz8UPI99AYrcPLyUjQUCRJi4alQPkeR5rdqBig7Z+3h7rvU1SjyvyBkUacT2/
cfUXM/ZTUfP2aWj6BGhIRDD53WDQar/SW3Bt8gGxD0h8QK6bcWlASHCACAcuF8ipvuuswJhO
xJjiOhSiaprOEZEAqwcAaAU5kFC8HlHqy0qE9nMryMJ0O2xiwco0odg7+8Ix1bdDcRafhxy6
Bi8G7BK3yxmnfquUkv9V1PDZSN3raUb3LKHoCEDExs3ay1PGdL6esUNKuCR/wIGMHo5YiYc0
DtMYOxFnDuVP4Slz5IrVZSzGimGL6tjEJGPoq9HKQQPWYlU7cmkCj8OhcaCvWjMs7hnNGBkz
dqpPCfH4zs489a4tUNMbjaGvJrdXarh/FHsY0if1mGGXijP8R6lLBDOVC3oDoXg4UfhWQOEx
aFl4xBGAnUwmR+oWrQDTqscGzWdiHcyRPQgMZUhMsHEBiBKfraPGQ7dGXnBEMVqliCaeKtGE
YP0rXNA8vg86TxIkWx0sWAiyuQsgQU4WAHJkbxeXSSlFpolEQnSaQMjU7c1FcIS5N3G01eWC
I0Z3NQHlW5Ne1hubKm3Zh3C6ItmOZRJvHdhtdT5QsmvLZS06J02pB4FbpkKbhBg1RRvH6ZjI
rcGIBMCp2Epr0wxd4C2qPGlwiBWRYfO/zVK8Ffn2XsgZNhdcm6N9lsc0jLDKcSDCNwABbS2k
vszSMEEkBwAiiiyY81jKS7uacd0B6+JzOfIluDWQwJGmSJdygCu3FGsLQDnqCrhw9GWbThOW
WLxx5Pi207c7NLbAnJadRoJUlZPxpcSB8K/t/Eo04b6t+H6ztbQrLj9EATI5OEBJgMxcDiRw
1+AiEMctSltEzJyRHNkUJbYLsa2Ulac4mcChs21NHyANp8haFUCIyPBsHFkao1VsE/MxR9uH
CM32mSfuy8rG0oxi98IGR4pJ4bxLM0xHqc8FDZAzCejY3sjpIaVICWOZRgj11JYxHgO97Qlu
kqQzILND0JHDktNlZHeETtFznSMxwZ0/Z5bHkVifE7QYrlmYpuHRrQ4AGdlj5QKUk239QvBQ
3GFR40D6R9DRaSYREIhtk2CXsUmzeERFegkm6LfiNR6+aE4HbMeQWHXyXBPPXOJS9C6LJ4i+
2OsLrImLK8R/bYoT7HsBzt21eOou2CX8wiMdP4SB/K06Q4SXPVIEBDsSxkY8N+MrkjODMO1w
jJeuz28fP396/de7/ufL25dvL69/vr07vv775ef3VzvWmsqnHypVzO3YPfoz9EX/Yt1h1N1G
1nsjeYezYGj3KyUV49E4Eoo4psgHWmeQDDK4a534TlSPZWGF410kvo2ywa4jSHKkcHUTrxVv
XNLHwXazlb/ZRtEf6nqAlyasZ5UZzZ2evW5lr653kZaBBB5OE4KwEcI3EQSRBgsQuWEdB3BF
KygxiQzCHXWM1TvdsotTTRa2rzsI0IjzLrCxZ3C6+i6i5755V7YFkiGQzV8iNiSEeDVuQQFg
4utbaHcLfK4AhHotW8+XbXVG3+OeZEJtMoXd6z///P5RfHbP+6Wxg/MVLE7RnnLWhQB0FqYe
rXWGKe6zDzNCWgZRfH8V6YuRZmngmLbrLCKUExhFl8YX5xbo1JT70mwN76Q4D6bJZF+MbpxG
Tj0NJk/4ImBY7P2MZJJ6N5lp3Si6fzETNPITZPTif0EzPJFH7VrxjSGCXRS1nFpQ/U0YslQ7
s3Fbo9HlFY9RCYH4GrbYjjpJElyuUjDxnNsAH4uxAsNcdjuioTDE6JSE72bWHFFEOwKGDlnj
bfL0NKHYRxEAPNUJFyJFv2pvECM4q7C6DPUeACovB7f1grxkAEGz/21/HaBlWc/1/sBuiyTj
F2QLnqBWE3Jiy1c2e9DkYxnF7hlWWH9LW6lZgmeWY+r0AmdR6GSW5UFqDap8V0cKyHL0RmlF
MyfRyBU2bwM5mKdWjWZxYq1T9WGSUXcMxlKRjOK4CHbxFLa84q7WC4oibtldqmnQJHKfX+XM
Mst4jNFrDIE+ZEHmJDnHY0IwrRJQVpVW3BlBraM0mTCgjQNilyCI/mNRsDw8ZXxa4ntdsZvi
YPOgEZaN8xMg//Hl48/Xl68vH99+vn7/8vHXO2n5WM9RdjV5dxU1gMVzIEhsduyZreT+/8UY
VbVMg4FmhNmSE8DonaYP88g3qOqJ3s6waS92Nn3RtIXHYb5nCQliXOGS78x4PMM1wJJevDIU
xajm4/pCp8S3mKEtlnGsRpbmsW5uzuIX9CzxbYuziapVyGqY6mbG6RsCxMJi+YMpjG/sIRoZ
T4nwtjIqkimsuODfHFGWsYiIeG0ITUMnapmYPm0Yh765pUyCnYq8byfTDNjMsitP5+JY4EEt
hNQ21B+6syN/oTy+L16IdrVZhHrqKzAk1qxRGh4i5ygE97mbGezzT2mFxsuYoud5ZNJkcLB9
SrJpwhHb3NxMhV78yc1PaHBmnrPfjF4pzf9A9+72qR1zWvh4WQO2vmt2C8n2Bl2BQz1BaJ+u
GYtjhTFArIeLjIXCLm2F5g4hr1gP0UA0rqV/Vj4u8xzxtW3wKHHKgUCDypIYq4FrJ6dh+zjM
jRHTMDV7m33nCZrmsPJBBPvEzUa42pGG2eY1BiSmHQqtmpUDlqaoow27pVuYSOJDqL7BWgjB
h/ZQnOMwRjUQiynLAnwsPFcHK4OU7rGaSeQxDtF5U7MmD3XbaQNKaEoKLFO+5SbhhNcVjvr0
3owRTNjduc6SpXTCu1Qep3eTx2jDnEPXhLLMU6Y8SrYL5TxJmuAdg1kHokyxqY4YoFBh7nQu
KA9JhAe9trhQZcLkMRQaC6JoLwoopt5eAM3mXrGzUubB8nCjhzL0VcZm0q3XNEzp2bagYXKk
qIJi8vDewQvoCR9CX+/0cUQwi1CdJcviHO0ajiToFtn279OcojsXaI0E3TmU1T1eT47FdwZx
VkeR5OASF8Xbc8+3cbuap4YdLh/gm7eeUh/5Bntnxgse3zYsQM9118oldNTNQkAkwkuQOvFm
YkbbvjBVVBNk6HOfxhO3WZqgi5o1R/i0lqf5Sky703zG9eAgwXz7DJ6MRp4DRIApFrl75eH6
R0ySEF1hoLdQw7rCxPjiC33pTE3QxjJ0y8C0Qgsl4faOtKh8vuyhs/zZW46JfrY7tVC29WhB
j94gTCvPxpOnyXRn6dvKx2Df4AwQ5cVw8WjqAY06DIFnym7PhfA1uxo+ybgAa66cPpSxRl9y
F0gyI2gDOcsfjyXGsjKw7vzkyZ4V56fuTupTMfRorVuuXjzs9p6sp7a/V/NamqJv8gxl225U
UPT0o/oA9Trs5a0Yaz60bYdG/qxBQJ3i055ala59/k1zba24xjrOuwM+PudrR7UfihG/3Ide
HoeqaD8UuKcTlH7shr65HDeKqI+X4ozb/XJ0HHnSGu9n3l//R9m1NTeO6+i/4qetmYfZ0d3S
Vs0DLcm2OpKliHLi5MWVSbu7U6cT9yZO1eT8+gVIySIp0Dn7korxgVeBJEiCwODThe4t6a+g
mIiP8ChpkRudG4rYLerdPruh7TewhjUVmTEdDlKVu9SsYIKO2z7p8UplXs99Tzt5EmFltiXP
Y2Qgi0eWlhUbkPasvrWyyaL7YieXkavXh18/8DyTcLOSEY5zGdBUZ4v94YJKFvTl68PzYfb3
+7dv6P5p6p1xaYhEnw+ZTKRbPDz+6+fT9x+n2X/NyjSzBn4DbJ+WjPN+kKmdilgZLB3HC7yO
fDwlOCruxf5qqW72BL27gen4WvFRiNSiLBLP2+msSPQ9Ryd2We0FlU67Wa28wPdYoJPPbjCM
yrOK+1GyXJGhIPq6h457tVSNqZC+3sFSMtdpdVeB0IXq3TkMphLjR5g9OMHNM4ERGS9xJpCI
W3urxUkbQfMEb0RYhtq6QyUSkPquZISox3MjKrbl1A5VyQCdYbZk7+j+XZRcb0LPmZcNVdVF
FrnOnK4Na9NduqH0OCXvPFNvJD4bDgPfZHwPOfN6u1EuIbnxQ7p41UlNWumErGLSTdsUWt9m
atwbJPH8epAojY5+QVuMZFovl70vdwX9Aj0wpfQRFAy/vYjWnOfVlrR4k02gWrZuB/9Xauvu
Ngzv1qtiU6tKEWIg5cJDLP/L97Q2yml2X5cwWLVnElh4W6NjQp14k7eLmucCXHKzNSNqOjjW
2GwhW/tu36KxUUt8jW1V3Wl2fz3Q9wfku2TbkjKGE5XbYSwFM720jJkatq2zP9j716ejumyc
adrHwHfZGEK1rNHl5H3+VxQYVaSd5cnvmxbM6OFdgzGtO739TSauVtKl0S11qqcGwvk1+AV5
R7ZBkKcIuvVhaUMD6T1Mp3PPTapdgrM0CJeIQKQ3eWSGnW8UhILLKhDS5IaTockRX6SVsBEr
PL6/XRe8K80hofgrBSZjZCi+TNPR9eMxnYmvKYIaL18Ph7fHh5+HWdpsz/7t0uPz8/FFYe3D
yxJJ/ke7se27AF0lMk5uYFQWzgpzJA1QdU3a0qv5b7Oq2NnSc9oppMrRZMVUqgSUy4pR1SrS
pR7feEAxagBWabsjNaaLva7nhh97XUSei7dYl3qhqFbTWgJR5FBsKNkcUNp0VuVqWItemUtk
nfYScogOxHLIOkjUmrgBYYaRAbq/cGq+Qe/xLKU6FsNZLrr0hpOW1z0Tr5eg5DdlfpOTXwfx
evlJBr1XvrZe5JMZfuTBUO9N77iCUtVpIwTfm+EwfxAioCrxF00XyFRm1Xsb18nwVzAxh+5R
VRUPyCnJ6DnFZ7POV4KxWzYrZhHN+x3oz8ScK7xCyyVhmIdw351S0anP82iazPeSy/7dGKwP
+21XlJycigF152S8O51l5077TiLRBUT3wzhBNUtFFZ07jkcsMoi4bmxHQF2zZIig/hh0QK8C
1wkoaUaEtDFSGIKQqs1VEKqeARR65Po0PaDaexX66gGkQg/Jcss0jNSTzgFYZF4ceT7VyEW3
5ylt43RWB/Bc/jIH98OSPPDUOYi2SyCY1lkCoQ2IqKwCr6T6UQAhIaY90Esp0SyELzcLOSJr
YvqVpcIRkQ0MPNV5oEZ3qY8oEZshmM7ETW1+wHa7mC4TAHocA+i7+umxCpGRAzSGhMoz9Evf
Iaq4gy2pej4xAELnJCRL6qIEP9rDEh8s53PXDy7KObB4geVN9ZkFtv/UqYbK4BGDV9JNKx8D
tW8YhHrfVZH2mmxYWzabGt3hOz4pqbAHTGInvjTTCRZQ6dk0cwGF9AwqsIh8aKlyJNrzV63I
uW+tMWCfSPyZjWfEsiDRhBRfWXHy/fLAwas4cSM0UBIBkTpWTvsGNhVuFLtUExCax8knLRBc
yY7OGQCbuAzwZXlBLnl9TGYA0H9QPeQi13EAfSciu7eHPs9dcJEzFoLQt4RADgi93J9RW66h
6/1j6RGEPq+z4CJ7BIag7xGTbFvC4kyM27aD2TXupXdSIdw+u7RBo8pCWmyqDDGxYkq6KJnA
5g4xPwuyNYVLrL6CTI9NhEI6o5Aug6+6UkRVniLFqmIZNw/xFATvIeXl4oShgh3TnsHfYlmY
JwuSo132mwehiFMfarJjMHFeeWiRNc0cgIhShHuAlrIBJMUfwCCM5gTQMd8jJhqkh4Qywrti
zxlxRNQx7oUhUWkB6A9vVGg+vzTdAoe4jKcTh3OXMg3TODxCNAAAxZvQ1DtQHgJKeeiWLInn
CZGivPE9hxWpR65YCvzJDKJymkEoTBbfJb37Tfm8HdVIFaY1PJ2FnDJHFkJ6ejBLd64RfWxg
4D7zvLnFD9CZSaqhnzPRrlV6jm3GXN8nOkIYGfshVb/e/vhiybdVHFrMMVQWS8hmjeVS9ZEh
JpdTQGyPJlUW2guDwuATk7SgE+oZ0gMLf0h+aoFc2g8hw5wYpYJObIORHnskPXaIHaWk2zZ7
PXpZY0IzFYfYawg6JVlAj+gmJRFd9WROVz2ZE5oD0mNacDmL44uz4n3pxw5VuXtxHJZEjUdO
1qgbz0PqzvHMgaaChGxIE0KSHlEV2bBtHAYWIHZtgEd0rATITUrXMHSqxox3XEOQQe0Qzkgt
1YPUFmsUeaRusGpZs54wyuukIpte/gNR/ajwc3QQ27X5ZtVRzi+BrWW3mvUF5k4ynoNv9B7O
+a/DI8ZcxQSTN9zIz4Iu169zBDVtt5SQCayB3hk/hSBt8T5s0rS8vCpo2x+E03XetpR5igQL
+HWnF5PW25UaZghpFUPHC3dm2U1bZ8VVfked1YqshNmJmSq9ExdkljTwFVb1pi24Zk88UvdL
Sh3ElHnF92psU0Er81QP0Sao91Bp66etFkU7kaDVkgzVJ6Cybot6y80kUEZXby33c4LhjrLx
QuSWlV3d6E25KfJbXm+KVCev7lqGkYJ0aoHOJQxSl5s1/MIWLW13hWh3W2zWjDJIkK3bYGif
ziy5TAeP2CpRNfeQhE19Uxu0elVQw2Sg44+GPks9s5DCgWi7rRZl3rDMQxn50JOuksDZW9yY
I367zvOS2yWvYqsirUAEcnPYlF1rdlDF7oT/CZ0qzOxWuv9IwV2kbY3OWayfqarxiiunIysL
hm3ZFZclcdORAcwAqdsuv9Kr2rANutsBqddGiUK291STd6y82+yMHDEkdpqRxNH6ZVyxVBjT
0UCeafdsKpYWlE2m4CgZeomFYTYZz01bwPJt7UPOQAQpM0QJVny7WZlZCrezpRH3WsW7nE1m
LyCCNML6k9vmUCiqKacTUlvRDyvFNNLm+YbxgjJEF1lWrO2+1Hd9vsMirVDluFLnj8Ic4TCn
8TyfzK3dGiYSOoqGhDEUsTWMJbJsce3eN9w3s74tCtOUVsN3xaainoohdp+3tdmNA80u4fd3
Gazr04EsnVjt11vaDFYs8GVDh/uk9IsxtK2mA412qRigt6Bj/E6SnU1xFOLQKLQwrddpsS+L
rgONLd/Amq5cyyM+2rNqhqkwBPddW9CejZBhW4qQnfQTdWSAfze253yIC8dQa8b36zQzSp8o
i0jDlikq2pne/Ph4e3qELi4fPrQwteccN3UjStyleXFjra+wN76xhW29UJKRDctWZqyeHu7u
mkumwDV8IX5bdCml41aVduDd3LZo55UDmWDuUamna7o/KuVbOkYJZCWDaw4Ru6v0T579iUlm
6+PbiY4HO5opV6nVjA0xnoEgqiPrTISJu1tSGhpyDD7vx9lIpNNc/QBhCzkVEXSho9PTayz1
Qy91za8tpVWdsmBWoJV2hWq9OFDOL6mVSH389PT4L0r6zom2G86WOYZh2Vb5RMTVXOzdPUh0
fjsskoOuA7+k1a+mIZ2p+4njrCmL0DZgldW9rgqGRYvL+AatPNe3GAtgs8qnezpgnW6iRHq2
8R0vTJSn2ZKMrkP9SY2FdRt5bDPCYTyp5OTCXgNbx3ED1w0mpeWlG3qO75DOCQSH8LvgTMoT
ZOqafECldcMkUZR41N5RwOeniCpRht3zaKphzSyg3gWNUTJ6JqFO2s5oaBZRNmE4OlydZhiG
pI/qETVbgsRoWkocqh5kB+JcjXU4EGP9am3sCYtDlDNDRD6jFvDgT6Jjna4znFHLS2SBS1t6
W96gUrhewB3VwbMACFcNUrozL9Yfzcqmd35IOmmSYiOf6hrd1aUM3/kZBXRlGibubjcpgnp0
bcp7+M802eB5yZau4L67LH03mRbZQ8YhtzGZCMvIv38+vfzrN/d3sRK3q4XAIc07Br2j1KzZ
b6OC+rs6IcteRtWdVlwFPo2mpTW53MHnm7QGXWBcyBIVpjuLRiu/jHAF1A83skO616fv36fT
K2pqK/nyz8hRAtJm3taagamG+X2txuHV0KrLLMg6B41ikbPOFL8eH7eBNJ42W0vOLIWdSNHd
WRISM98A9ZbvezFtie57+nXCsNJvs5Psw1F4NofTt6efGPL+8fjy7en77Dfs6tPD6/fDaSo5
5y5t2YZjVOwL33NoIKtyy2mNxgf78IJWEDW2Td5lOa3IGtnh0alViM+djEe1qiyzNM3RSWcB
2wb6bKKAv5tiwTb0AXDbpVKlINEM/TWK95MTEQdosV0ORuWKi9u7TbpfFpob0ltB1XYOffJp
eyWwr+qbHHYDXbG8U9P1KM/LJSrA1Na8ZwFJbziRVNBxzujMkJL99sFo2JAt2+6ygjcl0+qz
zoKADsGGBtKMp0Whn530sdtRfnI1ajj+HMC/HIPc1qJDQ+0YCACp3MGszrktUAnGghLnO+Xe
FkJQZaEkUMHlkZpe63HA94zadyb3lEV7DdNrIxTZc0Czcxr0YEQ9bVFgMZdoCWRgacox4E3W
KCY4+At3WwpFeLAt6q5cmMQWFiSDNrZWsmChWl0EdZNT2zaJifoYueDpI+/3/BiCj6V35y0L
mpS/Hb+dZuuPX4fXP25m398PsOcg7M8/Yx3KXLX5HWyetd1mx1YF6Xv8vKv7MCn7pmjUo1j0
wJyWyh4MfsDsgW+HtZi1AyO+PAKJVyYKuZoamZxp47vFUXSBuuYZdbCnpJt6btHBJIgVG1cF
Gxw7ThFehH7gkhkipMfg0UEyGJrOEgS2QvVYKQqWZmk+d2hbK4Mt8Wgvpyob9xx0DUlt0dQK
ScceSmWBOAkkrSS4SUNL/XtXWp9VTLo/qyqLz8v1LWhum7LWH6pLveDnEbbr/Pj+qrmAHvf+
eAWAIe9ArLsooN9Mk5koebCiXNTU3qWAJmyVAzz5IPzwcnh9epwJcNY8gA6Das+MT4f2Z6x6
OeLMQ7xwFHm0h+fj6fDr9fg43fJLJwj4IlL9MCMVJMbUX/oqEbnK0n49v30nCmoqrqnhgiDW
DKK/JNhP9YpnPT3zs4KBD2xvi3b0VXoEdfEWQwyP7+FNXvFG+pygTme/8Y+30+F5Vr/M0h9P
v36fveFO5Rv0eqYfZbLnn8fvQMb3YKokDQ/0CVimgwwPX63Jpqh8jf96fPj6eHy2pSNxGbRx
1/w5vlK7Pr4W17ZMPmOVavl/VztbBhNMgNfvDz+hata6k/j4pVLYDA1faPcEu8p/jIx6zv7d
0026VWWFSnE+6/+PvvdZz0EfIzfLNr8eatP/1MJFDHqmhDBAxGB+UW+yHBQdRQ1UmZq8Fa+6
Nql+Ga+y4GUvh3WT0ncVvrNjR0tJoHGBWjVss4ZGEEfEY4v3+Y2xcepZ8l2XCo+7Il3+zwl2
ZNbAF5JZxHgWr8yfDWDJGazCzoTebxvP9erJF2Pajjy+H9JL3cgiHGZbW7dvuk3oqu5Je3rb
xcncZ5P68ioMVXPYnjxcWmjH2zDHkjYjheqTGkMewnZkqVr2jrR9uqBYca9jo8tX1SSKx8WD
P1ANv1oWS8Glk/tdKSzIfQ01VP675GQavTFDqRzHwpnFUzaxwAS7SLkXpbsM8SFlL9/s8fHw
8/B6fD6cNGFksJFzI093VzYQKasxlu1KP1B0xJ6gW6QORO3GQxDn3oRAcun5LSrmqkMCfhuR
KoFC++ldVClIrTgdKNUMRqpZlIJoNcuYp9YhY76q74E8tZkTmYTEILiOLgSw45FF+WxXcAuG
V6uXcDyjM/CrHc8S46dpoSyJtIHz1S79cuXiNcd4s5T6nq/dVLF5oLrw7Al6fw5EM2YCkA3v
lioWB+TZNCBJGLqmW3hJNbIHEul0epeCoGhWmECKPNL/K0+Z76gefXl3BRsvTycsWG9DO6gv
+mCTA/DlAVSh2ek4+/r0/en08BNP7WBhMIejfOYAw7vsNDs2ls2dxG2pSgLkeoE6guZu4hmJ
vYh65oZA4pqsZBhGAcRaKYFq5wu/I2fye18s0bfy8PreAhuyAdjcVl3YvO5dLZu5Oijxd2Lg
iW9kHpPRcQFIPJM1sbhpRSihdjcsSwLVdyPMpSIetBbaOE3RiaNrEPEesCeNq/NGvs8/R6W3
2HLAyk0v7+vdnHQ3KS+q9BpgMN1g7hoE3WJZkBJ6cy0xWhNBNcXxSA/8IvatOsgkJdYJnmq/
jgQ/0mNTsF0SkU3F+K6eowYQAELgaSMESQmdOt/s712zqzZsO4/VCPQ8ExpdVWf99Zhq5S2C
OwBM21cI4XBil5qGB9DXajtQA+6QN5kSdz3XVzqxJzoxdx0iN9eLuWMJj9FzRC6PPGpcChyy
dUOjOD5P9OcFkhr75I1uD0axWWsu7yJ1qgxnYYwXALoyDULLu98hvkFl/Rh4YgMMq8bGcbOM
XMf8mD3Wb752Q6WG9eDS3K+uDsvX48tplr98VZYEXOjbHBaiMifyVFL0+/FfP2HfZmxhWBb7
5IS6rtLAC7V8xwxkDj8Oz8J6iB9e3rTNHetKBlrqujc0U6Y8AeT39QRZVHmkq3H429S/BE3T
vNKUx6quVbBr0/8zTzN/GsBlhNF4uC1wW7JqfPLtWsNV5ebmPk60QAaTjpDvAZ6+9oQZfKje
0ZDma4pkUD9uxcfQp95o4c+bId05U1X14805lTwTNHXDM8N6u1DbMc3YUCn1ytCY9nUMrP8y
clvdyzuI/oMUWE3rUQQ0dCL6NT+GQCDfdiOgO4IGSkDOhwgEkcka0PubMEw8vP3V3wP0dFsK
X5V/IDiaPhZGXtBOtZwwiiNr8BGEk8gavwTguWVHLyDKDAmBSFOO4Lde0fnc0VtialO+6uMR
5pVY3zpmTY1uGuk6ZzwIyEdzoDi4keprETUJzXt0FXm+vgbCeh+6Vl0jjElBgGU+mKtO8ZGQ
eOZyCA1wYg+tX2zLIXCE4dyy9gI41/aGPS1SNw5yHUEnUcrgvDhepAEuTCJf35+fP/qDPHWu
mWC9T9TD/74fXh4/Zvzj5fTj8Pb0b7QzyTL+Z1OWZxdp4jhfnK0/nI6vf2ZPb6fXp7/f8eZX
H6nJ5G2kdiNgyULk0fx4eDv8UQLb4eusPB5/zX6DKvw++3au4ptSRb3YZUB7pRbI3FV78f9b
zOgG9mJPaTPa94/X49vj8dcB6mIujOL4xNG3JUhyfWO6kkRame4PYSxbZJbtWk576F9UK1fz
Wyp+m4usoGnT+HLHuAd6uMo30vT0Cl03am22vqM+QO8J5GKyumtry7GGgOynHgJWDz3G07Fu
Bbq+Q8qn/dPJpfzw8PP0Q9FzBurradY+nA6z6vjydDLCIbNlHgSkT1+JKLMrHsI65j4HKZ4q
u2R5CqhWUVbw/fnp69Ppg5DDyvNVjTxbd+qktMbNgLotWnfcUwO4y9/6p+tp2kdfd1st7nsx
d1Qnxvjb085HJlWWMxvMGye0hns+PLy9vx6eD6DZvkMXTIZW4EyGVhBNSfNwQtKVz0KOE+UM
sXCtfk560BgyNY/nam0Givlu+UynXyxfVTt1YS42N/sirQIY/Q5NNQaUiui6GSAwBiMxBrXD
dBUw8xoASs0reRVlfGejkyN9wC7kty98bSW8IA1qBvhde3ewBHW8LpCmiMJz8ThOlNn0S7bn
Prn/Z9kWTy5U8Spx1Gq/0W2CQmgynviakCIl0WbltWu8vEdKTM/2aeV7bkzVDhFdLwKKb3Fe
AFDkUCeICET6Aeqq8VjjkIF6JAQtdpylNvdi1FkXuoN08jnsKnjpJY56uKMjqscdQXE97fzp
C2eu59LHFG3TOhbT7u7/Knuy5sZxHt/3V6TmabeqZyp2nOuhH2iJtjXWFR2xkxdVOvGkXdM5
Kkd9M/vrFyBFCSRBd+9DV9oAxBMEARIEKttX+xpmcGa/uANpDALb3TtsJGcx5IWYWCm6irKB
ySe1ldBk5apvx5ZKJhM2lQwiZnaYgGZ9chIKWtF07XVSBxxZmqg+mbFuNgpzbrGOmYkGxv30
jGuawlCHbQSc0zsdAMxOT6yOtvXp5GLKvWy/jvJ0Zp2va4gd3eNaZupQhitAoc6tdXSdnk1Y
N8RbmJipuerqxYwtErSX2d3j8+5DH94zm+rajvmgflvNFevjS/4osb9aysSSvNAlQPYiSiFs
JUssQVTZT4ZOTqd2yJZeuqqvlZZ0YE2usugUcyV7S7JHONFmHKQb9qZHVxlwrLeZhsg8K9j4
8XGTMeazf/2x+8e6QFEHKq2fgdIQ9prG/Y/9szfDZO9h8IrAOLIf/X70/nH3/AAm2vPOrt0E
MR8vYAlSBQeu2rIhaGvKGnQ4xwwjhoB3ZMbJvakXNU/Vd4NvbL8TPoOeCTbmA/x7/PwB/399
ed+rHJ0eyyu5PuvKorZXzs+LsCym15cP2MP3zBX06ZRKkLiG5ese7Z/O2CdLCnNhXwwAgGb4
BgNfbzf0rH82YQOtIeaUxtVRpNZm35Spq7IHOsh2HiaC6rNpVl4O+bwCxelPtP38tntHZYgR
S/Py+Ow4W1LxUU5tdRd/uyJGwZwVHKcrEKqcvI5LUJJImavSnqgkKnG02HS5ZTqhxoj+7VwV
a5h7U1ymIO44tSWrT88m9rWvgoRyJmukLUsBRgMm9WJTB9RnoayCqzFWyc3pzB6cVTk9PuPa
dVsK0OHI1WkPsGsyQDM65qzDZYlR033ePz+y2m59cuneFtLt0Pqu57uXf/ZPaLHhcn/Yozi5
33FlK5XtlI1QnSaxqPBNt+yu6cnefDKlJ31lkhMurhbx+fnMvq+qq8UxG3pre2lxJ/w+te7u
4TuiXaKqcXI8dXSH05P02AukSUb74ED0LqbvLz/w/Vforp+YHdP6kj/TmtaTqS0WflKs3p52
T694+MaKCCXGjwVsPTKzU7M10fTygjcZQJ4mWYdhNrIiKtoy5VyOsnR7eXw2mVkrUcFYod1k
YFhYp/EKwt0NN7DLUU1a/Z6SuB14hDK56GM6m32PGYWxrnLjp5dKqquj++/7Vz+0E2DQEXr0
0RJpt0hoLm4Ry0ogHTEAqskaI398JZlzvCqGGkpMLOO+QVDpwgBXRI0IZfWrZYPuYk1VpKmt
AuhFu7o5qj+/vSvPzrFHJqsIoMk7hhHYZUmZgKRfWY975lHWrTGFdFvPp0jGtgk/xzhAeSS7
pqgq3luSUql6nvgSapFec09mkAaTVyTZ9iK7wha5JWTJVqZjRwJllFvRTS/yrFvViR2mgCKx
w+HOKp+NUKY51RRRlqsil10WZ2dn7NaIZEUk0wLv0Kq4T9ZgJI41i8Mn6ARr5V/NqPsj/OjS
0jqAqoT/bk08P7y97B8skZTHVREI4mHIB21AkBiS+XUmM+en1lHN6ctqc/TxdnevNhd3mdUN
yVAGP/CdV1PgJRyNPjUioOCusREmqxAB1UVb9YndCxrbjODoI9BxEwMtPe2aFTsKTDeGw79y
aftspQ3KhrKChexdTZNvumxZDcSOGjHgh4QWHDKJ5MzT4wYs5uzZFtPA2aMim1dJvJRM4xeV
lLeyx7Nc3jesrFTySdwiuFtSVUsll1bgsGLBwxUwXqQ+pBOLlkBrEuIUfqgIE/jOKi9iaWN0
NB8TYsBH4C0594FQEZOodEBkHRX8K2yFnEt0EuY2SgxVAQO0Hc8kiXXqO/ODJQu6wPL8cios
d2kNriczNo8xou1+IgQfClHBwlU8iJesK8rS2pAS9i1PnSbZ3A4+gCCdc89NSEtWVwX/z2Vk
xe8B3sn5gEuZfmw4Wki2Z72+5dz/gN1eSUlLx7oWqHeCzgnGcimqmq1AbvEtEs2RZiDdHF9Q
wWgQHD5A7RBsPYnERw3o+HXj4glvdLCvVTclRs/jlkiNidfw3bj9kQYGw9SMFPM2Af7K0YU0
F01bSdromnlBrEHsHCmMekRByhBDGT3kqi0aizUVAN98YqACPdXo4clvj5hdrv9iI6qcf3Sp
8SZ0jQEusqa7tl4WahCnb6oSosZKpCTapljUMxgW/npVoUPYRYtRIbkTtQJmIhWonhAhN8Aw
5l5SAdt38GfsDEcg0o2APW4Bql1hxQglxEkeS/6VICHKJPS9KG+8zT+6u/9OH4Mt6gi2CWnz
ngKpCCOBkegpMJdbsawEFw/J0Jgp9D4u5n9il1Mog/cr0C3VSu377vPh5egvWO3jYh/4qegT
HRIWA9A6sPUqJEbMaOjrcwSWAp+SF3lixTnRbwBXSRqDYjuC17LKrfSKvdIz2jZ2mxQAT9MS
kOIRr9xrmq1oGlYeymwRd1EFaov1Yhj/KK61FEh/xMhOktQ6QoEOAsCxNKzlTVGtKRVR80x1
5Pf11PltRUrSELfjFGmZkRrSBXLaF6Ay54FFqpumOCyIx3Wsn5iDLGQ73xPhHINKCER23+Kk
FnOQ9m1cciHpgIQ7RoOFgj7xILQLGpwEdgz3J46GVWEf02hktjavysj93S1re0/WUG8HGfde
Wa54iRYlC6so/K0FAidqFRZTaG5AOtUygj1ofMNvl7GRAozkDcbS48OEKqq2xDjAYXxoiSik
J3FGKG/SjXg0J8rOjTTsEP5C+w5xYFTEIrgBhXefy5KfqTylzJnWJpjM19/27y8XF6eXv09+
o2iMla0E3ezk3GJaijs/4Y5lbBLqZ2FhLqgnkIOxTvQcHHfW65CEW3wR8JhyiLgTSodkeqAO
7nLUIZkd+Jy/rHWIeL8wh4i9kaYklydnwYZcsg5kzudTm6tGzOwy3MNz7oAWSZK6QF7sLoLz
P5n+vFVAM7FZS8WXsVtqqpq4VRkELwQoBX8oSil4p2VKEZ5rQ8F55lP8eagDockfen5iD9IA
nwVG6tSGr4vkoqvsMhSsdWc+ExFsxxkbvNvgI4mBGu3SNBzMhLYq7LoVpipEg7Ff/W9uqiRN
udKWQqb0gHaAV1KufXACrbKeow+IvE0av3jVSd0kbwDA5FonbLhKpGibhcX0ccppy22eRNbh
RQ/ocnwXnya3Kvb6EPWJ3EQV3eaKKn6WRazfFOzuP9/w8sKLVIUbHZ1S/A3GyFUrMSKPu4MZ
fVhWNejsMHtIjwGCqAGtLV0Z67KfrLK7eNVh0lnVF24vQxplayaRpiEaDmoVyh7OZK2OwZsq
sU8SDAnr8qBRCzfkD3CmsnYzGOuVTEv2nMCEZxvbIAinpXX29Tf0gX54+c/zl3/vnu6+/Hi5
e3jdP395v/trB+XsH77snz92jzgJX769/vWbnpf17u159+Po+93bw05dvo3zQ4KsHu2f9+gR
t//fu94p28w82CnYhWgNY5YT1lEIDDWgcpqT2HKk64YGz/kICe+MwbfDoMPdGN6euAw4qGvI
K4U5E4ve/n39eDm6f3nbHb28HX3f/XhVju4WMfRqaeW6t8BTHy5FzAJ90nodJeWKnnw4CP+T
lRUMjAB90oreb44wlnDQ4dwPRLAlItT4dVn61Ouy9EvAjPI+qQlPFoBb2lKPciNLsh8ORpSK
YucVv1xMphdZm3qIvE15oN909Sf2B7FtVtIOxtdjsCnhhvdxI3puLT+//djf//737t+je8W4
j293r9//9fi1qoXXsNhnGhlFXkNlFFtJKgZwFddc/HzT7ba6ltPTU5UaTd/4fH58R6eS+7uP
3cORfFYNRo+d/+w/vh+J9/eX+71CxXcfd14PoijzmraMMn+4V7BjiOlxWaQ3E50rz226kMuk
nrDBks1ak1fJNTMSKwEi69p0aK7enDy9PNCjLNOMeeQ3bTH3yoyaimlhxEZUHJox94pOq41X
dMFUV3Lt2jKcD5vgphL++sxXZGCdYcWoeU2bMf3B2JhW9Cp9KXf3/j00fJnw27nigFuuR9ea
0nhB7d4//Bqq6GTKzBGC/Uq2K53DxO3YPBVrOZ2HJ0sT1NwcV1EzOebzPRr+ZiV7cAKyeMbA
uBWQJcDK6paad5A0UiOLDy4TxNuvGEbE9DQQBG+gOJlyppZZgSsx8ToDQCiWA59OmJ10JU58
YHbCjAdmypLzInA+1YvlZTVhg1P0+E15qp7YaS1i//rduk0bRI+/1ACG8bX8URR5O08CZ0A9
RRWxUQwN7xUbO2Skg/BO9AxrikyCgeNvGZFAlTz0Ud1wvIZwzsg0u5DkFsdC/T3U9fVK3Ao+
lq6ZVJHW4hCPma2CYwgpD5ctq5J3MBn4bMYU28gDO2azKdjZ6uHjuGsOe3l6Rfc7SxsfxnSR
ikZ60j+9LTzYxWzKsF56e4CvALniFJfbuvETHFR3zw8vT0f559O33Zt5oMk1GkNDd1HJaahx
NV/qCK8spt8X3OZoXPCElxBF/DHuSOHV+2eCcaIl+j+VN8z4ofLZgSnw0/oHQqPe/xJxlR8U
VQMdmhjhnmHbMC61a/v82H97uwNb6+3l82P/zOzO+LqJk2QKDiLJZzx8DqV3wiGbIPex2S25
7/VqPfi5JuG/HtTRwyWMWiuHjgOdNlsy6NnJrfw6OURyqPphaw8PANFsOaLAFrnaeCB0VRFN
1ocgC2M5m2DEYn3HM8EtP6DRgUMPrj+gwhwv20hyl3KEKopgj+bbmWHauqhbbtNAOwhF0JVB
1DdZJvE8R50AYeahsTaCLNt52tPU7dwm254eX3aRrPrDI9l7fVi3wuuovkD3g2vEYylBzxAk
PTdRxceiLCwai1gKcTBLlrnE3HPaFwTdM8xJ1rDO8XnjX8oQe1eZIt73j8/aZ/X+++7+7/3z
I3GPU/euXYNpyfSJmh2O28fXX3/7zcHKbVMJOjLe9x5Fp5bS7PjyzDpcK/JYVDduc1gW60sG
oYLJFOqGJzYX/b8wJqbJ8yTHNigfksXX4YFnSGqmYLCLqqswSLztISCUnw4z9fMENFIMvE4G
yvjJgrKaR+VNt6iKzHGSoSSpzAPYXDZd2yT0yi4qqjixfDYx/5/s8jab8+Hf9fmpSP3iyyjB
+MfUeDQoBwwmECxr2Eot0OTMXsVRd8BOgjKbtrPOqBwDDn7SE2taMGJgLcv5DW/kEAJHm1MY
UW1EIDeJpoBZDGHPeP0qsiy4iOahSea+yRpdENmzta1FYLe4yGjnBxTofKhNOg9NEIpelC78
FvcVUBNSa9ne6v3QUTRBw2RKRigpeewTKpIdC2fpUcFkEdtbBNMp0pBue8GZHj1SOTJTB4Ye
noizmQcUVcaUD9BmBWskXEkNctuvYh79yZQWOPkbe9wtb+l7AIJIbzPBIra3AfqCheMQ++tW
HeLbiZdgM8ak2Glh2YIUisVOiCoyjwh3irouogRkyLWEQawE8evDBIcgKKhHN4Jiq4OZsP0i
YxW3MkpFhT7XK6Wbk9pM4kSVFQVpF0XVh7Gl84AY1JtDOkK9TPVYkIqvqAhMi7n9i1l9eYp+
I8wgN0WWRJT1ovS2awQpERN2gPpHaszKBCMQUDGxiEllhcq2u4TdryJDjNdW+dIWi8MrLGcb
s2+JjHKgoK9v++ePv/VzpKfd+6N/t6e2yLXKpWRtfBqM7iv8Ib32msd0xClsg+lwFXEepLhq
E9l8nQ3j0mtNXgkzMts3uYARP+CaZFEcCPB2k80LVAplVcEHklUwgoM1mPP7H7vfP/ZPvcLx
rkjvNfzNH1rdpt5882DozdlGtvM4wZr1HjjlIJR1mQZ2MUIUb0S14Ha0ZQwrIKqSsrGuZ9WV
S9biYdJK0nSRiwqGTznkfr2YXE4pv5YgM/BVR2apUBVYuKo0QDL1ryQ+kUJ31boRdN3oxoM+
qW60s6TOREPlk4tRbeqKPL3xRxRkSQTadpvrT0Sa4Lt39lRYCaKNyJu+p2Wh3JRrdwR6eKgu
7b+m84Dx2uyvstN/0QQY/SqPd98+Hx/xEjV5fv94+8TwJ/RhAOb/RuW6uiJyaAQON7l6nr8e
/zPhqPQzM76E/glajU4AGI5/tCf6UajdmRxc//Qsu6OmvSUVQYau/gcYeigJ77NZunZeC/6S
+pcG0m649u50u4O+sV+tZKljYUS6ooQDwwnjS9o367oUxKvtineBx6+LTc7bnsrkLJK6yJ2X
BDYGRgkU4TyU9cwhxoTSrIJjWgvreeGOhXbR9ma8B9MN1um+oUD3ggMTbshU6IRA/jWLEF2S
f4Gsilolf4IdNoSwkGEdmzcooX72UtPsYxNHkikXjBb3PCLEQLrGPUrm8SBsnQZfc5Kz50OV
HEE5alBt7FrSatHjf6GfCvht8pFRpFSxtQC+YU7DNBbHWLOX4q7kFmMYx73W7zqFjEvD7Vq9
wrev7pm0oj8qXl7fvxxhpL7PVy0dV3fPj1R5wdyC6J9SWKqmBcY3Pi058dNIZKWixQRyo45Q
LBp0q27Lw+G0NbJbtdD5RtQ8o22uYBOBXSkuOC1VnQnpuuyXS4d6rZ20YKt4+FT5k31po7nJ
82tWYOaVhnG7YYq02QQHay1lqeWMPkvBi/VRev73++v+GS/boeVPnx+7f3bwn93H/R9//PE/
5JilMGmml0q5HVziB6UTcxkyb6M0ohIbXUQOwxc6UlIE2NngiqkaUGwauZWewDIpsTxZz5Nv
NhrT1bB6StGsXIJqU1vvITRUtdCxUZQ7vyz9ld8jgp3RJgm0QMqSqwjHWV1emDyQtArVEmBz
fAzmmbYjKw/d7Mtguej/wxDDMlAvHWD9L1JBvQOVWFLIEaa0Oxg1zDgOJizwuT4+8YdsreVx
QKb8rTf+h7uPuyPc8e/xANFT2vEwktmt/UdINv9wa12jtLuipUeqrQNscNEINFww7o/RESx5
EGixXX4E1gQY1KCTjcnMopZVSfRailp33eFu2PfbzA9hDUulB0rMxRQ6DkG88y3BgALRqYDl
bLlq2gNlyiv6asNEvrC66U4JyGGtkFeMKm6WgQD9LLppCm6Z5SrYErSJbPv6N0aX6Bwu1Rwd
2UJEWfJuaiKVLErRW2f18AeWWtPVmwRtGrdmUlSvA9cbel4LJqPMgI9AQ1efKiultttn1WeO
NrgusjJ64fR4XhQN7g+k6NF7tLqCTXXRF86d1qgNy617tUlFExr0OhelndDZQRiryxkZPTNz
EBowrDpPrNNaCyc942JcKwotcljSAi849HfOvYGhAoFl8Czv9ZX6I0SOLvJmpdmFO+XX/dLc
lOR/6lfTFKdYoJsDh68yUVnKJeWmgYBthKkFTL5MlOreiqVbRpg8re/8wlvLA51GoaAHKVGG
9x7awp8SE+aPJT5wDVLWArPN+SEvXl53z2/793tLbtLjtWb3/oHbG2plEWa0u3skAd7WbU4f
BaifJMXk6OOuEMHWabTcqkb+jAw5LJTg2Ww6eOpVVD17uCEWKnmI2nrIoFJ083RM7fqIYayU
vu0VSaqtybDxq2gWqHj8vGx66GAXkGWReakQqMUuaFQ9kMn5gAO9AQRmD3K7JqaXFBVYiUoi
ajXVy3ycruOGjw+h7QK8CK1B6IZJsiRX6bnDFMHv50P/UJ07sPLm6HF3AE/vEYJU6owMpcbh
wnr7OqBOmGN39pJQ9XYlt/gi88Bw6ON0/XSDFaM9VR2V1vmhvr0HRMNGuFDo4ZaZAudJo29S
7aIADGsn5Q91FUXbugF2KHarrmLCeGPMhykqvIRs8KQiTBP0iVLYJOZ85DTvrokPuOkw2ubu
jF1n3sq3BgH9oyLHc0uXV/K52TUSHQlWhTqEuebXe5LH2CZ+v6NlLZIqA6NDei3QMQE4bUYh
iHS3wqgp9wZW8A8UxAnB+x7aXIcXkB40tesdWgTqHVPw2bIWLTKLQPviVGFTCFqVSeOxNnyJ
cLZowAUtx4Nbq/d6SF9v/R+tj94I4HEBAA==

--ZPt4rx8FFjLCG7dd--

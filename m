Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F282F43E1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 06:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbhAMFbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 00:31:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:8081 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725988AbhAMFbI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 00:31:08 -0500
IronPort-SDR: 8x5vMkuTpJYzh4gRLfyIEbbt4Rw6XGvL2YuTIAlUpTz+H5h20XTm/TkvVf4IMZu9MsGguX5OVW
 B591cMrwMdOg==
X-IronPort-AV: E=McAfee;i="6000,8403,9862"; a="174645465"
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="gz'50?scan'50,208,50";a="174645465"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2021 21:30:25 -0800
IronPort-SDR: ZRfyNfJhC2KisHFe5T/oyfsMEiLy8H2kWLKeVRBOUJhMb8danRP93Js7Fk96If+1gVi4LuWqI1
 YVe/ovN4qJ0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,343,1602572400"; 
   d="gz'50?scan'50,208,50";a="400424752"
Received: from lkp-server01.sh.intel.com (HELO d5d1a9a2c6bb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 12 Jan 2021 21:30:21 -0800
Received: from kbuild by d5d1a9a2c6bb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kzYjc-00004E-VV; Wed, 13 Jan 2021 05:30:20 +0000
Date:   Wed, 13 Jan 2021 13:30:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Felipe Balbi <balbi@kernel.org>
Cc:     kbuild-all@lists.01.org, Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH RESEND v4 08/11] usb: gadget: bdc: use the BIT macro to
 define bit filed
Message-ID: <202101131315.9VCNOfZJ-lkp@intel.com>
References: <1610505748-30616-8-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <1610505748-30616-8-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chunfeng,

I love your patch! Perhaps something to improve:

[auto build test WARNING on balbi-usb/testing/next]
[also build test WARNING on v5.11-rc3 next-20210112]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Chunfeng-Yun/usb-gadget-bdc-fix-improper-SPDX-comment-style-for-header-file/20210113-105252
base:   https://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git testing/next
config: x86_64-randconfig-s022-20210113 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-208-g46a52ca4-dirty
        # https://github.com/0day-ci/linux/commit/b9301494d83b247a1c4c1ecc892a9f806dde0aaf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Chunfeng-Yun/usb-gadget-bdc-fix-improper-SPDX-comment-style-for-header-file/20210113-105252
        git checkout b9301494d83b247a1c4c1ecc892a9f806dde0aaf
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"sparse warnings: (new ones prefixed by >>)"
>> drivers/usb/gadget/udc/bdc/bdc_ep.c:498:26: sparse: sparse: cast truncates bits from constant value (ffffffff7fffffff becomes 7fffffff)

vim +498 drivers/usb/gadget/udc/bdc/bdc_ep.c

efed421a94e62a7d Ashwini Pahuja 2014-11-13  423  
efed421a94e62a7d Ashwini Pahuja 2014-11-13  424  /* Setup the bd dma descriptor for a given request */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  425  static int setup_bd_list_xfr(struct bdc *bdc, struct bdc_req *req, int num_bds)
efed421a94e62a7d Ashwini Pahuja 2014-11-13  426  {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  427  	dma_addr_t buf_add = req->usb_req.dma;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  428  	u32 maxp, tfs, dword2, dword3;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  429  	struct bd_transfer *bd_xfr;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  430  	struct bd_list *bd_list;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  431  	struct bdc_ep *ep;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  432  	struct bdc_bd *bd;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  433  	int ret, bdnum;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  434  	u32 req_len;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  435  
efed421a94e62a7d Ashwini Pahuja 2014-11-13  436  	ep = req->ep;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  437  	bd_list = &ep->bd_list;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  438  	bd_xfr = &req->bd_xfr;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  439  	bd_xfr->req = req;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  440  	bd_xfr->start_bdi = bd_list->eqp_bdi;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  441  	bd = bdi_to_bd(ep, bd_list->eqp_bdi);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  442  	req_len = req->usb_req.length;
cc2e895c604c480b Felipe Balbi   2016-09-28  443  	maxp = usb_endpoint_maxp(ep->desc);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  444  	tfs = roundup(req->usb_req.length, maxp);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  445  	tfs = tfs/maxp;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  446  	dev_vdbg(bdc->dev, "%s ep:%s num_bds:%d tfs:%d r_len:%d bd:%p\n",
efed421a94e62a7d Ashwini Pahuja 2014-11-13  447  				__func__, ep->name, num_bds, tfs, req_len, bd);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  448  
efed421a94e62a7d Ashwini Pahuja 2014-11-13  449  	for (bdnum = 0; bdnum < num_bds; bdnum++) {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  450  		dword2 = dword3 = 0;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  451  		/* First bd */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  452  		if (!bdnum) {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  453  			dword3 |= BD_SOT|BD_SBF|(tfs<<BD_TFS_SHIFT);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  454  			dword2 |= BD_LTF;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  455  			/* format of first bd for ep0 is different than other */
016040268ccafaa7 Dan Carpenter  2014-11-29  456  			if (ep->ep_num == 1) {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  457  				ret = setup_first_bd_ep0(bdc, req, &dword3);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  458  				if (ret)
efed421a94e62a7d Ashwini Pahuja 2014-11-13  459  					return ret;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  460  			}
016040268ccafaa7 Dan Carpenter  2014-11-29  461  		}
efed421a94e62a7d Ashwini Pahuja 2014-11-13  462  		if (!req->ep->dir)
efed421a94e62a7d Ashwini Pahuja 2014-11-13  463  			dword3 |= BD_ISP;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  464  
efed421a94e62a7d Ashwini Pahuja 2014-11-13  465  		if (req_len > BD_MAX_BUFF_SIZE) {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  466  			dword2 |= BD_MAX_BUFF_SIZE;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  467  			req_len -= BD_MAX_BUFF_SIZE;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  468  		} else {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  469  			/* this should be the last bd */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  470  			dword2 |= req_len;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  471  			dword3 |= BD_IOC;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  472  			dword3 |= BD_EOT;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  473  		}
efed421a94e62a7d Ashwini Pahuja 2014-11-13  474  		/* Currently only 1 INT target is supported */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  475  		dword2 |= BD_INTR_TARGET(0);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  476  		bd = bdi_to_bd(ep, ep->bd_list.eqp_bdi);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  477  		if (unlikely(!bd)) {
efed421a94e62a7d Ashwini Pahuja 2014-11-13  478  			dev_err(bdc->dev, "Err bd pointing to wrong addr\n");
efed421a94e62a7d Ashwini Pahuja 2014-11-13  479  			return -EINVAL;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  480  		}
efed421a94e62a7d Ashwini Pahuja 2014-11-13  481  		/* write bd */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  482  		bd->offset[0] = cpu_to_le32(lower_32_bits(buf_add));
efed421a94e62a7d Ashwini Pahuja 2014-11-13  483  		bd->offset[1] = cpu_to_le32(upper_32_bits(buf_add));
efed421a94e62a7d Ashwini Pahuja 2014-11-13  484  		bd->offset[2] = cpu_to_le32(dword2);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  485  		bd->offset[3] = cpu_to_le32(dword3);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  486  		/* advance eqp pointer */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  487  		ep_bdlist_eqp_adv(ep);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  488  		/* advance the buff pointer */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  489  		buf_add += BD_MAX_BUFF_SIZE;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  490  		dev_vdbg(bdc->dev, "buf_add:%08llx req_len:%d bd:%p eqp:%d\n",
efed421a94e62a7d Ashwini Pahuja 2014-11-13  491  				(unsigned long long)buf_add, req_len, bd,
efed421a94e62a7d Ashwini Pahuja 2014-11-13  492  							ep->bd_list.eqp_bdi);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  493  		bd = bdi_to_bd(ep, ep->bd_list.eqp_bdi);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  494  		bd->offset[3] = cpu_to_le32(BD_SBF);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  495  	}
efed421a94e62a7d Ashwini Pahuja 2014-11-13  496  	/* clear the STOP BD fetch bit from the first bd of this xfr */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  497  	bd = bdi_to_bd(ep, bd_xfr->start_bdi);
efed421a94e62a7d Ashwini Pahuja 2014-11-13 @498  	bd->offset[3] &= cpu_to_le32(~BD_SBF);
efed421a94e62a7d Ashwini Pahuja 2014-11-13  499  	/* the new eqp will be next hw dqp */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  500  	bd_xfr->num_bds  = num_bds;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  501  	bd_xfr->next_hwd_bdi = ep->bd_list.eqp_bdi;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  502  	/* everything is written correctly before notifying the HW */
efed421a94e62a7d Ashwini Pahuja 2014-11-13  503  	wmb();
efed421a94e62a7d Ashwini Pahuja 2014-11-13  504  
efed421a94e62a7d Ashwini Pahuja 2014-11-13  505  	return 0;
efed421a94e62a7d Ashwini Pahuja 2014-11-13  506  }
efed421a94e62a7d Ashwini Pahuja 2014-11-13  507  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
P4fcapOTIgIA

--IJpNTDwzlM2Ie8A6--

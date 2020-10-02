Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E56280D1D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 07:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgJBFjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 01:39:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:28406 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgJBFjp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 01:39:45 -0400
IronPort-SDR: kVPeOvAKE3QZ5WuLUgu6OeGQqVjfQjtUmiTG8VD7leSHS5j9f/P18US9A78wvX+/EYJASR5z0f
 rp5/7HbiHPlg==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="150556348"
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="150556348"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 22:39:44 -0700
IronPort-SDR: g3MD/bm1EdWXGs6bMtX1z37iyIG+66fL8i9//nJPuc2/HUOX5cTT7Iei3+tzJRhjkL7pVidKEh
 3ZgLpz2OWlSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,326,1596524400"; 
   d="scan'208";a="308919771"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga003.jf.intel.com with ESMTP; 01 Oct 2020 22:39:41 -0700
Date:   Fri, 2 Oct 2020 13:36:25 +0800
From:   Philip Li <philip.li@intel.com>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     kernel test robot <lkp@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kbuild-all@lists.01.org, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        James Hu <james.hu@broadcom.com>
Subject: Re: [kbuild-all] Re: [PATCH v5 03/15] misc: bcm-vk: add autoload
 support
Message-ID: <20201002053624.GB30771@intel.com>
References: <20201001012810.4172-4-scott.branden@broadcom.com>
 <202010011123.tZnlIwLB-lkp@intel.com>
 <1478f8a3-4470-3529-90a0-c6a04703e76a@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1478f8a3-4470-3529-90a0-c6a04703e76a@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 10:48:08AM -0700, Scott Branden wrote:
> 
> 
> On 2020-09-30 9:07 p.m., kernel test robot wrote:
> > Hi Scott,
> >
> > I love your patch! Yet something to improve:
> >
> > [auto build test ERROR on char-misc/char-misc-testing]
> > [also build test ERROR on soc/for-next kees/for-next/pstore linus/master v5.9-rc7 next-20200930]
> > [If your patch is applied to the wrong git tree, kindly drop us a note.
> Yes, this patch series will not compile as described in the cover letter without Kees' patches:
> 
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
> 
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition in
> other patch series [2] being applied first).
> 
> Please note this patch series will not compile without [2].
Thanks for the detail info, and sorry for the wrong report. Currently
we are not able to analyz the info in cover letter which may lead to
wrong base used. If possible, you can give a try to use --base option
when git format patch, this provides more hints to us when looking
for a base.

> 
> [1] https://lore.kernel.org/lkml/20200706232309.12010-1-scott.branden@broadcom.com/
> [2] https://lore.kernel.org/lkml/20200729175845.1745471-1-keescook@chromium.org/
> 
> 
> 
> > And when submitting patch, we suggest to use '--base' as documented in
> > https://git-scm.com/docs/git-format-patch]
> >
> > url:    https://github.com/0day-ci/linux/commits/Scott-Branden/Add-Broadcom-VK-driver/20201001-093119
> > base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git c471bf4b11c7df0f0f9f42b5aeec424dc62d0c7e
> > config: powerpc-allyesconfig (attached as .config)
> > compiler: powerpc64-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://github.com/0day-ci/linux/commit/f04a1673933a1af94e44bc650533bbb271e3dcc1
> >         git remote add linux-review https://github.com/0day-ci/linux
> >         git fetch --no-tags linux-review Scott-Branden/Add-Broadcom-VK-driver/20201001-093119
> >         git checkout f04a1673933a1af94e44bc650533bbb271e3dcc1
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc 
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/misc/bcm-vk/bcm_vk_dev.c: In function 'bcm_vk_load_image_by_type':
> >>> drivers/misc/bcm-vk/bcm_vk_dev.c:284:8: error: implicit declaration of function 'request_partial_firmware_into_buf'; did you mean 'request_firmware_into_buf'? [-Werror=implicit-function-declaration]
> >      284 |  ret = request_partial_firmware_into_buf(&fw, filename, dev,
> >          |        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >          |        request_firmware_into_buf
> >    cc1: some warnings being treated as errors
> >
> > vim +284 drivers/misc/bcm-vk/bcm_vk_dev.c
> >
> >    206	
> >    207	static int bcm_vk_load_image_by_type(struct bcm_vk *vk, u32 load_type,
> >    208					     const char *filename)
> >    209	{
> >    210		struct device *dev = &vk->pdev->dev;
> >    211		const struct firmware *fw = NULL;
> >    212		void *bufp = NULL;
> >    213		size_t max_buf, offset;
> >    214		int ret;
> >    215		u64 offset_codepush;
> >    216		u32 codepush;
> >    217		u32 value;
> >    218		dma_addr_t boot_dma_addr;
> >    219		bool is_stdalone;
> >    220	
> >    221		if (load_type == VK_IMAGE_TYPE_BOOT1) {
> >    222			/*
> >    223			 * After POR, enable VK soft BOOTSRC so bootrom do not clear
> >    224			 * the pushed image (the TCM memories).
> >    225			 */
> >    226			value = vkread32(vk, BAR_0, BAR_BOOTSRC_SELECT);
> >    227			value |= BOOTSRC_SOFT_ENABLE;
> >    228			vkwrite32(vk, value, BAR_0, BAR_BOOTSRC_SELECT);
> >    229	
> >    230			codepush = CODEPUSH_BOOTSTART + CODEPUSH_BOOT1_ENTRY;
> >    231			offset_codepush = BAR_CODEPUSH_SBL;
> >    232	
> >    233			/* Write a 1 to request SRAM open bit */
> >    234			vkwrite32(vk, CODEPUSH_BOOTSTART, BAR_0, offset_codepush);
> >    235	
> >    236			/* Wait for VK to respond */
> >    237			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, SRAM_OPEN,
> >    238					  SRAM_OPEN, LOAD_IMAGE_TIMEOUT_MS);
> >    239			if (ret < 0) {
> >    240				dev_err(dev, "boot1 wait SRAM err - ret(%d)\n", ret);
> >    241				goto err_buf_out;
> >    242			}
> >    243	
> >    244			max_buf = SZ_256K;
> >    245			bufp = dma_alloc_coherent(dev,
> >    246						  max_buf,
> >    247						  &boot_dma_addr, GFP_KERNEL);
> >    248			if (!bufp) {
> >    249				dev_err(dev, "Error allocating 0x%zx\n", max_buf);
> >    250				ret = -ENOMEM;
> >    251				goto err_buf_out;
> >    252			}
> >    253		} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
> >    254			codepush = CODEPUSH_BOOT2_ENTRY;
> >    255			offset_codepush = BAR_CODEPUSH_SBI;
> >    256	
> >    257			/* Wait for VK to respond */
> >    258			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS, DDR_OPEN,
> >    259					  DDR_OPEN, LOAD_IMAGE_TIMEOUT_MS);
> >    260			if (ret < 0) {
> >    261				dev_err(dev, "boot2 wait DDR open error - ret(%d)\n",
> >    262					ret);
> >    263				goto err_buf_out;
> >    264			}
> >    265	
> >    266			max_buf = SZ_4M;
> >    267			bufp = dma_alloc_coherent(dev,
> >    268						  max_buf,
> >    269						  &boot_dma_addr, GFP_KERNEL);
> >    270			if (!bufp) {
> >    271				dev_err(dev, "Error allocating 0x%zx\n", max_buf);
> >    272				ret = -ENOMEM;
> >    273				goto err_buf_out;
> >    274			}
> >    275	
> >    276			bcm_vk_buf_notify(vk, bufp, boot_dma_addr, max_buf);
> >    277		} else {
> >    278			dev_err(dev, "Error invalid image type 0x%x\n", load_type);
> >    279			ret = -EINVAL;
> >    280			goto err_buf_out;
> >    281		}
> >    282	
> >    283		offset = 0;
> >  > 284		ret = request_partial_firmware_into_buf(&fw, filename, dev,
> >    285							bufp, max_buf, offset);
> >    286		if (ret) {
> >    287			dev_err(dev, "Error %d requesting firmware file: %s\n",
> >    288				ret, filename);
> >    289			goto err_firmware_out;
> >    290		}
> >    291		dev_dbg(dev, "size=0x%zx\n", fw->size);
> >    292		if (load_type == VK_IMAGE_TYPE_BOOT1)
> >    293			memcpy_toio(vk->bar[BAR_1] + BAR1_CODEPUSH_BASE_BOOT1,
> >    294				    bufp,
> >    295				    fw->size);
> >    296	
> >    297		dev_dbg(dev, "Signaling 0x%x to 0x%llx\n", codepush, offset_codepush);
> >    298		vkwrite32(vk, codepush, BAR_0, offset_codepush);
> >    299	
> >    300		if (load_type == VK_IMAGE_TYPE_BOOT1) {
> >    301			u32 boot_status;
> >    302	
> >    303			/* wait until done */
> >    304			ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
> >    305					  BOOT1_RUNNING,
> >    306					  BOOT1_RUNNING,
> >    307					  BOOT1_STARTUP_TIMEOUT_MS);
> >    308	
> >    309			boot_status = vkread32(vk, BAR_0, BAR_BOOT_STATUS);
> >    310			is_stdalone = !BCM_VK_INTF_IS_DOWN(boot_status) &&
> >    311				      (boot_status & BOOT_STDALONE_RUNNING);
> >    312			if (ret && !is_stdalone) {
> >    313				dev_err(dev,
> >    314					"Timeout %ld ms waiting for boot1 to come up - ret(%d)\n",
> >    315					BOOT1_STARTUP_TIMEOUT_MS, ret);
> >    316				goto err_firmware_out;
> >    317			} else if (is_stdalone) {
> >    318				u32 reg;
> >    319	
> >    320				reg = vkread32(vk, BAR_0, BAR_BOOT1_STDALONE_PROGRESS);
> >    321				if ((reg & BOOT1_STDALONE_PROGRESS_MASK) ==
> >    322					     BOOT1_STDALONE_SUCCESS) {
> >    323					dev_info(dev, "Boot1 standalone success\n");
> >    324					ret = 0;
> >    325				} else {
> >    326					dev_err(dev, "Timeout %ld ms - Boot1 standalone failure\n",
> >    327						BOOT1_STARTUP_TIMEOUT_MS);
> >    328					ret = -EINVAL;
> >    329					goto err_firmware_out;
> >    330				}
> >    331			}
> >    332		} else if (load_type == VK_IMAGE_TYPE_BOOT2) {
> >    333			unsigned long timeout;
> >    334	
> >    335			timeout = jiffies + msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
> >    336	
> >    337			/* To send more data to VK than max_buf allowed at a time */
> >    338			do {
> >    339				/*
> >    340				 * Check for ack from card. when Ack is received,
> >    341				 * it means all the data is received by card.
> >    342				 * Exit the loop after ack is received.
> >    343				 */
> >    344				ret = bcm_vk_wait(vk, BAR_0, BAR_BOOT_STATUS,
> >    345						  FW_LOADER_ACK_RCVD_ALL_DATA,
> >    346						  FW_LOADER_ACK_RCVD_ALL_DATA,
> >    347						  TXFR_COMPLETE_TIMEOUT_MS);
> >    348				if (ret == 0) {
> >    349					dev_dbg(dev, "Exit boot2 download\n");
> >    350					break;
> >    351				} else if (ret == -EFAULT) {
> >    352					dev_err(dev, "Error detected during ACK waiting");
> >    353					goto err_firmware_out;
> >    354				}
> >    355	
> >    356				/* exit the loop, if there is no response from card */
> >    357				if (time_after(jiffies, timeout)) {
> >    358					dev_err(dev, "Error. No reply from card\n");
> >    359					ret = -ETIMEDOUT;
> >    360					goto err_firmware_out;
> >    361				}
> >    362	
> >    363				/* Wait for VK to open BAR space to copy new data */
> >    364				ret = bcm_vk_wait(vk, BAR_0, offset_codepush,
> >    365						  codepush, 0,
> >    366						  TXFR_COMPLETE_TIMEOUT_MS);
> >    367				if (ret == 0) {
> >    368					offset += max_buf;
> >    369					ret = request_partial_firmware_into_buf
> >    370							(&fw,
> >    371							 filename,
> >    372							 dev, bufp,
> >    373							 max_buf,
> >    374							 offset);
> >    375					if (ret) {
> >    376						dev_err(dev,
> >    377							"Error %d requesting firmware file: %s offset: 0x%zx\n",
> >    378							ret, filename, offset);
> >    379						goto err_firmware_out;
> >    380					}
> >    381					dev_dbg(dev, "size=0x%zx\n", fw->size);
> >    382					dev_dbg(dev, "Signaling 0x%x to 0x%llx\n",
> >    383						codepush, offset_codepush);
> >    384					vkwrite32(vk, codepush, BAR_0, offset_codepush);
> >    385					/* reload timeout after every codepush */
> >    386					timeout = jiffies +
> >    387					    msecs_to_jiffies(LOAD_IMAGE_TIMEOUT_MS);
> >    388				} else if (ret == -EFAULT) {
> >    389					dev_err(dev, "Error detected waiting for transfer\n");
> >    390					goto err_firmware_out;
> >    391				}
> >    392			} while (1);
> >    393	
> >    394			/* wait for fw status bits to indicate app ready */
> >    395			ret = bcm_vk_wait(vk, BAR_0, VK_BAR_FWSTS,
> >    396					  VK_FWSTS_READY,
> >    397					  VK_FWSTS_READY,
> >    398					  BOOT2_STARTUP_TIMEOUT_MS);
> >    399			if (ret < 0) {
> >    400				dev_err(dev, "Boot2 not ready - ret(%d)\n", ret);
> >    401				goto err_firmware_out;
> >    402			}
> >    403	
> >    404			is_stdalone = vkread32(vk, BAR_0, BAR_BOOT_STATUS) &
> >    405				      BOOT_STDALONE_RUNNING;
> >    406			if (!is_stdalone) {
> >    407				ret = bcm_vk_intf_ver_chk(vk);
> >    408				if (ret) {
> >    409					dev_err(dev, "failure in intf version check\n");
> >    410					goto err_firmware_out;
> >    411				}
> >    412	
> >    413				/* sync & channel other info */
> >    414				ret = bcm_vk_sync_card_info(vk);
> >    415				if (ret) {
> >    416					dev_err(dev, "Syncing Card Info failure\n");
> >    417					goto err_firmware_out;
> >    418				}
> >    419			}
> >    420		}
> >    421	
> >    422	err_firmware_out:
> >    423		release_firmware(fw);
> >    424	
> >    425	err_buf_out:
> >    426		if (bufp)
> >    427			dma_free_coherent(dev, max_buf, bufp, boot_dma_addr);
> >    428	
> >    429		return ret;
> >    430	}
> >    431	
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 



> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org


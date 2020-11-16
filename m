Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E002B3CB6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 06:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgKPFyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 00:54:10 -0500
Received: from mga14.intel.com ([192.55.52.115]:3546 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725300AbgKPFyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 00:54:10 -0500
IronPort-SDR: yZlMTSohxLHM0I7HVWXN1E+2fLlkCCIlx1jJ9WMZxAfnb0JhK7NyA9sw2nHApygZu8dyY7QTvM
 q9ZlUdCWM5Ng==
X-IronPort-AV: E=McAfee;i="6000,8403,9806"; a="169920517"
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="169920517"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 21:54:07 -0800
IronPort-SDR: 6cQXkuTC1hlvNH3x7JY4O/QyXp4a3mR/JFK+0hVrLTrFcsJlvDC42DZUGIj/3hktNv+a6rmOGT
 pr22ksYKGR0Q==
X-IronPort-AV: E=Sophos;i="5.77,481,1596524400"; 
   d="scan'208";a="543465058"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2020 21:54:05 -0800
Date:   Mon, 16 Nov 2020 13:53:19 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
Subject: drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning: Non-boolean
 value returned from function returning bool
Message-ID: <20201116055212.GA3723@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f01c30de86f1047e9bae1b1b1417b0ce8dcd15b1
commit: 3c45f21af84eb05a355919abc80cf70a3a681cee ath10k: sdio: add firmware coredump support
compiler: nios2-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/net/wireless/ath/ath10k/sdio.c:2234:2: warning: Non-boolean value returned from function returning bool [returnNonBoolInBooleanFunction]
    return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
    ^

vim +2234 drivers/net/wireless/ath/ath10k/sdio.c

3c45f21af84eb05 Wen Gong 2020-08-18  2225  
3c45f21af84eb05 Wen Gong 2020-08-18  2226  static bool ath10k_sdio_is_fast_dump_supported(struct ath10k *ar)
3c45f21af84eb05 Wen Gong 2020-08-18  2227  {
3c45f21af84eb05 Wen Gong 2020-08-18  2228  	u32 param;
3c45f21af84eb05 Wen Gong 2020-08-18  2229  
3c45f21af84eb05 Wen Gong 2020-08-18  2230  	ath10k_sdio_read_host_interest_value(ar, HI_ITEM(hi_option_flag2), &param);
3c45f21af84eb05 Wen Gong 2020-08-18  2231  
3c45f21af84eb05 Wen Gong 2020-08-18  2232  	ath10k_dbg(ar, ATH10K_DBG_SDIO, "sdio hi_option_flag2 %x\n", param);
3c45f21af84eb05 Wen Gong 2020-08-18  2233  
3c45f21af84eb05 Wen Gong 2020-08-18 @2234  	return param & HI_OPTION_SDIO_CRASH_DUMP_ENHANCEMENT_FW;
3c45f21af84eb05 Wen Gong 2020-08-18  2235  }
3c45f21af84eb05 Wen Gong 2020-08-18  2236  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

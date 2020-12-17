Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBEF92DCA49
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 02:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388513AbgLQBIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Dec 2020 20:08:46 -0500
Received: from mga09.intel.com ([134.134.136.24]:24409 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726597AbgLQBIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:36 -0500
IronPort-SDR: SDtJEkgemEIzU7IiSiDXt73AYalxBN8kr0lf5s4VFwWGPSDNggRCQa9egZzuIWaioA0sQW6NOM
 f/l9pBnD610A==
X-IronPort-AV: E=McAfee;i="6000,8403,9837"; a="175310371"
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="175310371"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 17:07:53 -0800
IronPort-SDR: lzMreFwbhaAW+gQY9gHbDs9PCei4YD/idYimXqRyrSKodZeWQ+vElqTB1bblFKHAVjZW+NyXhP
 Z3ytofMo8rxw==
X-IronPort-AV: E=Sophos;i="5.78,425,1599548400"; 
   d="scan'208";a="338886600"
Received: from shao2-debian.sh.intel.com (HELO localhost) ([10.239.13.117])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2020 17:07:52 -0800
Date:   Thu, 17 Dec 2020 09:07:10 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Tova Mussai <tova.mussai@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: net/wireless/scan.c:552:2: warning: Assignment of function parameter
 has no effect outside the function. Did you forget dereferencing
Message-ID: <20201217010710.GP67148@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fab0fca1da5cdc48be051715cd9787df04fdce3a
commit: c8cb5b854b40f2ce52ccd032fa19750f4181d5fc nl80211/cfg80211: support 6 GHz scanning
compiler: c6x-elf-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <rong.a.chen@intel.com>


cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> net/wireless/scan.c:552:2: warning: Assignment of function parameter has no effect outside the function. Did you forget dereferencing it? [uselessAssignmentPtrArg]
    pos++;
    ^

vim +552 net/wireless/scan.c

c8cb5b854b40f2c Tova Mussai 2020-09-18  530  
c8cb5b854b40f2c Tova Mussai 2020-09-18  531  static int cfg80211_parse_ap_info(struct cfg80211_colocated_ap *entry,
c8cb5b854b40f2c Tova Mussai 2020-09-18  532  				  const u8 *pos, u8 length,
c8cb5b854b40f2c Tova Mussai 2020-09-18  533  				  const struct element *ssid_elem,
c8cb5b854b40f2c Tova Mussai 2020-09-18  534  				  int s_ssid_tmp)
c8cb5b854b40f2c Tova Mussai 2020-09-18  535  {
c8cb5b854b40f2c Tova Mussai 2020-09-18  536  	/* skip the TBTT offset */
c8cb5b854b40f2c Tova Mussai 2020-09-18  537  	pos++;
c8cb5b854b40f2c Tova Mussai 2020-09-18  538  
c8cb5b854b40f2c Tova Mussai 2020-09-18  539  	memcpy(entry->bssid, pos, ETH_ALEN);
c8cb5b854b40f2c Tova Mussai 2020-09-18  540  	pos += ETH_ALEN;
c8cb5b854b40f2c Tova Mussai 2020-09-18  541  
c8cb5b854b40f2c Tova Mussai 2020-09-18  542  	if (length == IEEE80211_TBTT_INFO_OFFSET_BSSID_SSSID_BSS_PARAM) {
c8cb5b854b40f2c Tova Mussai 2020-09-18  543  		memcpy(&entry->short_ssid, pos,
c8cb5b854b40f2c Tova Mussai 2020-09-18  544  		       sizeof(entry->short_ssid));
c8cb5b854b40f2c Tova Mussai 2020-09-18  545  		entry->short_ssid_valid = true;
c8cb5b854b40f2c Tova Mussai 2020-09-18  546  		pos += 4;
c8cb5b854b40f2c Tova Mussai 2020-09-18  547  	}
c8cb5b854b40f2c Tova Mussai 2020-09-18  548  
c8cb5b854b40f2c Tova Mussai 2020-09-18  549  	/* skip non colocated APs */
c8cb5b854b40f2c Tova Mussai 2020-09-18  550  	if (!cfg80211_parse_bss_param(*pos, entry))
c8cb5b854b40f2c Tova Mussai 2020-09-18  551  		return -EINVAL;
c8cb5b854b40f2c Tova Mussai 2020-09-18 @552  	pos++;
c8cb5b854b40f2c Tova Mussai 2020-09-18  553  
c8cb5b854b40f2c Tova Mussai 2020-09-18  554  	if (length == IEEE80211_TBTT_INFO_OFFSET_BSSID_BSS_PARAM) {
c8cb5b854b40f2c Tova Mussai 2020-09-18  555  		/*
c8cb5b854b40f2c Tova Mussai 2020-09-18  556  		 * no information about the short ssid. Consider the entry valid
c8cb5b854b40f2c Tova Mussai 2020-09-18  557  		 * for now. It would later be dropped in case there are explicit
c8cb5b854b40f2c Tova Mussai 2020-09-18  558  		 * SSIDs that need to be matched
c8cb5b854b40f2c Tova Mussai 2020-09-18  559  		 */
c8cb5b854b40f2c Tova Mussai 2020-09-18  560  		if (!entry->same_ssid)
c8cb5b854b40f2c Tova Mussai 2020-09-18  561  			return 0;
c8cb5b854b40f2c Tova Mussai 2020-09-18  562  	}
c8cb5b854b40f2c Tova Mussai 2020-09-18  563  
c8cb5b854b40f2c Tova Mussai 2020-09-18  564  	if (entry->same_ssid) {
c8cb5b854b40f2c Tova Mussai 2020-09-18  565  		entry->short_ssid = s_ssid_tmp;
c8cb5b854b40f2c Tova Mussai 2020-09-18  566  		entry->short_ssid_valid = true;
c8cb5b854b40f2c Tova Mussai 2020-09-18  567  
c8cb5b854b40f2c Tova Mussai 2020-09-18  568  		/*
c8cb5b854b40f2c Tova Mussai 2020-09-18  569  		 * This is safe because we validate datalen in
c8cb5b854b40f2c Tova Mussai 2020-09-18  570  		 * cfg80211_parse_colocated_ap(), before calling this
c8cb5b854b40f2c Tova Mussai 2020-09-18  571  		 * function.
c8cb5b854b40f2c Tova Mussai 2020-09-18  572  		 */
c8cb5b854b40f2c Tova Mussai 2020-09-18  573  		memcpy(&entry->ssid, &ssid_elem->data,
c8cb5b854b40f2c Tova Mussai 2020-09-18  574  		       ssid_elem->datalen);
c8cb5b854b40f2c Tova Mussai 2020-09-18  575  		entry->ssid_len = ssid_elem->datalen;
c8cb5b854b40f2c Tova Mussai 2020-09-18  576  	}
c8cb5b854b40f2c Tova Mussai 2020-09-18  577  	return 0;
c8cb5b854b40f2c Tova Mussai 2020-09-18  578  }
c8cb5b854b40f2c Tova Mussai 2020-09-18  579  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F2C2F0562
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 06:31:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbhAJF27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 00:28:59 -0500
Received: from mga02.intel.com ([134.134.136.20]:56859 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbhAJF27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 00:28:59 -0500
IronPort-SDR: +ONo96XiBN5zdeN7DH2hh09YDQAvUPM6UjkJDOZ+3TsUoWqHr7/xmPbIvRyuzPiIsIgs5rLVq/
 EbrXVGRFn3fg==
X-IronPort-AV: E=McAfee;i="6000,8403,9859"; a="164822171"
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="164822171"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2021 21:28:17 -0800
IronPort-SDR: cHmuKETKtYVHLu2F+GXoU3C6taJpZNmSPaK9fIx/oE+V52KiMflzxCZXAeA6ZW91K50pB5SW44
 9WdO/A6gndxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,335,1602572400"; 
   d="scan'208";a="362770146"
Received: from lkp-server01.sh.intel.com (HELO 412602b27703) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jan 2021 21:28:16 -0800
Received: from kbuild by 412602b27703 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kyTGx-0001QK-V3; Sun, 10 Jan 2021 05:28:15 +0000
Date:   Sun, 10 Jan 2021 13:27:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1855:42: warning:
 Uninitialized variable: fw_ver
Message-ID: <202101101327.Ajd5OjSM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   2ff90100ace886895e4fbb2850b8d5e49d931ed6
commit: 57430471e2fa60a412e220fa3014567e792aaa6f drm/amdgpu: Add support for USBC PD FW download
date:   10 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c:1855:42: warning: Uninitialized variable: fw_ver [uninitvar]
    return snprintf(buf, PAGE_SIZE, "%xn", fw_ver);
                                            ^

vim +1855 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c

  1836	
  1837	static ssize_t psp_usbc_pd_fw_sysfs_read(struct device *dev,
  1838						 struct device_attribute *attr,
  1839						 char *buf)
  1840	{
  1841		struct drm_device *ddev = dev_get_drvdata(dev);
  1842		struct amdgpu_device *adev = ddev->dev_private;
  1843		uint32_t fw_ver;
  1844		int ret;
  1845	
  1846		mutex_lock(&adev->psp.mutex);
  1847		ret = psp_read_usbc_pd_fw(&adev->psp, &fw_ver);
  1848		mutex_unlock(&adev->psp.mutex);
  1849	
  1850		if (ret) {
  1851			DRM_ERROR("Failed to read USBC PD FW, err = %d", ret);
  1852			return ret;
  1853		}
  1854	
> 1855		return snprintf(buf, PAGE_SIZE, "%x\n", fw_ver);
  1856	}
  1857	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 052DD2F8BAF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 06:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbhAPFhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 00:37:45 -0500
Received: from mga05.intel.com ([192.55.52.43]:64833 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725767AbhAPFhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 00:37:45 -0500
IronPort-SDR: q9Y2KiMJFUGfiZwLcUfneo13c7rlHLrQZJgzg+elmHFqyEpR2oPowP4O71836ZRG8BgKC1WMzY
 4TxNR9wcYXfQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="263440618"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="263440618"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 21:37:04 -0800
IronPort-SDR: 2LYrdsxYr31tfoueBWJs74+eUXWYTBjZ3kuDW7t8K6Ea2Gq+RoL/uiW6O1hBXbVAxLZZgBoeCp
 QGZYQPBorwUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="346378866"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 15 Jan 2021 21:37:02 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0eGj-0000jg-U4; Sat, 16 Jan 2021 05:37:01 +0000
Date:   Sat, 16 Jan 2021 13:36:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: drivers/gpu/drm/i915/gem/i915_gem_region.c:166:27: warning:
 Uninitialized variable: obj
Message-ID: <202101161308.BZvnDcpd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1d94330a437a573cfdf848f6743b1ed169242c8a
commit: c6d4a099a240a8742173f8e02db0ba08ffd37ef1 drm/i915: reimplement header test feature
date:   1 year ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/gpu/drm/i915/gem/i915_gem_region.c:166:27: warning: Uninitialized variable: obj [uninitvar]
    if (overflows_type(size, obj->base.size))
                             ^
--

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

>> drivers/gpu/drm/i915/display/intel_overlay.c:678:12: warning: Shifting signed 32-bit value by 31 bits is undefined behaviour [shiftTooManyBitsSigned]
     flags |= DST_KEY_ENABLE;
              ^

vim +166 drivers/gpu/drm/i915/gem/i915_gem_region.c

232a6ebae41919 Matthew Auld 2019-10-08  132  
232a6ebae41919 Matthew Auld 2019-10-08  133  struct drm_i915_gem_object *
232a6ebae41919 Matthew Auld 2019-10-08  134  i915_gem_object_create_region(struct intel_memory_region *mem,
232a6ebae41919 Matthew Auld 2019-10-08  135  			      resource_size_t size,
232a6ebae41919 Matthew Auld 2019-10-08  136  			      unsigned int flags)
232a6ebae41919 Matthew Auld 2019-10-08  137  {
232a6ebae41919 Matthew Auld 2019-10-08  138  	struct drm_i915_gem_object *obj;
232a6ebae41919 Matthew Auld 2019-10-08  139  
232a6ebae41919 Matthew Auld 2019-10-08  140  	/*
232a6ebae41919 Matthew Auld 2019-10-08  141  	 * NB: Our use of resource_size_t for the size stems from using struct
232a6ebae41919 Matthew Auld 2019-10-08  142  	 * resource for the mem->region. We might need to revisit this in the
232a6ebae41919 Matthew Auld 2019-10-08  143  	 * future.
232a6ebae41919 Matthew Auld 2019-10-08  144  	 */
232a6ebae41919 Matthew Auld 2019-10-08  145  
2f0b97ca021186 Matthew Auld 2019-10-08  146  	GEM_BUG_ON(flags & ~I915_BO_ALLOC_FLAGS);
2f0b97ca021186 Matthew Auld 2019-10-08  147  
232a6ebae41919 Matthew Auld 2019-10-08  148  	if (!mem)
232a6ebae41919 Matthew Auld 2019-10-08  149  		return ERR_PTR(-ENODEV);
232a6ebae41919 Matthew Auld 2019-10-08  150  
232a6ebae41919 Matthew Auld 2019-10-08  151  	size = round_up(size, mem->min_page_size);
232a6ebae41919 Matthew Auld 2019-10-08  152  
232a6ebae41919 Matthew Auld 2019-10-08  153  	GEM_BUG_ON(!size);
232a6ebae41919 Matthew Auld 2019-10-08  154  	GEM_BUG_ON(!IS_ALIGNED(size, I915_GTT_MIN_ALIGNMENT));
232a6ebae41919 Matthew Auld 2019-10-08  155  
232a6ebae41919 Matthew Auld 2019-10-08  156  	/*
232a6ebae41919 Matthew Auld 2019-10-08  157  	 * XXX: There is a prevalence of the assumption that we fit the
232a6ebae41919 Matthew Auld 2019-10-08  158  	 * object's page count inside a 32bit _signed_ variable. Let's document
232a6ebae41919 Matthew Auld 2019-10-08  159  	 * this and catch if we ever need to fix it. In the meantime, if you do
232a6ebae41919 Matthew Auld 2019-10-08  160  	 * spot such a local variable, please consider fixing!
232a6ebae41919 Matthew Auld 2019-10-08  161  	 */
232a6ebae41919 Matthew Auld 2019-10-08  162  
232a6ebae41919 Matthew Auld 2019-10-08  163  	if (size >> PAGE_SHIFT > INT_MAX)
232a6ebae41919 Matthew Auld 2019-10-08  164  		return ERR_PTR(-E2BIG);
232a6ebae41919 Matthew Auld 2019-10-08  165  
232a6ebae41919 Matthew Auld 2019-10-08 @166  	if (overflows_type(size, obj->base.size))

:::::: The code at line 166 was first introduced by commit
:::::: 232a6ebae419193f5b8da4fa869ae5089ab105c2 drm/i915: introduce intel_memory_region

:::::: TO: Matthew Auld <matthew.auld@intel.com>
:::::: CC: Chris Wilson <chris@chris-wilson.co.uk>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

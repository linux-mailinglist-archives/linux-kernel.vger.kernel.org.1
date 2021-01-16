Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C552D2F8BDF
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 07:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726581AbhAPGOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 01:14:51 -0500
Received: from mga17.intel.com ([192.55.52.151]:55206 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbhAPGOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 01:14:50 -0500
IronPort-SDR: c/5kcLrkF1JNlJpWmTXch3dq8fIEv3wES1dnCEHPXCfaJGYXjzxf6Br+8GfkgcXS4g2ZSOXZoe
 NJsutR4eJwvw==
X-IronPort-AV: E=McAfee;i="6000,8403,9865"; a="158419678"
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="158419678"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2021 22:14:07 -0800
IronPort-SDR: 5FOEsWg5B8NSWJwW0l/T6xI+C4mg6AV13HI7lvy+sL1l8Vj6bDeQDWHb/96IhOHWGJICV9ORSB
 pmcnZ7fvYUQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,351,1602572400"; 
   d="scan'208";a="465819337"
Received: from lkp-server01.sh.intel.com (HELO 260eafd5ecd0) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 15 Jan 2021 22:14:04 -0800
Received: from kbuild by 260eafd5ecd0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1l0eqZ-0000kk-KB; Sat, 16 Jan 2021 06:14:03 +0000
Date:   Sat, 16 Jan 2021 14:13:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>
Subject: drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2341:52: warning:
 Uninitialized variable: pw
Message-ID: <202101161428.kupVzIgG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b45e2da6e444280f8661dca439c1e377761b2877
commit: c60b93cd4862d108214a14e655358ea714d7a12a drm/i915: Avoid mixing integer types during batch copies
date:   4 months ago
compiler: gcc-9 (Debian 9.3.0-15) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


"cppcheck warnings: (new ones prefixed by >>)"
>> drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2341:52: warning: Uninitialized variable: pw [uninitvar]
    GEM_BUG_ON(overflows_type(eb->batch_start_offset, pw->batch_offset));
                                                      ^
   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:2342:43: warning: Uninitialized variable: pw [uninitvar]
    GEM_BUG_ON(overflows_type(eb->batch_len, pw->batch_length));
                                             ^

cppcheck possible warnings: (new ones prefixed by >>, may not real problems)

   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1535:6: warning: Local variable reloc_gpu shadows outer function [shadowFunction]
    int reloc_gpu = reloc_entry_gpu(eb, vma, offset, target_addr);
        ^
   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1384:13: note: Shadowed declaration
   static u32 *reloc_gpu(struct i915_execbuffer *eb,
               ^
   drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c:1535:6: note: Shadow variable
    int reloc_gpu = reloc_entry_gpu(eb, vma, offset, target_addr);
        ^

vim +2341 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c

  2333	
  2334	static int eb_parse_pipeline(struct i915_execbuffer *eb,
  2335				     struct i915_vma *shadow,
  2336				     struct i915_vma *trampoline)
  2337	{
  2338		struct eb_parse_work *pw;
  2339		int err;
  2340	
> 2341		GEM_BUG_ON(overflows_type(eb->batch_start_offset, pw->batch_offset));
  2342		GEM_BUG_ON(overflows_type(eb->batch_len, pw->batch_length));
  2343	
  2344		pw = kzalloc(sizeof(*pw), GFP_KERNEL);
  2345		if (!pw)
  2346			return -ENOMEM;
  2347	
  2348		err = i915_active_acquire(&eb->batch->vma->active);
  2349		if (err)
  2350			goto err_free;
  2351	
  2352		err = i915_active_acquire(&shadow->active);
  2353		if (err)
  2354			goto err_batch;
  2355	
  2356		if (trampoline) {
  2357			err = i915_active_acquire(&trampoline->active);
  2358			if (err)
  2359				goto err_shadow;
  2360		}
  2361	
  2362		dma_fence_work_init(&pw->base, &eb_parse_ops);
  2363	
  2364		pw->engine = eb->engine;
  2365		pw->batch = eb->batch->vma;
  2366		pw->batch_offset = eb->batch_start_offset;
  2367		pw->batch_length = eb->batch_len;
  2368		pw->shadow = shadow;
  2369		pw->trampoline = trampoline;
  2370	
  2371		/* Mark active refs early for this worker, in case we get interrupted */
  2372		err = parser_mark_active(pw, eb->context->timeline);
  2373		if (err)
  2374			goto err_commit;
  2375	
  2376		err = dma_resv_reserve_shared(pw->batch->resv, 1);
  2377		if (err)
  2378			goto err_commit;
  2379	
  2380		/* Wait for all writes (and relocs) into the batch to complete */
  2381		err = i915_sw_fence_await_reservation(&pw->base.chain,
  2382						      pw->batch->resv, NULL, false,
  2383						      0, I915_FENCE_GFP);
  2384		if (err < 0)
  2385			goto err_commit;
  2386	
  2387		/* Keep the batch alive and unwritten as we parse */
  2388		dma_resv_add_shared_fence(pw->batch->resv, &pw->base.dma);
  2389	
  2390		/* Force execution to wait for completion of the parser */
  2391		dma_resv_add_excl_fence(shadow->resv, &pw->base.dma);
  2392	
  2393		dma_fence_work_commit_imm(&pw->base);
  2394		return 0;
  2395	
  2396	err_commit:
  2397		i915_sw_fence_set_error_once(&pw->base.chain, err);
  2398		dma_fence_work_commit_imm(&pw->base);
  2399		return err;
  2400	
  2401	err_shadow:
  2402		i915_active_release(&shadow->active);
  2403	err_batch:
  2404		i915_active_release(&eb->batch->vma->active);
  2405	err_free:
  2406		kfree(pw);
  2407		return err;
  2408	}
  2409	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

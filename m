Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1E672B4095
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:15:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728610AbgKPKPZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 16 Nov 2020 05:15:25 -0500
Received: from mail.fireflyinternet.com ([77.68.26.236]:60125 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727012AbgKPKPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:15:25 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 23003528-1500050 
        for multiple; Mon, 16 Nov 2020 10:15:03 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201116100837.GA29398@kadam>
References: <20201116100837.GA29398@kadam>
Subject: Re: drivers/gpu/drm/i915/gem/i915_gem_throttle.c:59 i915_gem_throttle_ioctl() error: double locked 'ctx->engines_mutex' (orig line 59)
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@lists.01.org
Date:   Mon, 16 Nov 2020 10:15:04 +0000
Message-ID: <160552170467.29277.2663645719015888596@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dan Carpenter (2020-11-16 10:08:38)
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0062442ecfef0d82cd69e3e600d5006357f8d8e4
> commit: 27a5dcfe73f4b696b3de8c23a560199bb1c193a4 drm/i915/gem: Remove disordered per-file request list for throttling
> config: i386-randconfig-m021-20201115 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> 
> smatch warnings:
> drivers/gpu/drm/i915/gem/i915_gem_throttle.c:59 i915_gem_throttle_ioctl() error: double locked 'ctx->engines_mutex' (orig line 59)
> 
> vim +59 drivers/gpu/drm/i915/gem/i915_gem_throttle.c
> 
>     35  int
>     36  i915_gem_throttle_ioctl(struct drm_device *dev, void *data,
>     37                          struct drm_file *file)
>     38  {
>     39          const unsigned long recent_enough = jiffies - DRM_I915_THROTTLE_JIFFIES;
>     40          struct drm_i915_file_private *file_priv = file->driver_priv;
>     41          struct i915_gem_context *ctx;
>     42          unsigned long idx;
>     43          long ret;
>     44  
>     45          /* ABI: return -EIO if already wedged */
>     46          ret = intel_gt_terminally_wedged(&to_i915(dev)->gt);
>     47          if (ret)
>     48                  return ret;
>     49  
>     50          rcu_read_lock();
>     51          xa_for_each(&file_priv->context_xa, idx, ctx) {
>     52                  struct i915_gem_engines_iter it;
>     53                  struct intel_context *ce;
>     54  
>     55                  if (!kref_get_unless_zero(&ctx->ref))
>     56                          continue;
>     57                  rcu_read_unlock();
>     58  
>     59                  for_each_gem_engine(ce,
>     60                                      i915_gem_context_lock_engines(ctx),
>                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> I don't understand why this takes the lock every iteration through the
> loop

It doesn't.

static inline struct i915_gem_engines *
i915_gem_context_lock_engines(struct i915_gem_context *ctx)
        __acquires(&ctx->engines_mutex)
{
        mutex_lock(&ctx->engines_mutex);
        return i915_gem_context_engines(ctx);
}

static inline void
i915_gem_context_unlock_engines(struct i915_gem_context *ctx)
        __releases(&ctx->engines_mutex)
{
        mutex_unlock(&ctx->engines_mutex);
}

with the i915_gem_engines stored as a local in the iterator at the start
of the for loop.
-Chris

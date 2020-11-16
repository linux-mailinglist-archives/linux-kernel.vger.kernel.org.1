Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA172B41AF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 11:50:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729118AbgKPKqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 05:46:36 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:55308 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729058AbgKPKqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:46:35 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGAf2ab127075;
        Mon, 16 Nov 2020 10:46:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=9Aep8pGS050ZEJhVOryTKNnusq4g6aUkDoIgFxsAiUc=;
 b=f8299WSbx1+OMvCv+8/Al+ZkJyRj+6EoACvPRMgO9rrvFK/LJMEU8mtp9vkdjK0DjGJv
 j6ww3A5PynJ8HyXl/ZUkZW9xEolMWaSVlgxUFnHWMILcZ9Ug61mYHK6yUN21Nam8c6rI
 mEtgCGyibOJt1eNOKYWU1K7QZutn+T99B8TF/F2k3p7JrIxyXSbk/HdXzNKrCjdUQncv
 14c6AHtGFmxQ4cqdH+B20C2JZ4FolWfYq3+liogsaI8rMGW4yFqn1J6KBG5W3KOsG83b
 xtpt8iwemFsYzECkQeAB0O/VxwC59/PxdQ6/xJiAeO/PWLY4F3R3w8zLtSjFyox7uVgA IQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2130.oracle.com with ESMTP id 34t4ramjf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Nov 2020 10:46:23 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0AGAf9aS068457;
        Mon, 16 Nov 2020 10:44:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 34umcwp5hb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 16 Nov 2020 10:44:22 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0AGAiLB3026268;
        Mon, 16 Nov 2020 10:44:21 GMT
Received: from kadam (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 16 Nov 2020 02:44:20 -0800
Date:   Mon, 16 Nov 2020 13:44:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chris Wilson <chris@chris-wilson.co.uk>
Cc:     kbuild@lists.01.org, lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: drivers/gpu/drm/i915/gem/i915_gem_throttle.c:59
 i915_gem_throttle_ioctl() error: double locked 'ctx->engines_mutex' (orig
 line 59)
Message-ID: <20201116104413.GB18329@kadam>
References: <20201116100837.GA29398@kadam>
 <160552170467.29277.2663645719015888596@build.alporthouse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160552170467.29277.2663645719015888596@build.alporthouse.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011160062
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9806 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011160062
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 10:15:04AM +0000, Chris Wilson wrote:
> Quoting Dan Carpenter (2020-11-16 10:08:38)
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
> > head:   0062442ecfef0d82cd69e3e600d5006357f8d8e4
> > commit: 27a5dcfe73f4b696b3de8c23a560199bb1c193a4 drm/i915/gem: Remove disordered per-file request list for throttling
> > config: i386-randconfig-m021-20201115 (attached as .config)
> > compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > smatch warnings:
> > drivers/gpu/drm/i915/gem/i915_gem_throttle.c:59 i915_gem_throttle_ioctl() error: double locked 'ctx->engines_mutex' (orig line 59)
> > 
> > vim +59 drivers/gpu/drm/i915/gem/i915_gem_throttle.c
> > 
> >     35  int
> >     36  i915_gem_throttle_ioctl(struct drm_device *dev, void *data,
> >     37                          struct drm_file *file)
> >     38  {
> >     39          const unsigned long recent_enough = jiffies - DRM_I915_THROTTLE_JIFFIES;
> >     40          struct drm_i915_file_private *file_priv = file->driver_priv;
> >     41          struct i915_gem_context *ctx;
> >     42          unsigned long idx;
> >     43          long ret;
> >     44  
> >     45          /* ABI: return -EIO if already wedged */
> >     46          ret = intel_gt_terminally_wedged(&to_i915(dev)->gt);
> >     47          if (ret)
> >     48                  return ret;
> >     49  
> >     50          rcu_read_lock();
> >     51          xa_for_each(&file_priv->context_xa, idx, ctx) {
> >     52                  struct i915_gem_engines_iter it;
> >     53                  struct intel_context *ce;
> >     54  
> >     55                  if (!kref_get_unless_zero(&ctx->ref))
> >     56                          continue;
> >     57                  rcu_read_unlock();
> >     58  
> >     59                  for_each_gem_engine(ce,
> >     60                                      i915_gem_context_lock_engines(ctx),
> >                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > I don't understand why this takes the lock every iteration through the
> > loop
> 
> It doesn't.
> 
> static inline struct i915_gem_engines *
> i915_gem_context_lock_engines(struct i915_gem_context *ctx)
>         __acquires(&ctx->engines_mutex)
> {
>         mutex_lock(&ctx->engines_mutex);
>         return i915_gem_context_engines(ctx);
> }
> 
> static inline void
> i915_gem_context_unlock_engines(struct i915_gem_context *ctx)
>         __releases(&ctx->engines_mutex)
> {
>         mutex_unlock(&ctx->engines_mutex);
> }
> 
> with the i915_gem_engines stored as a local in the iterator at the start
> of the for loop.

Yeah...  But that's true enough.  But what I think is actually causing
the static checker warning are the continues.

    52          xa_for_each(&file_priv->context_xa, idx, ctx) {
    53                  struct i915_gem_engines_iter it;
    54                  struct intel_context *ce;
    55  
    56                  if (!kref_get_unless_zero(&ctx->ref))
    57                          continue;
    58                  rcu_read_unlock();
    59  
    60                  for_each_gem_engine(ce,
    61                                      i915_gem_context_lock_engines(ctx),
    62                                      it) {
    63                          struct i915_request *rq, *target = NULL;
    64  
    65                          if (!ce->timeline)
    66                                  continue;
                                        ^^^^^^^^^
This continue is for the inside loop, so "ctx" isn't iterated.  There
is another continue as well later in the loop.  Potentially they could
be replaced with breaks?

    67  
    68                          mutex_lock(&ce->timeline->mutex);
    69                          list_for_each_entry_reverse(rq,
    70                                                      &ce->timeline->requests,
    71                                                      link) {
    72                                  if (i915_request_completed(rq))

regards,
dan carpenter

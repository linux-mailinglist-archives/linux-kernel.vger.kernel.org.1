Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075EC26BDEC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 09:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgIPH1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 03:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbgIPH1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 03:27:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86209C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 00:27:42 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:27:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600241254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJUV+J0+7iLJsY+/O2L+HiDQFePi5E/vBU/TwuxqAII=;
        b=b+8f6y1oqDSuO0KU/2fnunvfnSoiKnzKdOFI9jxnyYgIYMvZRyKn7oDZS6XhW7BA/NwkzC
        jbs63rbcNjFwtIYYpU1Lo18wwjy2h2QZV9b/Dd8GmLFaGA0JrpJVAsLMJ5D8AbedYfSsOI
        HmA+vk4DoJm6L6T43S2q6aMw32fl+e3uVGfUUqEyij0jodvVAO3s0V8Rsvz6+gO+bo5+bE
        pMSNKJ1/0o9LFas0ODjS0dtT6QyrSksivv1wuGTkf2v6c/C5BImruf8DS9RzrZxKVlYGK4
        4/js5ixJBLJH1e7Jncz9j9D94bMgt7FWbNk2/liCJGFrSbW6uRZ05A+2x2x45w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600241254;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PJUV+J0+7iLJsY+/O2L+HiDQFePi5E/vBU/TwuxqAII=;
        b=UaSQyNnwofNw2RKbp01GcYB5rsa39Bzpht7YAi/2ALfDhbyQEGIIgeG9uZiKZAgy6OCS+k
        bSzwd3ZRBGuU6ECg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <lkp@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: include/linux/spinlock.h:346:2: error: invalid type argument of
 unary (have 'spinlock_t' {aka 'struct spinlock'})
Message-ID: <20200916072733.gyrpbsttn53hscbc@linutronix.de>
References: <202009161552.irOZaEej%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202009161552.irOZaEej%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-16 15:18:56 [+0800], kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fc4f28bb3daf3265d6bc5f73b497306985bb23ab
> commit: de8f5e4f2dc1f032b46afda0a78cab5456974f89 lockdep: Introduce wait-type checks
> date:   6 months ago
> config: mips-randconfig-r011-20200916 (attached as .config)
> compiler: mipsel-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout de8f5e4f2dc1f032b46afda0a78cab5456974f89
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    In file included from drivers/pcmcia/vrc4173_cardu.c:41:

This driver does not compile even before this commit.
Yes, it is still broken and yes it has nothing to do with this commit.

Sebastian

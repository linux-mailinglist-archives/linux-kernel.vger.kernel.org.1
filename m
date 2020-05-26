Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36AE91D1D6B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 20:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390147AbgEMS0i convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 May 2020 14:26:38 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:50448 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1733310AbgEMS0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 14:26:38 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 21191037-1500050 
        for multiple; Wed, 13 May 2020 19:26:10 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20200513182340.3968668-1-natechancellor@gmail.com>
References: <20200513182340.3968668-1-natechancellor@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc:     Mika Kuoppala <mika.kuoppala@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        kbuild test robot <lkp@intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] drm/i915: Remove duplicate inline specifier on write_pte
Message-ID: <158939436821.29850.17450210375327657946@build.alporthouse.com>
User-Agent: alot/0.8.1
Date:   Wed, 13 May 2020 19:26:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Nathan Chancellor (2020-05-13 19:23:40)
> When building with clang:
> 
>  drivers/gpu/drm/i915/gt/gen8_ppgtt.c:392:24: warning: duplicate
>  'inline' declaration specifier [-Wduplicate-decl-specifier]
>  declaration specifier [-Wduplicate-decl-specifier]
>  static __always_inline inline void
>                         ^
>  include/linux/compiler_types.h:138:16: note: expanded from macro
>  'inline'
>  #define inline inline __gnu_inline __inline_maybe_unused notrace
>                 ^
>  1 warning generated.
> 
> __always_inline is defined as 'inline __attribute__((__always_inline))'
> so we do not need to specify it twice.
> 
> Fixes: 84eac0c65940 ("drm/i915/gt: Force pte cacheline to main memory")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1024
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

I forgot to ping Mika about this,
Reviewed-by: Chris Wilson <chris@chris-wilson.co.uk>
-Chris

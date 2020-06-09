Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2B1F3373
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 07:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgFIF3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 01:29:43 -0400
Received: from ozlabs.org ([203.11.71.1]:51867 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727824AbgFIF33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:29:29 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzFg2B7xz9sTH; Tue,  9 Jun 2020 15:29:26 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        kbuild test robot <lkp@intel.com>,
        linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20200413190644.16757-1-natechancellor@gmail.com>
References: <20200413190644.16757-1-natechancellor@gmail.com>
Subject: Re: [PATCH] powerpc/wii: Fix declaration made after definition
Message-Id: <159168031335.1381411.13854674311774532181.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:29:23 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Apr 2020 12:06:45 -0700, Nathan Chancellor wrote:
> A 0day randconfig uncovered an error with clang, trimmed for brevity:
> 
> arch/powerpc/platforms/embedded6xx/wii.c:195:7: error: attribute
> declaration must precede definition [-Werror,-Wignored-attributes]
>         if (!machine_is(wii))
>              ^
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/wii: Fix declaration made after definition
      https://git.kernel.org/powerpc/c/91ffeaa7e5dd62753e23a1204dc7ecd11f26eadc

cheers

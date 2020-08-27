Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 330A0253F7A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgH0Hq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728238AbgH0Hq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 03:46:56 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2BFC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 00:46:55 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BcZYk6tYqz9sTh; Thu, 27 Aug 2020 17:46:50 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, schwab@linux-m68k.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <09fc73fe9c7423c6b4cf93f93df9bb0ed8eefab5.1597994047.git.christophe.leroy@csgroup.eu>
References: <09fc73fe9c7423c6b4cf93f93df9bb0ed8eefab5.1597994047.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Fix module loading failure when VMALLOC_END is over 0xf0000000
Message-Id: <159851435980.52163.8321314974560450612.b4-ty@ellerman.id.au>
Date:   Thu, 27 Aug 2020 17:46:50 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Aug 2020 07:15:25 +0000 (UTC), Christophe Leroy wrote:
> In is_module_segment(), when VMALLOC_END is over 0xf0000000,
> ALIGN(VMALLOC_END, SZ_256M) has value 0.
> 
> In that case, addr >= ALIGN(VMALLOC_END, SZ_256M) is always
> true then is_module_segment() always returns false.
> 
> Use (ALIGN(VMALLOC_END, SZ_256M) - 1) which will have
> value 0xffffffff and will be suitable for the comparison.

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix module loading failure when VMALLOC_END is over 0xf0000000
      https://git.kernel.org/powerpc/c/541cebb51f3422d4f2c6cb95c1e5cc3dcc9e5021

cheers

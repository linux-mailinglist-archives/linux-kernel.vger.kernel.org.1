Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF71526DAF4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgIQMBT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 08:01:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgIQL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:26 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB02C06178A
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSP52cjz9sTs; Thu, 17 Sep 2020 21:27:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/uaccess: Switch __put_user_size_allowed() to __put_user_asm_goto()
Message-Id: <160034201413.3339803.2260455102175755865.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:17 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Sep 2020 11:01:30 +0000 (UTC), Christophe Leroy wrote:
> __put_user_asm_goto() provides more flexibility to GCC and avoids using
> a local variable to tell if the write succeeded or not.
> GCC can then avoid implementing a cmp in the fast path.
> 
> See the difference for a small function like the PPC64 version of
> save_general_regs() in arch/powerpc/kernel/signal_32.c:
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/uaccess: Switch __put_user_size_allowed() to __put_user_asm_goto()
      https://git.kernel.org/powerpc/c/ee0a49a6870ea75e25b4d4984c1bb6b3b7c65f2b
[2/3] powerpc/uaccess: Switch __patch_instruction() to __put_user_asm_goto()
      https://git.kernel.org/powerpc/c/e64ac41ab0c510b3f85199a585eb886cad92fb19
[3/3] powerpc/uaccess: Remove __put_user_asm() and __put_user_asm2()
      https://git.kernel.org/powerpc/c/7fdf966bed155b214f4f1f9b67825a40b2e9b998

cheers

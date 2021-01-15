Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5E62F78DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 13:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731514AbhAOMYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 07:24:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731104AbhAOMYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 07:24:36 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6815CC061757
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 04:23:55 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DHL2H4kF7z9sVr; Fri, 15 Jan 2021 23:23:51 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, schwab@linux-m68k.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <0c0ab0eb3cc80687c326f76ff0dd5762b8812ecc.1610452505.git.christophe.leroy@csgroup.eu>
References: <0c0ab0eb3cc80687c326f76ff0dd5762b8812ecc.1610452505.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/vdso: fix clock_gettime_fallback for vdso32
Message-Id: <161071339940.2210050.16815442999051504532.b4-ty@ellerman.id.au>
Date:   Fri, 15 Jan 2021 23:23:51 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 11:55:15 +0000 (UTC), Christophe Leroy wrote:
> The second argument of __kernel_clock_gettime64 points to a struct
> __kernel_timespec, with 64-bit time_t, so use the clock_gettime64 syscall
> in the fallback function for the 32-bit vdso.  Similarily,
> clock_getres_fallback should use the clock_getres_time64 syscall, though
> it isn't yet called from the 32-bit vdso.
> 
> [chleroy: Moved into a single #ifdef __powerpc64__ block]

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Fix clock_gettime_fallback for vdso32
      https://git.kernel.org/powerpc/c/41131a5e54ae7ba5a2bb8d7b30d1818b3f5b13d2

cheers

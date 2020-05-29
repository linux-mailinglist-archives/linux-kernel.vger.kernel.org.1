Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DAAE1E74C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgE2EY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgE2EYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:24:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4F6C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:24:21 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49YBKY13Szz9sT4; Fri, 29 May 2020 14:24:16 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 334710b1496af8a0960e70121f850e209c20958f
In-Reply-To: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        segher@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using 'asm goto'
Message-Id: <49YBKY13Szz9sT4@ozlabs.org>
Date:   Fri, 29 May 2020 14:24:16 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 17:08:51 UTC, Christophe Leroy wrote:
> unsafe_put_user() is designed to take benefit of 'asm goto'.
> 
> Instead of using the standard __put_user() approach and branch
> based on the returned error, use 'asm goto' and make the
> exception code branch directly to the error label. There is
> no code anymore in the fixup section.
> 
> This change significantly simplifies functions using
> unsafe_put_user()
...
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>

Applied to powerpc topic/uaccess-ppc, thanks.

https://git.kernel.org/powerpc/c/334710b1496af8a0960e70121f850e209c20958f

cheers

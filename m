Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 111002AAA90
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 11:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgKHK3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 05:29:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728267AbgKHK3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 05:29:42 -0500
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187E2C0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 02:29:42 -0800 (PST)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4CTVjr60s3z9sTL; Sun,  8 Nov 2020 21:29:36 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>, schwab@linux-m68k.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        erhard_f@mailbox.org, Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
References: <9e225a856a8b22e0e77587ee22ab7a2f5bca8753.1604740029.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32s: Use relocation offset when setting early hash table
Message-Id: <160483134461.1400561.5111956119334566016.b4-ty@ellerman.id.au>
Date:   Sun,  8 Nov 2020 21:29:36 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Nov 2020 09:07:40 +0000 (UTC), Christophe Leroy wrote:
> When calling early_hash_table(), the kernel hasn't been yet
> relocated to its linking address, so data must be addressed
> with relocation offset.
> 
> Add relocation offset to write into Hash in early_hash_table().

Applied to powerpc/fixes.

[1/1] powerpc/32s: Use relocation offset when setting early hash table
      https://git.kernel.org/powerpc/c/01776f070ffcbf336be3bf1672bd3c589548d6c4

cheers

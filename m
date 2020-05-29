Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D091E74C8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 06:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgE2EYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 May 2020 00:24:33 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46907 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgE2EYV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:24:21 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49YBKb2VVkz9sT6; Fri, 29 May 2020 14:24:17 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 17bc43367fc2a720400d21c745db641c654c1e6b
In-Reply-To: <fe952112c29bf6a0a2778c9e6bbb4f4afd2c4258.1587143308.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        segher@kernel.crashing.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] powerpc/uaccess: Implement unsafe_copy_to_user() as a simple loop
Message-Id: <49YBKb2VVkz9sT6@ozlabs.org>
Date:   Fri, 29 May 2020 14:24:17 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 17:08:52 UTC, Christophe Leroy wrote:
> At the time being, unsafe_copy_to_user() is based on
> raw_copy_to_user() which calls __copy_tofrom_user().
> 
> __copy_tofrom_user() is a big optimised function to copy big amount
> of data. It aligns destinations to cache line in order to use
> dcbz instruction.
> 
> Today unsafe_copy_to_user() is called only from filldir().
> It is used to mainly copy small amount of data like filenames,
> so __copy_tofrom_user() is not fit.
> 
> Also, unsafe_copy_to_user() is used within user_access_begin/end
> sections. In those section, it is preferable to not call functions.
> 
> Rewrite unsafe_copy_to_user() as a macro that uses __put_user_goto().
> We first perform a loop of long, then we finish with necessary
> complements.
> 
> unsafe_copy_to_user() might be used in the near future to copy
> fixed-size data, like pt_regs structs during signal processing.
> Having it as a macro allows GCC to optimise it for instead when
> it knows the size in advance, it can unloop loops, drop complements
> when the size is a multiple of longs, etc ...
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc topic/uaccess-ppc, thanks.

https://git.kernel.org/powerpc/c/17bc43367fc2a720400d21c745db641c654c1e6b

cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE9B26DA50
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 13:34:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgIQLeE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIQL1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:49 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A31C061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:45 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSW73Czz9sVT; Thu, 17 Sep 2020 21:27:23 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d31506ca9bac9def68cf7424eded63fdc4fb6660.1597643167.git.christophe.leroy@csgroup.eu>
References: <d31506ca9bac9def68cf7424eded63fdc4fb6660.1597643167.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1] powerpc/process: Replace an #ifdef CONFIG_PPC_BOOK3S_64 by IS_ENABLED()
Message-Id: <160034201489.3339803.3277112055562212653.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:23 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:46:42 +0000 (UTC), Christophe Leroy wrote:
> This #ifdef CONFIG_PPC_BOOK3S_64 calls preload_new_slb_context()
> when radix is not enabled.
> 
> radix_enabled() is always defined, and the prototype for
> preload_new_slb_context() is always present, so the #ifdef
> is unneeded.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/process: Replace an #ifdef CONFIG_PPC_BOOK3S_64 by IS_ENABLED()
      https://git.kernel.org/powerpc/c/bfac2799301c19d81122af04a8a3ad5ecae3737e

cheers

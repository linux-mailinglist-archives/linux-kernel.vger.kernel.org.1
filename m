Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0933C26DAF0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 14:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgIQL74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgIQL10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 07:27:26 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F68FC061756
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 04:27:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BsZSN2x0wz9sTp; Thu, 17 Sep 2020 21:27:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a027d447022a006c9c4958ac734128e577a3c5c1.1599486108.git.christophe.leroy@csgroup.eu>
References: <a027d447022a006c9c4958ac734128e577a3c5c1.1599486108.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/32: Fix vmap stack - Do not activate MMU before reading task struct
Message-Id: <160034201451.3339803.5588442310335772695.b4-ty@ellerman.id.au>
Date:   Thu, 17 Sep 2020 21:27:16 +1000 (AEST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Sep 2020 13:42:09 +0000 (UTC), Christophe Leroy wrote:
> We need r1 to be properly set before activating MMU, so
> reading task_struct->stack must be done with MMU off.
> 
> This means we need an additional register to play with MSR
> bits while r11 now points to the stack. For that, move r10
> back to CR (As is already done for hash MMU) and use r10.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/32: Fix vmap stack - Do not activate MMU before reading task struct
      https://git.kernel.org/powerpc/c/c118c7303ad528be8ff2aea8cd1ee15452c763f0
[2/2] powerpc/32: Fix vmap stack - Properly set r1 before activating MMU
      https://git.kernel.org/powerpc/c/da7bb43ab9da39bcfed0d146ce94e1f0cbae4ca0

cheers

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A84C248690
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 15:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgHRN6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 09:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgHRN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 09:58:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82CA8C061389
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 06:58:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BWCDW3NB1z9sTS; Tue, 18 Aug 2020 23:58:19 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
References: <6eddca2d5611fd57312a88eae31278c87a8fc99d.1596641224.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
Message-Id: <159775907943.1766076.16539291819681115078.b4-ty@ellerman.id.au>
Date:   Tue, 18 Aug 2020 23:58:19 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Aug 2020 15:27:29 +0000 (UTC), Christophe Leroy wrote:
> On BOOK3S_32, when we have modules and strict kernel RWX, modules
> are not in vmalloc space but in a dedicated segment that is
> below PAGE_OFFSET.
> 
> So KASAN_SHADOW_START must take it into account.
> 
> MODULES_VADDR can't be used because it is not defined yet
> in kasan.h

Applied to powerpc/fixes.

[1/1] powerpc/kasan: Fix KASAN_SHADOW_START on BOOK3S_32
      https://git.kernel.org/powerpc/c/48d2f0407be7a36e8f20be37ec9121e021ef3964

cheers

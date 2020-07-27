Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DABB22EC23
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 14:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbgG0M2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 08:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726890AbgG0M2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:28:15 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A3FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:28:14 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFfGf4B1wz9sRN;
        Mon, 27 Jul 2020 22:28:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595852890;
        bh=j7IswI7LeuXrByn9IRbR3NmoDK1ZKhlctszqUmkC7uE=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=EWr+X3jvsCyLG4bhtvXSK0U+qEdG7lQGAjFKGLEDOhXnpWIYEX+YcDUPWf2BUVtla
         +8ag4sQMY/VB2/KwFAb/8kLKZT5s0UzFv2aOi/SCBOpdcXDmr2/nKZypxtKkqvnlQo
         HWktAq7rZMfSuGZEwHEdjKEn0lb64/vPaMVZQ13PTztXXqhh2rKcIzsRrto9Gv9MDn
         9IVzQf9rzb1GplxBId+TIJA80jgX7aQ/Fj4se1cL/C57nn9bUXSuF4AOiGxUrEygRR
         EttPAOJhO0ebEOlm1gkoKxaLZpmv+04Zdm/nar2Y1IP6Y5no9KXdnLKxF3f9KZ5J0e
         k1gw4x3Yc4cpQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gabriel Paubert <paubert@iram.es>
Cc:     linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
        dja@axtens.net
Subject: Re: [PATCH v2 2/5] powerpc: Allow 4224 bytes of stack expansion for the signal frame
In-Reply-To: <20200727082331.GA2110@lt-gp.iram.es>
References: <20200724092528.1578671-1-mpe@ellerman.id.au> <20200724092528.1578671-2-mpe@ellerman.id.au> <20200727082331.GA2110@lt-gp.iram.es>
Date:   Mon, 27 Jul 2020 22:28:09 +1000
Message-ID: <87mu3l6t2e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gabriel Paubert <paubert@iram.es> writes:
> On Fri, Jul 24, 2020 at 07:25:25PM +1000, Michael Ellerman wrote:
>> We have powerpc specific logic in our page fault handling to decide if
>> an access to an unmapped address below the stack pointer should expand
>> the stack VMA.
>> 
>> The code was originally added in 2004 "ported from 2.4". The rough
>> logic is that the stack is allowed to grow to 1MB with no extra
>> checking. Over 1MB the access must be within 2048 bytes of the stack
>> pointer, or be from a user instruction that updates the stack pointer.
>> 
>> The 2048 byte allowance below the stack pointer is there to cover the
>> 288 byte "red zone" as well as the "about 1.5kB" needed by the signal
>> delivery code.
>> 
>> Unfortunately since then the signal frame has expanded, and is now
>> 4224 bytes on 64-bit kernels with transactional memory enabled.
>
> Are there really users of transactional memory in the wild? 

Not many that I've heard of, but some.

Though anything that does use it needs to be written to fallback to
regular locking if TM is not available anyway.

> Just asking because Power10 removes TM, and Power9 has had some issues
> with it AFAICT.

It varies on different Power9 chip levels. For guests it should work.

> Getting rid of it (if possible) would result in smaller signal frames,
> with simpler signal delivery code (probably slightly faster also).

All the kernel code should be behind CONFIG_PPC_TRANSACTIONAL_MEM.

Deciding to disable that is really a distro decision.

In upstream we tend not to drop support for existing hardware while
people are still using it. But we could make a special case for TM,
because it's quite intrusive. I think we'd wait for a major distro to
ship without TM enabled before we did that though.

cheers

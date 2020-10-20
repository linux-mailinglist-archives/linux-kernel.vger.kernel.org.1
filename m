Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A532935DB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgJTHeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbgJTHeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:34:12 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00057C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 00:34:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CFlk721Hdz9sSC;
        Tue, 20 Oct 2020 18:34:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1603179249;
        bh=zmNZh+ZEQ1WLOU/BNA8riKCW5xmCis1MYfzfQimpEhU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=nHptS6F7eySdFEovSb7+ia+qEJhEV8hvOW501LZ5tAy7yGP/NwRkMUc/KWA3EGUCn
         MIpS2dnkLcal5HRvI0rbwRbnFrpf85pcgdhClRbyusVQQSzu7vID+lehXEsoBBCeLt
         DzOJGdn9OhAw30d1uknjCAwoXHvKh0u30Oh0MYpfYjMyYYpm1uUSQdXmx+HwctEUov
         Bs9B2s0iQHwajUSoqxnlSytMZ/itgVtPBqzhRQHArtsi5XM8Xgti9Klq0/xJs9SniZ
         QCfp7Idhh+C30SKUgGrj9pBuRKxpFnr8DM2as+9n10LXjbwdcL53ZSQetX7MmEm22+
         xcs8AV8BBiPkw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        "Christopher M. Riedl" <cmr@codefail.de>
Subject: Re: [PATCH 3/8] powerpc: Mark functions called inside uaccess blocks w/ 'notrace'
In-Reply-To: <20201016094132.GI2611@hirez.programming.kicks-ass.net>
References: <20201015150159.28933-1-cmr@codefail.de> <20201015150159.28933-4-cmr@codefail.de> <20201016065616.GB9343@infradead.org> <20201016094132.GI2611@hirez.programming.kicks-ass.net>
Date:   Tue, 20 Oct 2020 18:34:06 +1100
Message-ID: <87v9f5xsep.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Fri, Oct 16, 2020 at 07:56:16AM +0100, Christoph Hellwig wrote:
>> On Thu, Oct 15, 2020 at 10:01:54AM -0500, Christopher M. Riedl wrote:
>> > Functions called between user_*_access_begin() and user_*_access_end()
>> > should be either inlined or marked 'notrace' to prevent leaving
>> > userspace access exposed. Mark any such functions relevant to signal
>> > handling so that subsequent patches can call them inside uaccess blocks.
>> 
>> I don't think running this much code with uaccess enabled is a good
>> idea.  Please refactor the code to reduce the criticial sections with
>> uaccess enabled.
>> 
>> Btw, does powerpc already have the objtool validation that we don't
>> accidentally jump out of unsafe uaccess critical sections?
>
> It does not, there was some effort on that a while ago, but I suspect
> they're waiting for the ARM64 effort to land and build on that.

Right, we don't have objtool support.

We would definitely like objtool support at least for this uaccess
checking, I'm sure we have some escapes.

There was someone working on it in their own-time but last I heard that
was still WIP.

I didn't realise the ARM64 support was still not merged, so yeah having
that land first would probably simplify things, but we still need
someone who has time to work on it.

cheers

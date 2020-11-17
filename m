Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01AA12B72A2
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgKQXsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgKQXsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:48:45 -0500
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2376FC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 15:48:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4CbN1j4GPLz9sPB;
        Wed, 18 Nov 2020 10:48:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1605656921;
        bh=fEjz5+ECM3NqIzdqNElQ+//tKFuS35GsQ/buYOjPLls=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=X0uDEdFRObVJJ54zcMpTUtqlKdcaPC2hCj2Qd0czFF2R73iOZbIxvQEjeT1Zjk3cj
         zx0+gjfeyfAxQ4e2sJfv8UFkS7DGaX2kLKANEeMkk2fNOeNNU01jeyoBujKhuvP14t
         cMylf+vn5wpD4pWUOzKED4i5lN9cw2nKpTmNww0bDVOqMEqXfYzoGrCMTb/xdVZb6c
         hTJs7PyEJUjg6spdU0/f21LjXZySAdxhEgowfxnQOngKOCG3UPzFoSu759HYdvR/an
         MdnvrmqHdXFm2U0ZSfHsn4ybZOVoqB+R/xLJourOR4B3jsgipe0i7Q+kbqsdvUbWlM
         pCKB2CI4c6LmA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough pseudo-keyword in lib/"
In-Reply-To: <20201117221629.GA4679@embeddedor>
References: <20201116043532.4032932-1-ndesaulniers@google.com> <20201116043532.4032932-3-ndesaulniers@google.com> <20201117030214.GB1340689@ubuntu-m3-large-x86> <CAKwvOdk_sphJGQarEWJLzGZWkdzO9dqmcRmys3Retw3vn2Fwag@mail.gmail.com> <20201117221629.GA4679@embeddedor>
Date:   Wed, 18 Nov 2020 10:48:40 +1100
Message-ID: <87ima335pj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Gustavo A. R. Silva" <gustavoars@kernel.org> writes:
> On Tue, Nov 17, 2020 at 11:10:26AM -0800, Nick Desaulniers wrote:
>> On Mon, Nov 16, 2020 at 7:02 PM Nathan Chancellor
>> <natechancellor@gmail.com> wrote:
>> >
>> > On Sun, Nov 15, 2020 at 08:35:31PM -0800, Nick Desaulniers wrote:
>> > > This reverts commit 6a9dc5fd6170 ("lib: Revert use of fallthrough
>> > > pseudo-keyword in lib/")
>> 
>> Gustavo, whose tree did 6a9dc5fd6170 and df561f6688fe go up to
>
> Mine.
>
>> mainline in?  I'm not sure whether you or MPE (ppc) or someone else
>> should pick it this series?
>
> I'm happy to take this series in my tree.  I'm planing to send a
> pull-request for -rc5 with more related changes. So, I can include
> this in the same PR.

I doesn't really seem like rc5 material to me, but that's up to you.

I'd rather not take it in my tree because there's a lot of changes in
lib/ and that's not my area. I'm happy for the two powerpc patches to go
via your tree.

cheers

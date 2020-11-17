Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FE62B7299
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 00:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgKQXp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 18:45:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:33844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgKQXp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 18:45:29 -0500
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0381B2463D;
        Tue, 17 Nov 2020 23:45:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605656729;
        bh=ttg4Gcus/EKo32RUGFMpSMZAYd5VlrCZiWV26ttxjPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kIsqOYTZt8X/hArgRe8n2hSYbJ8b4fM3OTO5MT9Y9T3ym3Zw56mbQHRkOrT9eCrAi
         JcOYEUt1w7Pvv6WqqyILq/hpyKsknAkLKDFaPId2cvIRSBWPVX3+IblA3CRMLMUh/d
         wVopz3hi+wxauGf46yqHU7CArqWzi6UUX21FhMsQ=
Date:   Tue, 17 Nov 2020 17:45:26 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 2/3] Revert "lib: Revert use of fallthrough
 pseudo-keyword in lib/"
Message-ID: <20201117234526.GA7807@embeddedor>
References: <20201116043532.4032932-1-ndesaulniers@google.com>
 <20201116043532.4032932-3-ndesaulniers@google.com>
 <20201117030214.GB1340689@ubuntu-m3-large-x86>
 <CAKwvOdk_sphJGQarEWJLzGZWkdzO9dqmcRmys3Retw3vn2Fwag@mail.gmail.com>
 <20201117221629.GA4679@embeddedor>
 <CAKwvOdmNW3iynqi_+2c1P-6Prq1a8iVufoaZh2NAbsaBLeZZ4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdmNW3iynqi_+2c1P-6Prq1a8iVufoaZh2NAbsaBLeZZ4Q@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 17, 2020 at 02:28:43PM -0800, Nick Desaulniers wrote:
> On Tue, Nov 17, 2020 at 2:16 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > I'm happy to take this series in my tree.  I'm planing to send a
> > pull-request for -rc5 with more related changes. So, I can include
> > this in the same PR.
> >
> > In the meantime I'll add this to my testing tree, so it can be
> > build-tested by the 0-day folks. :)
> 
> SGTM, and thank you.  I'm sure you saw the existing warning about
> indentation.  Do we want to modify the revert patch, or put another
> patch on top?

In this case, it'd be much better to modify the revert patch. I also
saw someone made a comment to the first patch of the series. If you
can address both issues and send v2 it'd be great.  Anyways, as those
are trivial changes, I already added the series to my testing tree for
0-day build-testing.

Thanks
--
Gustavo

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71E9295A8C
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509379AbgJVIi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508194AbgJVIiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:38:25 -0400
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33221C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:38:25 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id 935E6E8080C;
        Thu, 22 Oct 2020 10:38:23 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 1C0A5160834; Thu, 22 Oct 2020 10:38:23 +0200 (CEST)
Date:   Thu, 22 Oct 2020 10:38:23 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        systemd-devel@lists.freedesktop.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, libc-alpha@sourceware.org,
        Dave Martin <dave.martin@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022083823.GA324825@gardel-login>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
 <20201022071812.GA324655@gardel-login>
 <87sga6snjn.fsf@oldenburg2.str.redhat.com>
 <511318fd-efde-f2fc-9159-9d16ac8d33a7@gmail.com>
 <20201022082912.GQ3819@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201022082912.GQ3819@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Do, 22.10.20 09:29, Szabolcs Nagy (szabolcs.nagy@arm.com) wrote:

> > > The dynamic loader has to process the LOAD segments to get to the ELF
> > > note that says to enable BTI.  Maybe we could do a first pass and load
> > > only the segments that cover notes.  But that requires lots of changes
> > > to generic code in the loader.
> >
> > What if the loader always enabled BTI for PROT_EXEC pages, but then when
> > discovering that this was a mistake, mprotect() the pages without BTI? Then
> > both BTI and MDWX would work and the penalty of not getting MDWX would fall
> > to non-BTI programs. What's the expected proportion of BTI enabled code vs.
> > disabled in the future, is it perhaps expected that a distro would enable
> > the flag globally so eventually only a few legacy programs might be
> > unprotected?
>
> i thought mprotect(PROT_EXEC) would get filtered
> with or without bti, is that not the case?

We can adjust the filter in systemd to match any combination of
flags to allow and to deny.

Lennart

--
Lennart Poettering, Berlin

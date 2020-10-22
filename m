Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03FD295910
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 09:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2508529AbgJVH0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 03:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508514AbgJVH0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 03:26:53 -0400
X-Greylist: delayed 513 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 22 Oct 2020 00:26:52 PDT
Received: from gardel.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD677C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 00:26:52 -0700 (PDT)
Received: from gardel-login.0pointer.net (gardel.0pointer.net [IPv6:2a01:238:43ed:c300:10c3:bcf3:3266:da74])
        by gardel.0pointer.net (Postfix) with ESMTP id AC041E8080C;
        Thu, 22 Oct 2020 09:18:14 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id 20608160834; Thu, 22 Oct 2020 09:18:12 +0200 (CEST)
Date:   Thu, 22 Oct 2020 09:18:12 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, libc-alpha@sourceware.org,
        systemd-devel@lists.freedesktop.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <dave.martin@arm.com>
Subject: Re: [systemd-devel] BTI interaction between seccomp filters in
 systemd and glibc mprotect calls, causing service failures
Message-ID: <20201022071812.GA324655@gardel-login>
References: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8584c14f-5c28-9d70-c054-7c78127d84ea@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 21.10.20 22:44, Jeremy Linton (jeremy.linton@arm.com) wrote:

> Hi,
>
> There is a problem with glibc+systemd on BTI enabled systems. Systemd
> has a service flag "MemoryDenyWriteExecute" which uses seccomp to deny
> PROT_EXEC changes. Glibc enables BTI only on segments which are marked as
> being BTI compatible by calling mprotect PROT_EXEC|PROT_BTI. That call is
> caught by the seccomp filter, resulting in service failures.
>
> So, at the moment one has to pick either denying PROT_EXEC changes, or BTI.
> This is obviously not desirable.
>
> Various changes have been suggested, replacing the mprotect with mmap calls
> having PROT_BTI set on the original mapping, re-mmapping the segments,
> implying PROT_EXEC on mprotect PROT_BTI calls when VM_EXEC is already set,
> and various modification to seccomp to allow particular mprotect cases to
> bypass the filters. In each case there seems to be an undesirable attribute
> to the solution.
>
> So, whats the best solution?

Did you see Topi's comments on the systemd issue?

https://github.com/systemd/systemd/issues/17368#issuecomment-710485532

I think I agree with this: it's a bit weird to alter the bits after
the fact. Can't glibc set up everything right from the begining? That
would keep both concepts working.

Lennart

--
Lennart Poettering, Berlin

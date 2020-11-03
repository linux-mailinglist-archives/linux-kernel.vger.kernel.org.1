Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2767E2A455C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 13:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgKCMmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 07:42:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:46018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgKCMmJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 07:42:09 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DBB8322243;
        Tue,  3 Nov 2020 12:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604407328;
        bh=geT2lk0I6IvtZVpOwXI/mI5+Q3wfBHW8Zw/X/UI9yvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R85uLBrHbN+t0WZuzZ/muGfRwWeRxyQgppyZJ6lZ7s8PsBhZIMhLeeTdg+6wo8SSO
         JgrI2gHgNxhsGkGQTQpDertO4pK/esqe/IFa+jNB6nkdQR8+p42kUrsG2nYT196kSq
         6OFhYq5rraKliZ5Azr33DlpYPEYPpgMWHdincncY=
Date:   Tue, 3 Nov 2020 12:42:03 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/4] arm64: alternatives: Split up alternative.h
Message-ID: <20201103124202.GA5219@willie-the-truck>
References: <20201103121721.5166-1-will@kernel.org>
 <20201103121721.5166-2-will@kernel.org>
 <20201103124018.GA40454@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103124018.GA40454@C02TD0UTHF1T.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:40:18PM +0000, Mark Rutland wrote:
> On Tue, Nov 03, 2020 at 12:17:18PM +0000, Will Deacon wrote:
> > asm/alternative.h contains both the macros needed to use alternatives,
> > as well the type definitions and function prototypes for applying them.
> > 
> > Split the header in two, so that alternatives can be used from core
> > header files such as linux/compiler.h without the risk of circular
> > includes
> > 
> > Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> As a heads-up, the uaccess macro move will end up conflicting with my
> uaccess rework. I have a patch moving those out into asm/asm-uaccess.h:
> 
> https://lore.kernel.org/r/20201006144642.12195-9-mark.rutland@arm.com
> 
> .... would you be happy to take that as a prep patch? Then in this
> patch you'd need to modify asm/asm-uaccess.h to include
> asm/alternative-macros.h.

Sure thing, I'll do that when I put the branch together.

> That wasy I can also carry that prep patch in the uaccess series, and
> avoid nasty merge conflicts, and it seems to make sense to factor out
> the uaccess bits anyway since they're not common alternative macros.
> 
> The patch itself looks fine to me, so FWIW (ideally with the above):
> 
> Acked-by: Mark Ryutland <mark.rutland@arm.com>

Cheers!

Will

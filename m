Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2F72AC94D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 00:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730463AbgKIXZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 18:25:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:40304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727311AbgKIXZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 18:25:57 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15471206A1;
        Mon,  9 Nov 2020 23:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604964356;
        bh=OVysUOvCr5fa7OosTb0TzgoRDvZFoVbKaYZCwm1QTRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w2aOvisNwjlGcG/pAQgMRKhxwbCZf46d0fOIN6SDjqsTiaBe/0z7ovwxKtsT7F2rY
         sv7faSNqBH29uftJkCaXIqSVbpSWzoAlUd+YMG3XYt2P77UBkABhwVz0CnuCEpbKfn
         +L/GLCjiBQsJiMeqEtQWQDjSaaqxQSuGNTWDCD8E=
Date:   Mon, 9 Nov 2020 23:25:51 +0000
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Upgrade READ_ONCE() to RCpc acquire on arm64 with
 LTO
Message-ID: <20201109232551.GA15385@willie-the-truck>
References: <20201103121721.5166-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103121721.5166-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 03, 2020 at 12:17:17PM +0000, Will Deacon wrote:
> Hi all,
> 
> These patches were previously posted as part of a larger series enabling
> architectures to override __READ_ONCE():
> 
>   v3: https://lore.kernel.org/lkml/20200710165203.31284-1-will@kernel.org/
> 
> With the bulk of that merged, the four patches here override READ_ONCE()
> so that it gains RCpc acquire semantics on arm64 when LTO is enabled. We
> can revisit this as and when the compiler provides a means for us to reason
> about the result of dependency-breaking optimisations. In the meantime,
> this unblocks LTO for arm64, which I would really like to see merged so
> that we can focus on enabling CFI.
> 
> I plan to queue these on their own branch in the arm64 tree for 5.11 at
> -rc3.

Now pushed to for-next/lto:

https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/lto

with Mark's comments addressed.

Will

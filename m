Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F487281373
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 15:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387749AbgJBNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 09:00:20 -0400
Received: from foss.arm.com ([217.140.110.172]:35464 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBNAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 09:00:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A2FC30E;
        Fri,  2 Oct 2020 06:00:19 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.49.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CA403F70D;
        Fri,  2 Oct 2020 06:00:18 -0700 (PDT)
Date:   Fri, 2 Oct 2020 14:00:08 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Paul Bolle <pebolle@tiscali.nl>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/atomics: Check atomic-arch-fallback.h too
Message-ID: <20201002130008.GA2500@C02TD0UTHF1T.local>
References: <20201001202028.1048418-1-pebolle@tiscali.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201001202028.1048418-1-pebolle@tiscali.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 01, 2020 at 10:20:28PM +0200, Paul Bolle wrote:
> The sha1sum of include/linux/atomic-arch-fallback.h isn't checked by
> check-atomics.sh. It's not clear why it's skipped so let's check it too.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>

This was an oversight; Peter and I forgot to add this when Peter added
the arch fallbacks in commit:

  37f8173dd84936ea ("locking/atomics: Flip fallbacks and instrumentation")

... for which we could arguably add a fixes tag.

Either way:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Peter, I assume you'll pick this up (and also that the hash is
up-to-date as it should be).

> ---
> It seems it never has been checked. So this does cast some doubt about
> the usefulness of these tests. But I'm clueless about this atomic stuff
> so what do I know?

The tests have been useful to ensure people fixed up the scripts when
altering other files, so I think it makes sense to keep this even if we
did miss one file recently.

Mark.

> 
>  scripts/atomic/check-atomics.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/atomic/check-atomics.sh b/scripts/atomic/check-atomics.sh
> index 8378c63a1e09..82748d42ecc5 100755
> --- a/scripts/atomic/check-atomics.sh
> +++ b/scripts/atomic/check-atomics.sh
> @@ -16,6 +16,7 @@ fi
>  cat <<EOF |
>  asm-generic/atomic-instrumented.h
>  asm-generic/atomic-long.h
> +linux/atomic-arch-fallback.h
>  linux/atomic-fallback.h
>  EOF
>  while read header; do
> -- 
> 2.26.2
> 

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10B4C25BF2A
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Sep 2020 12:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgICKi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Sep 2020 06:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICKiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:38:24 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FBDD20716;
        Thu,  3 Sep 2020 10:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599129504;
        bh=LAXgYKBZSgHnpP3vkKbhWFMU0X4+abqBQN6jvUOWbqY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ld1Q2yf2X4ppe6E/1c7dmW3CA+UkvzGxs9ys4JpwdZiYXo2bHei/hIwZyyuZvtNzA
         NKuGMmyikL5JlRlBn0fZ7UrAPjRMCZkyEhihJyUD+GoBP1BGBrGS9RZn0lCaUA7VmV
         YRiU01bnSfLZSu9kHl482I7piLbAX2hS/lbCXO2I=
Date:   Thu, 3 Sep 2020 13:38:19 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH rdma-next 2/4] gcov: Use proper duplication routine for
 const pointer
Message-ID: <20200903103819.GA1137836@unreal>
References: <20200902085513.748149-1-leon@kernel.org>
 <20200902085513.748149-3-leon@kernel.org>
 <eb874b37-3e3f-6819-78f7-bba3e684ae27@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb874b37-3e3f-6819-78f7-bba3e684ae27@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 10:56:38AM +0200, Rasmus Villemoes wrote:
> On 02/09/2020 10.55, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > The filename is a const pointer, so use the proper string duplication
> > routine that takes into account const identifier.
>
> This commit log makes no sense at all.
>
> kstrdup_const is merely an optimization that can be used when there's a
> good chance that the passed string lives in vmlinux' .rodata, in which
> case it is known to be immortal, and we can avoid allocating heap memory
> to contain a duplicate. [It also requires that the caller has no
> intention of modifying the returned string.]
>
> In the case of something called ->filename, I assume it's initialized
> with __FILE__ somewhere, making the above true for built-in stuff but
> not for modules. So if the gcov_info can live longer than the module,
> it's of course necessary to duplicate the string, but OTOH making an
> optimization for the built-in stuff makes sense. So this is certainly
> one of the places where kstrdup_const() seems applicable. But it has
> nothing whatsoever to do with the C-level qualifiers the argument may have.

Thanks, GCOV can't be built as module.

>
> Rasmus

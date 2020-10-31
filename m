Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 147872A18EF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 18:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgJaRQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 13:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgJaRQQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 13:16:16 -0400
Received: from kernel.org (unknown [87.71.17.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0E9F20729;
        Sat, 31 Oct 2020 17:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604164576;
        bh=+g/ECFZbBrYGZiEeJP4Q+Da/WO9Q8mFKk0sfwmNj/CM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z+Z+EPBCs+htmS7aXNo/EV40AL2IhUuzkR9VmhjUYQw4S0jhim7cEQR+jFXpoHUge
         GbS/Xfuvz097vHH80SL56ug6LJX4R8nRANsUhRUY21U4gx5wgh96BX7qDj+CuFAESQ
         Pq81H6K7guxtGoqs/y9clTNdUGsir8Xw+8mKcz4Q=
Date:   Sat, 31 Oct 2020 19:16:08 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>, Ard Biesheuvel <ardb@kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned
 memory reservations
Message-ID: <20201031171608.GB14628@kernel.org>
References: <20201031094345.6984-1-rppt@kernel.org>
 <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMo8BfLCfpZcQC3oqEvExSqZ+dT2sVDjcXoaO_XKALn4rGjoog@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 09:37:09AM -0700, Max Filippov wrote:
> On Sat, Oct 31, 2020 at 2:43 AM Mike Rapoport <rppt@kernel.org> wrote:
> > Please let me know how do you prefer to take it upstream.
> > If needed this can go via memblock tree.
> 
> Going through the memblock tree sounds right to me.

Can I treat this as Ack?

> -- 
> Thanks.
> -- Max

-- 
Sincerely yours,
Mike.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71ACC2E1DB5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 16:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgLWPEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 10:04:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgLWPEU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 10:04:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 163AA23137;
        Wed, 23 Dec 2020 15:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608735820;
        bh=l+DvgL216CNgSCfwhCbMJPQ+5ZkXoL//lqyzyUTKDHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hB64kiqX2Lncfc/UkL9Xey277ADA0B0oHiR1XBl0zorVS5pOmO1t0L9fMmwazaP7a
         8goPU4oN5m6NvypwN4c0awt4GtfkiL/qG84EZ3aTyBwo0fyVUOznTdLkaerAUZB2rd
         u6VkKs7vA6htUrsVua9NRvDgsi+Bt0DllVPyQvHtMw2snDvHVIiDp/TRC/kdNZ/OTz
         DRWdXoXk4+DAR/Wd1D/GTpQaoHB6z5ONRkoG5DSE4kDL0ETMzoHwHQj6gRVZwIPh57
         ykHePlIHg4LGqdsfNo8yzwpP2N2YQrybjujl1qtpnzmLGaHDQvBDb7Ej6ODBmiFTsK
         XYE6ESQNzDTxQ==
Date:   Wed, 23 Dec 2020 15:03:35 +0000
From:   Will Deacon <will@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v2] kernel: locking: delete repeated words in comments
Message-ID: <20201223150334.GA22659@willie-the-truck>
References: <20201221044048.15248-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201221044048.15248-1-rdunlap@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 20, 2020 at 08:40:48PM -0800, Randy Dunlap wrote:
> Drop repeated words in kernel/locking/.
> {it, no, the}
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> ---
> v2: rebase, resend
> 
>  kernel/locking/rtmutex.c   |    4 ++--
>  kernel/locking/rwsem.c     |    2 +-
>  kernel/locking/semaphore.c |    2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will

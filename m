Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E284303BC6
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391657AbhAZLgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:36:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:34262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391347AbhAZKVB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:21:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F349921744;
        Tue, 26 Jan 2021 10:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611656418;
        bh=6DOvlm706rmhsW1z1XjS9Clql0hWOECtjaG3EOjR5u4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KcIYYnFn0cJDwM+1zp1u10ruU2hCRePNLJ4RdTreVgSbjPDenCm07um2xBQsalAJm
         egkrX2ln79A+NTumO5yry667om3cEYlqxWhf/mNfNdJFniUCTq/aLaAas/HXAown0a
         RvyD5eo7+xjeSHVvCEIjmcUDg8YcVgSwxJk9mH6sgO000Lt6HqqiaIjRISpI/V65Pw
         d9GbleLg8aH2FjmaDBrpJcW+ASClD2PEvKQ9lXxvbmPUW8qILxfe97ApTcXAMzr6Pp
         6h1TUp4WOGjttXHqE0BLl9vXzp/Os79mfvvG0e1ab6r1aNWlm/8wQ09rtBIkk3JGAa
         sQaIs+1Vrh//A==
Date:   Tue, 26 Jan 2021 10:20:14 +0000
From:   Will Deacon <will@kernel.org>
To:     Nikolay Borisov <nborisov@suse.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com
Subject: Re: [PATCH v2] locking/rwsem: Remove empty rwsem.h
Message-ID: <20210126102014.GB29204@willie-the-truck>
References: <20210126101721.976027-1-nborisov@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126101721.976027-1-nborisov@suse.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:17:21PM +0200, Nikolay Borisov wrote:
> This is a leftover from 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
> 
> Signed-off-by: Nikolay Borisov <nborisov@suse.com>
> ---
> V2:
>  * Add reference to commit which made the file useless.
> 
>  kernel/locking/rwsem.h | 0
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  delete mode 100644 kernel/locking/rwsem.h
> 
> diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
> deleted file mode 100644
> index e69de29bb2d1..000000000000

Acked-by: Will Deacon <will@kernel.org>

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69E0D24D482
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Aug 2020 13:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgHULyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Aug 2020 07:54:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727979AbgHULyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 07:54:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D39F204EC;
        Fri, 21 Aug 2020 11:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598010841;
        bh=lCFRFQbXpUWJDBNgEKqSJWBGXQEf3rG2KVJd2mGFMBk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=boebsSOHPgamimsG1i9BIlwiVaHkGTNh12pa0x+o+mhd56enf1Bm3/5zY3uyCsANS
         vvHjZ21aOzYC7qV4VKprqN2ZYp3Id17c5VOdmxA5SiT6Hk1XF2Rrou77wBbZ/vPeUD
         pkxqlcsQsZEdB7+7vQc/qwwVMOfWW4zEgHu2jebE=
Date:   Fri, 21 Aug 2020 12:53:57 +0100
From:   Will Deacon <will@kernel.org>
To:     Marta Rybczynska <rybczynska@gmail.com>
Cc:     peterz@infradead.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/locking/locktypes: fix local_locks
 documentation
Message-ID: <20200821115356.GA20833@willie-the-truck>
References: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 08:54:40PM +0200, Marta Rybczynska wrote:
> Fix issues with local_locks documentation:
> - fix function names, local_lock.h has local_unlock_irqrestore(),
> not local_lock_irqrestore()
> - fix mapping table, local_unlock_irqrestore() maps to local_irq_restore(),
> not _save()
> 
> Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
> ---
>  Documentation/locking/locktypes.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Looks correct to me, thanks:

Acked-by: Will Deacon <will@kernel.org>

Will

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCCCF2FAB73
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 21:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437937AbhARU2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 15:28:43 -0500
Received: from ms.lwn.net ([45.79.88.28]:40994 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2394330AbhARU2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 15:28:19 -0500
Received: from lwn.net (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 11DAF9A6;
        Mon, 18 Jan 2021 20:27:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 11DAF9A6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1611001658; bh=vjaF1Jxtw/q+PbEt7mA2wP8zgMALXDurMvfIjvvtgjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=egIgfcXOhjlk68u+MXNjKp2VebpBQ5BB1466ywubEEiuDEin4FyDuBS/L9OE7s/T6
         xO8/FscK8wdF4J3cJ1BzKeY5caw4Dy+D5mSjlfiKzwhW3EkdRb0v6bl5qU9/Wc7l37
         QP+19fDuJYycub5QjI9JqFK5L21ItLBTnFEYQCdHz1GjThE13vzzoiXLML7+dp1xHT
         KteJEPZyWQgiyL/NYm3hQxjAhFc/Y/GOQnwPTn4Syz6cIlN4KtHinfih5ucpgoWj6/
         bVCYyfMW6MOCBvjWt2PLrzbkjUmKBEEAysOJfooI8pbWVyByuUmJpVfaxUxuy0ajKn
         xtWGld4rCnbOQ==
Date:   Mon, 18 Jan 2021 13:27:37 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH] Documentation: fix typos in split page table lock
 description
Message-ID: <20210118132737.318b2284@lwn.net>
In-Reply-To: <2338863.uUFqZTUbry@devpool47>
References: <2338863.uUFqZTUbry@devpool47>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jan 2021 14:19:36 +0100
Rolf Eike Beer <eb@emlix.com> wrote:

> Signed-off-by: Rolf Eike Beer <eb@emlix.com>
> ---
>  Documentation/vm/split_page_table_lock.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/vm/split_page_table_lock.rst b/Documentation/vm/split_page_table_lock.rst
> index ff51f4a5494d..c08919662704 100644
> --- a/Documentation/vm/split_page_table_lock.rst
> +++ b/Documentation/vm/split_page_table_lock.rst
> @@ -32,7 +32,7 @@ There are helpers to lock/unlock a table and other accessor functions:
>  
>  Split page table lock for PTE tables is enabled compile-time if
>  CONFIG_SPLIT_PTLOCK_CPUS (usually 4) is less or equal to NR_CPUS.
> -If split lock is disabled, all tables guaded by mm->page_table_lock.
> +If split lock is disabled, all tables are guarded by mm->page_table_lock.

Applied, thanks.

jon

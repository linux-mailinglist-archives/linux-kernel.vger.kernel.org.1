Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2722953F0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 23:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505919AbgJUVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2411408AbgJUVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 17:15:03 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6139C0613CE;
        Wed, 21 Oct 2020 14:15:02 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 5CFC17C0;
        Wed, 21 Oct 2020 21:15:01 +0000 (UTC)
Date:   Wed, 21 Oct 2020 15:14:58 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Wei Lin Chang <r09922117@csie.ntu.edu.tw>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation: x86: fix a missing word in
 x86_64/mm.rst.
Message-ID: <20201021151458.63e2d5ff@lwn.net>
In-Reply-To: <20201015062242.26296-1-r09922117@csie.ntu.edu.tw>
References: <20201015062242.26296-1-r09922117@csie.ntu.edu.tw>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Oct 2020 14:22:42 +0800
Wei Lin Chang <r09922117@csie.ntu.edu.tw> wrote:

> This patch adds a missing word in x86/x86_64/mm.rst, without which
> the note reads awkwardly.
> 
> Signed-off-by: Wei Lin Chang <r09922117@csie.ntu.edu.tw>
> ---
>  Documentation/x86/x86_64/mm.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/x86/x86_64/mm.rst b/Documentation/x86/x86_64/mm.rst
> index e5053404a..ede187571 100644
> --- a/Documentation/x86/x86_64/mm.rst
> +++ b/Documentation/x86/x86_64/mm.rst
> @@ -19,7 +19,7 @@ Complete virtual memory map with 4-level page tables
>     Note that as we get closer to the top of the address space, the notation changes
>     from TB to GB and then MB/KB.
>  
> - - "16M TB" might look weird at first sight, but it's an easier to visualize size
> + - "16M TB" might look weird at first sight, but it's an easier way to visualize size

Applied, thanks.

jon

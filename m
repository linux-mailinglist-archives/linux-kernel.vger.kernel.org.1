Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4628C2E337F
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 02:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgL1Bo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 20:44:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:57112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgL1Bo6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 20:44:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AD2D22522;
        Mon, 28 Dec 2020 01:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609119857;
        bh=+odxiDUmAkqtS67hXT2msSOU8wUvOYdpSg7ZS7qOcXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AL5poWRTnO5hJyWIv8CyHmkn6o2A1202rwGGlFU+BJn/I032S7dALax9Ho7huXwQH
         nwhmjmSxmC/KDz0y3mMH/s3bNkEMVC+S6PK0osRG1E3tRyEUJzSjj7ND47JcisgWon
         tqLw31dqMy22ZRRGOdtuOxZzFbE5OHzcx9CX7Rk3EfPi7HgWWT6K4TXKRhPvYkezis
         Y06DZ3hCaa4XNrQWnUiabJ3feHVkb9QFlFj/lj4fYeLH6bH2rUJyjcJw0sGkaDsIAl
         a4PjSN0jOmveCPeMQ/Afbgu4sxZF1ITkH8UDIjAasuiNU/HpORjCrmfuD+jWPLmHfR
         RsLDnRODIV4iQ==
Date:   Mon, 28 Dec 2020 10:44:14 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 02/19] x86/insn: Add @buf_len param to insn_init()
 kernel-doc comment
Message-Id: <20201228104414.e1061048ce09305ec0dc4c3d@kernel.org>
In-Reply-To: <20201223174233.28638-3-bp@alien8.de>
References: <20201223174233.28638-1-bp@alien8.de>
        <20201223174233.28638-3-bp@alien8.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Dec 2020 18:42:16 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> It wasn't documented so add it. No functional changes.
> 

Thank you for fixing!

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/lib/insn.c       | 1 +
>  tools/arch/x86/lib/insn.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 404279563891..1ba994862b56 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -37,6 +37,7 @@
>   * insn_init() - initialize struct insn
>   * @insn:	&struct insn to be initialized
>   * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
> + * @buf_len:	length of the insn buffer at @kaddr
>   * @x86_64:	!0 for 64-bit kernel or 64-bit app
>   */
>  void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
> diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
> index 0151dfc6da61..f3277d6e4ef2 100644
> --- a/tools/arch/x86/lib/insn.c
> +++ b/tools/arch/x86/lib/insn.c
> @@ -37,6 +37,7 @@
>   * insn_init() - initialize struct insn
>   * @insn:	&struct insn to be initialized
>   * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
> + * @buf_len:	length of the insn buffer at @kaddr
>   * @x86_64:	!0 for 64-bit kernel or 64-bit app
>   */
>  void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64)
> -- 
> 2.29.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D912C45F8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 17:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732417AbgKYQxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 11:53:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:33046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730115AbgKYQxh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 11:53:37 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0EC02083E;
        Wed, 25 Nov 2020 16:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606323216;
        bh=te8Oy9XLGYOL27YFUlNQH28c35Qek0dhlpTDNhOkAI0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wpqKDL4PEYoRUDxXLHygQ5Cgkvb/VIvxlkhIcsy/yDCWMNzf/L3nhfgeQKZDxggjY
         cI3PAVcBmlJk2aqLZ1LSx9KQR+JOdGAcmHbrZ6w868/bIdK/+UlXQmfbfrAUiqMYxv
         wfIwFMjOb3acWQpSx1Qxb1wx0qFYxZ/N7NPE3m4U=
Date:   Thu, 26 Nov 2020 01:53:33 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andy Lutomirski <luto@amacapital.net>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 03/19] x86/insn: Add an insn_decode() API
Message-Id: <20201126015333.fb0fb2b548013073ce72f19f@kernel.org>
In-Reply-To: <20201124101952.7909-4-bp@alien8.de>
References: <20201124101952.7909-1-bp@alien8.de>
        <20201124101952.7909-4-bp@alien8.de>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Borislav,

On Tue, 24 Nov 2020 11:19:36 +0100
Borislav Petkov <bp@alien8.de> wrote:

> From: Borislav Petkov <bp@suse.de>
> 
> Users of the instruction decoder should use this to decode instruction
> bytes. For that, have insn*() helpers return an int value to denote
> success/failure.
> 
> While at it, make insn_get_opcode() more stricter as to whether what has
> seen so far is a valid insn and if not.

(only from the viewpoint of VEX coding, a bit stricter, but not perfect.)


> Copy linux/kconfig.h for the tools-version of the decoder so that it can
> use IS_ENABLED().
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> ---
>  arch/x86/include/asm/insn.h       |  24 ++--
>  arch/x86/lib/insn.c               | 182 +++++++++++++++++++++++-------
>  tools/arch/x86/include/asm/insn.h |  24 ++--
>  tools/arch/x86/lib/insn.c         | 182 +++++++++++++++++++++++-------
>  tools/include/linux/kconfig.h     |  73 ++++++++++++
>  5 files changed, 391 insertions(+), 94 deletions(-)
>  create mode 100644 tools/include/linux/kconfig.h
> 
> diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
> index 5c1ae3eff9d4..e80ddfe86255 100644
> --- a/arch/x86/include/asm/insn.h
> +++ b/arch/x86/include/asm/insn.h
> @@ -87,13 +87,23 @@ struct insn {
>  #define X86_VEX_M_MAX	0x1f			/* VEX3.M Maximum value */
>  
>  extern void insn_init(struct insn *insn, const void *kaddr, int buf_len, int x86_64);
> -extern void insn_get_prefixes(struct insn *insn);
> -extern void insn_get_opcode(struct insn *insn);
> -extern void insn_get_modrm(struct insn *insn);
> -extern void insn_get_sib(struct insn *insn);
> -extern void insn_get_displacement(struct insn *insn);
> -extern void insn_get_immediate(struct insn *insn);
> -extern void insn_get_length(struct insn *insn);
> +extern int insn_get_prefixes(struct insn *insn);
> +extern int insn_get_opcode(struct insn *insn);
> +extern int insn_get_modrm(struct insn *insn);
> +extern int insn_get_sib(struct insn *insn);
> +extern int insn_get_displacement(struct insn *insn);
> +extern int insn_get_immediate(struct insn *insn);
> +extern int insn_get_length(struct insn *insn);
> +
> +enum insn_mode {
> +	INSN_MODE_32,
> +	INSN_MODE_64,
> +	/* Mode is determined by the current kernel build. */
> +	INSN_MODE_KERN,
> +	INSN_NUM_MODES,
> +};
> +
> +extern int insn_decode(struct insn *insn, const void *kaddr, int buf_len, enum insn_mode m);
>  
>  /* Attribute will be determined after getting ModRM (for opcode groups) */
>  static inline void insn_get_attribute(struct insn *insn)
> diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
> index 1ba994862b56..1f749e3b4a25 100644
> --- a/arch/x86/lib/insn.c
> +++ b/arch/x86/lib/insn.c
> @@ -13,6 +13,9 @@
>  #include <asm/inat.h>
>  #include <asm/insn.h>
>  
> +#include <linux/errno.h>
> +#include <linux/kconfig.h>
> +
>  #include <asm/emulate_prefix.h>
>  
>  /* Verify next sizeof(t) bytes can be on the same instruction */
> @@ -98,8 +101,12 @@ static void insn_get_emulate_prefix(struct insn *insn)
>   * Populates the @insn->prefixes bitmap, and updates @insn->next_byte
>   * to point to the (first) opcode.  No effect if @insn->prefixes.got
>   * is already set.
> + *
> + * * Returns:
> + * 0:  on success
> + * !0: on error
>   */

So this is different from...

[..]
> +
> +/**
> + * insn_decode() - Decode an x86 instruction
> + * @insn:	&struct insn to be initialized
> + * @kaddr:	address (in kernel memory) of instruction (or copy thereof)
> + * @buf_len:	length of the insn buffer at @kaddr
> + * @m:		insn mode, see enum insn_mode
> + *
> + * Returns:
> + * 0: if decoding succeeded
> + * < 0: otherwise.

this return value.

Even for the insn_get_*(), I would like to see them returning -EINVAL
as same as insn_decode(). Same API group has different return value is
confusing.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

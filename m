Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E80E2B1E60
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:13:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgKMPNv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:13:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:13:50 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C240BC0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:13:50 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id z3so3271835qtw.9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=icY/gp+ng2kINfYBZsfVN8BUZwIF1dDaISfx4TfzD2M=;
        b=qUTnqXtny2JjwSI0SvENJU/TcwJ87cdgIdjM4s799Ig+0s24GlCO0TXtOxJz1z/1mp
         1XYP0+riF28L3b55+iEDH7c5fNwnQaOwy7HwcAn+ghn8tBnE3q44nO+N3OyboxeCrRnd
         SNzJjdRLQe3gjyGZh+JTeDW8soThNpSpeTpCfFv/Xc+gkURnesTNyS8qYidBuVDs22Qa
         88Pi/k9X3aeDJhKp4TkgNFmOWPaQwFVRpcjjMxYXZKkkloenpHaKiffoafIVtNuP/DfP
         W9JZzynLsX8A4gISQidOWcTL8oTNqYV3OoxnRQWKzdluYktWCe/Sjg8Kjrlceoi05Q86
         jchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=icY/gp+ng2kINfYBZsfVN8BUZwIF1dDaISfx4TfzD2M=;
        b=eo1nlbcJR1RGoFpC5XQnIosR6n9YHD9wheDoxNf74ZxNs84uEWwBDiZr/gEckz0x+W
         H0UluL5lOmTYwOJogRbr/KGlNBrhOgLiilVlv/yEtyN5rFJ2fKDdFyD6f5+bLGVsM5zY
         GjNbQaocgI6tQbvwgCNTNsKOOr4U0vPyXzbW0tVYrY/4vLIIzeQInrE0FtU6Bb29MrG/
         Ysn1wEpxqDJvil2B8SdwCbzsM2WtvgnNAKuZCMJTsU4gD3GETWu/ZM+mJJgymGfjzdjy
         qEAkeZ6lF3wPGc3ubFS2tJ0UkKApqh7NkThOnXw5pPCbICZZp+6LM50rS6udJ2ZIhTZ5
         OgVw==
X-Gm-Message-State: AOAM532nR6X7Zi6kVBLX0DawTEo9ATzQ7K6igPvif3zTMMhI73BUx/K6
        V7MWTTAMY1pCOZ1yrvwCdsc=
X-Google-Smtp-Source: ABdhPJyQkw2sNTpsmbKp7Tn1/LYmD6RwSNOjYZJZj5amx6nEAZlfomfmLulQZAHpAZ10F2z7YUQkzw==
X-Received: by 2002:aed:3802:: with SMTP id j2mr2369048qte.388.1605280425153;
        Fri, 13 Nov 2020 07:13:45 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y35sm2783098qty.58.2020.11.13.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 07:13:44 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 13 Nov 2020 10:13:42 -0500
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot/compressed/64: Drop the now-unused
 finalize_identity_maps()
Message-ID: <20201113151342.GA618063@rani.riverdale.lan>
References: <20201113150810.1233016-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201113150810.1233016-1-vkuznets@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13, 2020 at 04:08:10PM +0100, Vitaly Kuznetsov wrote:
> Since commit 8570978ea030 ("x86/boot/compressed/64: Don't pre-map memory in
> KASLR code") finalize_identity_maps() has no users, drop it.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/boot/compressed/ident_map_64.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
> index a5e5db6ada3c..6bf20223dc0f 100644
> --- a/arch/x86/boot/compressed/ident_map_64.c
> +++ b/arch/x86/boot/compressed/ident_map_64.c
> @@ -167,16 +167,6 @@ void initialize_identity_maps(void *rmode)
>  	write_cr3(top_level_pgt);
>  }
>  
> -/*
> - * This switches the page tables to the new level4 that has been built
> - * via calls to add_identity_map() above. If booted via startup_32(),
> - * this is effectively a no-op.
> - */
> -void finalize_identity_maps(void)
> -{
> -	write_cr3(top_level_pgt);
> -}
> -
>  static pte_t *split_large_pmd(struct x86_mapping_info *info,
>  			      pmd_t *pmdp, unsigned long __address)
>  {
> -- 
> 2.26.2
> 

I had sent this and another unused removal last month:
https://lore.kernel.org/lkml/20201005151208.2212886-1-nivedita@alum.mit.edu/

Thanks.

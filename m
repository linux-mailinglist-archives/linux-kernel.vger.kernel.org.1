Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 960E828755C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730333AbgJHNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728969AbgJHNpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:45:01 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AC2C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 06:45:01 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 140so5275696qko.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 06:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hTx5wxbwW2y1aqwu6D/P4lkFjUf8iqV76vNFf1Ytp58=;
        b=TuR3rgRh1QHA8p4nESYsGWXEq7xJZ1IkCA919YQ28SWsZO0Yx/v3sOr2tS0Fiwv+UT
         ppQcFGpUv1nKi6RwuGPaq04K8v2kPbodyR/aozzOxoyDxnuo0Enapaj4B4pb72TUqRxi
         ujmJpWb5vxTXG4eZDp1A6mEH8U5QwcMtvcgXkrieVYD6KgLK/30ltIUly99ficeeDVFG
         Iif72Bfg8P/sdpznOXBnmqOYo0MUATO+KLyOjnuW0m4DOLdSWEl+cCDKqo4V8XmEOqiL
         5GIk4iaq33fRYaAwuqCcMHuQTpS1Ra/ZMueZuuTL3PgFEC+WQr+iJEckKDALeXkgILX7
         1iZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hTx5wxbwW2y1aqwu6D/P4lkFjUf8iqV76vNFf1Ytp58=;
        b=nZXqNg82JiIgxsUZAhd1TP7155arwsbPdKnXZecurHQqcOkuq6/f0nsn+jOF106pvb
         vCK1EAALR1ubL9Di688MBZCWuJ9omnZOP0olqJxh2PmyD+cVG6y8Bcx7xuIVYlPvR85w
         OwTaxeHI70X67hHwG7W0ZM7suJCxTEKailyb93w+RsaVLbgedjNkXX7dcYYWs2hxzw3Q
         /kyUxhed3ZfQMMg4XBMN2gJsIk7ONFEOZHJKvOa5utO+15bxqeySa5wT4bSsccezhRBW
         C7r5jzFf1qaMqacIvXY9sTV2t2zFN5+2XfBIN+3vZgy9ueMXP5XsFgfX7/4XZH2fYP1O
         2xew==
X-Gm-Message-State: AOAM5303u59+faPVwAaKkaJAcucdcirLgABNLRZ4AnP5u6vP8Nq0DU/x
        BHCH3rp7SnpajT9Dy2eSjRtoV/rrgh7bpg==
X-Google-Smtp-Source: ABdhPJz5gVl5NgCwvFXoCSmNb7juWGwW7oR2EFiI+lsrz3zhdiyaIeOxq7bPyA540CeolHKPt5Y7JQ==
X-Received: by 2002:a37:a251:: with SMTP id l78mr7765239qke.291.1602164700449;
        Thu, 08 Oct 2020 06:45:00 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id d142sm3892800qke.125.2020.10.08.06.44.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 06:44:59 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 8 Oct 2020 09:44:58 -0400
To:     Joerg Roedel <jroedel@suse.de>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] x86/boot: Initialize boot_params in startup code
Message-ID: <20201008134458.GA2429573@rani.riverdale.lan>
References: <20201007195351.776555-1-nivedita@alum.mit.edu>
 <20201007195351.776555-2-nivedita@alum.mit.edu>
 <20201008090420.GD3209@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201008090420.GD3209@suse.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 08, 2020 at 11:04:20AM +0200, Joerg Roedel wrote:
> On Wed, Oct 07, 2020 at 03:53:47PM -0400, Arvind Sankar wrote:
> > Save the boot_params pointer passed in by the bootloader in
> > startup_32/64. This avoids having to initialize it in two different
> > places in C code, and having to preserve SI through the early assembly
> > code.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> 
> Nice cleanup!
> 
> >  /*
> >   * Jump to the extracted kernel.
> >   */
> > -	xorl	%ebx, %ebx
> > +	movl	boot_params@GOTOFF(%ebx), %esi
> >  	jmp	*%eax
> >  SYM_FUNC_END(.Lrelocated)
> >  
> > @@ -209,6 +208,8 @@ SYM_DATA_START_LOCAL(gdt)
> >  	.quad	0x00cf92000000ffff	/* __KERNEL_DS */
> >  SYM_DATA_END_LABEL(gdt, SYM_L_LOCAL, gdt_end)
> >  
> > +SYM_DATA(boot_params, .long 0)
> > +
> 
> You should add a comment here that boot_params needs to be in the .data
> section because in .bss it would get zeroed out again later. Same
> applies to the 64bit version of this.
> 
> With that changed:
> 
> Reviewed-by: Joerg Roedel <jroedel@suse.de>
> 

Ok.

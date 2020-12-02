Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8E92CC9A0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 23:32:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgLBWav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 17:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgLBWav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 17:30:51 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DAC0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 14:30:11 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f14so1410426pju.4
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 14:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4qDI8fXrRiY//c2cY8v2SRnoRi5MIHxovIte32lpQ5E=;
        b=VzWaofaf+mk+DYFfKusq/ibaf9go2lyaVVt94rb+0N+pcSYPmkQXU5LN3YUPA0dhkT
         vLS4ohrwLnUgd6PGhxuDUv8K7LmdPmCQ/3j6/vmr5Vm8mhQvOERjIUL3pl3whbE8p3Sl
         tnotD/QQ6KxhCY/lY2udqJKcX6Uz1/XqZbl7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4qDI8fXrRiY//c2cY8v2SRnoRi5MIHxovIte32lpQ5E=;
        b=pOiT3xHSqXXjC2C607gcytlI988KCfGUN4/JtMbaLdM+/HbOB8MXoU4h/pUx+dNkGp
         JuyHqUI1UHGs1hxwkqzDnUNZl8wXKqFS7CNLe0ZJj0IUfw4xafL+bjWBZ8BbBsWwuSRJ
         yGh57U0R9GCimRg9Yh6+BsyILMJzOzarPecH3/cSAJ6/ygQ6dFh6XL2W4DbAYk0B1Mg8
         OnImIrj1f2y8modblvoofcW7WOFv/pSPLdWSAHB7fESkCOqvEvISQy1sbhWYtzNJALWa
         vxlFC+U09K3IuQloQ0Fher5adDSn3oykbis4sIy2PMHL/JQGdIopWPvvevg4Rukh8kPg
         5czA==
X-Gm-Message-State: AOAM530sUOGv59TAUVC0crAmOLOgKubRJm4MSFYR54Sb2fwMLvlobk7s
        EpmdF/hXrhHYkfuPn7+DQNE6kg==
X-Google-Smtp-Source: ABdhPJwN2GnEz55TS/DFhaOAmUvJPdOuloCAkMJ2fIMK2IYoZeDKCiUd2RrufKX3Pi8RYdURxVqaEA==
X-Received: by 2002:a17:902:860c:b029:da:1ba0:3979 with SMTP id f12-20020a170902860cb02900da1ba03979mr243150plo.8.1606948210576;
        Wed, 02 Dec 2020 14:30:10 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v18sm104369pfn.35.2020.12.02.14.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 14:30:09 -0800 (PST)
Date:   Wed, 2 Dec 2020 14:30:08 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pstore: Move kmsg_bytes default into Kconfig
Message-ID: <202012021427.3E12CABB@keescook>
References: <20201201201234.137572-1-keescook@chromium.org>
 <20201202214257.36wf5a4ui2axr3es@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201202214257.36wf5a4ui2axr3es@chatter.i7.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 02, 2020 at 04:42:57PM -0500, Konstantin Ryabitsev wrote:
> On Tue, Dec 01, 2020 at 12:12:34PM -0800, Kees Cook wrote:
> > ---
> > This was sent off-list, so I'm resending it to lkml (with the commit log
> > cleaned up sligthly) before I push it into for-next/pstore.
> 
> Also, nice:
> 
> Writing /tmp/20201201_keescook_pstore_move_kmsg_bytes_default_into_kconfig.mbx
>   ✔ [PATCH] pstore: Move kmsg_bytes default into Kconfig
>   ---
>   ✔ Attestation-by: Kees Cook <keescook@chromium.org> (pgp: 8972F4DFDC6DC026)

Yay! :)

> Did you use the sendemail-validate hook for this?

In my scripts right now, I'm doing this before "git send-email":

# Construct header-based attestations
b4 attest outgoing/*

I haven't yet converted to using the git hook.

-- 
Kees Cook

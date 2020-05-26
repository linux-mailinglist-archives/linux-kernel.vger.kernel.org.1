Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61BD01C7D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 May 2020 00:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbgEFWt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 18:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729243AbgEFWt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 18:49:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94AC061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 15:49:55 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so1243174plp.6
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 15:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Q2FUrzCimCoQvPDI8jhXkMBxIsQZ8fqLNRuB8pW8C9I=;
        b=apgnO1tx03gYzmTiztou0ozl4DqE9Ke1CUls8XDLxiqo5GiuaT0cgajPeNIc1Nvgrh
         QSR/aDtXJFrDbcw3pE4mo7iM3uXupATiB4zjUWXDBhAWz29oyPbkwjLQEjzRYt4t1HSV
         HCgAaF82vmv4XqWI3sJU/yOu1FGAMo8m0rBsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Q2FUrzCimCoQvPDI8jhXkMBxIsQZ8fqLNRuB8pW8C9I=;
        b=kjO5QQBt33VQ+iJ1c/MquGrB25VVzOJ5hTxGMR/plx05NhDFiSXV5S/WWjm9IzCc5F
         rrF+6CaEgqaTrZrU27I0IKb5cwJCCWIkQFqaM2HQbXYI9CrK35nM2+CzFoQM6Bx8xxtg
         03FruS0ZIP+JYhr5hYMAES1GSNQtSErj3f7ge0XNdnroTV1F2DBhSKgSxphj+IZa156L
         c3ZdZlSmnx0FR5zCcXnn8wXm00YeJZwq/dIZLdsclIOizOfTwOu/jThNgGtqfKTbx9+E
         YQMTlH7776+Br8e4x0ie/jFIM9apcV/boJnwkMAqB4NAzZwx2bO/sAifez6AkAdancoR
         TtvQ==
X-Gm-Message-State: AGi0PuYM+ZLqwTpBQCmYWxBa9FVAtvsjJsIy6O4hecTaAP92c4P7xN8Y
        gWBePU8TtwbNCzoZ9iZ3rsmWdkd18Zg=
X-Google-Smtp-Source: APiQypKzOSl6t5TXplgO53uZ+njke5Lpns5FHbM+l01D4h+BwwkOyeefVKk0O7oypj6oZi1uWRWTzA==
X-Received: by 2002:a17:902:bd09:: with SMTP id p9mr10891853pls.214.1588805394525;
        Wed, 06 May 2020 15:49:54 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a30sm2294097pgm.44.2020.05.06.15.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 15:49:53 -0700 (PDT)
Date:   Wed, 6 May 2020 15:49:52 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] securityfs: Add missing d_delete() call on removal
Message-ID: <202005061543.97CC065531@keescook>
References: <202005051626.7648DC65@keescook>
 <20200506011431.GB23230@ZenIV.linux.org.uk>
 <202005052024.2D7626C742@keescook>
 <20200506040252.GC23230@ZenIV.linux.org.uk>
 <202005060831.C05759E@keescook>
 <20200506184920.GD23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506184920.GD23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 07:49:20PM +0100, Al Viro wrote:
> On Wed, May 06, 2020 at 08:34:29AM -0700, Kees Cook wrote:
> 
> > Just posted the whole series:
> > https://lore.kernel.org/lkml/20200506152114.50375-1-keescook@chromium.org/
> > 
> > But the specific question was driven by this patch:
> > https://lore.kernel.org/lkml/20200506152114.50375-11-keescook@chromium.org/
> 
> Yecchh...  First of all, you are leaving a dangling pointer in your
> struct pstore_private ->dentry.  What's more, in your case d_delete()

Yeah, good idea: I can wipe out the pstore_private->dentry at this point
just for robustness. From what I could tell the evict got immediately
called after the dput().

> is definitely wrong - either there are other references to dentry
> (in which case d_delete() is the same as d_drop()), or dput() right
> after it will drive ->d_count to zero and since you end up using
> simple_dentry_operations, dentry will be freed immediately after
> that.

Do you mean the d_drop() isn't needed? What happens if someone has
the file open during this routine? The goal here is to make these files
disappear so they'll go through evict.

> I have not looked at the locking in that series yet, so no comments

Yeah, I would not be surprised by some more locking issues, but I think
it's an improvement over what was there. Most of the code seems to have
been designed to be non-modular. :P

> on the races, but in any case - that d_delete() is a misspelled d_drop().

I'll change it; thanks!

-- 
Kees Cook

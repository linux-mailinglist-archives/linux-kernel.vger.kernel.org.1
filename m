Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B4F1CE8EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 01:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgEKXO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 19:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKXO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 19:14:27 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A53C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:14:26 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id s69so295626pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 16:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oLYGiY1VcoUuZyQjSRt0EjsR/VIIkqkknogJiDpiRhY=;
        b=UCck4fLisgj6UcVB/cAH9mNu4GpO5hH8d5mbh/bG3fku7/1Jrx6/4TOECxiimjIWOx
         7KbuxG0YYV8aG1EP1qn6CCmTJTbfozI0IKKBOMEO+dzE/i1mJI7jd0nF0e2NlDlDhyZS
         ni3FdgM+hLwUi9CdX6nncPPcyj+72dW+ERF24=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oLYGiY1VcoUuZyQjSRt0EjsR/VIIkqkknogJiDpiRhY=;
        b=OsrNdMiGCGN213baa6gkPmnC940mKi1mrz/XbiI3W+y9ciSR/iVQMVSmjFpXGUmuSN
         +M9SYXmaElznx1NFy2B9t7TpWTJZ3S6nDb9G9+rFM0pOtItqCXSCjk11L0Jne3O6A8iL
         5DqSpLksWjZ+2PtzNC4YZpoS9GFmpKFLvGIbkkbsa97oSMjPiV7Ag8Beti36oApLqYsx
         dVLD9ELFmnZ1j7jZ4aX64dWbhFqcFueLa5b5Gcu6gcAYX60HJ/NV0AAk/GZLDLDDAKoD
         IoqYOukN70V4yatoisAIFcY478Q426oqwQl3qRJxVenBYvkbHTifDimsu01+9Xge31l+
         WEqw==
X-Gm-Message-State: AGi0PubdWr1y5PXhpJJicsco85ghBuS5DJKXR3rhGVXj8xODI87ni3o7
        ax14ILwzdsziekGVlLrDa9uGG2uR9Zw=
X-Google-Smtp-Source: APiQypIMHggqUeWrrrUBc+49/UkRkp4H6it9wkIlmlUqDgYBAzEEiw7GofYyl0Ye461eA6ivRZ/xng==
X-Received: by 2002:a17:90a:1941:: with SMTP id 1mr25376738pjh.65.1589238865966;
        Mon, 11 May 2020 16:14:25 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9sm10217183pfc.179.2020.05.11.16.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:14:24 -0700 (PDT)
Date:   Mon, 11 May 2020 16:14:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     WeiXiong Liao <liaoweixiong@allwinnertech.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh@kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH v7 11/18] pstore/zone,blk: Add console frontend support
Message-ID: <202005111613.8C332ABC@keescook>
References: <20200510202436.63222-1-keescook@chromium.org>
 <20200510202436.63222-12-keescook@chromium.org>
 <db0ae27c-8e96-9b85-9526-920800da4755@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db0ae27c-8e96-9b85-9526-920800da4755@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 08:38:32AM -0700, Randy Dunlap wrote:
> On 5/10/20 1:24 PM, Kees Cook wrote:
> > diff --git a/fs/pstore/Kconfig b/fs/pstore/Kconfig
> > index f18cd126d83f..f1484f751c5e 100644
> > --- a/fs/pstore/Kconfig
> > +++ b/fs/pstore/Kconfig
> > @@ -236,3 +236,15 @@ config PSTORE_BLK_PMSG_SIZE
> >  
> >  	  NOTE that, both Kconfig and module parameters can configure
> >  	  pstore/blk, but module parameters have priority over Kconfig.
> > +
> > +config PSTORE_BLK_CONSOLE_SIZE
> > +	int "Size in Kbytes of console to store"
> 
> maybe	                    of console log to store"
> 
> since my console size is not measured in Kbytes.
> 
> > +	depends on PSTORE_BLK
> > +	depends on PSTORE_CONSOLE
> > +	default 64
> > +	help
> > +	  This just sets size of console (console_size) for pstore/blk. The
> 
> 	                         console log
> 
> > +	  size is in KB and must be a multiple of 4.
> > +
> > +	  NOTE that, both Kconfig and module parameters can configure
> > +	  pstore/blk, but module parameters have priority over Kconfig.

Good points! I've fixed this and a typo in the ftrace Kconfig help.

-- 
Kees Cook

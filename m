Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5FD62975E6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753651AbgJWRkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 13:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753644AbgJWRkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 13:40:13 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91DCC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:40:11 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id i26so1463825pgl.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 10:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZqP+pDAqwl0vm0EDa5k2rDU/fo01GdgiAMIENZpdsv8=;
        b=mj2T49J8gQrFFhGKsZgQtKxY6nwyDd/Lnm8MbigzTINw9idCg+Zh7Avel0YyxyiPNI
         7ajVBvQ7xY9MGEW1BVpHZzR9fnaix9drV82PY/rwqxzihi6o64MnanSr1etwLEefw0eS
         LuhVSmg+s89rKvzqg6jY5Nf9X+/eP96X3Ao+Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZqP+pDAqwl0vm0EDa5k2rDU/fo01GdgiAMIENZpdsv8=;
        b=jd/PULQd+A8ip7GpztZEGp9SlNSz+wgNR393C1muZZg4uuN9/5IfMq2g1NfMY6SehJ
         nBQDb9ZXMaim3bCJNkbkcC5xAYdBRzebj6zry3hVNDYxysuJGREL1TETcYUAHIqis39R
         cWUI+C4bS/INaHW+K+KXrWiSgQIz2Nlhy0bMkazM/t5VFM5HafgwMiuthAZnr11n4UhR
         Il7awL4iVgWdfCmda3jh3OBqWleTu0WKq5u+dJCxrH4nX2SPBih8CXgjU+d9HbbAlkQ3
         JzxwIDfTM2TE1rsrQZjii1/hIheVIZuwwhVfB9Aa4ZHE83J6J8DzWuSMB1oh5xg27WAi
         kVIg==
X-Gm-Message-State: AOAM531IA/AmCzEm8d7ra5CH+2Szi/t8grMPnken0MniU0cJR/TOEyQu
        B8v56KFcdwuo4jJtiY/wHMZxRw==
X-Google-Smtp-Source: ABdhPJwwYEzc8bj+e0QmiHdLOS6y2rJMDSM45Ig7sMTUAAnSKOWB8XdB8tOm4Sr9ElfavlxiwgVfmA==
X-Received: by 2002:a63:2d05:: with SMTP id t5mr2935833pgt.178.1603474811368;
        Fri, 23 Oct 2020 10:40:11 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t129sm2695390pfc.140.2020.10.23.10.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 10:40:10 -0700 (PDT)
Date:   Fri, 23 Oct 2020 10:40:09 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 49/56] refcount.h: fix a kernel-doc markup
Message-ID: <202010231039.DE05B63@keescook>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
 <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd94a95cfe01b97190b6ffb9e942cb4bbeeaa6bf.1603469755.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 23, 2020 at 06:33:36PM +0200, Mauro Carvalho Chehab wrote:
> The documented typedef just after the kernel-doc markup
> is named "refcount_struct".
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  include/linux/refcount.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/refcount.h b/include/linux/refcount.h
> index 497990c69b0b..8f431b0e69e4 100644
> --- a/include/linux/refcount.h
> +++ b/include/linux/refcount.h
> @@ -101,7 +101,7 @@
>  struct mutex;
>  
>  /**
> - * struct refcount_t - variant of atomic_t specialized for reference counts
> + * struct refcount_struct - variant of atomic_t specialized for reference counts

Hm, this is a weird one. Yes, it's actually "struct refcount_struct",
but the usage should be refcount_t (through the typedef). I'm not sure
what the right way to document this is.

-Kees

>   * @refs: atomic_t counter field
>   *
>   * The counter saturates at REFCOUNT_SATURATED and will not move once
> -- 
> 2.26.2
> 

-- 
Kees Cook

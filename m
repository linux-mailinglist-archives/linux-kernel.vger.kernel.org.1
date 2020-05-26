Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D301F1C3049
	for <lists+linux-kernel@lfdr.de>; Mon,  4 May 2020 01:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgECXoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 May 2020 19:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726353AbgECXoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 19:44:03 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF425C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 16:44:02 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id w18so7562065qvs.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 May 2020 16:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DB+JYuSo5NfqsXCq3zyrJCZb3Y4yeKrCLHhEr8ezCWA=;
        b=tlwDo1UFFjggk18KKshuuXk5JVVs+U2gr7+t0nvL8/AG/9SmGl0NvMkoHs5Je1ZwzH
         Y2w/huQ1gDu2Bi5JCmcrBJtYTlKmfUu8pGUkl0tu2j+U92RxjwYM2/0LK1yg7tcsDjZj
         rwCqaUUkEZZc1e7btDT6fPzXnn+tkhZSfOir4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DB+JYuSo5NfqsXCq3zyrJCZb3Y4yeKrCLHhEr8ezCWA=;
        b=NoAEpfQFELkqX8+nM9hUSKYEy7iVP+bvviU3ONiDOGvhworUpg6Ozxl5kCpUxqrpyu
         0gNjANf/S87Cyh0PqDaCX6THvq+bfrzssKRnMu9u1ekciKQW4qlMJWq5YitM74Sfr4rB
         wUqbJfwRRIw2qpFRCQTIBsCZ7hgC96q6dHFt4wfEbov3cDCXNVB/HLXLPRw812PgY8oS
         FY6Po86Ycqbsr/BN73Ccz4XCI70IzDPlNf3xd3nFwW6FXf4eV01SdlABlBpa8fHA+mad
         3DTbZIQrnTcvVQYIZ+0IThIPXBiGEx3KbXnd1FNe6yOePY/rmT/UuP3o9DIUtiOX+5A/
         DmMA==
X-Gm-Message-State: AGi0PuZnO1RIZRHN6Lja8L74KZr1oQOngw+oUYUzWH4A5PD0l2IPIEAo
        KMLE5T4KG6sTDUwsLSU+X5ZOtw==
X-Google-Smtp-Source: APiQypJVVPJ+XIfOn2dfpDsqfHoDLQL9dpTm5PdKz0C5NHGQBgQNETFGjA9G1W/RD/S/0iXkjOwIlw==
X-Received: by 2002:a0c:ba17:: with SMTP id w23mr14508596qvf.176.1588549441596;
        Sun, 03 May 2020 16:44:01 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id n10sm8444942qkk.105.2020.05.03.16.44.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 16:44:00 -0700 (PDT)
Date:   Sun, 3 May 2020 19:44:00 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Joe Perches <joe@perches.com>
Cc:     paulmck@kernel.org, "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>,
        RCU <rcu@vger.kernel.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH 03/24] rcu/tree: Use consistent style for comments
Message-ID: <20200503234400.GB197097@google.com>
References: <20200428205903.61704-1-urezki@gmail.com>
 <20200428205903.61704-4-urezki@gmail.com>
 <20200501190555.GB7560@paulmck-ThinkPad-P72>
 <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93f764ad743082f2bbab4595eb892c2004e61b44.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 01, 2020 at 01:52:46PM -0700, Joe Perches wrote:
> On Fri, 2020-05-01 at 12:05 -0700, Paul E. McKenney wrote:
> > On Tue, Apr 28, 2020 at 10:58:42PM +0200, Uladzislau Rezki (Sony) wrote:
> > > Simple clean up of comments in kfree_rcu() code to keep it consistent
> > > with majority of commenting styles.
> []
> > on /* */ style?
> > 
> > I am (slowly) moving RCU to "//" for those reasons.  ;-)
> 
> I hope c99 comment styles are more commonly used soon too.
> checkpatch doesn't care.
> 
> Perhaps a change to coding-style.rst
> ---
>  Documentation/process/coding-style.rst | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> index acb2f1b..fee647 100644
> --- a/Documentation/process/coding-style.rst
> +++ b/Documentation/process/coding-style.rst
> @@ -565,6 +565,11 @@ comments is a little different.
>  	 * but there is no initial almost-blank line.
>  	 */
>  
> +.. code-block:: c
> +
> +	// Single line and inline comments may also use the c99 // style
> +	// Block comments as well
> +
>  It's also important to comment data, whether they are basic types or derived
>  types.  To this end, use just one data declaration per line (no commas for
>  multiple data declarations).  This leaves you room for a small comment on each
> 
> 

Yeah that's fine with me. This patch just tries to keep it consistent. I am
Ok with either style.

thanks,

 - Joel


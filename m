Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BB285089
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgJFRPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgJFRPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:15:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D518DC061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 10:15:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so8313326pgo.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 10:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yTGFOHS5GcOt7CVNwiIo17hbgHumuG0VmvA89y6hN+k=;
        b=bSpOj+AC45cpECVjPMPeMl0lam129LvO9ZcWAHbMzJIibYalTmxs/g0W301CCYjBuW
         ZkD34feINU+2hWGElB2GFvvH12dg6PuO4iIQf+9a6eBERwxiDoo0lJ1bAnRHza9bCi2j
         T55yyJJOtABNg1xcrNdFX7OzpRlQYTISiAexqNQx9b7aszTF2nH/Z4igim1IpLay56Mb
         pe5Xg5kzu9TnAP1dl0TSzyE4mEyGQQTBuv2G1wk0MyeMt3CmRbUcqVowTtl2v2UI/sUG
         npnqn8G0XH5Y6uGULH0h2GfFcvhgjZzMSSzYvEfgsJyxlZAEcV8sUOWmMui1IO5jlnyG
         BWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yTGFOHS5GcOt7CVNwiIo17hbgHumuG0VmvA89y6hN+k=;
        b=FPbYt/xUwiApeM3nTT2I1o6wnWLGH8eLC+DvUhPeA1IG3ykbAlmNK7TNTNl/itHJue
         E8uk0Gif9MMRGC0jYkWFjiqGsfoQpV4zUG1XsP+08P2qf2QrynMcZXVLJMpoQoRQ3g0a
         KbpvsNEwmgB3Aa5XiySK60vypSDg1FlLTpo1LL6S13dZ5ynle5hIcBgmmqAPKNt5jG6z
         mE44nASXLSTX2gUq/XfdijRLOeSRwllvZciOWSAY9BTJAyrtolrQbnrJSgsOoWGziox2
         QBb1AshQHt6kCqasLOf+yHe4Ww6rn23XySvLzAQrXFf6oppk70L+3G9dysbJUXhYyk5N
         Kxbw==
X-Gm-Message-State: AOAM532x48axDu6pQVa4f8NvPfS7GMdSEp41IPmnYKotdEBVrrRBDHG8
        Lxd9lW2CQV+wfK5tRmDvXJ4=
X-Google-Smtp-Source: ABdhPJxKELb/EryImGhSYb6gut9vCas19C1rmCSfh6CXqArb8sZ7EkLcTBTxPYxATdUBAuQKW4BcoQ==
X-Received: by 2002:a63:1d26:: with SMTP id d38mr5176136pgd.0.1602004507235;
        Tue, 06 Oct 2020 10:15:07 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id x5sm4659348pfr.83.2020.10.06.10.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 10:15:06 -0700 (PDT)
Date:   Wed, 7 Oct 2020 02:15:04 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Shreyas Joshi <shreyas.joshi@biamp.com>, rostedt@goodmis.org,
        shreyasjoshi15@gmail.com, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] printk: handle blank console arguments passed in.
Message-ID: <20201006171504.GA64770@jagdpanzerIV.localdomain>
References: <MN2PR17MB31979437E605257461AC003DFCF60@MN2PR17MB3197.namprd17.prod.outlook.com>
 <20200522065306.83-1-shreyas.joshi@biamp.com>
 <20200522100046.GH3464@linux-b0ei>
 <20201006025935.GA597@jagdpanzerIV.localdomain>
 <f19c18fd-20b3-b694-5448-7d899966a868@roeck-us.net>
 <20201006095226.GB32369@alley>
 <24f7a6bc-c917-2bb7-0e86-9d729c18e812@roeck-us.net>
 <20201006134328.GD32369@alley>
 <20201006163514.GE32369@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006163514.GE32369@alley>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/10/06 18:35), Petr Mladek wrote:
> > > Whatever is decided, I'd like to have it made official and documented to
> > > avoid a similar problem in the future.
> 
> Sigh, it is even bigger mess than I expected. There is a magic
> variable "console_set_on_cmdline". It used, for example, in
> of_console_check() to prevent using the default console from dts.

I wonder if we can do something like:

---
@@ -2200,6 +2200,9 @@ static int __init console_setup(char *str)
        char *s, *options, *brl_options = NULL;
        int idx;
 
        if (str[0] == 0) {
+		console_set_on_cmdline = 1;
                return 1;
 	}
 
        if (_braille_console_setup(&str, &brl_options))
                return 1;
---

	-ss

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF72EC760
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 01:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbhAGAjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 19:39:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36459 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726157AbhAGAjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 19:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609979867;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PZJysm9mhMs1vBRXKoARzZAsE8IJ9JXbKKeY+zpyAV0=;
        b=SqUiPIGwuoill7Ei5674cAQE0xkno5ImE2ZVjuOmQuKx2f46os1bmdFtmQaq7iKkt6XHn6
        gy7cFwf+NlwqijnADp+P6czznvOHCr/pl6zAHDJRKBmHN9UyHgRBD++Jgd92srImwOyxMs
        739uMw86VAgcnuqIGTxqE7ezYNYiW6s=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-203-g2fn7BXpNHGpbAC4Dvjhrg-1; Wed, 06 Jan 2021 19:37:45 -0500
X-MC-Unique: g2fn7BXpNHGpbAC4Dvjhrg-1
Received: by mail-pl1-f197.google.com with SMTP id y10so2651161pll.20
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 16:37:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PZJysm9mhMs1vBRXKoARzZAsE8IJ9JXbKKeY+zpyAV0=;
        b=EKovQvcu7s1ZXG0ezV8UNHEuTMVfhBxjGdyWsqpvMlW65b1XHMKjRJcODl0/8Ijdhe
         22m+YR5LZXEjfsdDzHtMmi+CwsKYTKpsyblW+RhP8gGzIoHmRFKI4jPjJJ9Na2rWSagH
         N0XdrwaMGOlOOTc5FwiLoX4DGIwL6CTaNC9zH/dXPOqmXiJREyBnbo9BrUXTFDTRkk3+
         KbQTwTEWv1gUrnEcQ8lmKR1r7qazpzO6utN/WlnHuspHush5ApAoyDguVOJECWyUgRvu
         aNWr9+4tuk+vj9Ks7TGbdJKpRQPpfNRNLGzCqRcmwsgyAZNVvmgI4Z9fiCcsnziSVtVh
         8v5g==
X-Gm-Message-State: AOAM530jsDzoxKukdEH0niReJ4NvRgwdYecbZ/oRMte4UfKYSPNQc5vx
        pYKqcXRkMHu/hMSK8kqkIsMdn853dPvi562hTX+W9Rb7y+f6v495llnrihevNtXLmLa7Gtc9EkO
        tPQSSM/wKjvHuckgiXpkzfL/c
X-Received: by 2002:a65:4347:: with SMTP id k7mr7138468pgq.186.1609979864120;
        Wed, 06 Jan 2021 16:37:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzz2Zls6s49VpIvvKtVzEWGm4eY+aco8/7VnaUqQvUSaGlhhr5XpOekEYJi255jN+exwtP+ow==
X-Received: by 2002:a65:4347:: with SMTP id k7mr7138450pgq.186.1609979863893;
        Wed, 06 Jan 2021 16:37:43 -0800 (PST)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id v2sm3461818pgs.50.2021.01.06.16.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 16:37:43 -0800 (PST)
Date:   Thu, 7 Jan 2021 08:37:33 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs tree
Message-ID: <20210107003733.GA304388@xiangao.remote.csb>
References: <20210107101544.68bdd395@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210107101544.68bdd395@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Thu, Jan 07, 2021 at 10:15:44AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the vfs tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> In file included from fs/erofs/xattr.h:10,
>                  from fs/erofs/namei.c:7:
> fs/erofs/namei.c: In function 'erofs_lookup':
> fs/erofs/internal.h:23:21: warning: format '%s' expects argument of type 'char *', but argument 4 has type 'struct dentry *' [-Wformat=]
>    23 | #define pr_fmt(fmt) "erofs: " fmt
>       |                     ^~~~~~~~~
> include/linux/dynamic_debug.h:129:15: note: in expansion of macro 'pr_fmt'
>   129 |   func(&id, ##__VA_ARGS__);  \
>       |               ^~~~~~~~~~~
> include/linux/dynamic_debug.h:147:2: note: in expansion of macro '__dynamic_func_call'
>   147 |  __dynamic_func_call(__UNIQUE_ID(ddebug), fmt, func, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~~~~
> include/linux/dynamic_debug.h:157:2: note: in expansion of macro '_dynamic_func_call'
>   157 |  _dynamic_func_call(fmt, __dynamic_pr_debug,  \
>       |  ^~~~~~~~~~~~~~~~~~
> include/linux/printk.h:424:2: note: in expansion of macro 'dynamic_pr_debug'
>   424 |  dynamic_pr_debug(fmt, ##__VA_ARGS__)
>       |  ^~~~~~~~~~~~~~~~
> fs/erofs/internal.h:34:33: note: in expansion of macro 'pr_debug'
>    34 | #define erofs_dbg(x, ...)       pr_debug(x "\n", ##__VA_ARGS__)
>       |                                 ^~~~~~~~
> fs/erofs/namei.c:237:3: note: in expansion of macro 'erofs_dbg'
>   237 |   erofs_dbg("%pd, %s (nid %llu) found, d_type %u", __func__,
>       |   ^~~~~~~~~

Thanks for modifying this. Use %pd is more reasonable than using d_name...
It might be fixed as "%s, %pd (nid %llu) ...", thanks for this!

Thanks,
Gao Xiang

> 
> Introduced by commit
> 
>   879d4376533c ("erofs: use %pd instead of messing with ->d_name")
> 
> -- 
> Cheers,
> Stephen Rothwell



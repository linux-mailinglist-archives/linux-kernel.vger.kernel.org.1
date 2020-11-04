Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090502A6C3E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 18:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732124AbgKDRyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 12:54:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730865AbgKDRyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 12:54:16 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7668CC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 09:54:16 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id p15so23959436ljj.8
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KDF/IVt/yM5vKvfY6fRo0fNzEAF8Z0Cn2GtQDil02vc=;
        b=hXhtTtO+S8d2VZNihnap8ENkU4okxgo2j5jRC3/VfbThfzLKjoY9rFtASjZkhfK3s3
         qhVE8hIVQgRDoaRjKV+sJOgqdoZDAN9jHBYe4N0IyHtI1g8IALfcuzpLWg2QZ6LIm8LB
         c/aLMvqxGizeQKNfljmxCLZHLcPpM+v9Z3VkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KDF/IVt/yM5vKvfY6fRo0fNzEAF8Z0Cn2GtQDil02vc=;
        b=jifiI6Eey37yfU7WuxufPtC/1WI8UBvvUyv6QAAKKN3XfeAduR1XxZOzCJZHJ+2akD
         fmjZ/0Y77I8dWTfCG9oxOYl4p1IxhXbP7WVTZTEbnLxf6Fe4t3sZYdrctIUDpHg9F6Sf
         pXUo5ITdHkkB6xkIL+MnfpL15nk6MB8eQB+zKxKtTkaijb5PUsgh/9GK9/QrVDVqaUSo
         PNbSJ9yc6Lre4eM5qItZghS2dhdFnvHJbK7TEuPKGt9/g2zM1ehtFCx9xEDqxNnFxk0c
         wdR+wxWwDln8kIaizcGmPOiJnNAQsDZI66mLMWw+mqcO6H1JYq79ajA3VlFla1eiOLbN
         YYYw==
X-Gm-Message-State: AOAM533iLWovz/ReIquj7ZhDqusCEJnJQsJSf7d8vZQlt6YOpbhHJmP1
        4Q6+Au8fGPDMToe0Ot+nFIQchjVDVe/I0Q==
X-Google-Smtp-Source: ABdhPJzod3vRPg+VrX283hY7qVSvjbw2J2ekPbIMNf/7cB8pB4V76c6uMxu7YNV8l/kBB310v76UgQ==
X-Received: by 2002:a2e:584e:: with SMTP id x14mr10279725ljd.335.1604512453695;
        Wed, 04 Nov 2020 09:54:13 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c1sm575344lji.101.2020.11.04.09.54.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Nov 2020 09:54:12 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id 11so4366383ljf.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 09:54:12 -0800 (PST)
X-Received: by 2002:a2e:3e1a:: with SMTP id l26mr11736406lja.285.1604512452220;
 Wed, 04 Nov 2020 09:54:12 -0800 (PST)
MIME-Version: 1.0
References: <20201104082738.1054792-1-hch@lst.de>
In-Reply-To: <20201104082738.1054792-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 4 Nov 2020 09:53:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=whzWXASyyzs3veAUZznCT2+EeeBaX3o8w8NsKNL+woarQ@mail.gmail.com>
Message-ID: <CAHk-=whzWXASyyzs3veAUZznCT2+EeeBaX3o8w8NsKNL+woarQ@mail.gmail.com>
Subject: Re: support splice reads on seq_file based procfs files v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg KH <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 4, 2020 at 12:29 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Greg reported a problem due to the fact that Android tests use procfs
> files to test splice, which stopped working with 5.10-rc1.  This series
> adds read_iter support for seq_file, and uses those for various seq_files
> in procfs to restore splice read support.

Ack.

Al, do you want me to take these directly - we'll need this to avoid
the regression in 5.10?  Or do you have other things pending and I'll
see them in a pull request.

             Linus

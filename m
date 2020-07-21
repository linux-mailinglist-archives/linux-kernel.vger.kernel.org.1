Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8809E228CEA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 01:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbgGUXzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 19:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbgGUXzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:55:18 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 787B1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:55:18 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k1so204170pjt.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 16:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UlYBxW7aN7ApC49X/dqnNQi/KmY2OEUg1dgouAJXg4o=;
        b=pds+v1Ag+NBGhS3gHM0HxLrVLAZnOn5vH1eIwYT9d+b+iBDmReY+XBbXSi1a5XXSLy
         uLJZIfLS7pI727nPYVCqJguQSFs3E9UCNZoOyn/tAlUNEf+pN6ynOIbJ1irzYv5/wL74
         FtRsTnvy19EM0NtYIH76+922QsvhoLTzOkGs+Db9npYes2mMO7HK/Sjb1VMCwGAUIYej
         KL7sMegGj+GAjQr5eRV+XPH3IupdHs8FKqReZ1MV/BBe0oU8f7/NU1Yqa+ha8Wal7y1P
         tk6JhnttgB9VcOXBg1LToo6KKcIwBwz/7EO+jRE5oE5WeB83Z/x2zH/ruC5P190sRuMU
         rYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UlYBxW7aN7ApC49X/dqnNQi/KmY2OEUg1dgouAJXg4o=;
        b=FtRuSJfy9TmAZ+vgawh61RloApy9/s1M3oF6F5l68ZiqfQLCeOW3ImQqpCRUuy33g+
         jc77GEFGYzuewqoq+HFz7Ec/HQIJYsXj6oS1la/Qtquk02saDSDRRig5RXHupjMDOaz9
         KB51Txux5z7W9xTtgO8ZhfJEb2btleh2UOvxbYZ270kSPxta5L8oe9P7XgwQcTnOERiY
         00j8SYSVt35bnSsJBPAa9vPPgZPXqG61dU+gvmO9s9WkYaKytNSOgtZ5GBmh1RzcrRyH
         /batEk/Qdm+xwbmTh4Ysr6mDX06Uk+sskFSX6UUYbVlYYk5KmwVi+Jz6cBsBdA6w+RiP
         ZjVg==
X-Gm-Message-State: AOAM532jVJSxGZZqYHK9RbW2tDOajHtp6RROU55UwNLqaZ/ILQRqYqTf
        GuY6J0cfaW/vDUP2Oo8cxYeLbEjIJpiR1OtFOnxbhA==
X-Google-Smtp-Source: ABdhPJy641UDhbOqx3GLdk4RIzHJGrLZYkheLlWEit5N/FtCbqV8ZMqLpPt2Fq2A2yaleWOiUcoYr4rDKR63HAtJ2DQ=
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr6654686pju.80.1595375717756;
 Tue, 21 Jul 2020 16:55:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200721054528.2556267-1-davidgow@google.com>
In-Reply-To: <20200721054528.2556267-1-davidgow@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 21 Jul 2020 16:55:06 -0700
Message-ID: <CAFd5g46ughJzQCH_mh897NYovVuryvM1_Xi-9YfP6nsUHZsT4g@mail.gmail.com>
Subject: Re: [RFC PATCH] platform: ioremap: Build iomap functions even without HAS_IOMEM
To:     David Gow <davidgow@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeff Dike <jdike@addtoit.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Richard Weinberger <richard@nod.at>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-um <linux-um@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:45 PM David Gow <davidgow@google.com> wrote:
>
> A number of drivers use devm_platform_ioremap_resource(), but do not (or
> did not) explicitly depend on IOMEM[1,2]. Given that the only platform
> without HAS_IOMEM seems to be UML, and it has sufficient stubs for
> devm_platform_ioremap_resource() and its dependencies to build, we can
> remove the HAS_IOMEM requirement here, rather than playing whack-a-mole
> with different drivers which don't try to build against ARCH=um.
>
> The reason this works at the moment is that stub ioremap and iounmap
> functions were added to UML to support this sort-of thing[3]. This
> particular change doesn't require adding any additional stubs, but there
> is possibly room in the future to stub out the remaining iomem functions
> (or to provide mock implementations for testing), and get rid of
> HAS_IOMEM entirely.
>
> [1]: https://lkml.org/lkml/2020/6/30/176
> [2]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1e7468bd9d30a21e059af477106dc5588ae52dff
> [3]:
> https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1405627.html
>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>

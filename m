Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1561D2CE483
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 01:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgLDAhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 19:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgLDAhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 19:37:04 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52286C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 16:36:24 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id c79so2507800pfc.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 16:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u42CbjiqH6yH/u4ofLvYgcwvhaYpZ3AArTDQstrAzmY=;
        b=wIaFO/wSzHzjZwn1K9BZkWRiMVTHUfLIky33xyclPtHbQNj4cUInEma62So9YDnJBD
         4Ygg+MvKHE8OeBie7rddhxhxkGcjq6ncB+tPP9WqwkIt6QOtt79nu3AuehcVCjq7nBvo
         aR7E1S9kdDStyl/fX+L1svgxyGuuZ3lbmvH2/TbBl8umw1ksQ0ZX1a/+Na9r8qDYQuNQ
         6UNUjq5pZTzQx9pWPGuISyHb1iygcO0qla7HqRD4obXPmzLf5V7Jl0pCBN6CaGoppFKj
         3mBaWXJ5/lQe7h54ABxPertLI88b1wq8hzkQfMWYIiDn7KDjztNkAFfK9F79EmT7Ed7H
         JsPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u42CbjiqH6yH/u4ofLvYgcwvhaYpZ3AArTDQstrAzmY=;
        b=JbLzx5MHTOjKue9HczBZpbqiVjdu868PciQNDyxdYyfBgWH4b1VvdaCEPuS3Waq0Ig
         1rCz2st/E7M3QfZUGefp2yZ2Q+6nZ6eefQCURP8QJFC/dPFfKTglmqQMIvFjB39s2uzw
         smfeAW9qDrAoT8mHGs0m/ecpFfjfgFTM8DMb3kXjfVxuU97vMDBnFuvFbLj04hGc4gZW
         qJId0B/dZ9oOsQOYuin5690RZvKpStk/Ixyfp+T335kgFYCEr7RjdaSnPC5W/X3ZlMGQ
         UF+roKrqK98mdMbfBq2c6ikMNaeSUU4iQQ1cV7HAebNJ/8rGc9jkzKd/QPbPkL35NQjF
         P4bQ==
X-Gm-Message-State: AOAM53137B7RL7I4MGwJ7fqk/WGiZqAIeCe2jmmGl36pQ6F5CgyoHC5l
        13Ab9ykbxaZ9LI2bbCtFmmRgQg==
X-Google-Smtp-Source: ABdhPJxvoWOtHpgv1xEaceUoRj3awXWl1dkFM7Q9a7dGVnWw/wkMg5i5rqtQhMD8830KNmta/N5pDA==
X-Received: by 2002:a63:d312:: with SMTP id b18mr5267980pgg.233.1607042183627;
        Thu, 03 Dec 2020 16:36:23 -0800 (PST)
Received: from google.com (h208-100-161-3.bendor.broadband.dynamic.tds.net. [208.100.161.3])
        by smtp.gmail.com with ESMTPSA id k1sm2104233pgm.21.2020.12.03.16.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 16:36:22 -0800 (PST)
Date:   Thu, 3 Dec 2020 16:36:20 -0800
From:   William Mcvicker <willmcvicker@google.com>
To:     Jessica Yu <jeyu@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v2 0/2] Adds support to capture module's SCM version
Message-ID: <X8mEhIeYeMjZc/+7@google.com>
References: <CAGETcx8unBFUHxM67VdOoaWRENGXYoc4qWq2Oir=2rUyJ7F5nA@mail.gmail.com>
 <20201125010541.309848-1-willmcvicker@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201125010541.309848-1-willmcvicker@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 01:05:39AM +0000, Will McVicker wrote:
> Hi All,
> 
> I have updated the patchset to:
> 
>  *) Include Documentation.
>  *) Use a consistent output pattern for the SCM version.
> 
> In my debugging, I found that the vermagic reported by modinfo can actually
> vary based on how the module was loaded. For example, if you have a module in
> the initramfs that is newer than the module on disk, then the initramfs module
> will be loaded (not the one on disk) during boot. Then, when you run the
> command:
> 
>   $ modinfo MODULENAME
> 
> The vermagic returned will actually be the vermagic of the module on disk and
> not the one in the initramfs which was actually loaded. With that being said,
> adding this scmversion attribute ensures that you can *always* get the correct
> SCM version of the module that loaded.
> 
> Please take a look at the updated patch and provide any comments you find.
> 
> Thanks,
> Will
> 
> Will McVicker (2):
>   scripts/setlocalversion: allow running in a subdir
>   modules: add scmversion field
> 
>  Documentation/ABI/stable/sysfs-module | 17 +++++++++++++++++
>  include/linux/module.h                |  1 +
>  kernel/module.c                       |  2 ++
>  scripts/Makefile.modpost              | 20 ++++++++++++++++++++
>  scripts/mod/modpost.c                 | 24 +++++++++++++++++++++++-
>  scripts/setlocalversion               |  5 ++---
>  6 files changed, 65 insertions(+), 4 deletions(-)
> 
> -- 
> 2.29.2.454.gaff20da3a2-goog
> 
Hi Jessica, Masahiro, and Michal,

Friendly reminder :)

Thanks,
Will

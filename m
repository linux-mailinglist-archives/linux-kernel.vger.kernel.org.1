Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85DB42680CA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Sep 2020 20:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgIMSmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 14:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725936AbgIMSmr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 14:42:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBF0C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:42:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id v123so14878641qkd.9
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 11:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0jHT31ssRcmY7ESE4GVbo7WflQpjnUMgGP99rhdZqTo=;
        b=XtjAXeDbAzYnt5xUw1wrTDDaTX7HrUGx7xGdWDkl+h31ILt+RsWuoCkdHDAxu7gyoa
         WEMo7wCOAdsaINHXzt0zddMEndq36m6vytOl9mrFiGGF8abruG73b1v2n9mz0jhALg7h
         QuRUk5Xx+4CvQpoTrH00gd/1eFBOmJhCNdJpvHc7tEO7xRmJ1P1pv1dBiDFqj3aXZgHK
         OwwDUfAk/XWhUU86EdZd1EVNxzgMB9TC56N1s9pMWKvjFbESAQgdzLiOtWjYlIBgihf1
         EokXQIj8pKBBFKw36BoS3Ht2bYh6DU7WLO4t0Kalcm+D+pU0B/RAGnDeDDeZUsUOGfoi
         0SPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0jHT31ssRcmY7ESE4GVbo7WflQpjnUMgGP99rhdZqTo=;
        b=lHDuQMEfQ3AhwLgghqjf/quzN+uhDR11kgYOzVPPTkn/6wZiAyIAMYiGiIC8smjpAi
         RK8su/OXu7CIZQUOWZzsIGxu6AZOJEpTwC+xIDvZEvESVdHVrTBjlYGHvrwKvBhCBSJN
         LmHC2sq9kwMXwdhfDzMVKmNcoZvnnnFHD5bcykof4EplNGTpjU9dN0vWUw74NdVWxWUA
         8kcq2JXM/auevM6s7ETbINGLwN0lEAxEzu5QJC+ZQ9JDZzuRVSWenlUoZaMKNFZwY/ow
         i7XOJjZ47WEH/CRH+jRlKBTnJbHv81/xt3+9kMpfQER+7on43xg6icQmeK2IbYedYFZ7
         Iu0g==
X-Gm-Message-State: AOAM533qsg9TRfo/TZC5drVpRpDb1E6porbHWhXsbXkafbWYcLZdSqao
        xV8OTuSrzih+k1u5Jm4p/vahxxC0FKu4h1cfryU=
X-Google-Smtp-Source: ABdhPJw/m0CM9zylJN/yWgP2jPSsGqo8GaGn2BHaGVIsRN5Vhjx+jhYGgtS7zLNLJzl9RFJNqmSPKokcBsp4ol4mn1o=
X-Received: by 2002:a37:a189:: with SMTP id k131mr9496229qke.34.1600022565905;
 Sun, 13 Sep 2020 11:42:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200817142909.1972897-1-chengzhihao1@huawei.com>
In-Reply-To: <20200817142909.1972897-1-chengzhihao1@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Sep 2020 20:42:34 +0200
Message-ID: <CAFLxGvxOw1ZY9PoeuJNGaweFBTjoW3jAj2=TtF5wMkBm-dgh9A@mail.gmail.com>
Subject: Re: [PATCH] ubifs: ubifs_jnl_change_xattr: Remove assertion 'nlink >
 0' for host inode
To:     Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "zhangyi (F)" <yi.zhang@huawei.com>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 4:29 PM Zhihao Cheng <chengzhihao1@huawei.com> wrote:
>
> Changing xattr of a temp file will trigger following assertion failed
> and make ubifs turn into readonly filesystem:
>   ubifs_assert_failed [ubifs]: UBIFS assert failed: host->i_nlink > 0,
>   in fs/ubifs/journal.c:1801
>
> Reproducer:
>   1. fd = open(__O_TMPFILE)
>   2. fsetxattr(fd, key, value2, XATTR_CREATE)
>   3. fsetxattr(fd, key, value2, XATTR_REPLACE)
>
> Fix this by removing assertion 'nlink > 0' for host inode.
>
> Reported-by: Chengsong Ke <kechengsong@huawei.com>
> Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>

Applied to fixes, thanks!

-- 
Thanks,
//richard

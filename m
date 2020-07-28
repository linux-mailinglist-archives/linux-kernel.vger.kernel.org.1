Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C837B2302C4
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbgG1GZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgG1GZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:25:50 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF7C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:25:50 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f1so16521403wro.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7etnaWOwVx6vNnoAvWMwIKpf2RbffIgHQ+Ut1q/2kv8=;
        b=YPBKAucSuaaf0P/MoRJbUS6YUlX4lgKwIHfXj8kMmn7VgUjhZkX5rNqMQtZU8B+5X/
         Xc4ch8YTm38tgIYFMi9LaOKn7TYaAOgQjIxwxxdC7aG1uMFStwiaiCOqhsLIn3R7vszK
         SIbUHh7CNbo0zBtb1j5l8IjEVQ9tvgHYkjFitOyITdWxWZzgWed5r3I0PXE6ThDfU5HN
         n5YMY+nNygQOKo8PLMPqjSn4yRgjjVZiRjewR3r72lviGgzsbFu5QO6pEWTUeh0uAG09
         BH9WwFswLLnlzagBOmXVavtQbx0Z9ZIWtqDvwLC+6vh1QwcCKe7UIHHwlqubNonY8FlS
         Wvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7etnaWOwVx6vNnoAvWMwIKpf2RbffIgHQ+Ut1q/2kv8=;
        b=ZRy/ZqYJziK9IJ4JG6a/XqPCVztA0f+IkJA1N6IHxIVeQ+RLVQW9YVSowtEsrau0ZL
         aSwxwFTwRlYV4F+07j9WfdDme5cTB5sNtGNRI/L7CH6HRdVrr1s8DbgdBXPlIA9QYJQD
         VvfxNjpkWWO9boKMWGQvqw5Zs1z20h28rX5t4XFiSco3gqGhNc0l8KiykwcO72k1i5JL
         RYHCq5mQxKh20oGleukG0xTBc8a2AmkXM59VhYQroZzkUP/824ME7O/+wGa5Uwakn2zN
         +GnKp2IFTGKEb+KHV4ZOna4IVxzTlwK0V5y9lwTVKueuIWdmQi+LKuj1CEAu9kVBUgf6
         HelQ==
X-Gm-Message-State: AOAM531/vrCJ+Jl3rqST7YZl7PTtKi1edrU4HizwQ8g5oltmxhGsWcq/
        G5G/zdjX0Ft8cjBKKa101vM4EUU+P/baXskwqS+xsg==
X-Google-Smtp-Source: ABdhPJyad6Em+rX/p7Ji908ZQHajh7zAhsMAC2huISArT4VENpdGyGPdZ94rIl1ouUQwvSKcqdf81TYCZkrnf40qg70=
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr23050073wrq.319.1595917549191;
 Mon, 27 Jul 2020 23:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200725045921.2723-1-kalou@tfz.net> <20200725052236.4062-1-kalou@tfz.net>
 <20200727142140.GA116567@localhost.localdomain> <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
In-Reply-To: <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Mon, 27 Jul 2020 23:25:38 -0700
Message-ID: <CAGbU3_nPuWyrhOVbHGk7EXb+fVAOR1sC08Fu-1sOdbOsmQkE_A@mail.gmail.com>
Subject: Re: [PATCH v3] proc,fcntl: introduce F_SET_DESCRIPTION
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 6:39 PM Pascal Bouchareine <kalou@tfz.net> wrote:
> > struct file is nicely aligned to 256 bytes on distro configs.
> > Will this break everything?
> >
> >         $ cat /sys/kernel/slab/filp/object_size
>
> Indeed on the config I'm using here this jumped to 264 bytes
>
> Would it be better to move this to the inode struct? I don't know the
> implications of this - any other option?

Well it doesn't actually make much sense to share that at that level

However the above 264 is building from 5.4 without f_sb_err, so I
think master already passed the 256 bytes too ?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDFD26825D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 03:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgINBut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 21:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgINBur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 21:50:47 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B09C06174A
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:50:46 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so17179750ljk.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Sep 2020 18:50:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mox7FaPJWIYIRuYrY0ZpJ9BmZbviHmr9/DMK0U0NTmQ=;
        b=nL84slLJwvzmcA73ngV4HBV+rZx9j/fO++dOjc+Dh0dGeDk2tLpgIG7zeCqSyX+wIo
         F1vdUHAZClQzLAEtEcoz+T3jzJ3i9cjNBfQkIj+I2GTk0vtlJeqNBvmOUfy7k1UW8npO
         l7BuFZj5BDGNo6rlrpPLmCbT7fGOae9Lw5gwLk0Nj+h4VR3a4/0EgG0zTam2WrvWaVX2
         wskpNEg4Hqz9sv1jboUKM6oESjoL/2Oc9Mj4UF9c2LjNrB8FeOk/PJcJrkAzNqSJK2ZH
         MzMHJ+CyJHciyEJlo6VKH9cN2zQ0av5Hz1OCwmWut9vg2C3kttsotrzLC5m37VxndIJ9
         C+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mox7FaPJWIYIRuYrY0ZpJ9BmZbviHmr9/DMK0U0NTmQ=;
        b=g2dkxvYT8Pl4xOKfkyEFiIqDv4Su+42STusPU4XF8v1rM1kWoOBDyKx+VXknjpw6WR
         GLoAPzl1HHBJTaEeNjHx2N0rRu1uHhuZt6DP550BRxmUUq9jEFtwLpFQBWufcD50Q0x2
         K5WP9NHue5Fzjwf2f6qRQEwY0QZRAReMet/NmsUvGv+f2/Gr6e9UNwFcZKSiZYKInfgT
         +BM+TvsuR1HnuI0RG99V5cp4f6K+RuiKU8zYNM/P2pcErxv/JBMrlJSHfKzjgwW2vw0S
         BqpFfXoLzEvs4gkWNfhWjj5BZjhxeyciIx3nf7pTlIv9whXaFrb7jvdtZTwveh8NLoYL
         nJ/g==
X-Gm-Message-State: AOAM5304rf1dN117t1yAVZ08T26A8vGptOy5ZBch7P+ZdtiQ5Jbt1WIc
        BJ54Ah60tQNmsPOFJy6EMOaE1ZxCliAoRhnqHPA=
X-Google-Smtp-Source: ABdhPJxvV+S94s7WbQ91OF8bg0Ot7QRgo1I2wb50ifHYaOAxLg/5ebTqDk4OVlKpP2lu6ovOroMq4ydD3Gt+r50G/VE=
X-Received: by 2002:a05:651c:2c9:: with SMTP id f9mr4151065ljo.257.1600048245333;
 Sun, 13 Sep 2020 18:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <1600007555-11650-1-git-send-email-jrdr.linux@gmail.com> <20200913145520.GH6583@casper.infradead.org>
In-Reply-To: <20200913145520.GH6583@casper.infradead.org>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Mon, 14 Sep 2020 07:20:34 +0530
Message-ID: <CAFqt6zYru2VfaBFHEB6+7vMPXUbgX8R5f+GHqxaGjhP8QZEyzw@mail.gmail.com>
Subject: Re: [PATCH] mm/gup.c: Handling ERR within unpin_user_pages()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 8:25 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Sep 13, 2020 at 08:02:35PM +0530, Souptick Joarder wrote:
> > It is possible that a buggy caller of unpin_user_pages()
> > (specially in error handling path) may end up calling it with
> > npages < 0 which is unnecessary.
> > @@ -328,6 +328,9 @@ void unpin_user_pages(struct page **pages, unsigned long npages)
> >  {
> >       unsigned long index;
> >
> > +     if (WARN_ON_ONCE(npages < 0))
> > +             return;
>
> But npages is unsigned long.  So it can't be less than zero.

Sorry, I missed it.

Then, it means if npages is assigned with -ERRNO by caller, unpin_user_pages()
may end up calling a big loop, which is unnecessary.

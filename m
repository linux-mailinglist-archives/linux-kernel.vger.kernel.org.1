Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 849D3273519
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 23:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgIUVoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 17:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIUVoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 17:44:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43D0DC061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:44:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so14213430edz.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FBnY2mGkBlFH+IxSO6esO9hEh+IRERtFDhquE+Lbxw8=;
        b=vPSZJ0ccTDOAJwum3dIpeLxmBLFcJRM0RqCZ00ufRLomhDw+Vtg9oI0Xoar2bgt3Ux
         bANb5fhL5Ie/XU28/thsoHsuqRgJzsca1V5wUgJIwv87vBCY+Y54xz9RTWlbmuFJ7oRg
         J69OMrOGkrQQug7qucKP5bn8CKJIL9w9FbxAlIgGLo2Q6LvAe2uOw4X8yhP4PDCxKX0S
         vfyiV1RXGowiCESCRKjLOMuFoV9++v06DhBuFyCew4/NUvtlViOtdlv+mTiA6wlTOsrF
         NQSJ6PnOTMSemSyKzTMal+DDffP+Y9pXfwEmBUsjDbM/1S1LLFFmFkvFZTm02uED9u5A
         M5kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FBnY2mGkBlFH+IxSO6esO9hEh+IRERtFDhquE+Lbxw8=;
        b=BSbBfs36pORLLjjrU/sYyTWn+T8GemYi3JAMfc7rn+j9yaV0TZ7sxIeXak5wxUV59y
         o+khJxK1CPeE0zDLtej4a+uuoEFEPXY7R6O6TsjQdeB4TtmlMcOb7vT0GNVHt+FNUcXk
         Hfs6ns9CVzObUiUKLIbx0tnmshIFp8RdKHV6fnIHvN4U8YR+upcY0e5IH/2Zdpco8Xp7
         H1hlyn1xN+VyRlIfP5KEeu+dBBcHlsvtjxvlQ7Bt5YO88w3+Wseeuq90MEB2zm4AO5D+
         FogglnIwFxunwZ9gmwo7hMkBfzhg0pYg/CW+/8a8Q2XOIXCJUlO33liSaV8ru4DlQhZa
         yHVw==
X-Gm-Message-State: AOAM531pZdrW3kyHqPCHtIN6CY5v7PdKOqzrL97N7oA8BX+Euv/ZMkFy
        LC3pEt7oICKB0kLLg8fX/FYQpYWvPENBpI3Ms+fTk/HtBTM=
X-Google-Smtp-Source: ABdhPJzZeAPnQ0VNHSGt5inmkr7a8ZlWm+RFTliuCEinVL/xEeaqFKNj/Dmw0vv2DKD/A429oHfQZTqL7i/jMwQfnZs=
X-Received: by 2002:a05:6402:176c:: with SMTP id da12mr978510edb.386.1600724644777;
 Mon, 21 Sep 2020 14:44:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921211744.24758-2-peterx@redhat.com>
In-Reply-To: <20200921211744.24758-2-peterx@redhat.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 21 Sep 2020 23:43:38 +0200
Message-ID: <CAG48ez0o+yBpYdzR_-bU3A0nrpzXyM+c+Yk=ZtOZ92qe5x0izA@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 11:17 PM Peter Xu <peterx@redhat.com> wrote:
>
> (Commit message collected from Jason Gunthorpe)
>
> Reduce the chance of false positive from page_maybe_dma_pinned() by keeping
> track if the mm_struct has ever been used with pin_user_pages(). mm_structs
> that have never been passed to pin_user_pages() cannot have a positive
> page_maybe_dma_pinned() by definition.

There are some caveats here, right? E.g. this isn't necessarily true
for pagecache pages, I think?

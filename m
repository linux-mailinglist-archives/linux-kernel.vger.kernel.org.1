Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D83E279CC9
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 00:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbgIZW2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 18:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726242AbgIZW2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 18:28:53 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AA0C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 15:28:52 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id 77so6844818lfj.0
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 15:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x5311Cy+5DCxZN2zAMmFnDHSFfNBkBdzbRGB2+4qmlE=;
        b=eM40qe7xNe/voahDDsD2+ynKrCh6tr+a8hkfQXaw7ZsgyvOb7QTfd11jF1V1yIvj66
         QnA5VeYmOA4XA9JilcomS14bh0OgX8MsCmXGMBGQnDeVJSgSqEJyY3HBjxJzy+siGE/h
         9+dTc1JsEX62nNBYXvVeboBvNAXsH6roUjn38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x5311Cy+5DCxZN2zAMmFnDHSFfNBkBdzbRGB2+4qmlE=;
        b=NjdnRtRL+KpVCqhNAiaq+dLfB9/c2/zazpU6pjhsEYqIMzEIr6MyUqBO5YTlMcA07k
         47CpJcuXABRdOSpkcxb8GeeeywaU/XZtVyzmfvLpdhTl8rc77bqtHh6d/foVdF3yr2hK
         hKGTDSzRwqJrRP9WGLf6S7J/xjNQ+09WpRsfH8z5t9kXOa735/RSfPFdm68ITibQrfcm
         LsM28kQOTSQwUsJo8dNqYzclg6hbXzVsfKc5jkWDkcouMjkC2it+C6IqyqrXGMJRKJ6Z
         szdmsUUuujJUFO/PwQEkTT5AnXboM+mxto9p7jhE5Su7d6rLBi32TxwrwV0lux5Upo3D
         JJ4g==
X-Gm-Message-State: AOAM5322rbJo5YIFodN5pjAUMYb5O+cuJ+MEGNtfVUrqnRzlQJ4gqpJJ
        2VXjb7EtMKDzRpBl9OepO+i17gNQEyVMYw==
X-Google-Smtp-Source: ABdhPJwB7ZsRJNUMMQqG8Cy496Rf2xOrIa1c0XuH12dzZact6ch1URvomJdCnslkEXTKTBz2mb+UEQ==
X-Received: by 2002:ac2:43ce:: with SMTP id u14mr1496820lfl.363.1601159330827;
        Sat, 26 Sep 2020 15:28:50 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id p27sm2202416lfo.272.2020.09.26.15.28.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Sep 2020 15:28:48 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id a22so5309925ljp.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 15:28:48 -0700 (PDT)
X-Received: by 2002:a2e:7819:: with SMTP id t25mr2940089ljc.371.1601159327915;
 Sat, 26 Sep 2020 15:28:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200923170759.GA9916@ziepe.ca> <20200924143517.GD79898@xz-x1>
 <20200924165152.GE9916@ziepe.ca> <20200924175531.GH79898@xz-x1>
 <20200924181501.GF9916@ziepe.ca> <20200924183418.GJ79898@xz-x1>
 <20200924183953.GG9916@ziepe.ca> <20200924213010.GL79898@xz-x1>
 <CAHk-=wgz5SXKA6-uZ_BimOP1C7pHJag0ndz=tnJDAZS_Z+FrGQ@mail.gmail.com>
 <CAHk-=whDSH_MRMt80JaSwoquzt=1nQ-0n3w0aVngoWPAc10BCw@mail.gmail.com>
 <20200926004136.GJ9916@ziepe.ca> <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
In-Reply-To: <CAHk-=wiutA_J-OfvrD8Kp3SoYcfMHUwsU7ViOH48q7QN0AQ6eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 26 Sep 2020 15:28:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
Message-ID: <CAHk-=wi_gd+JWj-8t8tc8cy3WZ7NMj-_1hATfH3Rt0ytUxtMpQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] mm: Introduce mm_struct.has_pinned
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Peter Xu <peterx@redhat.com>, John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 6:15 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think that over the weekend I'll do Peter's version but with the
> "page_mapcount() == 1"  check, because I'm starting to like that
> better than the mm->has_pinned.

Actually, rafter the first read-through, I feel like I'll just apply
the series as-is.

But I'll look at it some more, and do another read-through and make
the final decision tomorrow.

If anybody has any concerns about the v2 patch series from Peter, holler.

              Linus

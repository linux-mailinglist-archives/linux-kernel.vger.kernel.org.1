Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF5AC287AF5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgJHR1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729377AbgJHR07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:26:59 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D680C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:26:59 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id dn5so6629085edb.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NK/SL9W3DmzutM+WXBbWy3ollYdvMFEoNGZZc0Sd0N0=;
        b=Pd6VXGVE8CSWBlYfJc2ci7thQfj4LljK+DJhu8w6e8FcVdLdk3U/YZwGom/AXGVXtj
         Ggz2o+eCvr/JNTnw6z/RhM0wt8xenIB7IzJ6KG7ZwbDB7DFRfSRLf1/dfvPz+8QWjOIS
         Z9+hbKEICkevSo1xsnaRO+OTbvh604S+XCOqB91gp0sa6gC7k036dd/UzxZkADvIydKr
         kr4pA7X/Jh0ssBN4lsprAf89fNIC664UtfgczHQJ/JhSfnrMj3ZGhLElRO6iQ8kkK/ft
         01IFeZNFutVsBpnGIrn/d6l8xGiyrNOvLxNOEp5wCZWeetFdsV3pIAhK8/pMaGCiM5Y3
         TwnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NK/SL9W3DmzutM+WXBbWy3ollYdvMFEoNGZZc0Sd0N0=;
        b=Xe0BDcdRcILq9lYZP3VJLS+VbZTtiCZgzQsESSKQkgjzM1KkpmWZYyQPv+L30EQWBx
         zzDVkUEK2ug/KGcySRw7LpM/AYJk4UK1B00Gobon9YZFyUYGBZmSHopfrpjgQkCpLgUX
         CnTFjL34zkGP2etZvUkYM4IVPdM9q4Lqb8Dw0BsLW9wPxcT8pC8qHNJ5D6ZnxyV5dJ5a
         GrFQBxbVwAK/LGnGeWEBPMfl5j6A7Dgm/VVVdeWJzmyqYQm4ylPdJTgJsCFiUZw1YgXW
         wTqcgFgPuBj5i5PMaS3E9XGz4o1TgbQa3XbWjv6lG/owO/x+EO6G0JLss9oefXtLc5bz
         Wswg==
X-Gm-Message-State: AOAM533y0EJoPiUN1no/waCebC+MZtV0ALfNMGbVO7pCrDw58mW3w3bz
        v0qcukrTBImD0teIXAv9X/hEc5pVuS+5KQ809Bb6cw==
X-Google-Smtp-Source: ABdhPJwCRvJlPe3HTKxjHpBOw8YuPBCkXh9yxNGN84Y0S8cA9Jio+pxXOUqkXJ4XuStzFAbxLOl3TqmmcZhcBjeb0oA=
X-Received: by 2002:a05:6402:32f:: with SMTP id q15mr10185170edw.230.1602178017731;
 Thu, 08 Oct 2020 10:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20201008165408.38228-1-toiwoton@gmail.com> <CAG48ez1OU9PFQ06mf4L59SEmi6Vwxnao8RuVXH=dCiyMhqVwYA@mail.gmail.com>
 <20201008172300.GL20115@casper.infradead.org>
In-Reply-To: <20201008172300.GL20115@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 8 Oct 2020 19:26:31 +0200
Message-ID: <CAG48ez3-uvDXL7-WBapEJMHrkXYpnAw=AgbP2evOZgNMFWKy-A@mail.gmail.com>
Subject: Re: [PATCH RESEND v2] mm: Optional full ASLR for mmap() and mremap()
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Topi Miettinen <toiwoton@gmail.com>,
        linux-hardening@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 8, 2020 at 7:23 PM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Oct 08, 2020 at 07:13:51PM +0200, Jann Horn wrote:
> > And for expanding stacks, it might be a good idea for other
> > reasons as well (locking consistency) to refactor them such that the
> > size in the VMA tree corresponds to the maximum expansion of the stack
> > (and if an allocation is about to fail, shrink such stack mappings).
>
> We're doing that as part of the B-tree ;-)  Although not the shrink
> stack mappings part ...

Wheee, thanks! Finally no more data races on ->vm_start?

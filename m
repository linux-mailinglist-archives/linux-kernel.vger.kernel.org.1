Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B78D9287AA0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 19:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgJHRJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 13:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730147AbgJHRJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:09:27 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF451C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 10:09:26 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y16so5404249ljk.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z5wcuDA1gh/3Ps6l+NWlPcHbmyW5YaIQwLSEAvKTv+g=;
        b=cZHvUXj5G6+H19Nj4m528LVZtsoSSR8DXg8s8jyXKZNl8yYlcGAb2i3EBmVhdsS3AF
         W3RfTehbw6eYlGzzLmiYFkaUZwBpmdmMlDJneXc80kfm7LkKDSW9OkSK0jUhE0zjXx/x
         +Nat7/Qr8ncJLNBYgRySy7Jc9Y8kWw+L70eL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z5wcuDA1gh/3Ps6l+NWlPcHbmyW5YaIQwLSEAvKTv+g=;
        b=nFjOWTeJcJG2C3pYMy0o8C9ZZ3TBNCcFTsTZS7dfJJf9FueooC7igogJCN3HEl5HnL
         7/UVSMgQZpiq4pAuYLMXfZiYFn4DZhB43oBa/t1Y/fS9GR2Vz98tSOjs8nyddZ9BVf+2
         Ld4e8xYE1vEWDPChfCp5L2GrUrJuYlcopTVxOCTQBPz+9OGVHg33zX/SvF42f8nJuJbf
         xmOKFwWBCvfgg8Uh9IZdnPHBCKwWt0JvEK0U+wDU9yxxKgH5Hkpt9lckJfUYEmivMIzA
         qswOBdWDbUFfFBzJR7goytt4hdg/XvD3ctyZl77dKXJsSa0vhJton2VH8WQ79xVGG6CC
         Qdog==
X-Gm-Message-State: AOAM533ezzHf1NVMY+yS9meC/offdh+PO1fedeIflkXDaNgwnww209uC
        5SMOzg+C+mY81nrLJAZ+1jnzrIIAritWLQ==
X-Google-Smtp-Source: ABdhPJx4BRhe268+XP5dIziWb/v0DuUuwvZjGGE2arV8Q5I1I3CR73LdH233rjCbvQHaqw1Nfj/+kA==
X-Received: by 2002:a2e:97d6:: with SMTP id m22mr3465078ljj.328.1602176964421;
        Thu, 08 Oct 2020 10:09:24 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id j17sm1051449ljg.82.2020.10.08.10.09.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Oct 2020 10:09:23 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id 133so6577516ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 10:09:22 -0700 (PDT)
X-Received: by 2002:a2e:2202:: with SMTP id i2mr3411487lji.70.1602176962536;
 Thu, 08 Oct 2020 10:09:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201008092541.398079-1-aneesh.kumar@linux.ibm.com>
In-Reply-To: <20201008092541.398079-1-aneesh.kumar@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 8 Oct 2020 10:09:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRmi=uie1xV=p72CG8rhG8md_MWKtvPguxUtjbSPtVYA@mail.gmail.com>
Message-ID: <CAHk-=wiRmi=uie1xV=p72CG8rhG8md_MWKtvPguxUtjbSPtVYA@mail.gmail.com>
Subject: Re: [PATCH] mm: Avoid using set_pte_at when updating a present pte
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nick Piggin <npiggin@gmail.com>, Peter Xu <peterx@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ahh, and I should learn to read all my emails before replying to some of them..

On Thu, Oct 8, 2020 at 2:26 AM Aneesh Kumar K.V
<aneesh.kumar@linux.ibm.com> wrote:
>
> This avoids the below warning
> [..]
 > WARNING: CPU: 0 PID: 30613 at arch/powerpc/mm/pgtable.c:185
set_pte_at+0x2a8/0x3a0 arch/powerpc/mm/pgtable.c:185

.. and I assume this is what triggered the other patch too.

Yes, with the ppc warning, we need to do _something_ about this, and
at that point I think the "something" is to just avoid the pte
wrpritect trick.

               Linus

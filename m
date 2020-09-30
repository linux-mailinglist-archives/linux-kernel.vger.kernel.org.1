Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0364427F5ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgI3XYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbgI3XYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:24:54 -0400
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43171C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:24:53 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id k2so2576844ybp.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 16:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kQN/VEfDdjX5avpgdFSz5SN2peX8hbqc+PeyEygnJJQ=;
        b=YhG3ShaC7/6QIeO5Erm4os2H5+E+5WD5nhBGQ365+hRsPNNApe1PegAwJL8cabUth9
         eCJupXwhhMRD1JTLPGhlGYN2IwxT9VC1Bpv2PAYHsINuTeVSWn4K0FDzJ6/ALz439I/v
         ekXI0ZzYQVeprDUaSMJ3tqFdV40PzGIFgTAku5eelgxg9co9xc+o98ENBIxpQjufrrkb
         ehFjESqfYVfwSgXwzPqFLUyUXkKaaQVyvTu2XOXOvU+JL0RfW6bXHOf+EBy9kqY0nLIh
         7hcztgIwWfUsHtdBvLx9okcGqBAC3lzvUnsBxhpOyKYR+f9bArFRPGKCNWLDPsp9wiiK
         qVjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kQN/VEfDdjX5avpgdFSz5SN2peX8hbqc+PeyEygnJJQ=;
        b=anLSH+8E/Xsj60Sa1bxQPIBWr3pcjtw8oiihWdRxNSmMkcPGvMW2WNxEXaIK9fWGOP
         DugZDCwPsOez5JBiKhpmP9XwO+FmDoY5VfUGZXxqmEBhsMP4WLAzIwXqNn8CSAkQT3Jf
         ZXaLxoAQzhCLndahxUdhvQDsYGePU0XfyJt0+TjHhVWaK/Q4epog1QZYA02rZCLlaPZ1
         mj5Jc2RBsquC+YeY3MIa2sOmM2FdRVjwgTMNLb68MoBQFqkRfeQU68w0j1NisK5q/tMV
         350I2l/rdR0U37UWDZPULQggO7+7kDhGeVF4zPqFoF3EYisKMjSrEWU+VkrNZrrOrm8k
         kclQ==
X-Gm-Message-State: AOAM531LQf1vjA53SEH8EJx2rUpkF4vV8xzp+QxNhNoxda93zCh+6uJz
        Z3aAcFSFymsxG0NqovOVCWM1fjMs3HbyqT1VkhprAI3Mb5nWrQ==
X-Google-Smtp-Source: ABdhPJzTtg1x0wdG8AGHlOHNnHHpxdHWuJaLj8KzGpnPhj796YLhl/jpix/ZR8BrjsAyUR+fR8iIV9VZq4PSeY/WIFk=
X-Received: by 2002:a25:14d5:: with SMTP id 204mr6807010ybu.162.1601508292279;
 Wed, 30 Sep 2020 16:24:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200930011944.19869-1-jannh@google.com> <CAG48ez1GM==OnHpS=ghqZNJPn02FCDUEHc7GQmGRMXUD_aKudg@mail.gmail.com>
 <20200930123217.GD9916@ziepe.ca>
In-Reply-To: <20200930123217.GD9916@ziepe.ca>
From:   Michel Lespinasse <walken@google.com>
Date:   Wed, 30 Sep 2020 16:24:39 -0700
Message-ID: <CANN689HPPP3kKNFpm5ymJhk-FODN1nXgMHouZ5-v1m=BJ+HyJg@mail.gmail.com>
Subject: Re: [PATCH 4/4] mm/gup: Assert that the mmap lock is held in __get_user_pages()
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 30, 2020 at 5:32 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
> On Tue, Sep 29, 2020 at 06:20:01PM -0700, Jann Horn wrote:
> > After having cleaned up all GUP callers (except for the atomisp staging
> > driver, which currently gets mmap locking completely wrong [1]) to always
> > ensure that they hold the mmap lock when calling into GUP (unless the mm is
> > not yet globally visible), add an assertion to make sure it stays that way
> > going forward.

Thanks for doing this, there is a lot of value in ensuring that a
function's callers follows the prerequisites.

Acked-by: Michel Lespinasse <walken@google.com>

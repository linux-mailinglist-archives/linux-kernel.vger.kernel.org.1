Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22393280FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 11:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387608AbgJBJSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 05:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbgJBJSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 05:18:02 -0400
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C95ADC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 02:18:02 -0700 (PDT)
Received: by mail-yb1-xb42.google.com with SMTP id a2so696126ybj.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 02:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Vsjo30pgyOUaef87RJlkVqPkl1WeoNmBll1hNfvAZmU=;
        b=AWF/8lP+/Nl6Tu9rGdxcSoT5C6Ym+2LAhrLg7DhdLj299c+5+DgEYG1RwNMFAivBh3
         cwE0qGwo90rpYmZMcUnsdumVHlrX/iktoB7i6NT2WSF1SAWM9HgDvig+XioF1zvVK2dZ
         rdX7cyOR8HK1up6v5yAvbXSGe0SJOXA9e1hmHPo4mgwioCsFyBhyluNnPTczUWyEDWnm
         ofkNAu08t36N0yHkj+x4qtbUpzquXvmgzHgAWK2OJF3T8lwpT66aqAvyDNvHn8orMlc8
         u0UcrIY3CgOxSvuVB+t6ONEsrKbU5QyM1FnlqKfOkInUYBYAvtMJ2bslSyHQpElmxpvG
         Zh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Vsjo30pgyOUaef87RJlkVqPkl1WeoNmBll1hNfvAZmU=;
        b=Tnkc68GHJ8PzlccC1IGUSxjsZFjJtDIfPe7oin2Gf5+o6VP/As9F976r1m4RqbbSay
         97PO84AK8u6CGJo5ydz9LngbwASgE4Ez7/4Km3xoDBePry+JBFwV5l6LVmZFXiFpdAzm
         ZwHhDLFS3YmXFo0f7NZXyrpWClTWBKMTx/1lCLU0XHv26A9GuKdltmVu9saAwmVjrcxT
         MxcNZzitCg95bgUr1GC0EKpHVG5XXZdMrJztuoXJjXo/EUB0re1oOhiLL/KsdAETZtZp
         4tK/AqQ3qMskochhazCEUdxws6KnEipBA6ZgvK5F+nLxsN9NOeW2cPUjDzDuh0MDj8D6
         1lXg==
X-Gm-Message-State: AOAM532Bam+SVg8wL+ww7equOICf3acVcI3cLClkeEVHXnzAiPHmHZkb
        En57ct5/2kc6H1CWFAEPOUQCWZ49obf8imbICfwThQ==
X-Google-Smtp-Source: ABdhPJyPBuvssqN/33F6eY14jTT+a+H/yPFD0+SG2k2GowbWLmh3q7LGH/7YYKEdpdnFAiVucEWGEP5B/qXvNQHe8zM=
X-Received: by 2002:a25:5056:: with SMTP id e83mr1441462ybb.287.1601630281691;
 Fri, 02 Oct 2020 02:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAG48ez1+ok5c5PK4DjA6-rYkg9qPeKoRrJmc5jsGf=TZZbShJg@mail.gmail.com>
 <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
In-Reply-To: <CAG48ez1kMuPUW8VKp=9=KDLVisa-zuqp+DbYjc=A-kGUi_ik3A@mail.gmail.com>
From:   Michel Lespinasse <walken@google.com>
Date:   Fri, 2 Oct 2020 02:17:49 -0700
Message-ID: <CANN689H9hXzaV0_vpFfrvjQD6xAEaPnjok_17zWGHumRNs-ZWg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmap locking API: Order lock of nascent mm outside
 lock of live mm
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        linux-um@lists.infradead.org, Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 1, 2020 at 6:25 PM Jann Horn <jannh@google.com> wrote:
> Until now, the mmap lock of the nascent mm was ordered inside the mmap lock
> of the old mm (in dup_mmap() and in UML's activate_mm()).
> A following patch will change the exec path to very broadly lock the
> nascent mm, but fine-grained locking should still work at the same time for
> the new mm.
> To do this in a way that lockdep is happy about, let's turn around the lock
> ordering in both places that currently nest the locks.
> Since SINGLE_DEPTH_NESTING is normally used for the inner nesting layer,
> make up our own lock subclass MMAP_LOCK_SUBCLASS_NASCENT and use that
> instead.
>
> The added locking calls in exec_mmap() are temporary; the following patch
> will move the locking out of exec_mmap().

Thanks for doing this.

This is probably a silly question, but I am not sure exactly where we
lock the old MM while bprm is creating the new MM ? I am guessing this
would be only in setup_arg_pages(), copying the args and environment
from the old the the new MM ? If that is correct, then wouldn't it be
sufficient to use mmap_write_lock_nested in setup_arg_pages() ? Or, is
the issue that we'd prefer to have a killable version of it there ?

Also FYI I was going to play with these patches a bit to help answer
these questions on my own, but wasn't able to easily apply them as
they came lightly mangled (whitespace issues) when I saved them.

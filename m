Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1392EF809
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 20:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbhAHTWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 14:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbhAHTWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 14:22:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37693C0612EA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jan 2021 11:21:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id a12so25521540lfl.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9DxyyoxIwNzC1Y/lXVr8iCFhiC0bplWgkzCKo8X8mJ4=;
        b=Gcx7xVZjyHw/sasNrschAvXzsVr5SUmk8l4VqcXNth9xR5nFmmnhSoTc/zj/AczJPN
         44vYVJkRn1AdvUMJeYZkFMoH0x6N3tnYU2BJ5CFk9lGiou4F4xX1AglhpfoLcoWwRBbE
         /yDR6QYtIsiQteY126FvGiA2W6Vv1VpdOkkag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9DxyyoxIwNzC1Y/lXVr8iCFhiC0bplWgkzCKo8X8mJ4=;
        b=d4vWWww4dkyiMR6gRRRFO4RKhW0+0HA+6+6Iu6SQw/IzZYSXfKCOu2tZxAZoqMi4TB
         EjBn+dhg7JZuZs66LyzVPuNTLyTsEzkoqd7S8so26EcgtUuv3dD11rz+b0H77br1sI2E
         2a1ZJpImN4r3rg6mb5x7ZVkRo3ODE0UnpqYN5wiCw8mqUNW6O8RDmDjctOqSVVXi0xE+
         Dbltwxl9ld2j80Amlh91EV9xiXfQ0+ApxixYeeFdHrnRgp9Rag2InijDoL0HW2rv1FCr
         e6AnBEFR8D24TuMT6eJh1K/XBksTqQI7I2lG9A7JFm7b+kmb5h5MWkmmbiBVBvezabg1
         +6Vw==
X-Gm-Message-State: AOAM532MmXKv1/Ht/yMCzbZoeuiU1Qv25FcoZ17DEwnhy53JEaWq3vnD
        O3Y52UmiqVHcjYpWPEZcdJYHoTXQs+lxMQ==
X-Google-Smtp-Source: ABdhPJxqMYX3Xp32Ut9PyYVHyDyTYJbNrYEJ/MIWDxTdHjIMDF/9LSNlIdYMeTj9TNzbDuez5FT6CQ==
X-Received: by 2002:a19:cc05:: with SMTP id c5mr2120177lfg.393.1610133700397;
        Fri, 08 Jan 2021 11:21:40 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id a4sm2299064ljp.14.2021.01.08.11.21.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Jan 2021 11:21:39 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id s26so25471177lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 11:21:39 -0800 (PST)
X-Received: by 2002:a05:6512:789:: with SMTP id x9mr2048861lfr.487.1610133698921;
 Fri, 08 Jan 2021 11:21:38 -0800 (PST)
MIME-Version: 1.0
References: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
In-Reply-To: <3d34069ab2d249d866ea1d18a47e4170dbfb5982.1610132102.git.luto@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 8 Jan 2021 11:21:23 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjwuwUv1kCOrG00xWEnAt8iqgKFYzvRZG-GOmkaTg0yhw@mail.gmail.com>
Message-ID: <CAHk-=wjwuwUv1kCOrG00xWEnAt8iqgKFYzvRZG-GOmkaTg0yhw@mail.gmail.com>
Subject: Re: [PATCH] x86/vm86/32: Remove VM86_SCREEN_BITMAP support
To:     Andy Lutomirski <luto@kernel.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Linux-MM <linux-mm@kvack.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Jann Horn <jannh@google.com>, Jan Kara <jack@suse.cz>,
        Yu Zhao <yuzhao@google.com>, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 8, 2021 at 10:55 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I can't find any users at all of this mechanism, so just remove it.

Ack, as long as it sits in linux-next for a while.

            Linus

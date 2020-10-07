Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5494728629A
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728797AbgJGPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgJGPwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:52:42 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1CFC061755
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 08:52:42 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id b12so2675781edz.11
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 08:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+kRXBiTTqLjoGuZADUPKhdAQg4SP22QhzxvR6S3848o=;
        b=nqUDHkZUkA+6evfFg+zzhGq85zxiHhImQ0yisbZigWKi3GOaE0AZ+9ws+VhE7Xhy/R
         uw6Bhxdl/QvOlaZa+zfugJ4TYgesSTDiSrMKHbrrBDRMAdISHaEBvnCGrS7vkaPTwUbX
         pWA9btmQc+4tJe7MqWz6nj/w3UHHpz8glHtbdC+dSP7D4QghKBlDFZumDCijaJXZ0u8f
         YL5cxFmbwMdjY1xS0NAXsbL/w2G18k+nCxIh70sE5P3sWwnR1MGAKfzg6L8WPAp8e0V7
         89t0DINkUocnpm8qezUl72nwIm1AlLu6cebjwyIrqQQB+oaz5ZQWinOI+313V19cBEGo
         S4Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+kRXBiTTqLjoGuZADUPKhdAQg4SP22QhzxvR6S3848o=;
        b=XSwV1vDI5Q5FZD17LyxG51kityj9qgJ+V0sAGGjF09VS52Ze3QGjQUNio0QI+Mz3U8
         eIizj1sbZSYmlvaDnLQzIXtulj+rurhKYI54FP7t8xaY4SjrCw0QAkG56lOw9XWFRm8P
         RSpYtJAz1XwzjYLJl5wP7nh7X1eCvLYr9h4mxuGIlXNbr0mapskqVFr2MISNJkI4geBr
         jiITcBjoPixZ08n+YILf8Kq0oWLDfiPH6Z8l6v4wRl1PQF/wehVitIWxVMmjAgeJ6DhS
         1rB10RQC3m9tyl2bGdgwWDitrjC8E40ottulEFyM6CI+MTPOhLo00Wuf+YLUJ8txEwCG
         147w==
X-Gm-Message-State: AOAM531ge6dy4KdsSRV6z+NzuXcxH6XazdSO7j2hDi2h9JzF/TWM2u/V
        8150937Nbz7zUMouTVgAwjcS1rB46AwrbH3CJV0=
X-Google-Smtp-Source: ABdhPJxfazbFsQCQXjT26uU6DP50kS4jYKa7wASwPIdnkg+0Seru1E0+NnAhK1qFBoBa/p3RvaOEv5Q8IBMVZDNV1FA=
X-Received: by 2002:a50:c05b:: with SMTP id u27mr4176668edd.290.1602085961143;
 Wed, 07 Oct 2020 08:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20201006205103.268F74A9@viggo.jf.intel.com> <20201007095225.GH29020@dhcp22.suse.cz>
 <89df7a1e-747c-4059-0b4d-6e2ffe129579@redhat.com>
In-Reply-To: <89df7a1e-747c-4059-0b4d-6e2ffe129579@redhat.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 7 Oct 2020 08:52:28 -0700
Message-ID: <CAHbLzkq0EZDwN28Bhfhv1pPqv0he2QA5by9etXriasnq0h9-7g@mail.gmail.com>
Subject: Re: [RFC][PATCH 00/12] mm: tweak page cache migration
To:     David Hildenbrand <david@redhat.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 7, 2020 at 2:55 AM David Hildenbrand <david@redhat.com> wrote:
>
> On 07.10.20 11:52, Michal Hocko wrote:
> > Am I the only one missing patch 1-5? lore.k.o doesn't seem to link them
> > under this message id either.
>
> I received no patches via linux-mm, only the cover letter and Dave's
> reply. (maybe some are still in flight ...)

Yes, exactly the same to me, but anyway I saw the patches via linux-kernel.

And, it seems the github series doesn't reflect the changes made by this series.

>
> --
> Thanks,
>
> David / dhildenb
>
>

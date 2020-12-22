Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 991F22E0DFC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 18:49:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728102AbgLVRtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 12:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727962AbgLVRtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 12:49:35 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77344C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:48:55 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id e25so2960287wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Dec 2020 09:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gZ3Mpnz+y+y40eMwZF/PF9p0ykrXNof+TnqSLHPYMc4=;
        b=fJurTTnF+Va0FHUdyTWNlS1cGpvh5djyhWHIz8cfeXiEfOyaHauqRQAM7CWWF/HB4r
         XIFtvR6qpYy5MgmX/TledRqo+t3vH2fcKr7e38xsmzAyKFWgAU8vhI2ZUIFIAYsEkZ8p
         a1YloLSV7hKc5+Gwt6KP7k500IbltONvgsDcSeGi9zSpQg8zA7YgsqoHX5zOYwp5BF/e
         iW/jP7UOFR0ATiu/JRaMsx7mEMPFpD1OoYVYpfMH/SAtbBGfvYXc6oIG88gZL0BbXR1o
         FAp5U+WxGka2LA/evqmWwrzWueuV0cQwOyeE9XZRiQIJnFQm1w0/OvkqpZyWL+tQoCmU
         sZBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gZ3Mpnz+y+y40eMwZF/PF9p0ykrXNof+TnqSLHPYMc4=;
        b=L5vlK9vrmlP63ZcgITfwJjnl7GVUb0vMne8fIEg3ZqQp1FhtMF6aEyViRRViJH+Jfp
         PALS55PlrnyO6Wcqo6Y76hnrmWKt6hBp37FbovlS+U6FobvWYKqwtjrKrNgYqtd7Nhru
         0XJngKJtQ5qfONqHFOc/Ig8BoAOtyw9UzTPgm23sCg0bOOZ3jI029877GFKZYUPhhNMZ
         u2BTgSQeexV5AIyH5NMgfd+RdHmDYvxk9YO1F74sGK8D9mekc6ChoDwVn2XbuGtTqlKX
         uRlqBzOOaZgTZX+lVdfMFyb1nBdj39EozJ7XZebJZZ26tGzfnXHlSLPG7zJw4eiL4d2T
         r6gA==
X-Gm-Message-State: AOAM532ZrxWx3MAYEFAq7yJHYIhZVCOjz9AD5kNAqR47jAeP4okQltdN
        2uS0+jXWdFQELq5QOQ95RaEBV8MO4PrD32VTZaFt4w==
X-Google-Smtp-Source: ABdhPJx8xdo+vZEMkO7jQEED2nsivqCj2PRiduHKYZoEitQJoXN17y7RtUWzBp4kXUmTBuo5w4edqoIkhNfbujhKVnY=
X-Received: by 2002:a1c:4e0a:: with SMTP id g10mr22732565wmh.88.1608659333913;
 Tue, 22 Dec 2020 09:48:53 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
 <20201222134438.GA7170@infradead.org>
In-Reply-To: <20201222134438.GA7170@infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 22 Dec 2020 09:48:43 -0800
Message-ID: <CAJuCfpGiVS69kznSrAdosxnRd-zgXPJd8MXou=gd8K8j7xLMjA@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Christian Brauner <christian@brauner.io>,
        Oleg Nesterov <oleg@redhat.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 22, 2020 at 5:44 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Dec 11, 2020 at 09:27:46PM +0100, Jann Horn wrote:
> > > Can we just use one element in iovec to indicate entire address rather
> > > than using up the reserved flags?
> > >
> > >         struct iovec {
> > >                 .iov_base = NULL,
> > >                 .iov_len = (~(size_t)0),
> > >         };
> >
> > In addition to Suren's objections, I think it's also worth considering
> > how this looks in terms of compat API. If a compat process does
> > process_madvise() on another compat process, it would be specifying
> > the maximum 32-bit number, rather than the maximum 64-bit number, so
> > you'd need special code to catch that case, which would be ugly.
> >
> > And when a compat process uses this API on a non-compat process, it
> > semantically gets really weird: The actual address range covered would
> > be larger than the address range specified.
> >
> > And if we want different access checks for the two flavors in the
> > future, gating that different behavior on special values in the iovec
> > would feel too magical to me.
> >
> > And the length value SIZE_MAX doesn't really make sense anyway because
> > the length of the whole address space would be SIZE_MAX+1, which you
> > can't express.
> >
> > So I'm in favor of a new flag, and strongly against using SIZE_MAX as
> > a magic number here.
>
> Yes, using SIZE_MAX is a horrible interface in this case.  I'm not
> a huge fan of a flag either.  What is the use case for the madvise
> to all of a processes address space anyway?

Thanks for the feedback! The use case is userspace memory reaping
similar to oom-reaper. Detailed justification is here:
https://lore.kernel.org/linux-mm/20201124053943.1684874-1-surenb@google.com

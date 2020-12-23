Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0CA32E2001
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 18:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgLWRdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 12:33:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgLWRdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 12:33:09 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50A9C0617A6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:32:28 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id y17so19334625wrr.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Dec 2020 09:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+u4HaQZ1cdgjeiGaZ8lzaVDKyHykee/RjOPEPv24mOI=;
        b=U4BfHPe+CwSjOhbhz0tlQtUuD4sLyUmYOyw3DR+Z8s9RwnSDQK8osHUb4PPSsCErx6
         uM8gfuTZ3LMhL0IWTUFZMQ+SZFKDaNs8woYxEk0yxSM9azY3+UQcDNa5o2RBV/rtABcO
         v0L8TdXlWzc5hqcIsDiw5FbvECLAWsQyiToLpxguB7KkwGybzYgPleGhcB8y9+UPsCET
         v51Xv0W83LauUvH8J8Wg1xstijP4wylDk9BJKz/w+NKz27B84uNsG0Y40A8S/VhoOck/
         8XsKTwFgxBOCjrYrHTOi3BCgCaYB6GUQLrm0IBxnUo5cFSJw324NGTiqfdFpS5LpjUJB
         QIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+u4HaQZ1cdgjeiGaZ8lzaVDKyHykee/RjOPEPv24mOI=;
        b=uiwegskCuufP2b7PQ5NeZX8xPuHFyec75zsJTommqQnWVQMqRlL+bO24b8ggym3miI
         nKfqAwkI0CY1R1y7R7+DY2wwOYB4xUfi+yvrHnro9VkkV73Bpge1pK1yh2E1PugmyUT/
         RPDQE0DCB5WKLQyvibq1Mdz7aZVLDwKMa20TeXYl/HsAXxLGROtIs23n4a2RUCDpyVlJ
         l0Sf/oo5zjAIF/jMkOwb2PiQAN8WCBr6n3oZJeDqFUXlmuPzdN52Y9DwCr+VLIPCrOa4
         epSlExWCy2kDmVH5jbvv35VBZM5ZdeI4xDPKpAt+jj0cmHTAroEQ3mdxoFmBnrabGPt7
         D2Yg==
X-Gm-Message-State: AOAM530IDddgtSHscYfH9ciH3cMNhi3utnFpwneMamNBYUjLT6QwG3P/
        ijrHjCyC6kOhdUyz/c8tapE0W3Fixc2NZwXmYJ+GeQ==
X-Google-Smtp-Source: ABdhPJzUAsAuBD2dVSthDXzQ7IV73X0J7foD8oXS9oA18h84oUxm1ab4Ym5dVSyuFZBgVcIqjONvx6V9YQowI2xv8JE=
X-Received: by 2002:adf:f0d0:: with SMTP id x16mr31048930wro.162.1608744747266;
 Wed, 23 Dec 2020 09:32:27 -0800 (PST)
MIME-Version: 1.0
References: <20201124053943.1684874-1-surenb@google.com> <20201124053943.1684874-2-surenb@google.com>
 <20201125231322.GF1484898@google.com> <CAG48ez0UKYCdgyW91SmOcT52vbLFz9RjLpaucWpj6bTrgQCwnA@mail.gmail.com>
 <20201222134438.GA7170@infradead.org> <CAJuCfpGiVS69kznSrAdosxnRd-zgXPJd8MXou=gd8K8j7xLMjA@mail.gmail.com>
 <20201223075712.GA4719@lst.de>
In-Reply-To: <20201223075712.GA4719@lst.de>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 23 Dec 2020 09:32:16 -0800
Message-ID: <CAJuCfpGQQN-FEoRUymeGSs86Du5DmziNbbr7uXqSTd2xsqMn3g@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm/madvise: allow process_madvise operations on
 entire memory range
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jann Horn <jannh@google.com>, Minchan Kim <minchan@kernel.org>,
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

On Tue, Dec 22, 2020 at 11:57 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Tue, Dec 22, 2020 at 09:48:43AM -0800, Suren Baghdasaryan wrote:
> > Thanks for the feedback! The use case is userspace memory reaping
> > similar to oom-reaper. Detailed justification is here:
> > https://lore.kernel.org/linux-mm/20201124053943.1684874-1-surenb@google.com
>
> Given that this new variant of process_madvise
>
>   a) does not work on an address range

True, however I can see other madvise flavors that could be used on
the entire process. For example process_madvise(MADV_PAGEOUT) could be
used to "shrink" an entire inactive background process.

>   b) is destructive

I agree that memory reaping might be the only case when a destructive
process_madvise() makes sense. Unless the target process is dying, a
destructive process_madvise() would need coordination with the target
process, and if it's coordinated then the target might as well call
normal madvise() itself.

>   c) doesn't share much code at all with the rest of process_madvise

It actually does reuse a considerable part of the code, but the same
code can be refactored and reused either way.

>
> Why not add a proper separate syscall?

I think my answer to (a) is one justification for allowing
process_madvise() to operate on the entire process. Also MADV_DONTNEED
seems quite suitable for this operation.
Considering the above answers, are you still leaning towards a separate syscall?

>
> --
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
>

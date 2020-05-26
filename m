Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F65E1C0992
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 23:41:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgD3Vlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 17:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726447AbgD3Vlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 17:41:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ACCC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:41:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id s10so5776775edy.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 14:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hkpaJwE+XdImJwiRCGmMrHpnH9Do497AqONxguPuLh4=;
        b=ejzlSjOSQT9fOgnWL9BlmOywT9YUrObwmrAsjURuygWHxwV8OQVp72xlXJtZ02/TVw
         DIT/agnijUbVoAX7BK86VAyjiWzMyGXM2KTuZI6UNemsiX1Cq2rx0pT3HwreM1CaOKlk
         g255rxIrtopXIP8n5gl+jKtXRgHpDyi++7rWe+DxBDgBZCFAwnPQpsWVH19peAeY9FzY
         yaIFdv6+/raAyg7urd5JvKL/fqOUW4UB7EqADLBzSUJ+f8Aahl2Zz0zKvpxAEb37wx7V
         DTqNs130Y7jUegFidoOJ9vnmbx17b9H5MOSZ5HwfoY9hpRUnZWiWdAn+WzCJoM0ygalG
         kz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hkpaJwE+XdImJwiRCGmMrHpnH9Do497AqONxguPuLh4=;
        b=OGWbNsi89R35TlR2t7Rpv3eXQtLsI/xIKQrtmlTKRJdah5C1TrA0yq8Em6PO0UjgdS
         qk+KO+PPAL8gGleifU7D+2QbJfY4Wb3n4C8/ko6mjodoSWHhTBBlyA1wxSTv5N91VGH7
         I30bCrJsoT+io5H4WH66ANomdOr7haHC1pXwUWJ7LfWYSWbdp4AP5XbquPeW2GnLn7yh
         9Apb7NN4tUXl4oDKnJ3WjlAReL9NfKbpR5VWl1kHtpNCe4gogm5FyGBbD10Wm5oKP5IS
         5fiYWs5iYaDWBNQwhhtegCYnXlYWA0AxbDyvYSuTpqAQG/p20J2GkTBsoY/iJw0qI0r7
         oJ7A==
X-Gm-Message-State: AGi0PuZisogtvxevjff/bkBjp2D4GJY7U1df3BPJBL/c8iagLKzT4HWG
        Qrvnv4FTrW6Gwb6ZzI+pLW9xoeivHyqacJ0/bcQiIA==
X-Google-Smtp-Source: APiQypJ/NZIDe1nyo+ttBHz9E+jzzV+NreYGwdIKd9gp9L17jS4zp63ur9u6iJDTRLJh3/QP04vldfbKOZe8y5H1q9E=
X-Received: by 2002:a50:c28a:: with SMTP id o10mr979777edf.85.1588282895115;
 Thu, 30 Apr 2020 14:41:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200430201125.532129-1-daniel.m.jordan@oracle.com> <20200430143131.7b8ff07f022ed879305de82f@linux-foundation.org>
In-Reply-To: <20200430143131.7b8ff07f022ed879305de82f@linux-foundation.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 30 Apr 2020 17:40:59 -0400
Message-ID: <CA+CK2bDwg=s6RbTCirm4U5gvRsnCMred-pnrW=WzN9hfGuBsiQ@mail.gmail.com>
Subject: Re: [PATCH 0/7] padata: parallelize deferred page init
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Zi Yan <ziy@nvidia.com>,
        linux-crypto@vger.kernel.org, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 5:31 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Thu, 30 Apr 2020 16:11:18 -0400 Daniel Jordan <daniel.m.jordan@oracle.com> wrote:
>
> > Sometimes the kernel doesn't take full advantage of system memory
> > bandwidth, leading to a single CPU spending excessive time in
> > initialization paths where the data scales with memory size.
> >
> > Multithreading naturally addresses this problem, and this series is the
> > first step.
> >
> > It extends padata, a framework that handles many parallel singlethreaded
> > jobs, to handle multithreaded jobs as well by adding support for
> > splitting up the work evenly, specifying a minimum amount of work that's
> > appropriate for one helper thread to do, load balancing between helpers,
> > and coordinating them.  More documentation in patches 4 and 7.
> >
> > The first user is deferred struct page init, a large bottleneck in
> > kernel boot--actually the largest for us and likely others too.  This
> > path doesn't require concurrency limits, resource control, or priority
> > adjustments like future users will (vfio, hugetlb fallocate, munmap)
> > because it happens during boot when the system is otherwise idle and
> > waiting on page init to finish.
> >
> > This has been tested on a variety of x86 systems and speeds up kernel
> > boot by 6% to 49% by making deferred init 63% to 91% faster.
>
> How long is this up-to-91% in seconds?  If it's 91% of a millisecond
> then not impressed.  If it's 91% of two weeks then better :)
>
> Relatedly, how important is boot time on these large machines anyway?
> They presumably have lengthy uptimes so boot time is relatively
> unimportant?

Large machines indeed have a lengthy uptime, but they also can host a
large number of VMs meaning that downtime of the host increases the
downtime of VMs in cloud environments. Some VMs might be very sensible
to downtime: game servers, traders, etc.

>
> IOW, can you please explain more fully why this patchset is valuable to
> our users?

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B1B2A50DA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgKCU2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:28:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727688AbgKCU2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:28:30 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40900C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 12:28:29 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id v19so15562227lji.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZU40kR5HcxrCIMrQq1e+LANf73GOnwaiJ4pksrxcvYU=;
        b=hOjYAUZNJSYSRMX840dgVH2+0EeqOmzdNHXYtvBtMdFPKamlSY3NtNIJI4bDPGpQ8D
         h0iLkBTmcQahnrj/1pEiixAK/pvyy3OKwOKb9uCBUDb6LmR82IqnyYRORA4lK6RdHRQB
         JsbUvxLbjVs4+G2BB7YZLfKVXQGcHb+QRtyxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZU40kR5HcxrCIMrQq1e+LANf73GOnwaiJ4pksrxcvYU=;
        b=tkyk2muf/LXBh1i/r7ElK3pmQoVJ19vLOdQqM+y2V3L2g+S+OlB5kd22ZZ9wi+myXj
         GSGNaBzOgyy9NosQDC3omP0Hvxbw2chdFJDR6AAW4dSmM8fXF5dojfNnBah81uW2k+2h
         RZ64Nf+ypAF1y1yD1/2BVUo3Eah5Pmfr6X/MEfjoL65Kt4I1pHY5oGk+QVjdxyWFsTqU
         vgPezDcv0jIVg4yvM6k0ygNglJBeoREoF7wWXds8kzYvTCsDKlE6n7cpM0d7GdZ/6eSc
         BDbnPsyng813nt8sN4bhISBG8GRR7pb3rNSDc0fdt6sIC3CvRp0yySIOom2lkZS1jbZD
         O0Xw==
X-Gm-Message-State: AOAM531BkCseBCKZtNa+nMU/r3fSABZfUV1mVpZS+LKw1GnOwIJzT12Z
        sHmkm67ACZeScMLIoUi4wC64DlNu0vKnvZSg6Pnkog==
X-Google-Smtp-Source: ABdhPJzOQKNBKOTt8A6R9djuhirhayRnPtb8aWN7s9Vp0KTZh/eX6MR8kXGFwcmSDC+zBsXdSywUAOIIum4FQY+RJMI=
X-Received: by 2002:a2e:3c07:: with SMTP id j7mr4478439lja.83.1604435307622;
 Tue, 03 Nov 2020 12:28:27 -0800 (PST)
MIME-Version: 1.0
References: <20201103153132.2717326-1-kpsingh@chromium.org>
 <20201103153132.2717326-3-kpsingh@chromium.org> <CAEf4Bza=80OMCBMLJJa5Vu1qokwzCtePcu4arruXUi8jHK8eWw@mail.gmail.com>
In-Reply-To: <CAEf4Bza=80OMCBMLJJa5Vu1qokwzCtePcu4arruXUi8jHK8eWw@mail.gmail.com>
From:   KP Singh <kpsingh@chromium.org>
Date:   Tue, 3 Nov 2020 21:28:16 +0100
Message-ID: <CACYkzJ4HC8vaNjbtC8r2n_-3jLyHYP5-_CAVCPXSsCdZAviepw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/8] libbpf: Add support for task local storage
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Jann Horn <jannh@google.com>, Hao Luo <haoluo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 3, 2020 at 8:28 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Tue, Nov 3, 2020 at 7:34 AM KP Singh <kpsingh@chromium.org> wrote:
> >
> > From: KP Singh <kpsingh@google.com>
> >
> > Signed-off-by: KP Singh <kpsingh@google.com>
> > ---
> >  tools/lib/bpf/libbpf_probes.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index 5482a9b7ae2d..bed00ca194f0 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
> > @@ -1,6 +1,7 @@
> >  // SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> >  /* Copyright (c) 2019 Netronome Systems, Inc. */
> >
> > +#include "linux/bpf.h"
>
> why "", not <>?

I need to disable this vscode feature where it tries to be oversmart
and adds includes. Fixed.

- KP

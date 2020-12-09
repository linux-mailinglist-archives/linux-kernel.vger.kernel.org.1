Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D32D3A02
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbgLIE7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 23:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbgLIE7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 23:59:21 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF88C0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 20:58:41 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id w13so1168672lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 20:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBU+e9OSHN03tEBuFDzMijCMQwPZkTjl7eLQDLYiRp4=;
        b=G7vkKJtO3pRwuncSuACCNx/qk9DuzS7aAXF8Y9Vir0gvCVajW6oaXVgWYTcpiVuxDT
         u1UpXH/ZOHzPmC+S68cNG/A+OogChxR2/b8Bf1Ef+gSPieL9uABVBcY6/PiAqb8u3J+h
         sRtjGlFHY6r8JWATLbfdX6C+Dr1wjDoOsi/58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBU+e9OSHN03tEBuFDzMijCMQwPZkTjl7eLQDLYiRp4=;
        b=NiJ52Byhd45CJmV5QCnXrWIIiVa0UHopjX9lccwQHpNHYTrROQaExJ8bUmrAULEb0i
         U95eG0JHw3RW5XerZKgtd33Py/kRIT9MFvwmmjoKCdgjQwIzvDiPT7QPcaj0GWkrJ9Hx
         D6rWH5IWX83BXiNOkCoI8H2QvdsBUQveZsoXhIVoocNnsU+ZfIwfR6HZ807db7+Af3XT
         5x7qKDavDjNlPzqIiQfK9S/6ncQkKGDHkNDFtWmIL5FhXMuMDqplX2XcIHWLjacs3ocJ
         Ct/ooAvfqTY97QNovtKmr/tSCmE5Y0BjZsc2azM7dNRlH4ERn78sob2ZdTchle1PKyv1
         mNdg==
X-Gm-Message-State: AOAM530f/CnDetD4GWf/8UbUX2jaZNEyipGSnWyC5JeNuZsBPYe/3IZk
        tJzXWVCo/53QKgEmLoH491u/nkKmUx0aqQ==
X-Google-Smtp-Source: ABdhPJyXc57Vv/7bq1KDiPXTBnths7VNyhQcqeYX+hDEk9IH82/s5pKI731ct0dBDxQ8W5XjdaljDw==
X-Received: by 2002:a19:ac0b:: with SMTP id g11mr395665lfc.661.1607489919225;
        Tue, 08 Dec 2020 20:58:39 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o3sm38385lfo.217.2020.12.08.20.58.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Dec 2020 20:58:37 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id y22so505325ljn.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 20:58:37 -0800 (PST)
X-Received: by 2002:a2e:9b13:: with SMTP id u19mr296752lji.48.1607489917095;
 Tue, 08 Dec 2020 20:58:37 -0800 (PST)
MIME-Version: 1.0
References: <20201209032155.564991-1-minchan@kernel.org>
In-Reply-To: <20201209032155.564991-1-minchan@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Dec 2020 20:58:20 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjWDchdE6sd+nwoGmybj96VFC8VOybCSrB7QOouPs+QvA@mail.gmail.com>
Message-ID: <CAHk-=wjWDchdE6sd+nwoGmybj96VFC8VOybCSrB7QOouPs+QvA@mail.gmail.com>
Subject: Re: [PATCH] mm/madvise: remove racy mm ownership check
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Christian Brauner <christian@brauner.io>,
        David Rientjes <rientjes@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Security Officers <security@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 8, 2020 at 7:22 PM Minchan Kim <minchan@kernel.org> wrote:
>
> Jann spotted the security hole due to race of mm ownership check.
> If the task is sharing the mm_struct but goes through execve()
> before mm_access(), it could skip process_madvise_behavior_valid
> check. That makes *any advice hint* to reach into the remote process.
>
> This patch removes the mm ownership check.

Applied directly - I'm not sure Andrew has anything else pending, so
might as well short-circuit it.

              Linus

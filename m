Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37169276324
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 23:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgIWVbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 17:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726265AbgIWVbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 17:31:06 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374CBC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:31:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id j2so1241065eds.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJHxje/HDno3CeRcQJWrHEYE5vhmzwobhZPN68xAP/4=;
        b=VA3dwzB/IRvGJdFParHV7gRb8Nf9qVfGzgAS5aUh+UCWZxgapIXJgoorgN5/pxAcl8
         jsFBTOQFs95M+/KvXGyqYjRvmBYcEgqdEleJ9SmY5uU3Kbr0dG8k3K5eKiVt4phN9HbJ
         NreO4VAgLH0fnPFmZZyux45tKbfFAadA0SAfI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJHxje/HDno3CeRcQJWrHEYE5vhmzwobhZPN68xAP/4=;
        b=n8Q5r4DSpSbq3dXpL0d+2GJSuisiRA4+8iLkIQQWOBhkTszuu4FyCiqkKc/+uAR5K3
         Rccg1cC6qZDLWf9lWsJIuXzJoPFimbqx9/8B1pud34ODKRG1ydXOlhnXiD18jaImnynu
         oUlC0OoqOCSsXUpq625/yedcsczK+S3fUR6CGBu95WlsD979z3xS3U4MTuNgnDJssrVN
         FfUydk1EWKaDHz41U0uQcu9DCzwJ7rGhRsiKigHX1vpqtZisaMRrZleyYD6qg3umNX2L
         tXQW2b5epfJd5EDtsEsk/h5X8HYjCE4SlrizR9nasnM49ofvUETNIyfA/LgA9oUTzb3j
         U/lA==
X-Gm-Message-State: AOAM530h/ADvBH6zfFOFul0hn+/kgZAMIzDf9PKgPFotzSUrEiXvFzmD
        Xe2vmZSaDf/+BRxULICOToWFaJSGa3wAHg==
X-Google-Smtp-Source: ABdhPJzBz+UzuJfOScRd/WUOQCCizW6c82SS9LUKvnYHf5kG2fEtymLJAykO8IUR2oosTS1MNvh0xA==
X-Received: by 2002:a50:fd19:: with SMTP id i25mr1404696eds.142.1600896664726;
        Wed, 23 Sep 2020 14:31:04 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id q12sm880490edj.19.2020.09.23.14.31.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2020 14:31:04 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id p9so1614433ejf.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 14:31:04 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr585986ljm.285.1600896257194;
 Wed, 23 Sep 2020 14:24:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200921211744.24758-1-peterx@redhat.com> <20200921211744.24758-4-peterx@redhat.com>
 <CAHk-=wh3G+OqehMdybQ++ikPMgd9BcydKJqkd6gRNuVz9TJG+w@mail.gmail.com>
In-Reply-To: <CAHk-=wh3G+OqehMdybQ++ikPMgd9BcydKJqkd6gRNuVz9TJG+w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Sep 2020 14:24:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjU-k5jDE62_VfWrT7EwiLnBtDOM7kdTQ7ALC2x_HBh3g@mail.gmail.com>
Message-ID: <CAHk-=wjU-k5jDE62_VfWrT7EwiLnBtDOM7kdTQ7ALC2x_HBh3g@mail.gmail.com>
Subject: Re: [PATCH 3/5] mm: Rework return value for copy_one_pte()
To:     Peter Xu <peterx@redhat.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrea Arcangeli <aarcange@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 23, 2020 at 10:16 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But these two patches are very intentionally meant to be just "this
> clearly changes NO semantics at all".

The more I look at these, the more I go "this is a cleanup
regardless", so I'll just keep thes in my tree as-is.

                 Linus

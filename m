Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE80F27ABBB
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 12:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgI1KW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 06:22:56 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:47191 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI1KWz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 06:22:55 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 8215c312
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Sep 2020 09:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=wTAhT9EYxTkHdUEgSfGeOhslmQ8=; b=lAblRJ
        I0VxgjLuhvHrMmvpKN/6dpPSVtG3oWVHQGKKCZzFG779KRafrpi5AB4vRvMrcsVz
        SlJwSS82Byw84Ewy4npsCvqIZk5h3tFrWUc1kwLUiWCvT0kT0o76w2hnY7stVwGh
        wr0lARQSXHVrh3/1/qXUBClb/K/1aa+I3UdBpspjx5sXGqSRXV/rQte1v27fP3he
        y8WMx7hmIA4chBGr/RXcxRfC8etKwCRTlXzHJKsd1euHQNYTiyCfOn6t1FxUDl5+
        9B4XsBK7Errr4y+9CHJ31d3L+xdynZjvO+woDImwuPO85Lqa2FyBRPaew/UUMagC
        InGEjzoGBoOQQvcw==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id b6122e2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 28 Sep 2020 09:51:27 +0000 (UTC)
Received: by mail-il1-f170.google.com with SMTP id l16so632947ilt.13
        for <linux-kernel@vger.kernel.org>; Mon, 28 Sep 2020 03:22:54 -0700 (PDT)
X-Gm-Message-State: AOAM530go60XBtXcVjspd8phi58iQ4TqjYXTGiyJRAo2Z0pFjjiw1LhC
        jjUXhEgcQEsFnhYLBv3AKVCFCo/73TDCeAaal4s=
X-Google-Smtp-Source: ABdhPJyZRzG1bbGT6XpASR1fpR2gx9TmJTgCyZ7QIBzrdzJrmTojXadzf89yA17ovlLpgM+2msLgC+ayvNRMnU0GABs=
X-Received: by 2002:a92:988c:: with SMTP id a12mr548508ill.38.1601288573296;
 Mon, 28 Sep 2020 03:22:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHmME9odvKzyAG7HgzSE-1gLOfiU=HL1MB5w4z=AwOsjz9WJPA@mail.gmail.com>
 <CAHmME9qPo_MNrVioY=qgOVNxYBVY1_i_eep5wzP-7Akq5fH1Xg@mail.gmail.com> <CAHmME9qBtUuOSEU3Cb9rL7SHaBAwk862VEPdmYcisnSHDERtvQ@mail.gmail.com>
In-Reply-To: <CAHmME9qBtUuOSEU3Cb9rL7SHaBAwk862VEPdmYcisnSHDERtvQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 28 Sep 2020 12:22:42 +0200
X-Gmail-Original-Message-ID: <CAHmME9ppPhLLtS4Vd5g-Yz9dZUUc7V_yjA8qOkYs4HsnGWtpcQ@mail.gmail.com>
Message-ID: <CAHmME9ppPhLLtS4Vd5g-Yz9dZUUc7V_yjA8qOkYs4HsnGWtpcQ@mail.gmail.com>
Subject: Re: 5.9-rc7 null ptr deref in __i915_gem_userptr_get_pages_worker
To:     Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     intel-gfx@lists.freedesktop.org,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, this is just a copy and paste error, when the code was originally
pasted from internal_get_user_pages_fast, which assumes a current.
I'll fix this up and send a patch shortly.

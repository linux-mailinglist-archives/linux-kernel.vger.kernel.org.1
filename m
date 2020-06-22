Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD73203E06
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 19:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgFVRch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 13:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729971AbgFVRcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:32:36 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795FFC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:36 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id k15so3097411lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZsJVwDrOxKrBzWWAsZN0Wz485qfczm0ojFoE3HuC8Y=;
        b=B97slECk7p+UApt7HEu2L46Awqn4jeXNqhBPxYKtyGhSPTh/Jb//7y7zBEyWqWevtW
         dLu6Fx/khrwGC8lHn/tYWNwJ80sqbHHvLODpaOthDRf94MI7UD5vDelpS1d7e8K+AN4Y
         OvGhfdZg2Y5xvmbRCoxIgStQPCgOasGuzQTvsk9WYHueX6/I5DLiLN7DpRfmRup6J2uf
         gHz0bN2X6saHrWIY+6Odwb9Sczp0L2zGJy7l800XdroTPsjy5Tqw5haIST4edmoy6qNB
         vmq48Z/I4HSgRZiS2eaXV6maEJlz0qtfrnuXhZB5bN2FvaE8tiTxPRKEMQ78FNo6fXD+
         pTkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZsJVwDrOxKrBzWWAsZN0Wz485qfczm0ojFoE3HuC8Y=;
        b=K9PkirkM/HJzJ9H58MyMnwCyROUnCbKJCGh1FO4Qp1Oq1fAXXXoXDgn5mAj83/aMfs
         0K6W8UJyCoj0Zv7Maze/+n9jM1Bv3B2ljhYl4ikOxQ5Fgt9zxpbHN5GSOFQiqavTuIYA
         rBeRsffpqdZLyWPHnElGb7f+BilgL+5AhAq52TH29siUpb7ewB9XY2mTdpuJdZuCQfG5
         5UzSKwUM4Erumq1TMpmE4u6PCmN3iZw1yFlyc3qlKvxIA9M0C3iEoPiKBnVLZKjLEFIE
         bm5iYkRWa5wGFaE961w6YU04ULJp5Z0YpqQFVyJE0qNhK4IGz84zKqeZITNb7ITn5Nvk
         Jbig==
X-Gm-Message-State: AOAM531ORLexdgS22Zj4vbEAEhW1ZBekSR0JjFz4Er2dWPXjW2l03BLy
        pAcI++4HluBlS70HplSIoIm96IyqAjGl4igyJBpIWA==
X-Google-Smtp-Source: ABdhPJx0uWPE+mHRbsfaQ2QHd0ZSFRs9zLnEbwP/Zl1FPpJTvIlUyLTOw+ivd5xB2DSTieKirftUU/0t2M1cu4jIdNw=
X-Received: by 2002:a19:4301:: with SMTP id q1mr10373314lfa.96.1592847154742;
 Mon, 22 Jun 2020 10:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-17-guro@fb.com>
In-Reply-To: <20200608230654.828134-17-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 10:32:23 -0700
Message-ID: <CALvZod76FnujSBu50CP_4T=k2P8BEA3aivvF5TyH7f901VKnqw@mail.gmail.com>
Subject: Re: [PATCH v6 16/19] mm: memcg/slab: remove redundant check in memcg_accumulate_slabinfo()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> memcg_accumulate_slabinfo() is never called with a non-root
> kmem_cache as a first argument, so the is_root_cache(s) check
> is redundant and can be removed without any functional change.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>

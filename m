Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC452A77E8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 08:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKEHWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 02:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgKEHWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 02:22:24 -0500
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8F1C0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 23:22:24 -0800 (PST)
Received: by mail-oi1-x243.google.com with SMTP id j7so693188oie.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 23:22:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WSZ3+zLaojBm8Llmv8mdwwh1sKAbO9V1JJ7VIGY5YaM=;
        b=iqd4cqhaOURh+RJCIK7wwSnQuhnxujTo2ztBt+aVcxykRvNrG9uuBde3XzAhI2pjP9
         OOE6bjCaG65Qow41L4PK7cMY5hA3m5pLHsAATuQziti/UZ0+bTHycJBzTs1WKnnc8giT
         tkB9OA/hvZS1dUUOu23LMJteVg7jYwg6J+RJ2kp/63ti20sl0YrPLjk0haMozMXNKVmb
         64oS4WIeHb6RrS6tGBtkbjyiyJUWaKycGNBbqPgg/xgAza+dbfnEvHcJaDQsqkpGWLLs
         6VgB5i9La8YVUm0i1paX5ZOAA2//pHVk34C21OIjBlBwfU8aA2aZhgSn9VPAQ3NkOpXw
         LyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WSZ3+zLaojBm8Llmv8mdwwh1sKAbO9V1JJ7VIGY5YaM=;
        b=IXwvdJR5yjylZUIUcigsKdxoCoL+QjmJ/fVfuhyPOzt8R0L8N2YwlYwVuhrSTNKoaH
         84q/C8qYfkT/eK5rLF4gJy9a71M/iI0eKiIL1d/zfVuCsDt8ounM7WUJdrMnzr/R7xmw
         VYxx94m9ZkbyUwqhL0JeuhxaZVd79bqEwPQE1MWgt7Pk4m/418dTF5b8UJgkPuGCPjlU
         TQljkBFGiVVln+EmtN72ttJ+cpxV+iJs1hgy9mnKaI57liVGGflKj3W0a3KJMDltPI5E
         7SGJbn7nethzkI5/FsN/PQOAEmqfvPtBsLoafcPcluiQc7N+c1R6UqBCk6+dstOL3v4l
         RDag==
X-Gm-Message-State: AOAM530ofI66r75Myfd7cw+UewYcWBq6SQMLg3Qv8Mx1zfaTnzm3Ct9G
        8p2I7JpyHKavd3Pri/Gu/XZW8r0B2qmiUi1wUdpIEQ==
X-Google-Smtp-Source: ABdhPJy0F5JCc98tp7QNjA610x1Eqz7f1L3ylLULpbwz+DrTYw2meMBgEMIwHINr6f0EPsTptlEuoAYI6lV5pfkWL5c=
X-Received: by 2002:aca:4b82:: with SMTP id y124mr750400oia.35.1604560943669;
 Wed, 04 Nov 2020 23:22:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1602838910.git.zong.li@sifive.com> <b10784643665ad56ca41ea6754c7f28f8be1c7ca.1602838910.git.zong.li@sifive.com>
 <160454434294.3965362.6100009498384462585@swboyd.mtv.corp.google.com>
In-Reply-To: <160454434294.3965362.6100009498384462585@swboyd.mtv.corp.google.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Thu, 5 Nov 2020 15:22:10 +0800
Message-ID: <CANXhq0qpEXejD765A5S5KfbuYQc=in5sFdEmk5K=BzZy2L=nmQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: sifive: Extract prci core to common base
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Albert Ou <aou@eecs.berkeley.edu>, linux-clk@vger.kernel.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Yash Shah <yash.shah@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 5, 2020 at 10:45 AM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Zong Li (2020-10-16 02:18:23)
> > Extract common core of prci driver to an independent file, it could
> > allow other chips to reuse it. Separate SoCs-dependent code 'fu540'
> > from prci core, then we can easily add 'fu740' later.
>
> Please indicate if there are any functional changes or this is just code
> movement.

There are some changes for common use, not just code movement or
copies, I would figure out the changes in the commit message  in the
next version.

>
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  drivers/clk/sifive/Makefile      |   2 +
> >  drivers/clk/sifive/fu540-prci.c  | 586 +------------------------------
> >  drivers/clk/sifive/fu540-prci.h  |  21 ++
> >  drivers/clk/sifive/sifive-prci.c | 409 +++++++++++++++++++++
> >  drivers/clk/sifive/sifive-prci.h | 201 +++++++++++
>
> How much of this is a copy/pastes? Can you generate patches with
> format-patch -M -C to try to find copies and renames?

I tried to add -M and -C option to find renames and copies, but it
doesn't detect anything here.

>
> >  5 files changed, 652 insertions(+), 567 deletions(-)
> >  create mode 100644 drivers/clk/sifive/fu540-prci.h
> >  create mode 100644 drivers/clk/sifive/sifive-prci.c
> >  create mode 100644 drivers/clk/sifive/sifive-prci.h
> >

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA872EB672
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 00:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727376AbhAEXpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 18:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbhAEXpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 18:45:46 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3553CC061793;
        Tue,  5 Jan 2021 15:45:06 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id h22so2620573lfu.2;
        Tue, 05 Jan 2021 15:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=X+lsGeGZVOdiCcuCKyqZkmsAaN7NfLED4MoSjrB0U1s=;
        b=kKOaGXJUdAEzBjhbtqV+bOMfPTBDrhqllrk1Rdx/EV28lEPligrl+K83MLWlzYL5/m
         4NSj7Kjr3YFzJ7OV/L+jbcesVQ7id9MoVyA+xgfGt1UtR0G7pxNLfGQVAYVPcK1U25xa
         TU9iSEQGZttY1BZlDuxhnsjDubQJ8bBPVMoKqLZ9lHXQSZzemiIVaexaWlhQp5eBunVa
         3XishtpIagh5xvHHLM5SpIw13QbD64t/TJvu5qzY4QNFa3C8p+WHCZv31y+LxFwTbpuv
         RM1Tebb7+L7Yt7gsK74hP2XVeYN2rUEwEIjuBBUocQ9W0vc7PD1wq79ocYQ0Bu8U+aSQ
         v87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=X+lsGeGZVOdiCcuCKyqZkmsAaN7NfLED4MoSjrB0U1s=;
        b=ayvi1cmx1QiY36S29OV1zljmWuZDEp8+plfl2kBt6OoeT6P/sbNo5cTk93qI/J48je
         6YZaRjtb93i/bJYUlG8wssUdWEAGxza0N3ctrWeUJaNBI9tjPXqIbdMp5pU3JkVtJCcV
         ofFtCxZfMKjlfTXNP7QHaYQiVG7PnVSy3buup6BgqQ5QnX/6OgqMsk6XbGPowAoLp1mQ
         kaIC02DPFhjMELjXo392SJa6pNcKXkzQ5TEq4nsAUBa/GmjxJdx5qjUxPCu4nAXPaYtD
         I7nbjvEsUEg6zbV/VZ5DfNIXEC0xhv4loI6M4u2ep1/ILtUoWa3TOVcLtYeurjeAQkJJ
         Ztig==
X-Gm-Message-State: AOAM531AmyIvmKGqCJQJnem1D6L/axm0gYMcF3fB1uwiNkFxBo4aQ8Gt
        K6z46qE8T4la1VjC3Zm8FrTiTSqeKSKg6DGaqs1ksTSsHcU=
X-Google-Smtp-Source: ABdhPJwhxJi7vZ0KT+rMAxScAM8Iih24dkkUHO+FNwsoEjZu/OE+MvgafQWdcMqEBFFJ7MIvyo92w1U2aUynnPy65UQ=
X-Received: by 2002:a2e:a593:: with SMTP id m19mr861832ljp.327.1609890304730;
 Tue, 05 Jan 2021 15:45:04 -0800 (PST)
MIME-Version: 1.0
References: <20210105041630.1393157-1-daeho43@gmail.com> <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
In-Reply-To: <dba4be04-70dd-d48b-391c-1f2355591097@web.de>
From:   Daeho Jeong <daeho43@gmail.com>
Date:   Wed, 6 Jan 2021 08:44:53 +0900
Message-ID: <CACOAw_xXPZm65BD0SAwFECyEMCD0i_g+7mKyd+=Gtm3p-W19og@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix null page reference in redirty_blocks
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Daeho Jeong <daehojeong@google.com>,
        linux-f2fs-devel@lists.sourceforge.net,
        kernel-janitors@vger.kernel.org,
        Colin Ian King <colin.king@canonical.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it~

Thanks,

2021=EB=85=84 1=EC=9B=94 5=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 9:06, Ma=
rkus Elfring <Markus.Elfring@web.de>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> > Fixed null page reference when find_lock_page() fails in
> > redirty_blocks().
>
> I suggest to choose an other imperative wording for this change descripti=
on.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/submitting-patches.rst?id=3D36bbbd0e234d817938bdc52121=
a0f5473b3e58f5#n89
>
>
> > v2: changed error value and break the loop when error occurs
>
> I propose to use a return statement instead of a break in the second if b=
ranch
> for this function implementation.
>
> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/D=
ocumentation/process/coding-style.rst?id=3D36bbbd0e234d817938bdc52121a0f547=
3b3e58f5#n481
>
> Regards,
> Markus
>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

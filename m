Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A822E69E6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 18:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbgL1R4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 12:56:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728572AbgL1R4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 12:56:34 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3877C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:55:53 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id g24so10437635edw.9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+KCAl2CiJbnbJJ52PbrJQ/sx9JxeAL7guGf+7oxxWo=;
        b=SofL8nKkdwHpUTZqSmG+FjeuPUI3sK2UYk9szGs+pH0VqD7zrQheFhFuHFrIKWE01r
         xkgDLG13Wm2CertOhQgX38s+1QN5uzSgba4+CSz+9G50RXdNkoawyRRx8IJUoddRUGzy
         hPT9zeaALKJOgOEkCP1/kG9VYGlwiNP6E6yfmuqb9ZLsoVjwoFNkohnkjPwauz6b3TCG
         6vOOds+5bNfyR59aL+9+CPIYwx01tk6Jb462t/nRA82eWQmj4rT7P0obHUrBb///Bypn
         t/rBexWAWhJ7vDVcikpjX2j1vwtCSSk4JEUkV2c3qavTvZs09pRnGakc6D9xMqm9Nlu9
         fjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+KCAl2CiJbnbJJ52PbrJQ/sx9JxeAL7guGf+7oxxWo=;
        b=SWVwOTyhJ9L7j8k96YtnoTW4hniBnJ79db59OeZzBu1OQL1KFPF66en3dgFQvcCuWE
         JLr7WUGj7odxemcG534upB4HGf0sAM2680uaVIbWYcEOS9UX+J6RL5uW8mIJPNzYc8Zq
         SlZIo46Xr+V5tOR6DsqFNxHTAD0OGyUtKrzd/+WzNzLCRR+AnvAtddN1jnzLQ6HQxP0J
         4BxTY+ayX+/sp0RlXy6gJivnPuDMNekdzh18c42DkeA4iIoHj09ogprMgUwDUd5Dt5vm
         cJvbBY0+Vivagl4GSCiHl98zF/JStSPUKoMxUh8Q8yWAqcBDeZ37FueDrz+3LD8K/rue
         I8Mg==
X-Gm-Message-State: AOAM531sJv1htTAOSA47B4eMm7neipEJhTrHLTiZV3h0+GVT5rIMST/9
        0quB7uQjgq2EFB25gI722RHhyTjv/t0ZaSxban6pMw==
X-Google-Smtp-Source: ABdhPJxZRieYuu1UvOB+0HgrAEay6rB7Y6ccKvUaTsZxc2/vZhs+56Rppur5BYqFKpXyVLcqf4P5kfm2Ik1KAasiSYA=
X-Received: by 2002:aa7:dacf:: with SMTP id x15mr42273859eds.134.1609178152762;
 Mon, 28 Dec 2020 09:55:52 -0800 (PST)
MIME-Version: 1.0
References: <1608762196-29871-1-git-send-email-tharvey@gateworks.com>
 <1608762196-29871-2-git-send-email-tharvey@gateworks.com> <CAGngYiXSyNXjxTHBVd13NfjexzZpOZb1dayWDWO7eV19xNr5wg@mail.gmail.com>
In-Reply-To: <CAGngYiXSyNXjxTHBVd13NfjexzZpOZb1dayWDWO7eV19xNr5wg@mail.gmail.com>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Mon, 28 Dec 2020 09:55:41 -0800
Message-ID: <CAJ+vNU3in8f1zchYj=X3LFY8P6G-_zTeOvCQ1u_rjp8+Bdmicw@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: imx8mm: Add Gateworks IMX8MM Development Kits
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     =?UTF-8?Q?Anders_R=C3=B8nningen?= <anders@ronningen.priv.no>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 24, 2020 at 7:34 AM Sven Van Asbroeck <thesven73@gmail.com> wrote:
>
> Tim, Anders,
>
> On Wed, Dec 23, 2020 at 5:45 PM Tim Harvey <tharvey@gateworks.com> wrote:
> >
> >  - 2x RJ45 GbE (IMX8MM FEC and LAN743x)
>
> I noticed that you are users of the LAN743x PCIe ethernet chip.
>
> On non-cache snooping architectures such as ARM, the receive performance of
> this chip's driver is about 1/3 of what it should be. I am currently preparing a
> patch set which boosts performance x3, but it's not trivial, so I am looking for
> LAN743X users who could help test the patch set - especially on arm64 or x86,
> architectures I have no access to.
>

Sven,

I'm happy to test your patches for lan743x.

Best regards,

Tim

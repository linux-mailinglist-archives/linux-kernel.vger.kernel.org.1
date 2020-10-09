Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1CFF288690
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbgJIKKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:10:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42105 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726357AbgJIKKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:10:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id 16so9623353oix.9
        for <linux-kernel@vger.kernel.org>; Fri, 09 Oct 2020 03:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXgTAeNLVRwrvbBQvZBKH0svcGPL7IUxdBe/H8dLzzA=;
        b=CpN3Ev1yuU52dFSAw9qNOyVUo1jOn31wCaLwes8QaXa1uWz3LSqlQ0SLVUVITGO9RG
         Zk+7kUv97Lx52bN3VuQZVOMDZBQa2epHVUHrpHoAg8E6rLUIkMuQLruxOezs8IfeVVG0
         VpMzCmZWO/e4N85b+asrWTW28O3jwx2c5gtR9wdxjhMqVqPjxh5u7/iuPFYu2RMdxuvZ
         yutuORFvK8dgYLqtBi3B2UjZdNd1DHQ41YvRKryY+2athbsoXYQaHBDHaigSwvb2Czl0
         d9ADWIyHbxXkVJ5JIADZheaEdB2yckAJZwfsUXqluQpcSGb/3QYm+YKz/PjwaTq25+Zz
         +w9w==
X-Gm-Message-State: AOAM531Q5d83/5cETOHbQfKyJy1cYq4xjbdChpKtf2QaXClGPQaLOcEC
        2/l1T2dqoZODOILP1a1GdMvUZwSXa6mwiMgsjgoPBGJ0
X-Google-Smtp-Source: ABdhPJzCiM2XmUWGqDX7CzY9RyUkC0BiX6GPjQTNsOIQ6Ki/UsmD18hb6kCuXY2SG1Dw7ubQLpxfUyUXadw8itY2Wco=
X-Received: by 2002:aca:4441:: with SMTP id r62mr1823303oia.153.1602238209569;
 Fri, 09 Oct 2020 03:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20201009095621.833192-1-laurent@vivier.eu>
In-Reply-To: <20201009095621.833192-1-laurent@vivier.eu>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 9 Oct 2020 12:09:58 +0200
Message-ID: <CAMuHMdXa=6xbSka9VYzwu1a1hDYufTcOCF=-Qdd9WGzU0vT4Gg@mail.gmail.com>
Subject: Re: [PATCH] m68k: remove unused mach_max_dma_address
To:     Laurent Vivier <laurent@vivier.eu>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Roman Zippel <zippel@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Philip Blundell <philb@gnu.org>,
        Joshua Thompson <funaho@jurai.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Sam Creasey <sammy@sammy.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 9, 2020 at 11:56 AM Laurent Vivier <laurent@vivier.eu> wrote:
> This information is unused since the discontinuous memory support
> has been introduced in 2007.
>
> Fixes: 12d810c1b8c2 ("m68k: discontinuous memory support")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.11 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

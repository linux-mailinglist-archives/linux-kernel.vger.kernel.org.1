Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E710A2CD2AC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 10:39:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388614AbgLCJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 04:37:09 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:23442 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388316AbgLCJhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 04:37:08 -0500
X-Greylist: delayed 71147 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Dec 2020 04:37:07 EST
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 0B39aFsh013571;
        Thu, 3 Dec 2020 18:36:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 0B39aFsh013571
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1606988176;
        bh=x8OvcNutt5onFObxwnHYLXR/nGNhZQWM3+7oyhZlPgk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M9EsR0/DdWqYebefZu63RfnltxRdf7Q53JgbpqhKTEPaQpIlJ8qq2bv2BtKvXDrPp
         9Pw0zsurlajLY44hFdqd6pY9lr+3kfCl2ZCyY96e/WhbdWCt1kRQ4QsSRYASghvAO1
         tB/NkiSzksmoXIRYZTV1kARciV3Ceo3ie2Tf6jnjjh4Ph8DSr1S6ofdkGmeI2MMP2G
         QEh1uh8u77X3T+5YrKHbNphBGhYDVxLFo/qGNSvy3MgzYKHIynoMRUnqSXea3ZimbJ
         3GdKlLnufXX4/gzgr83BmMjqpQ1I1SJodYwuhMIOoUWFipTs1G9QUdHUd7RuB6/prK
         pXSaZ0yT+3H4g==
X-Nifty-SrcIP: [209.85.214.177]
Received: by mail-pl1-f177.google.com with SMTP id bj5so834161plb.4;
        Thu, 03 Dec 2020 01:36:16 -0800 (PST)
X-Gm-Message-State: AOAM532LAT7ZSPLSkSB279DjnC4nYYR1RKRnD2/JlECQznZ3JiznCBiX
        8M4kgY10AqKWcZsBibUpSAFe5N/hp0zYDp0DyWg=
X-Google-Smtp-Source: ABdhPJzjV6Ook+YxcvOQmDYKJWFe+fPV8a/ozmjg9gCokwsVKGjwNd+FyJd9CUltEvQKzkJ1JkC0eS1XgqGAKJiVS4E=
X-Received: by 2002:a17:90a:5905:: with SMTP id k5mr2276786pji.198.1606988175303;
 Thu, 03 Dec 2020 01:36:15 -0800 (PST)
MIME-Version: 1.0
References: <20201202134929.99883-1-masahiroy@kernel.org> <202012021101.E0BAFC3B@keescook>
In-Reply-To: <202012021101.E0BAFC3B@keescook>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 3 Dec 2020 18:35:38 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
Message-ID: <CAK7LNAQxS2Zn3O4Q0Ca5KgoyEwW5_5DtPDZoXAH+dxbki7dmLg@mail.gmail.com>
Subject: Re: [PATCH] gcc-plugins: remove code for GCC versions older than 4.9
To:     Kees Cook <keescook@chromium.org>
Cc:     Emese Revfy <re.emese@gmail.com>, linux-hardening@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 3, 2020 at 4:01 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Dec 02, 2020 at 10:49:29PM +0900, Masahiro Yamada wrote:
> > Documentation/process/changes.rst says the minimal GCC version is 4.9.
> > Hence, BUILDING_GCC_VERSION is greater than or equal to 4009.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Acked-by: Kees Cook <keescook@chromium.org>
>
> Do you want to carry this in the kbuild tree, or would you like me to
> pick it up?
>
> Thanks!
>
> --
> Kees Cook


Please pick it up.
Thanks.

-- 
Best Regards
Masahiro Yamada

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CDD72AEDD9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgKKJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:33:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726011AbgKKJdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:33:47 -0500
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 076DA20756
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 09:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605087226;
        bh=E237N15UI1ysnqV/JxNmaeLL0fcS/FkbrJoOjVJ1psY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aFqME1+yN+KU2Nt9S6yZcEm52VyTjJ8wmdTtg3SrTtrl/eB/ywcNh4PeEy/49DnR3
         Iezir2EAtxu5Cj8aLqc1br7JjffWZ7L6HamYE3tVKqisnpoo1Xm4nk1M1vhINW5JZW
         8fwi/esP7Vfw/xBLf7Jqo+XFVMY+oOLjhEAxU/GE=
Received: by mail-ot1-f48.google.com with SMTP id a15so1550764otf.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Nov 2020 01:33:45 -0800 (PST)
X-Gm-Message-State: AOAM530svkOBhCAoxsMU5EI8mugF0QFckAWSpw4KXp1HVPx0fng0fbpY
        8k3HcZAodREQqOqPBiJbskCfGU8j2R/97ZNAuEw=
X-Google-Smtp-Source: ABdhPJxHhfffJss6qDNCrB9I8V47wTYNH5uSQtOjQSwA5P8Q0YnHiXAeer1/2N8UdzHqo7F1LPkN1sd9Y1i4jTL5e4o=
X-Received: by 2002:a9d:65d5:: with SMTP id z21mr15868652oth.251.1605087225231;
 Wed, 11 Nov 2020 01:33:45 -0800 (PST)
MIME-Version: 1.0
References: <bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch>
 <20201108064659.GD301837@kernel.org> <7782fb694a6b0c500e8f32ecf895b2bf@agner.ch>
 <20201110095806.GH301837@kernel.org> <CAK8P3a2MCdUbN0QSb+M3g5_6HjPsaQwtKxFjADMZWomdry4-Ww@mail.gmail.com>
 <20201110162155.GA4758@kernel.org>
In-Reply-To: <20201110162155.GA4758@kernel.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 11 Nov 2020 10:33:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
Message-ID: <CAK8P3a2vKOb_R3_tqO_XVCCn5Si2jFA5DRe_spB2-+gsoDhO6g@mail.gmail.com>
Subject: Re: [PATCH] mm/zsmalloc: include sparsemem.h for MAX_PHYSMEM_BITS
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Stefan Agner <stefan@agner.ch>, Minchan Kim <minchan@kernel.org>,
        ngupta@vflare.org,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        sjenning@linux.vnet.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Linux-MM <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 10, 2020 at 5:21 PM Mike Rapoport <rppt@kernel.org> wrote:
> On Tue, Nov 10, 2020 at 12:21:11PM +0100, Arnd Bergmann wrote:
> >
> > To be on the safe side, we could provoke a compile-time error
> > when CONFIG_PHYS_ADDR_T_64BIT is set on a 32-bit
> > architecture, but MAX_POSSIBLE_PHYSMEM_BITS is not set.
>
> Maybe compile time warning and a runtime error in zs_init() if 32 bit
> machine has memory above 4G?

If the fix is as easy as adding a single line in a header, I think a
compile-time
error makes it easier, no need to wait for someone to boot a broken
system before fixing it.

       Arnd

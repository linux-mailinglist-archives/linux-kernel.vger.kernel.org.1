Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0299A2D90BA
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Dec 2020 22:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406401AbgLMVUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Dec 2020 16:20:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729458AbgLMVTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Dec 2020 16:19:43 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9859C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 13:19:03 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id c7so13950244qke.1
        for <linux-kernel@vger.kernel.org>; Sun, 13 Dec 2020 13:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uEj5TwH+jF3Bmynj+wEm1bjYaLOAOMFYl4ta4y496EM=;
        b=AfGIlZvbJ2BFofpWgW6kU93wCMfNU4k4SB99E62zljL/B0LAUzE0g+1bIrPJrdv2ay
         ODytx+h70L6YPCip+7JHK4cHM7eVlOqxXajS2w0K40HR8ks9UMQOtDWdkIhkFwAkAHK7
         eztMnMpNqSy7Pq5zY58EaE6IH0KLGv7iGY5bVmU+LTrbFye98s+YNQVlgv7/7iCTfOt1
         FP4263xVw/6NCg4p6yC7HnmxM3m9gXwuB6GQYi43+GAOj3lq/NXu4WQ5u9TOO4dp5zx0
         Lx9/TvRRelj/x44UqK4gmauisSvamt2/ehKTHa2w7ukqqfOPDhfY+1XXzSAq+mkoU3qC
         FIlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uEj5TwH+jF3Bmynj+wEm1bjYaLOAOMFYl4ta4y496EM=;
        b=c5RhfOgp6sDdU/xgnwOoI4RU739LJVGInFPVtKaK9+qY8UB2/B1SmdZVJ9J2nav2LS
         ZQuW3Q7N5RRg15DG6MaPbTDD1E3K/F9t66iOsxmNFFGtZuILEernN5fZi8yI30HbKg+W
         i8ooEYOrdSBlHPfwp4g/tYvbQFnYWd72SbGMhjbSj9k2YW33xiEq2p+IHTRUHeeYgkMj
         ZwEivsXGw3MjWtrZClSZu9W5krJIRh8i4iaJ0A4t4EzGLtW42fGtxHJ6nBiQh6Ha2/z9
         jwEn0SkK1zx3FA48huB7wfHT4jbPscy+BrUzZeuf66SnoxOP1IYn4XS6cjdnZOsOCJ77
         iTgQ==
X-Gm-Message-State: AOAM533sFtfkLzarwJI7Z3a1CZfg/xaBoK4jjBuMk0+XEDJXa6kkTnP8
        pl9DmdbvCWADV1r82KpCl2yzJR7b8Lq/uns1RUg=
X-Google-Smtp-Source: ABdhPJzWsh4b/EyC3iBQvX8YGTuTc5ndVFQvGeALAJcrEDUTs9CsI+SfrWbGguyBK96TkTMJTZ0/+ntZxFGu3rD8MLE=
X-Received: by 2002:a05:620a:22ab:: with SMTP id p11mr29522537qkh.237.1607894342930;
 Sun, 13 Dec 2020 13:19:02 -0800 (PST)
MIME-Version: 1.0
References: <20201103115645.684-1-kechengsong@huawei.com> <20201211033139.15172-1-kechengsong@huawei.com>
In-Reply-To: <20201211033139.15172-1-kechengsong@huawei.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Sun, 13 Dec 2020 22:18:51 +0100
Message-ID: <CAFLxGvyjibfBHZi8Z1whxoLLJ7uQjKasKX1kzBwvVzvXoCXXaw@mail.gmail.com>
Subject: Re: [PATCH v2] mtd:ubi: Remove useless code in bytes_str_to_int
To:     Chengsong Ke <kechengsong@huawei.com>
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 11, 2020 at 4:38 AM Chengsong Ke <kechengsong@huawei.com> wrote:
> > I just send the v1 with the wrong module name 'ubifs'.
> > [PATCH] ubifs: Remove useless code in bytes_str_to_int
> >  :-)
> > Thanks,
> > //Chengsong Ke
> ping

Both patches are in my next tree and should appear soon on linux-next.
Thanks for your patience.

-- 
Thanks,
//richard

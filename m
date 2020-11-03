Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0612C2A3F3E
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 09:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgKCIqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 03:46:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbgKCIqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 03:46:22 -0500
Received: from smtp3-1.goneo.de (smtp3.goneo.de [IPv6:2001:1640:5::8:37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B083C0613D1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 00:46:21 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by smtp3.goneo.de (Postfix) with ESMTP id 46B6B23EEDD;
        Tue,  3 Nov 2020 09:46:18 +0100 (CET)
X-Virus-Scanned: by goneo
X-Spam-Flag: NO
X-Spam-Score: -2.945
X-Spam-Level: 
X-Spam-Status: No, score=-2.945 tagged_above=-999 tests=[ALL_TRUSTED=-1,
        AWL=-0.045, BAYES_00=-1.9] autolearn=ham
Received: from smtp3.goneo.de ([127.0.0.1])
        by localhost (smtp3.goneo.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9JuM-piM7XoZ; Tue,  3 Nov 2020 09:46:15 +0100 (CET)
Received: from lem-wkst-02.lemonage (hq.lemonage.de [87.138.178.34])
        by smtp3.goneo.de (Postfix) with ESMTPSA id 3FB7723F6C2;
        Tue,  3 Nov 2020 09:46:15 +0100 (CET)
Date:   Tue, 3 Nov 2020 09:46:10 +0100
From:   Lars Poeschel <poeschel@lemonage.de>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>
Subject: Re: [PATCH v5 02/25] auxdisplay: Introduce hd44780_common.[ch]
Message-ID: <20201103084610.oxfdp2665l7u3u6j@lem-wkst-02.lemonage>
References: <20201029095231.311083-1-poeschel@lemonage.de>
 <20201029095731.311528-1-poeschel@lemonage.de>
 <CANiq72nY2aXiTcG0=OJR4JNkY7qZU1dStfMHkbFoT5cekNRkvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72nY2aXiTcG0=OJR4JNkY7qZU1dStfMHkbFoT5cekNRkvA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 31, 2020 at 10:26:30AM +0100, Miguel Ojeda wrote:
> Hi Lars,
> 
> On Thu, Oct 29, 2020 at 10:57 AM <poeschel@lemonage.de> wrote:
> >
> > diff --git a/drivers/auxdisplay/Kconfig b/drivers/auxdisplay/Kconfig
> > index 81757eeded68..a56171d1a1ba 100644
> > --- a/drivers/auxdisplay/Kconfig
> > +++ b/drivers/auxdisplay/Kconfig
> > @@ -14,12 +14,31 @@ menuconfig AUXDISPLAY
> >
> >           If you say N, all options in this submenu will be skipped and disabled.
> >
> > +config CHARLCD
> > +       tristate "Character LCD core support" if COMPILE_TEST
> > +       help
> > +         This is the base system for character-based LCD displays.
> > +         It makes no sense to have this alone, you select your display driver
> > +         and if it needs the charlcd core, it will select it automatically.
> > +         This is some character LCD core interface that multiple drivers can
> > +         use.
> > +
> > +config HD44780_COMMON
> > +       tristate "Common functions for HD44780 (and compatibles) LCD displays" if COMPILE_TEST
> > +       help
> > +         This is a module with the common symbols for HD44780 (and compatibles)
> > +         displays. This is the code that multiple other modules use. It is not
> > +         useful alone. If you have some sort of HD44780 compatible display,
> > +         you very likely use this. It is selected automatically by selecting
> > +         your concrete display.
> > +
> >  if AUXDISPLAY
> >
> 
> These two should be after `if AUXDISPLAY`, no? I noticed the menu is
> broken when I went to compile test this (the options appear outside
> and the auxdisplay menu is empty). Perhaps you don't use menuconfig so
> you didn't see it?

I did see it and had a look and did not spot anything obvious (to me).
So I put this aside as "This is supposed to be this way."

> Sorry I missed this in previous iterations...

No need to be sorry. In the end it's my fault. I fix this.

Regards,
Lars

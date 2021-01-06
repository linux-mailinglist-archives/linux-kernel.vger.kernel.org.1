Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59A742EBC87
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 11:39:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbhAFKiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 05:38:16 -0500
Received: from tux.runtux.com ([176.9.82.136]:55426 "EHLO tux.runtux.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbhAFKiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 05:38:15 -0500
Received: from localhost (localhost [127.0.0.1])
        by tux.runtux.com (Postfix) with ESMTP id 6D3206EF93;
        Wed,  6 Jan 2021 11:37:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at tux.runtux.com
Received: from tux.runtux.com ([127.0.0.1])
        by localhost (tux2.runtux.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xqxNnamEXbMe; Wed,  6 Jan 2021 11:37:26 +0100 (CET)
Received: from bee.priv.zoo (62-99-217-90.static.upcbusiness.at [62.99.217.90])
        (Authenticated sender: postmaster@runtux.com)
        by tux.runtux.com (Postfix) with ESMTPSA id 61E166EEFF;
        Wed,  6 Jan 2021 11:37:26 +0100 (CET)
Received: by bee.priv.zoo (Postfix, from userid 1002)
        id 750A346C; Wed,  6 Jan 2021 11:37:25 +0100 (CET)
Date:   Wed, 6 Jan 2021 11:37:25 +0100
From:   Ralf Schlatterbeck <rsc@runtux.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Willy Tarreau <w@1wt.eu>, Lars Poeschel <poeschel@lemonage.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Subject: Re: [PATCH 1/2] auxdisplay: HD44780 connected to I2C via PCF8574
Message-ID: <20210106103725.vlqsmlxmqkjbyrzu@runtux.com>
References: <20210105150124.dvlochv3qrp4wpre@runtux.com>
 <20210105150400.j7hhxu5uextga5mz@runtux.com>
 <CANiq72mYUVvyJuv6pxeYvzQrOyRvp4Uy8AxF_WMDgQaKBndi-A@mail.gmail.com>
 <CAMuHMdXTNXmKacw47zBxG3YG_xcjMQrKS-4iy518wU+6dq9ahA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXTNXmKacw47zBxG3YG_xcjMQrKS-4iy518wU+6dq9ahA@mail.gmail.com>
X-ray:  beware
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miguel, Geert, thanks for the quick feedback.

On Wed, Jan 06, 2021 at 09:03:13AM +0100, Geert Uytterhoeven wrote:
> 
> Unless I'm missing some little detail, there should be no need for this
> driver: this wiring (and alternative wirings) can just be expressed in DT.
> Examples (using 74HC595 SPI GPIO expanders) can be found in my
> renesas-overlays branch:

Thanks for the examples.
I've tried this and it really works!
It feels somewhat slower (I'm using user-defined characters) but that
probably doesn't warrant its own driver.

So I'll contribute a documentation change that adds an example of how
to use the I2C-enabled version of the display, this may be non-obvious
to others. I'll start a new thread for this, stay tuned...

@Miguel: Thanks for your detailed feedback on coding style, I'll use
this next time ;-)

Ralf
-- 
Ralf Schlatterbeck                      Tel:   +43/2243/26465-16
Open Source Consulting                  www:   www.runtux.com
Reichergasse 131, A-3411 Weidling       email: office@runtux.com

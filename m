Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 244AD288753
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 12:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731328AbgJIKuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 06:50:18 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:45244 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725931AbgJIKuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 06:50:18 -0400
X-Greylist: delayed 67794 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 06:50:17 EDT
Received: from mxback24j.mail.yandex.net (mxback24j.mail.yandex.net [IPv6:2a02:6b8:0:1619::224])
        by forward104o.mail.yandex.net (Yandex) with ESMTP id 365F2941A69;
        Fri,  9 Oct 2020 13:50:15 +0300 (MSK)
Received: from myt5-ca5ec8faf378.qloud-c.yandex.net (myt5-ca5ec8faf378.qloud-c.yandex.net [2a02:6b8:c12:2514:0:640:ca5e:c8fa])
        by mxback24j.mail.yandex.net (mxback/Yandex) with ESMTP id okL3AxZNq0-oFkqon2q;
        Fri, 09 Oct 2020 13:50:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602240615;
        bh=CNch+vPnwA5gD9ynJvrV3P/4cnROJTStRNgK9v0tNtw=;
        h=Subject:From:To:Date:Message-ID;
        b=gJalr+F1mHNkX35ftppMt7Y8FIOPgKxwcvqGd1sBb5kmomfaTRseDiii7H1PV9dVq
         IA5IUvfw1/25tlK4OEYXelBLxh9ERp0ZUD7GiBkByL6N52wyZ+9szTPV2qtTt+xSER
         R2tPeT8WKJ4GdxItvnMe+A6fmOZv5Se3TZp7WHgk=
Authentication-Results: mxback24j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt5-ca5ec8faf378.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id r0yopRirzr-oEk4HRM1;
        Fri, 09 Oct 2020 13:50:14 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
To:     linux-fbdev@vger.kernel.org,
        Linux kernel <linux-kernel@vger.kernel.org>
From:   stsp <stsp2@yandex.ru>
Subject: drmfb console switching problems/questions
Message-ID: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
Date:   Fri, 9 Oct 2020 13:50:13 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I am trying to run my sdl1-based app
under linux kms framebuffer (amdgpudrmfb
in my case).
The app itself works perfectly, but
console switching is not.

If I switch the console while the app
is drawing, then it will corrupt the
VC I switched to. It will just draw on
top of the VC's content.
Question: is this expected? Is drm
framebuffer global, rather than per-vc?
If so, should I somehow freeze my
app when it is switched away? And
why would it be the case, with the
modern video cards that have multi
gigas of RAM on board?

If my app crashes without a clean
shutdown, then the framebuffer kinda
hangs. I can switch to other VCs but
I don't see their content. All I see is
the last drawing of my app. If I happen
to have an X server on some other VC,
then switching to it immediately unhangs
everything, and I can switch back.
In fact, even if I hit Ctrl-Alt-Del, then
fb immediately unhangs (by systemd
or plymouth or whoever else). But for
example SAK combo doesn't unhang.
So it seems to be very simple to hang
the framebuffer, and is quite difficult
to recover.
Question: is this an expected behaviour
or a drmfb bug?

Thanks!


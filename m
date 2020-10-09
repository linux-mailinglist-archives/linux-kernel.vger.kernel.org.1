Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E10E828887F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 14:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732791AbgJIMQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 08:16:40 -0400
Received: from forward101j.mail.yandex.net ([5.45.198.241]:35767 "EHLO
        forward101j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730726AbgJIMQk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 08:16:40 -0400
Received: from forward100q.mail.yandex.net (forward100q.mail.yandex.net [IPv6:2a02:6b8:c0e:4b:0:640:4012:bb97])
        by forward101j.mail.yandex.net (Yandex) with ESMTP id 18FCF1BE1BA7;
        Fri,  9 Oct 2020 15:16:37 +0300 (MSK)
Received: from mxback8q.mail.yandex.net (mxback8q.mail.yandex.net [IPv6:2a02:6b8:c0e:42:0:640:b38f:32ec])
        by forward100q.mail.yandex.net (Yandex) with ESMTP id 13B1A7080004;
        Fri,  9 Oct 2020 15:16:37 +0300 (MSK)
Received: from vla3-3dd1bd6927b2.qloud-c.yandex.net (vla3-3dd1bd6927b2.qloud-c.yandex.net [2a02:6b8:c15:350f:0:640:3dd1:bd69])
        by mxback8q.mail.yandex.net (mxback/Yandex) with ESMTP id r7DUHYblvr-GadGW3bS;
        Fri, 09 Oct 2020 15:16:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602245797;
        bh=WUtDIoR4iluD92A4YT4RWnCJ9f15qpCaPNrXb1hVUIY=;
        h=In-Reply-To:To:Subject:From:Date:References:Message-ID;
        b=eEWjC4eS2JvWh/ezlhmazTdv/1MfFkWjW6w+qoen1KTguwsnBc39qK7yAPCwjWCYJ
         V290RJiXYMUlwqZDUnh9M0G9+flJIVEpRPAv0X42TUdRDPuwHsPqXfQoQz0MunNvsc
         856bBh1OT0vraTkn7V1+oM2++ymWdrmtXOfsJJlk=
Authentication-Results: mxback8q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla3-3dd1bd6927b2.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id yGnkQcd4j8-GanqWC9S;
        Fri, 09 Oct 2020 15:16:36 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
From:   stsp <stsp2@yandex.ru>
Subject: Re: drmfb console switching problems/questions
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org,
        Linux kernel <linux-kernel@vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
Message-ID: <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
Date:   Fri, 9 Oct 2020 15:16:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.10.2020 14:59, Thomas Zimmermann пишет:
> Fbdev exposes the video ram (or a shadow buffer of it) to all
> applications. Only one can draw at the same time. It's a limitation of
> the design. To fix this, your application has to stop drawing when you
> switch consoles.
OK, thanks for info.
Quite a sad news, if you ask me.
Is there any ongoing work at solving that?

Anyway, the fact that fb can
permanently hang, is, I suppose,
another problem - the one that
can't be worked around in an app.
I suspect it is the result of sdl doing
ioctl(console_fd, KDSETMODE, KD_GRAPHICS);
After which, I think, redrawing on a
VC switch became disabled.
Would it make sense to improve SAK
to unfreeze from that? Otherwise its
too easy to hang the screen permanently,
and no way to recover.

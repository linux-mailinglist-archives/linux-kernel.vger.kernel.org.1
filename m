Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18BA62D57CD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:59:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgLJJ7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:59:38 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:59853 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgLJJ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:59:38 -0500
Received: from [192.168.1.155] ([95.117.52.229]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWiYo-1kcBmu2YCO-00X5bV; Thu, 10 Dec 2020 10:57:00 +0100
Subject: Re: [PATCH] drivers: usb: gadget: prefer pr_*() functions over raw
 printk()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>
Cc:     linux-kernel@vger.kernel.org, balbi@kernel.org, leoyang.li@nxp.com,
        linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <20201208144403.22097-1-info@metux.net>
 <X8+howyVRiTR9gv/@pendragon.ideasonboard.com>
 <9aaa06ad-0bd8-486d-b16b-66927d57cf96@metux.net>
 <X9C0vOLZOnLZoPR8@pendragon.ideasonboard.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <a454b90c-2888-7779-222b-ba642526495a@metux.net>
Date:   Thu, 10 Dec 2020 10:56:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <X9C0vOLZOnLZoPR8@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1tUVJHur9zX95g721i8+x6mG6wmouby4GJKEfF1tz4XFWPNrZ/7
 F/0YH1fgIF4zjb7qtk769Vi6cM6ZT1UpgNGxpgfJFc3Y8jNwzPj2TmcoXUq0af5R6PG7Cze
 3ww1YZu6Pn1HrVV0QNEF+0u5U+s59/S9tsVcs7TOCV4xAotexcMORVBjoQdls4A6O5RRf72
 sHzHjeee9qCCdyHhmKrzA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:Kb6OzIMvFl4=:rt/1WtbPXoLMRyWeiCU41R
 oPxy4MeGjWDuZZWU/5ZXBZTY6ShAijSpX2bD/Ce5B/T1hHtxc5aGtKWV5BIthsI2EFxkgcd5A
 D9XBLw1y/YfamZbgE2G3uVLSzOkBVQYKxK29Rogz/po6s3PeJCTL0smxPn/9PoMlpMD/teemQ
 i+arF87oYz+cjnLAyi9phGgZruYZpZd7MsAZVpvdzFd9OeP3SDNndUkOMTzuzssORdVJqEKS6
 sJ41mQMbo5p7cw0wFgRsMM/D5KlO3ogbvGQbVppmSB8AoZy+T/Nh+d+f92iFKm4EQTDm4snQm
 3YMzq0lWvy7YY1EZ371l455OoaBjObKUujxiYhNgkbm6e8ebxda9LYL2raObopumPmXYsx4GS
 jgwHEYPqEYjP8AeC1qxy9jnJxmayr4HHzCuxfduDaJ1MfB5efUX9CCuh+uRJH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.20 12:27, Laurent Pinchart wrote:

Hi,

>>> I wonder if this shouldn't be dropped instead, commented-out code isn't
>>> very useful.
>>
>> Indeed. Shall I send a separate patch for that ?
> 
> Yes, that would make sense.

Okay, I'm currently doing a more in-depth rework. I'll send another
patch queue later.

Since I don't own the corresponding devices, I can't do much testing
(just build tests and careful review), so I need some help w/ that.

> As most of the files touched by this patch are device drivers, dev_*()
> functions should be used instead of pr_*() where possible. I'd recommend
> a first patch that converts to dev_*(), and then a second patch that
> converts the remaining printk()s, if any, to pr_*() in the contexts
> where no struct device is available or can easily be made available.

I'm now splitting it into per-driver patches. They're getting a bit
bigger, since I'm also replacing some debug macros, etc. In some cases
I'm introducing new helpers for not having to write long expressions
to get the actual dev ptr, adding some prefixes (eg. per usb endpoint
logging, ...).


--mtx

-- 
---
Hinweis: unverschlüsselte E-Mails können leicht abgehört und manipuliert
werden ! Für eine vertrauliche Kommunikation senden Sie bitte ihren
GPG/PGP-Schlüssel zu.
---
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287

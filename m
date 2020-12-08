Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772642D27EA
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 10:42:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729018AbgLHJlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 04:41:03 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:38377 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726584AbgLHJlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 04:41:03 -0500
Received: from [192.168.1.155] ([95.117.39.192]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvJwN-1jvZBj1E2L-00rDGh; Tue, 08 Dec 2020 10:38:18 +0100
Subject: Re: Pass modules to Linux kernel without initrd
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
References: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <8aac3537-e84b-057d-94d8-0327261daaf8@metux.net>
Date:   Tue, 8 Dec 2020 10:38:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:f6ndVt5QD7gllhRB5CIJ1/rw1/p+1mzsCSVykyvECSBFUdLe/M2
 t8HwMZgxwcGliGuWUHdA1VE2vzcbghW1IZlJHjBsquAblwFpIGUS43Z+F9z4pjk/EPJ/JSc
 JwJITsvm53nZx9Xi2847d5Z8/WBJOEpzvqUgrMicJEByo377FQ/Li7R0wjdrDrZJvRQgDmT
 ZNN0zMdes6qv+7r1vWfng==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ymnzZM7htwQ=:3WW+WzHeJn60wk/8rjW6fv
 sfA0PFb5XAA+8ZT9OL+H9HCgmjyO61pUehF2wvkxFs49wm+KJocMbuqAX6aLzIT4rNkiE3zpq
 +uC3W0Sd33klB1l6khZw8yDgQGdhsXeqCrUCO07ZivI9IwKDcd5jHzo0Gla0V5dTRhTw+/HWf
 kSFqG3TFH+gYsyRMPqx7gWvIDSGY/xlMSXg3+thiqCnrT6kfwdOoNcu0PYs7R8j47PJo00Chs
 Z4KhrOwbgOL1phx960KhK6jUSdSn92x2rT1s4gIuA75jfxfLw7ubhC32xEIqUtsUvu7RATF8J
 VI45htDEkJopg2p61UGZn32pXnFwTcKMRhyXV2F93RelHZEIGLE9kyOnLN3z0PjdTFqcG6NLY
 1Zf6PNXDTtwSkBV3JxcerGKtgyrpxGNLqjRZ6YQd1yH7IVmPzceIr6xqR5Dqe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.20 10:24, Paul Menzel wrote:

> Similar to passing firmware and microcode update files to Linux or
> building these into the Linux kernel image, would it be possible to
> append the required modules to the Linux kernel image, and Linux would
> load these?

Indeed, yes it does. Just set the corresponding CONFIG_ symbols to 'y'
instead of 'm'. If you don't need to dynamically load any modules
(already have everything you need compiled-in), you can completely
disable module support via disabling CONFIG_MODULES.

For embedded systems, this is quite common. I'm also using it for
trimmed down virtualized workloads that don't ever need to dynamically
load modules.

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

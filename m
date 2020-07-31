Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E579234722
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Jul 2020 15:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731446AbgGaNrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Jul 2020 09:47:01 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:41901 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgGaNrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:47:01 -0400
Received: from [192.168.1.155] ([95.114.120.213]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MNLVU-1kQLlT1Ho2-00Oq7X; Fri, 31 Jul 2020 15:46:01 +0200
Subject: Re: [PATCH 1/1] platform/x86: revert pcengines-apuv2 wire up
 simswitch gpio as led
To:     Florian Eckert <fe@dev.tdt.de>, info@metux.net,
        vhart@infradead.org, andy@infradead.org,
        Eckert.Florian@googlemail.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200713085010.26394-1-fe@dev.tdt.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <6def788e-f2f8-da80-b189-56ae4630440f@metux.net>
Date:   Fri, 31 Jul 2020 15:45:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200713085010.26394-1-fe@dev.tdt.de>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gvQASfyCUdBJUlXB+j8gsge/Qsoqfw6HG2tgxqrlkG1x1JVZ9ua
 AbOYsJWe1+Vi13224V7IXa+3NIfzFfA72TRcGqx5BgudblxRmQDUhuvwI4+AoOqdysnOSog
 KED5MY2Q5Rn8xSqVq12VSGD9gBkkzCqDMoBlhgRQ2gywiN+AFSRIbK2f9gR2BT1+JjrOsxv
 qUpfl2+x9vSDoI5uECQQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:AjfJU2kW+VE=:sk/JXlCjo8h1jsPPXyG8or
 ViEbfNIypIzFFh6PXajXRjNbr+x0h7f0qu/coCWkZq2wF8rVQxpxRNtLN80SYjoUolsEVOxEc
 o+yMvMMXU0WHs4zE0sZtVnxCOlZmNJSr1BeQvE8878DW4Me5Eazo1HN4GCYkyfZjFqK5Y69CR
 gC/XXu/LxP9Di67oMDISJIm4PwKa27LDNWvnGRrB9DFDLG/ovw/nT7SbZ3SAJZvLgZlDSDuFv
 YxR8Dmxlr+ZZdC1DHSQWg9K9asbdyrREfKRkfFGqtgEggnr1vgw/rvYGdUL34/dOggAYnNr56
 Zpjb5UBR0eWF/JjjvqyPSzLWpMAAy1CsmqAXnTgC0IKgx7+pmFg2g0o2t1/cVvPXH4vJjXJd7
 48o4gN38AjGp+n7tkT7kHJUhefMJoX8vBjcnsW/VAms8jQxj/gSt92PReevx3UkOzfeqIBzw0
 fHvnXhBFIZdXDAgXYttzCtFrITk9U8+n2t/8ora3k95K9vH5jlIlUyhqi221jyK/EeFPEWHzK
 CA6QMgGYUFerq5v8qmKv79VVXWogDgzdlG3xxQxmSvxI6KJPRcIuNLnpyPl59ZpvUG/6JW4mK
 YX7US77H6XyQkEY99+9RdPBY9r3uURl+vmiDtUKySiDNmfaAFcczxg/LBkXcGWKXsU1bodvcS
 RwjE9NykMoDLFcNWwZoClzVS1ZMOAcTlj8awMlu0kRm2kYtPRnkVSL6JSxMw0yhglXquIgA7u
 6oM/5C+6BcayajvoSgPtOgYZ+ahnSv0vmXWonUfRSe3S57Q9MmU8WIC4E8yzDobJuEuiZ3C0r
 GU8ohq6d8tYk4p+ASY57twMBNPtTe7OQ/v3uTkkKdcqCXOFAuoHiHz7t874iYYT9o/I54sG
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.07.20 10:50, Florian Eckert wrote:

Hello Florian,

> This reverts commit 5037d4ddda31c2dbbb018109655f61054b1756dc.

no, please dont.

> This change connects the simswap to the LED subsystem of the kernel.
> From my point of view, it's nonsense. If we do it this way, then this
> can be switched relatively easily via the LED subsystem (trigger:
> none/default-on) and that is dangerous! If this is used, it would be
> unfavorable, since there is also another trigger (trigger:
> heartbeat/netdev).

I don't think that potential silly abuse is a good argument. It if
would, we should also disallow things like "echo FOO > /dev/sda" :p

The reason for it wire'ing up was having an simple and easy to use
interface. Raw gpios do NOT meet this criteria: complicated to use and
not stable addressing (from userland PoV) - would require an extra
userland program just for that single specific task.

Yes, LED is not the optimal approach, same for other gpio-connected
switches, eg. relais or various multiplexers. But as long as we don't
have a really fitting subsystem, it's IMHO the best compromise we have
so far.

Actually, I've already been hacking on a better subsystem, which models
switchable inter-device connections. It's called portmux. But it's not
usable yet. Lets talk about this instead of just wildly dropping
existing functionality, that's used in the field.


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

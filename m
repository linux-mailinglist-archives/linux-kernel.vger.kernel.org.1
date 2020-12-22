Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7F2E0F1D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 20:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726921AbgLVTx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 14:53:58 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:36251 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgLVTx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 14:53:57 -0500
Received: from [192.168.1.155] ([95.118.68.26]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MG9Xu-1kqjsd39oK-00GbOJ; Tue, 22 Dec 2020 20:51:15 +0100
Subject: Re: [PATCH v3] drivers: clk: make gpio-gated clock support optional
To:     Stephen Boyd <sboyd@kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel@vger.kernel.org
Cc:     mturquette@baylibre.com, matthias.bgg@gmail.com,
        linux-clk@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20201202123446.21902-1-info@metux.net>
 <160842266128.1580929.15786525540819499647@swboyd.mtv.corp.google.com>
 <160844222880.1580929.12780984836660049815@swboyd.mtv.corp.google.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <d98dff5f-5880-9ecf-b102-79ec64a11537@metux.net>
Date:   Tue, 22 Dec 2020 20:51:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <160844222880.1580929.12780984836660049815@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:g6HZ6qzFtmVXhWZbGpRPlXB6w4VSxc6zp0//8UzR9CPGvlhGagq
 YF7m3h3xt+rRpKRQZH3ME0SJBafNNhyN+MN8UDt/z2e5orDqWL8uxlmvQ25sJM45IfG06ua
 9rO7pzkR+cMwxF98WuOe6jVdFs1dWL0AXbEVr3Z31aByWwmjpceWT0MN+AhWemXCu/0qLXp
 OrZPU3w2vStxQ7WKS/DsA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SI6s/J81h8I=:DuVCewtS/SQfXUaPMapQZd
 oL1GhVuV71HDvs8uKKX3W+9IJC+oribbWSkVLne14ANICco2xQIZ97pDG6DK1h8yBQwV4fFWM
 uQvJn0/N66F52q8ebOiAL7gzc9zJ4XF7YGA8qFFaWOYrtwJe5YBd8SYeGPHJUWPvH/QAzR17c
 iq0DZBY7jvoQq9HGt2Mamm41VoT8+io/o1/1KMDe9jlegiQZOAahjqT6zzLxSWnNYxF2FBnYo
 IBV4Vnmljc7Fj2cZ1imCyJyQToPvyPbACm1hLVJKmCN66OqPeuhXwidLyxuEAtgvBpXlCNQcF
 rTEpvi35+5x4Ad1TwYxcRV/BZ53Z8kPjHr8ambA2xbV4XJuM2EKDxgJtmWU6LI9SC2ueV7vr/
 I/Z39sVlRiQS7u9lADvcNjCA1Y2rvaW931gGzY/V7jwpJWLdHvmvX6NujBFy6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.12.20 06:30, Stephen Boyd wrote:

> It looks like it needs to be a bool Kconfig to match how it used to be.
> A module would be interesting, but would require more changes
> presumably, like getting rid of builtin_platform_driver() and replacing
> it with module_platform_driver().

Okay, I'll rework it and post a v4.

thx.
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

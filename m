Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76A4C20B3CA
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 16:40:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgFZOkP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 26 Jun 2020 10:40:15 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:50197 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725792AbgFZOkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:40:14 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1Mq2vU-1j24eU2rnG-00n6WI for <linux-kernel@vger.kernel.org>; Fri, 26 Jun
 2020 16:40:12 +0200
Received: by mail-qv1-f52.google.com with SMTP id d12so4596215qvn.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 07:40:12 -0700 (PDT)
X-Gm-Message-State: AOAM530mwZoKHdK0xsfGvygMeqOu2T9TVCEDAKD8YqKsoH/CBt+zx680
        qjs3K0NuNGzJ9UkNWj4AaqhQDpRT9ZuIrn1tLRs=
X-Google-Smtp-Source: ABdhPJzWw7W5nerM6QkZ6Df85H2usVwLruFgbmVXNNAb7BqmaTdDnguwMQ+3GzI21ff5jnaqtPk82CDQvXjkhL30oLw=
X-Received: by 2002:a0c:ba0e:: with SMTP id w14mr3481578qvf.222.1593182411591;
 Fri, 26 Jun 2020 07:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200626130525.389469-1-lee.jones@linaro.org> <20200626130525.389469-9-lee.jones@linaro.org>
In-Reply-To: <20200626130525.389469-9-lee.jones@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 26 Jun 2020 16:39:55 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Pe9ToePzfRH2cwXVwtGMhw5Hy=y=TeknN93QmWnZmtQ@mail.gmail.com>
Message-ID: <CAK8P3a3Pe9ToePzfRH2cwXVwtGMhw5Hy=y=TeknN93QmWnZmtQ@mail.gmail.com>
Subject: Re: [PATCH 08/10] misc: cb710: sgbuf2: Add missing documentation for
 cb710_sg_dwiter_write_next_block()'s 'data' arg
To:     Lee Jones <lee.jones@linaro.org>
Cc:     gregkh <gregkh@linuxfoundation.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:S/fyCTWtqhcordAfyvl9VCW0r/xE93yoE27DJXD6DZKb9j0ffB+
 u8rwDlnKc4A+m0UzAFetfmA4mvIc9O412OIcb80byFZpjUBPbT++BCZwfwgVlD6Tn58Mp6n
 J76Gh8yH1EAiQuUXuHqLLeVrjzE9GOC+c6r/yDdgpzsnY9QPuYeVNpfS6sK2F+piXFsdGdN
 whkyBt1/DRX/WFE0bpQ5A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JeZ0GZAHmGU=:mLSv7pE6JAyA6G5njz6xIa
 Oxhxxq5XE0Ea+dzzAnE4aDeDO+A1WFWvrdHWSJ+Ql703x8kn+NuXwduPXapoNJhUA9SkoyDDc
 YFOj8IkaFiHrGlkt3lWd0BpWnLRv3IJAR8ttGTv52wCwmAPBq6iosB/PuFFX+TwQKxrOgbi97
 NB6jCiqzaJ5MIWmk7qKQxNqF8VqZ+9ZCzHHPfSi/lA+b+r/tysz7dkhV1XTQVJT59QrNGZRLU
 mMxZsr2iYdsO55PJg59Z0CVCr31E4+asXbAln2if15xQ27EytFhwo65hcALQzKfH0hBubmNLX
 CVxvCvs3e+E8TWNJINQTM49HBUmmIXH5UWl8FnBhyRG/VZcAozjIEKHqQB5rwy2NYdyagAA7M
 dD72TzI5X1Sf5u/O9dDMbFQrt/tE97Zdd9Zx1IXhaqOuyE1usTsxGSBDOCTRx5DpeQqmy4E0d
 u/E5a2v4MksZS9umHujYDbBZ1p1Xn756VtByUFezHvGVT6NKg5sMRwmja5e9Dp9LcTHLUtaNE
 BVbHureHMKfd1bosiCgm+ZAcbYH084HBFjYQd9iHnR4vNnB3fr/7o5wanMeFdlYUbcmOCFtKX
 gdtI7E3WGEw4BsKBYOvOdZIZMEDxYepgfeEFguKGJwlqo4U9f0cIoABNtgZQGoBKANSxFQENN
 fIhZKPt8uLolUIYhRb5n6uMfA7JWyJaL7xzmlg7TQANipEQXCEwjmxyGtB85f8maBoqLLqRqI
 F0b2nhqDjf+EAUZqpYMrj5HmkcFU9oVRbr26C3/S+BC9yrCbJhr0WgIi2XsbqBGj5SLT19Uks
 rVVPJQ5MWgPI/BRqawnCSZKzLfGCJII0FySR7OpbX8k2dZ+9ag=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 3:05 PM Lee Jones <lee.jones@linaro.org> wrote:
>
> An attempt was made to provide a proper kerneldoc header for
> cb710_sg_dwiter_write_next_block(), but a description for it's 'data'
> argument was missed.
>
> Squashes W=1 kernel build warning:
>
>  drivers/misc/cb710/sgbuf2.c:131: warning: Function parameter or member 'data' not described in 'cb710_sg_dwiter_write_next_block'
>
> Cc: "Michał Mirosław" <mirq-linux@rere.qmqm.pl>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 969F6271EFB
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 11:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbgIUJfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 05:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgIUJfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 05:35:22 -0400
Received: from smtp.ungleich.ch (smtp.ungleich.ch [IPv6:2a0a:e5c0:0:2:400:b3ff:fe39:7956])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F35C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 02:35:21 -0700 (PDT)
Received: from bridge.localdomain (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id 0B16A1FD81;
        Mon, 21 Sep 2020 11:35:16 +0200 (CEST)
Received: by bridge.localdomain (Postfix, from userid 1000)
        id 2DCF41A60327; Mon, 21 Sep 2020 11:35:30 +0200 (CEST)
References: <20200910112701.13853-1-linux@rasmusvillemoes.dk>
 <20200917065615.18843-1-linux@rasmusvillemoes.dk>
 <87pn6k384e.fsf@ungleich.ch>
 <73cb82c5-37fd-7fa3-5778-723337934a2b@rasmusvillemoes.dk>
User-agent: mu4e 1.4.13; emacs 27.1
From:   Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Nico Schottelius <nico-linuxsetlocalversion@schottelius.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Brian Norris <briannorris@chromium.org>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/setlocalversion: make git describe output
 more reliable
In-reply-to: <73cb82c5-37fd-7fa3-5778-723337934a2b@rasmusvillemoes.dk>
Date:   Mon, 21 Sep 2020 11:35:30 +0200
Message-ID: <874knrqxp9.fsf@ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Rasmus,

Rasmus Villemoes <linux@rasmusvillemoes.dk> writes:
>> So I suggest you introduce something on the line of:
>>
>> ...
>> num_chars=12
>> ...
>> --abbrev=$num_chars
>
> I considered that, but it becomes quite ugly since it needs to get into
> the awk script (as a 13, though perhaps we could get awk to do the +1, I
> don't really speak awk), where we'd then need to use " instead of ' and
> then escape the $ that are to be interpreted by awk and not the shell.

No need for that, awk can read (and use) environment variables...

> So I think it's more readable with hardcoding and comments explaining
> why they are there; should anyone ever want to change 12.

... so that in practice you only need to change 13 to var+1 and 12 to $var.

Cheers,

Nico


--
Modern, affordable, Swiss Virtual Machines. Visit www.datacenterlight.ch

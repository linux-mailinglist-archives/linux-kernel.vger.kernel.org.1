Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 814D12F1819
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388319AbhAKOYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:24:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26931 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388036AbhAKOYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:24:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610374962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gI8XHNu0lkd3sJIe8skJ03bmA6HUK+N9Xsm4VZa0VaE=;
        b=H5w0Jssfe0dlcxeRjSLmR9HOxAypiF9sT53nptMk/pCi7uNJogXvouMq7TZwm6Pr8Jlc6M
        hXwit46XOUq4PQn+2Xe0TmnbxXaH1LgXjenmf4jCshYmEy5600tgFYgYVFtjhL5WqhHXby
        BRRz1gr47qRVY55yMqGn8xiBvki3kiw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-285-umpc9rAtNXqUC3wIZ2CICA-1; Mon, 11 Jan 2021 09:22:37 -0500
X-MC-Unique: umpc9rAtNXqUC3wIZ2CICA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE147107AD3A;
        Mon, 11 Jan 2021 14:22:32 +0000 (UTC)
Received: from trippy.localdomain (ovpn-113-111.rdu2.redhat.com [10.10.113.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B5D555C224;
        Mon, 11 Jan 2021 14:22:25 +0000 (UTC)
Message-ID: <41dc7795afda9f776d8cd0d3075f776cf586e97c.camel@redhat.com>
Subject: Re: Old platforms: bring out your dead
From:   Mark Salter <msalter@redhat.com>
To:     Arnd Bergmann <arnd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Krzysztof Adamski <krzysztof.adamski@nokia.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        Baruch Siach <baruch@tkos.co.il>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Daniel Tang <dt.tangr@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jamie Iles <jamie@jamieiles.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jonas Jensen <jonas.jensen@gmail.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>, Alex Elder <elder@linaro.org>,
        Alexander Shiyan <shc_work@mail.ru>,
        Koen Vandeputte <koen.vandeputte@ncentric.com>,
        Hans Ulli Kroll <ulli.kroll@googlemail.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Mon, 11 Jan 2021 09:22:25 -0500
In-Reply-To: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
References: <CAK8P3a2VW8T+yYUG1pn1yR-5eU4jJXe1+M_ot6DAvfr2KyXCzQ@mail.gmail.com>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.2 (3.38.2-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-01-08 at 23:55 +0100, Arnd Bergmann wrote:
> * c6x: Added in 2011, this has seen very few updates since, but
>     Mark still Acks patches when they come. Like most other DSP platforms,
>     the model of running Linux on a DSP appears to have been obsoleted
>     by using Linux on ARM with on-chip DSP cores running bare-metal code.

Hi Arnd,

So this has been on my mind for a while now. I no longer have working hw
for c6x and TI hasn't been forthcoming with replacements. I'm totally fine
with removing it from mainline. In any case, I'm not really in a position
to go forward as maintainer.

Mark



Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88AD71DFD9B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 May 2020 10:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgEXIJO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 24 May 2020 04:09:14 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:46674 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgEXIJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 04:09:14 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3CEC861D8DF0;
        Sun, 24 May 2020 10:09:11 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id hjO1QG7WQrtF; Sun, 24 May 2020 10:09:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8DEEB6071A74;
        Sun, 24 May 2020 10:09:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ocJ1eMPe1I_U; Sun, 24 May 2020 10:09:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 64D2761D8DEE;
        Sun, 24 May 2020 10:09:08 +0200 (CEST)
Date:   Sun, 24 May 2020 10:09:08 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     syzbot <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        daniel baluta <daniel.baluta@nxp.com>,
        festevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel <kernel@pengutronix.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-imx <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux@rempel-privat.de, Miquel Raynal <miquel.raynal@bootlin.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        shawnguo <shawnguo@kernel.org>, syzkaller-bugs@googlegroups.com,
        Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <768166145.263589.1590307748272.JavaMail.zimbra@nod.at>
In-Reply-To: <000000000000861e3305a65e9d74@google.com>
References: <000000000000861e3305a65e9d74@google.com>
Subject: Re: KASAN: use-after-free Read in uif_close
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Topic: KASAN: use-after-free Read in uif_close
Thread-Index: IdpTiJPobSmrVYjHxyHltpNxiv96sg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "syzbot" <syzbot+0ce97ea45b008ba3b8bd@syzkaller.appspotmail.com>
> An: "Arnd Bergmann" <arnd@arndb.de>, "daniel baluta" <daniel.baluta@nxp.com>, "festevam" <festevam@gmail.com>, "Greg
> Kroah-Hartman" <gregkh@linuxfoundation.org>, "kernel" <kernel@pengutronix.de>, "linux-arm-kernel"
> <linux-arm-kernel@lists.infradead.org>, "linux-imx" <linux-imx@nxp.com>, "linux-kernel" <linux-kernel@vger.kernel.org>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, linux@rempel-privat.de, "Miquel Raynal" <miquel.raynal@bootlin.com>,
> "richard" <richard@nod.at>, "Sascha Hauer" <s.hauer@pengutronix.de>, "shawnguo" <shawnguo@kernel.org>,
> syzkaller-bugs@googlegroups.com, "Vignesh Raghavendra" <vigneshr@ti.com>
> Gesendet: Sonntag, 24. Mai 2020 08:03:03
> Betreff: Re: KASAN: use-after-free Read in uif_close

> syzbot has bisected this bug to:
> 
> commit 32ec783ae19d48084b893cc54747fed37b07eb0c
> Author: Arnd Bergmann <arnd@arndb.de>
> Date:   Wed Apr 8 19:02:57 2020 +0000
> 
>    firmware: imx: fix compile-testing

Hmm, from a quick check I don't see how this is related.
Arnd?

Thanks,
//richard

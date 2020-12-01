Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E149C2CA5DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 15:39:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391462AbgLAOiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 09:38:55 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.51]:27549 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbgLAOiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 09:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606833362;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=YO7T528IveKzgY+Fkp7j9zsngKTboM0z5a2l0Ge6wZc=;
        b=av2vphJfcjhSDoVIhWQ+VkU+U1IBJ3qlGSYJsecBzsCpxiS0plbrdJDW5kPG7S6HMo
        ylP7mgKd0DxBx9LNMpEHfMCkwnguXGN8IlnHFRR52AEl4xMHC7Z1XVEkGJ9ud0BF3naZ
        vAr53R3YnEmsbbIE9kSD/r6Y2Zi753kJjziDKJ7Zz/VbvbLYIPkttdYee/0K7mwVAaL9
        PM+lTCt4YosJDVsxYH/0/xY6V8ZSn1I4LmULcgV+tRQBylEeufWxWF2ue+XkrrFjTlUt
        ofq+TQNggN1Tw7bqTfU2aePOzP101F9smxqZr1quvjyYk29LjklknOoIDW7gWtPQgOPq
        +lDQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBp5hRw/qOxWRk4dCz0tZci65gKwSHSOzPCVVBaQfKyHICBNIH6DBKP"
X-RZG-CLASS-ID: mo00
Received: from [IPv6:2001:16b8:26a9:5c00:580e:6fc8:ca54:f161]
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id N02faawB1EZxUmX
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Tue, 1 Dec 2020 15:35:59 +0100 (CET)
Subject: Re: [BUG] SPI broken for SPI based panel drivers
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
Date:   Tue, 1 Dec 2020 15:35:58 +0100
Cc:     Mark Brown <broonie@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Discussions about the Letux Kernel 
        <letux-kernel@openphoenux.org>
Content-Transfer-Encoding: 7bit
Message-Id: <6283C16F-549C-4463-BC08-E2C1A1D78B2F@goldelico.com>
References: <2D7916FA-678F-4236-B478-C953CADF2FFA@goldelico.com> <CAGngYiXgc_m2A7Wihxuhzm-u4qH-JZgxHjke653zvyT45jMU7Q@mail.gmail.com> <4AC29229-9542-4E77-B993-217E29C7E209@goldelico.com> <20201201121620.GB5239@sirena.org.uk> <A499CCB9-F2EC-4F24-AA79-5A7FA6A092A9@goldelico.com> <CACRpkdYf2dUF6PjYcvnsKDPoxXPWiWKKAqpik4-2AAQjRmatfw@mail.gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

> Am 01.12.2020 um 15:20 schrieb Linus Walleij <linus.walleij@linaro.org>:
> 
> Hi Nikolaus, Sven,
> 
> the fault that the thing broke in the first place is all mine.
> Credit where credit is due!
> 
> The reason why I shoot in the dark to convert all SPI
> drivers to use GPIO descriptors instead of the global
> GPIO numberspace is detailed in drivers/gpio/TODO
> so I will not repeat it here.
> 
> I don't know if much can be done about it other than
> having better programmers than me at the task. Or
> less tired when they write the patch. etc.
> 
> What other operating systems do to get around the same
> type of refactoring problem is to aggressively
> deprecate and delete code that does not follow the
> latest ideas of the driver subsystem developer. This
> is not an option on Linux because we don't like to leave
> working hardware and users behind so I am painstakingly
> fixing it all over the place, with a little help from my
> friends. Sometimes it blows up in my face, sometimes
> in other people faces too, sorry about that.

Everyone has such a patch written at the wrong time of the day...
See for example: f069b5a0b27a

Let's work on a fix for the fix now.

BR and thanks,
Nikolaus


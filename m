Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1137E2A5F3D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 09:18:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbgKDISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 03:18:15 -0500
Received: from mout.web.de ([212.227.15.3]:44329 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726564AbgKDISJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 03:18:09 -0500
X-Greylist: delayed 305 seconds by postgrey-1.27 at vger.kernel.org; Wed, 04 Nov 2020 03:18:08 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1604477887;
        bh=35ZhIxsCOOsP7usUajFw1qevtlDipe69Xji1H0wl7zU=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=GuXJu21NgNZIxiNpo630uPOCUNT1Hd88EJLLCRMGZzGjC7iFWaBRLt7XPwachQvr1
         7RB25MxOKHF13TiOxBPZsQq0QOX+YW9U3My6OXPOsjBwMs+AwGz5bzMF37uE9HZ94o
         V7Jxhe+LElyCN+DLmnrhVDNi6KNfasFhXO6VXcOk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.0.0.110] ([193.36.117.236]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfYoV-1ky6SJ2y67-00P4yr; Wed, 04
 Nov 2020 09:12:56 +0100
To:     Nick Dyer <nick.dyer@itdev.co.uk>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        "George G. Davis" <george_davis@mentor.com>,
        Jiada Wang <jiada_wang@mentor.com>,
        linux-kernel@vger.kernel.org
From:   Andre <andre.muller@web.de>
Subject: [Regression]: Commit 74d905d2 breaks the touchpad and touchscreen of
 Google Chromebook "samus"
Message-ID: <735253bd-5500-2b8d-c98d-99bddb0617ce@web.de>
Date:   Wed, 4 Nov 2020 09:13:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:djnkFNgU7pE8pyOXpKcpggw04y3BlhsBJuUZ1Jt4gcu0sj+35f1
 19LpS394tXb0zFdF8SoJG4FsGwD6eA8OCt402XFxJPlCJIh5AQEWv1qZod0FzCzXSe/QIlO
 CkeSehgsKiettowMvnXoePdP/p6rHJDEHkz+h0bh1ES2UG4bfMGkpYgef+NBokzqX7HvoVN
 Go80dUay5LvB7hIAoGY3g==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9zinPyvhoPo=:05kPGR6M2hfYUj7YnThg+f
 V7G0u5cpHDG+v5lM8Vz8N3Udcua4pVtTXqPJ7ecBSC9zeglDvBD0h4ZGqjMmG7UrprB6nj6ON
 2Qob4J5tBExRzP1UjGFwyXaVAzEWl62QsW7W8o87SQqvxnHsvgxvdcCHvy6HpoLesJiX2/70T
 aMiK9yTyFwbMeCVm1YUvlbrNDEjrbgXfeZV1ed9f4QQTVj+Ry5H4UDtXEUjrMAR+1yq4F103s
 wXSWQ0zrwLpDQFzuU6qepcQ8ISCeSEAwp7WDx0bh7lA4enPyPiGOdlgmR7ewMaxSUaZFLFWF3
 fXe6gHs0693TgAShjE03PPHr/EoPwiYqLgRckbpE2UA5QWxGqQwYgTe5kO1UOKi2FGrmVC56/
 C8WwAYNUjIX/iPlV6MoonCo718FrimXXg/FoDaYxwjIXopCdz/KjN8nZ6Xy86QJRGmle/Gw5n
 i1LyoNDzL5SLKUenHw30375i5SOrlEAYozb7rIwiep665REqiab+JBBkLRr6q180E5sFkab+t
 gRyACKodmto3sA3A0wXTonKJsID9Pn+MwrctjZT2KjRNYSeJpWFhA8ro4C8VenQGXdvfW6P3a
 Nq+ecRmNO0YzdzB18SyXUPum87FYfbAF05niOEyZvFlrZWLr5sRPxuLcQSPjmB8kiL7GmieVq
 LJ2ByvgUdx1yGK+HgdBo7uwV6mnJ/nvPGvUxsNSjcrmzVDTXAkhYUhmtPPVUVuH/lf9sP79x0
 Rl76KRU71pGkrm8Lf7qUUDZ6VCEFlhpHO12yfX3X+e5+5yBIq5zZKTiGYwolDv8PT2FlWzF5R
 OzG61sSIqKlw3NYNR7+6s6FTrwwYSQg44KHU+uRyqTboCuVx6s7rzbsP1heQNc9Mr+YR0sa2H
 N94m/uj6RjarYJd7MtQg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

commit 74d905d2: Input: atmel_mxt_ts - only read messages in
mxt_acquire_irq() when necessary

breaks the touchpad and touchscreen of the 2015 Chromebook Pixel "Samus".

Reverting the commit from the current git tree gets them to work again.

I am not at all shure what info to include, but I will happily provide
it on request.

The dmesgs of a boot with commit 74d905d2 show "Enabling RETRIGEN
workaround", but otherwise looks the same as a boot without.

Here is the relevant bit (with 74d905d2):

atmel_mxt_ts i2c-ATML0000:01: Family: 164 Variant: 17 Firmware V1.0.AA
Objects: 32
atmel_mxt_ts i2c-ATML0000:01: Enabling RETRIGEN workaround
atmel_mxt_ts i2c-ATML0000:01: Direct firmware load for maxtouch.cfg
failed with error -2
atmel_mxt_ts i2c-ATML0000:01: Touchscreen size X960Y540
input: Atmel maXTouch Touchpad as
/devices/pci0000:00/INT3432:00/i2c-0/i2c-ATML0000:01/input/input4
atmel_mxt_ts i2c-ATML0001:01: Family: 164 Variant: 13 Firmware V1.0.AA
Objects: 41
atmel_mxt_ts i2c-ATML0001:01: Enabling RETRIGEN workaround
atmel_mxt_ts i2c-ATML0001:01: Direct firmware load for maxtouch.cfg
failed with error -2

Thank you,
Andre M=FCller

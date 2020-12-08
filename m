Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25992D2BCC
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 14:22:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgLHNWR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 08:22:17 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:38507 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgLHNWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 08:22:16 -0500
Received: from [192.168.1.155] ([95.117.39.192]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MDyoU-1kuHrq2lIS-009vG1; Tue, 08 Dec 2020 14:19:38 +0100
Subject: Re: Pass modules to Linux kernel without initrd
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Ben Hutchings <ben@decadent.org.uk>
References: <6fbaf375-389d-6581-55a1-78bbe2852e2d@molgen.mpg.de>
 <8aac3537-e84b-057d-94d8-0327261daaf8@metux.net>
 <2f67eee5-b613-43ef-7790-7f29f203c808@molgen.mpg.de>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Message-ID: <b2596c89-fd4b-c7d4-7420-2bcc87ac1eb0@metux.net>
Date:   Tue, 8 Dec 2020 14:19:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <2f67eee5-b613-43ef-7790-7f29f203c808@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8
Content-Language: tl
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:tRmgtKKoMj3xY5u0SrXpaEWeF8+0i8inAgYi5k8hWom3EtHR9Zy
 h6zCaU9wqwu68IrQgkpgdyEQoImy/ukKbFBaqckXsbao/pocG0TmBKKFHruveHwn9wIakpF
 uJB9XU1tqapbu/9IacKUGPTQXaDsjtud74lQnr/KODDUFyGu9BOW2vgnmnpuceoOZN/ssiT
 UVlAPFLHdm5qlqumG6jkw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JClE20M7Jp4=:j/L9TR2atU62Oa5Lk9MAE5
 Jztf6us3RTzrJi0DsRufv/Tdy2ghZYiPceplkNnnKdqCTqiAslDrATyLgqeVW3GtIdz86QBis
 N5rCtCK9k/KKV9UV1yfv5jtvb9yA2XM1OeWUTsvcgDTJTC1gXSqN2QBixioS98hDXsTAGqUAm
 8nAR5v3yuN17eb3Ika2QuvuxIPMIyKJ0HOmGsR5F3sj4UZJlS//JzbTw0V0d1897B2sF/Onbh
 6ikpQd7Q7Y/+mQMgC7Pa2MAeTDSKp29cCxYCie1aWB8qK52Ck+j+hrghTC2yg1LV6RGCYv+eh
 KHstBXtfWiN8HCU1c81gpY0AXnELAuoOpecYeVuHeNiRQzcZLbmLYCqJQfr6sgkeHOuKisBZh
 orjoHaaFGlvDQ+l8qF9gkZk1oHoNR8750m2hjqd6duj6cJsENytrzXyEDUnnC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.12.20 11:58, Paul Menzel wrote:

> Thank you. I know this and do it myself. But, the requirement is to use
> the distribution Linux kernel (package). I am sorry for being unclear.

What about rebuilding the distro package ?

Actually, I wonder why using a generic (bloated) full-blown distro
when resources are that scarce.


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

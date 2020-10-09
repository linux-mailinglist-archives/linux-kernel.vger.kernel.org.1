Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF7452889B4
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 15:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388446AbgJINYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 09:24:47 -0400
Received: from forward105p.mail.yandex.net ([77.88.28.108]:46921 "EHLO
        forward105p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388407AbgJINYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 09:24:47 -0400
X-Greylist: delayed 314 seconds by postgrey-1.27 at vger.kernel.org; Fri, 09 Oct 2020 09:24:45 EDT
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward105p.mail.yandex.net (Yandex) with ESMTP id D2E2E4D414BF;
        Fri,  9 Oct 2020 16:19:23 +0300 (MSK)
Received: from sas1-27140bb19246.qloud-c.yandex.net (sas1-27140bb19246.qloud-c.yandex.net [2a02:6b8:c08:1803:0:640:2714:bb1])
        by mxback14j.mail.yandex.net (mxback/Yandex) with ESMTP id b8XHafhg4m-JNkS8apT;
        Fri, 09 Oct 2020 16:19:23 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602249563;
        bh=zB0GvwffsX4+2scJZ6ePH9toGt+lVivOsqSXrlJ/y/E=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=HtpHNOojIxiqahjm7UWAUreoiWet91/Cmmkwls6+Pu30YGVovrkYLHeR/LzkN2y/K
         nrJMRFsibbYbZFLOD692zyC0aB/fDge1zDlIp6DDNE65+bnb5XDg6gGkwn+76Quz4f
         tZPkVF/NtCJm+2wQArP2XlrIChHQ6LXrI6inGxhs=
Authentication-Results: mxback14j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by sas1-27140bb19246.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 2R0q1w1tUv-JNm8hc9H;
        Fri, 09 Oct 2020 16:19:23 +0300
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client certificate not present)
Subject: Re: drmfb console switching problems/questions
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org,
        Linux kernel <linux-kernel@vger.kernel.org>
References: <17980f58-c2d2-ac58-88ce-e21b5a56da39@yandex.ru>
 <df4d1918-dcb1-4951-6280-f178ecbbfc2f@suse.de>
 <70ce31ca-5922-584c-8631-3853c488f3c7@yandex.ru>
 <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
From:   stsp <stsp2@yandex.ru>
Message-ID: <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
Date:   Fri, 9 Oct 2020 16:19:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <e2118f89-2c55-ec12-1e33-f2ba418af914@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.10.2020 15:58, Thomas Zimmermann пишет:
> Hi
>
> Am 09.10.20 um 14:16 schrieb stsp:
>> 09.10.2020 14:59, Thomas Zimmermann пишет:
>>> Fbdev exposes the video ram (or a shadow buffer of it) to all
>>> applications. Only one can draw at the same time. It's a limitation of
>>> the design. To fix this, your application has to stop drawing when you
>>> switch consoles.
>> OK, thanks for info.
>> Quite a sad news, if you ask me.
>> Is there any ongoing work at solving that?
> I don't think so. Both, SDL1 and fbdev, are pretty much dead these days.
> The solution to fbdev is DRM, which does not have these problems.
>
> You could your application under X11 to use SDL's X backend. X would do
> all the VC handling then.
That of course works.
I was trying w/o X.
Do you think it is possible for
me to test other techniques of
drawing under kms console?
Or fbcon and X are all that we
have?

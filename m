Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F234288A7C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732391AbgJIOOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:14:47 -0400
Received: from forward101p.mail.yandex.net ([77.88.28.101]:49173 "EHLO
        forward101p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726471AbgJIOOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:14:47 -0400
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward101p.mail.yandex.net (Yandex) with ESMTP id AC43226448F3;
        Fri,  9 Oct 2020 17:14:44 +0300 (MSK)
Received: from iva1-bc1861525829.qloud-c.yandex.net (iva1-bc1861525829.qloud-c.yandex.net [2a02:6b8:c0c:a0e:0:640:bc18:6152])
        by mxback10g.mail.yandex.net (mxback/Yandex) with ESMTP id C5mD5bxPqh-EiWW1dRw;
        Fri, 09 Oct 2020 17:14:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1602252884;
        bh=4IQ2UZqrxX06X24xfc0QT/4vwxH62r4bVpdGWVMTZd8=;
        h=In-Reply-To:From:Date:References:To:Subject:Message-ID;
        b=pEgnJQLS9BDCjQlqqh5+Jw1h4zcGZG02vaHgSDpXQMt8N+f5X91ty7VSUiyUTtggT
         MLpS5nLZF6SN/L1Uv41nMrYmF7g1WRf/S0fOH8ppMxdqWdHErxApAf1WSJrU2SSXma
         DEX8D4I0EHQPoC0/9dN3jhtrVvPU8A2UxfZLjBok=
Authentication-Results: mxback10g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva1-bc1861525829.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id 7JDfKQrgBy-Eim4k5Fq;
        Fri, 09 Oct 2020 17:14:44 +0300
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
 <cacba527-fe32-e80c-4659-799452741791@yandex.ru>
 <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
From:   stsp <stsp2@yandex.ru>
Message-ID: <e3f40930-6927-042f-7857-e843e1e24236@yandex.ru>
Date:   Fri, 9 Oct 2020 17:14:42 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <050632f0-6440-1254-2aed-931dd515ff37@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

09.10.2020 16:31, Thomas Zimmermann пишет:
> I can't say for sure. IIRC SDL2 can use DRM directly.
Yes, that was a great hint indeed,
thanks. It didn't work for me in the past
(a year ago or so), so I added SDL1
support. But now I re-tried, and it indeed
works!
And, as far as I can tell, the hanging
behaviour does not happen, at least
not that simple.
Thank you.

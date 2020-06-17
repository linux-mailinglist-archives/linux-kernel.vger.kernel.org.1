Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF26C1FD62B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 22:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgFQUkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 16:40:21 -0400
Received: from mout.web.de ([212.227.15.4]:54897 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726861AbgFQUkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592426417;
        bh=UiiAvBpuUiRO3x5HnYiUAemg9bMmkz1vZ3gs/FDgu2E=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=bu9G4Z7bN6cQc4OMBQjIRcU1M1O49MKhCTXwN+YAJDoVR6HGrNp6WeZDCW3hxzaOl
         ulG0e0l/rApmOpBQ/UWercNmNaJfLu7ggD12vT1p2Q+xqTe+dFawIOZY7hocnCCPpF
         0bXAcSYfBY/JGll3GD6pJRDSVTXDJLKq/NM3ej4k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.115.66]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N0qv3-1j0gKq1rrp-00wjec; Wed, 17
 Jun 2020 22:40:17 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] coccinelle: api: add device_attr_show script
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <5b125cc2-b958-89b7-22d5-a5880be680bf@web.de>
Date:   Wed, 17 Jun 2020 22:40:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:gx1RAok07w7bQHIqS4c5wM9jxqgyYDKUxRJyW/l2spBDXvabvbG
 rLSty7kkTgis5YBkrS9Q3nofVgCApatQyjLnp1DIMRHv8BjXEe2XKguunEHFGZi3dcyAzDt
 YLJSZhmBFeSJAFMO9DN0RMTRFcvRM7fdQAsBk3tmuVHWeYu+H+81ZM7yRfHOL4hMs7JF3y8
 SyKztddayLghkjt4V+9Pw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PjIWVHw8k+Q=:lcK76di10R9wVem3+JeVVl
 Ed3y0nIvMI7Q9wXIIKDn5s55KGCeGtWn94RUHIHC73hT0aZa4dEGC5nMvhW2CZCEXjQ7cziL7
 utGvHv2OBB7uaplcHCwpURK/0vsPfuMu13av41i2sWbE63sqWvpBF6jVRX/eDmqcpmXxOiZHD
 T93yugD8NKSk5KNyzAoQTtEfzeSEsP0ztZ0vOPrEFzp39QKbwbm8R5YuaChM0VJ0I2IG+4unt
 +ybBVLMOcX3QMLCHSXcUgiAG5eqYvXH52RdJwHOu0qHTDvUSTVJv6SY5dW6nDboX5oaEEjXUk
 jz24CnrTLYnXjVNtcPUkV55xhOcIdnCNNr9VaGK6t/YT+3WOljg7MtZ/HxM5bx3NJKjJkVXZ5
 5ieFYuYD0m+ym9amSwxP2Id4+bg9rXMk6x/dU0IlKsAyFEoMBMqD8QgsDABuy1pxUH5Dr6Tr5
 HXnTSl0FQRTAzsQuxyYILdMtSbpKodjmWoOJOCKuP8PL/ZIihtQPZM93gLQ5pMhdQwjWy52Zn
 riJ7QFwi6RRUWSgdzzR90FoNsrb53oG+nFb5xQ4+WQna1P382Hs4/L7JV8H4RzeWoMClT0BjP
 H1mdrihn56ZkAkzv0gTAfO+o2CT0tyB8XuDpZQpx5UoojTc/vUPw0iVR3MK+JnrL4chJo6BoK
 jQezD6prBLCFdQUAIMUT/FOSvLiNKnrDtbW2xfG2uk5EJ5PEMx2S9w9TDR/KzRDsyioGpeet2
 SdiTqTILSuh8Mse5nPs/9s+QelS2hQTm5VFcD5KgbAAlE0Z0VZ19uH6kHgE9H0rFX262siZsT
 ICYCEcR3t8vN6FxsJdyppRPBI1VAI4uYoD4PpQWOkwWAclnC7ORdHdr9zBqWmt0OgqZRXeaDw
 1stRDWprHWmcDIyxihkH0NfZvVxkIyckEtPWHTCSSX0TdO1iLNGy8rYhe6E0PY64XpRKAB82z
 dK0H5X3nDmiOf+Zke/LOjb4AnzyxHkCmAQsZrlP5OaHHN7ji4SGnt1brLGIJHpKDkoBMUh4ug
 nEtKH0UeJVwMzSJbKUCFeU2kW84d2Tg5iKGsFyOkIj/fZBR3t+pPM9MiOUbcVAKFHJI79tpJl
 8VsPa2pD+VcnRS33cSlFIrQetLeGEO6SaNEzUuEBBtgweRKYHRJM3Xk0PtYXxfhzIfuJ3oje5
 TRsnbhA4FaJJKyT4L0MpUQUI+tygeEz37Z3yIl9OEEyEcw3VYj4R1Jh5acoGevGFpToJiyPHV
 hinHWTv/fxaaAZXkY
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The semantic patch looks fine.

Are there any implementation details waiting on a final clarification
also for this code review?

Regards,
Markus

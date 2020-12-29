Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8962D2E72E4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 19:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgL2SDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Dec 2020 13:03:39 -0500
Received: from mout.gmx.net ([212.227.15.19]:35501 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726111AbgL2SDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Dec 2020 13:03:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1609264916;
        bh=SK8QITzCfWoZ/op3YpTUgnGR0uIsWk1XBJ/06nVaCnw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FO1EJ9ABcWzp/xDi9Q3yWXhGcFk1S6PgHUJDWsfYHxIbLaB6PG2wIM+WrXsG0kAU7
         Hci5v/2hSHbHvvCsxKcCQVSBqRbUu72vZ+N7wfCxp/MPq5bSJx+dZJan6XYP1VXBFe
         1damZl+J9t1OkdaGuCK67muinFVaFHLchgpHrKM4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.23] ([77.6.105.225]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M8ykW-1kzGrK1aha-0065Jm; Tue, 29
 Dec 2020 19:01:56 +0100
Subject: Re: [RFC PATCH 2/2] mm: readahead: handle LARGE input to
 get_init_ra_size()
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        linux-mm@kvack.org
References: <20201220211051.1416-1-rdunlap@infradead.org>
 <20201222173533.c9e28416835d7487b0e28cda@linux-foundation.org>
 <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
From:   =?UTF-8?Q?Toralf_F=c3=b6rster?= <toralf.foerster@gmx.de>
Message-ID: <d2edfb69-93b4-d938-faf0-5f7c0f1158b9@gmx.de>
Date:   Tue, 29 Dec 2020 19:01:55 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <6a595671-20a8-e63f-f3ea-f4749a574efa@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:O57Jbv6kXlXZvbyRWDd9xH2aYHMSjIDdEK/JCXmJADBX42EyMzX
 LL0jUj6u14qy4yJtCdb9NXZ9AWB0HNGF1Qmwg9rGBeDpz1JNW1ZZDB36zzC7zDxa20/UopD
 Lf273dw33OevxfFGr2xnPrsrLUswP1LZeWcn8TkZ6OL60VzyMYt7oqyuUvKoEIH77h2HV5u
 KrZrJkW2VK6DgBIeZ3B3Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VnL47sgNejg=:X0iVsPMBWnbU304MgmUW73
 fAzlnctILy1ZoCB96gR15CzJC+aEMQyRspayN670fgaqvFHSEnqdDP4uoT+t8Y4lgif3+hyVa
 CJkLd7AVQvDH6EFe1BlILTs5hrj5eriFx7i2rGrNkEQ+nZKuepkhgoa/R7oDTNNzAIk/Nd/4l
 EhjofJhRUgzC60zgmGuprnroaUuo0uXF38+28yvqQ3GquNvz/CJRbWjI7r6qSnRC2Sl6B49Fr
 etc2gMTstE/Le74dgtCsK/VIebV/QpG///NhASwklRxIv0RxhU5UMDAMMlqUC5okgWfX0f44q
 oKqwq2dRIgIaGuSrT/PxbBEWuYXfxFQnkKZpTmRqGbwGSZmherqRHimRgWLSytVTrnHrMlvYK
 vZ548K2NSXMm0z1RGmlWzU8btBhgZhndMzWCQloROb1SD3zz6IMtRfejxPrKCtXI86IgQisZs
 zWNRsWWYrYNsYHyNXhtIINjShVnlpjiLZh48JyEguttyHUPctu+3DpSOJLiqER/x5nLsYPkre
 MhNnuwa9IkKsWJt+gz1UbRv2Iejvb20GfHWVIWwUbq+FY2+dFt6RHkF8Z2ctlZu8dJHPoVItT
 N7Nc2+n5B/VZJxMjX+whj0yuXpVcpg//01zb/PrLBhRj9R7WGHPElSD3pGZ6pd0FTgUP2dn25
 Qo8XOEBaCJlwa3w4lZxLdZRNAx+Rk/SE8biaOS2+CFMsEyEk8DihpX5a5jh6KCDyepuJ7A8K2
 XbaNHK81vvaLBJAoTYwLal/eyZna3R9aDzgEcXU/N3zlZZNYFFWOLhypXdhwoH2vXZHQCoruh
 QDI6LAgGct51MmEgJGjdc3v54Lf90rWQPdaeFZsfytxbq1BWfrrzJmZ98yNgVIgnWaJONQp/H
 urG2BJj5XFik0T7SKadg==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/23/20 2:50 AM, Randy Dunlap wrote:
>> What motivates this change?  Is there any reason to think this can
>> happen?
> Spotted in the wild:
I run 2 hardened Gentoo systems, a server and a desktop.

I patched the server with this:

mr-fox ~ # cat ubsan.patch
=2D-- linux-5.10.1.orig/mm/readahead.c
+++ linux-5.10.1/mm/readahead.c
@@ -310,7 +310,11 @@ void force_page_cache_ra(struct readahea
   */
  static unsigned long get_init_ra_size(unsigned long size, unsigned
long max)
  {
-       unsigned long newsize =3D roundup_pow_of_two(size);
+       unsigned long newsize;
+
+       if (!size)
+               size =3D 32;
+       newsize =3D roundup_pow_of_two(size);

         if (newsize <=3D max / 32)
                 newsize =3D newsize * 4;



and the issue did no longer occurred at the server (5.10.2).

I did not patched the desktop system and the issue occurred still 3
times since 21th of december (5.10.2/3)

=2D-
Toralf

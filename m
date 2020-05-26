Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A2519D4DC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Apr 2020 12:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390670AbgDCKNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Apr 2020 06:13:36 -0400
Received: from mout.web.de ([212.227.15.4]:60845 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727928AbgDCKNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 06:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585908784;
        bh=/U+bW05Pvewq2voj1LF69LW/5jvM7rtMfQBqg8tSR2E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=o+0Z03poM4U31FXxR/xinx7ahcOjHcaGziXpxkS+cVpIWlq+XA524EhQjZLils4sz
         yUc9lD2mmU/pKSxfLv8uD9FcMWHh82Cl6zETQQpiCE6iFFHt3pANZbzPuMGA8sfbbJ
         SGO6M/p9gfClWfgE8Ykrwvoe0AiaJxaPXGky35Ek=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.25.116]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M52ju-1j7sJ40qT8-00zBi2; Fri, 03
 Apr 2020 12:13:04 +0200
Subject: Re: mfd: asic3: Delete redundant variable definition
To:     Lee Jones <lee.jones@linaro.org>,
        Tang Bin <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <b2a0e5f6-1f07-a7bd-2f3c-c95119efe635@web.de>
 <20200403092521.GD30614@dell>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <89c74a65-3da0-ddd5-2b80-407fd3a66ec6@web.de>
Date:   Fri, 3 Apr 2020 12:12:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200403092521.GD30614@dell>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:WDlLIQDzCjgBF1LYn7Jo133V1B0JfwlQaoxkQlKIvM5fp6c08LT
 wqeApRwS9Cp94RUEQGQBwVgLCbiJw6EKUnKBC4KmdwowaoTEIq2gXrIrB2zgCCj8ad1bF5v
 J+EdKz0h0Pcwpv5s7GXIGWAdDJzDT8llUYlLByF9FmwKvR26dVkY6wGI2g+tGrWWmdb/EWv
 UTwGY0v/w/jU1AOTclD0A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CTbuHs7vKAQ=:yTxwslRopQ3AzDiu2MuMQ4
 Sm3jlcu9L67uW66FqSFFA06vAq4M++2qHpe7dhIz8ADTFaU5oZFNi6FWCBcMznI/Z6o8vut4i
 qfjNbiAmnH69AUDwHFwXLUR5rB7KHYL779q/+GaNx9bxKQoiDoVBs29srHojLH4H7pH8fdej2
 0Wt2nTU3o8hm2tv1IQ/8bGOtzmifSNEzFvWp9Pf9i4XmH1ltQVpJ3rpCl9G8TL3k85kNdeeV1
 /yZ6quYhZdarW7eacSdsmDoZsusxMbTzvZXlBzqFE2CJQsWG6pgUp4ODYZo0b5WyZ63ToZ6ye
 XPImDJuZno/RRnb5+qbPTxE5s9Dz+E35T4Pv3M/i1s3rYOZ61REz8XPUO+lxZHOzu/tQEjfqF
 t39PkBp8RJoTrljcc3pnqK7VyjC6OsmH61NC6S1vOxyepx+XJkWDjADcogy1B7AXMpw4NY420
 o1vV2DYHRxuhfqorvrLZ0op2fcIghueq4rs23hdPz/IJrAVp/IuKx+l4TFAT0fpuOx+5y7yfv
 GYJdatecTsyGwfpNKBQps5b4LLGJ6IXsXhag+nRDxkKvaZHbyR0p29WNsgM7BsPKDKiZH9rbE
 Bc/4dKBng2CiIUxbJeHsy/5WVB7AL6bWIkrzz+znQgBsFz7CMXah1pNLDMQhn9jZ6GykS1bng
 tTouAC288UxMKPBKSHp8PJNZ6U6JN9UfgOwlcBdhPRHP9N3JlSrJh4w5VTozDMPr78/Z75gkJ
 gyrwn05nGQS07oAqclPYayNGcKPr2zh68769WygYvyG4XQsCeOYrNedwZLsDLiNHubOz0+fz/
 WUraimWTJAN3Ik087rVppsagpCcdRh7jowVKlH+HdqlFf8p1iuRx8zEd6S7Hy9+SGli7y6qPA
 JWBLWKPQesae1Da+F2k4L7RrN2kPJH6NyN8KmDVdv8Qj7O2eyEVAFziGyOMAX0INTquWPtupb
 SvgR5m+i1MGNU0Cf0f1E1d7/KSSCOlLDHAxfw9wBkxzG8mjYjGhAughmRYq0xds1AtSs+ypn9
 GUDP00ACIPs8mf/sccDc20K2mWT9e0JhjW3lg6sFpDtfy09m7NeB+y+s8PRmrmBmzvdkScP4c
 8Wgyu90HAihCaKJ3eo0TShPirYJ8HcVCAVKZmS+QXduz+gdq2LHYJqJyICZC2d0DVWlNS9vxc
 yLU5v8JJ7r9Pp2ISva357SUiBXldsOunLd3xv8ePkQYa016mosTIWxrBzMY14z503CKu7ZaD+
 wXkfP0vmdtUmA9aKa
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Why wasn't this sent 'in reply to'?  Something wrong with your mailer?

It seems that my mail program version contains still open issues for
the preservation of this information after a click on a web link.
mailto:tangbin%40cmss.chinamobile.com?In-Reply-To=%3C20200403042020.17452-1-tangbin@cmss.chinamobile.com%3E&Cc=lee.jones%40linaro.org%2Clinux-kernel%40vger.kernel.org&Subject=Re%3A%20%5BPATCH%5D%20mfd%3Aasic3%3ADelete%20redundant%20variable%20definition


> Now this messages is orphaned.  Floating about in my inbox on its own.

This effect can be unfortunate.


Regards,
Markus

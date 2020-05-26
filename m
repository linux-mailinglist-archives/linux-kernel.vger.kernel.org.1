Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191D11B0E80
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Apr 2020 16:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729929AbgDTOfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Apr 2020 10:35:50 -0400
Received: from mout.web.de ([212.227.15.4]:60181 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726895AbgDTOft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 10:35:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1587393344;
        bh=IZtN/ZdXSQbveyG7MY0Xsv18QdKs+zXQq0Dtm1Q7Vv4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=r7V2w+qUOrJzHOFjGCAzRcFI+9nSa7OazHQFWW2JMKcbtUjXivixSVnxYS+at16Y9
         CeJHtFyoVhgGqBhKUx0picRNFn2f5XiTWc19kgKq1T5oXs38oNh1aVQYc6FMr16EU6
         yYezrqvz348IGC8M1bik4M7M22q31PCR8XJprddQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.153.203]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LfVe5-1it5Oj32iX-00p7uO; Mon, 20
 Apr 2020 16:35:44 +0200
Subject: Re: [PATCH v2 1/2] regmap: Simplify implementation of the
 regmap_read_poll_timeout() macro
To:     Dejin Zheng <zhengdejin5@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20200420134647.9121-1-zhengdejin5@gmail.com>
 <20200420134647.9121-2-zhengdejin5@gmail.com>
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
Message-ID: <81379fcd-0ee4-069c-542d-7843ba34867b@web.de>
Date:   Mon, 20 Apr 2020 16:35:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200420134647.9121-2-zhengdejin5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dPeg69VETzH7MVQip4wSCZPw/0REA9q/efI3CjjInNF2fA0ZXEG
 NIroXLIopHITsj3oVgqZGjzv3fUwUwpWD8qG1RI+sd96WHEOOOfpXXYEIJwfnlLZIAXKybT
 3fJE8askauHNtBhHSjekYP3SCS7GuxCMIcW85BQZB6+xJAzKYUMb5jROj+DqyYAKrIFDGVp
 1VS+caY6nKkggBSSZrpgg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yAKQzslJ6ng=:8ODhhD44xzkxjx0S07kGWN
 z1IH6JwqZAsv5XQ9Mt3FL3y+K6wUHGNcBj50f8T1hNUXfdi/xDlyt51mNf17mlTX+k1nDUGaK
 kOv4y1tlbvoFNrlNJ2Z7oyOP4/bGZ/yd5N5dPJx6XvVKHD3x+MXjpoUGeF/zPWFanu1TnLslt
 86kXDYnPUQjfaZCphzS/TV/7cSI33JUoBIQLRfX811GayNl48FPOt21DGYk0qePDB9rmZ1icm
 4mXRU4DzuJoJXAxG3WSmjkuCPC1IqHSJn4rIJrdblvnV76PUJ/wmG0cBh7e7UgyQIn7tdC/EH
 TZhr10hg2s+5RS5S52y4zPXkrVUn01vb5Zmx76TYbifUUhusFsw+VJtOZAWOUIHfttK48CgDA
 nbChbNyf4Z4CO0qR9kxJi2Cmxc1qBHf7L/sTGN6bC+kgox4XSkwse6F8jnwUAZk8ZVv+m4XvR
 asjDFr9sQIb2yzTf/Tq69ZVk3DMECC2ZIipiYeEPkaMZwnrmLoWx4DCA4QvAxFQVSxNlrAi1Y
 W6BKDP12xq9WuQ2rxCDbLJ7xOl9ZKmHX5noQhlxy3YFCDhF0v/5w217wIbXHNr2F1vMU6qGk4
 TCUImAcmpN7n0laBILVgwhZaBIf+d6ik/CDOjnT567Y9W4JLM1zN38zqfMhfBrrviOpdR5Uk9
 a7iYi3tSUSJQnTKkxL04gpiSwZ3RtIdKERUhRSYLrWP594uGuhpviS8oHC5hUTkUQBgomOCFG
 Xl+ggHMX3c+U/QSLrCDOQp7ZJcUknlqCXCIOW+Avum0xrL66G/ljw8eySiwno5CjMN3BCWPop
 a6SL8XQhkfn5ijxp7fQllQUgFLoCK3dv0sMdGuM9EMQTiEZyrFp51RA6NU0ZdzeGJOfu2VsDC
 0rkxct4mxLwNQFBmXhrwrccFcqwSHRh2WmhkTVVkkIUh5LUBhhfBZLCC9Y0P89BOukfmb257Z
 eDFFy6skJlqVC6eWe9aG+oPjy9HRkImIYK3/DVVl0c6BdMtZ5+CLOe2TAbOnnR/iaSPxn/Olk
 btiniUXXJ8K36ahaeFvHul6xu3JWCwFfAPJxgCevX6NX7cshkhpe+yK//5TDt21DBNWF2werw
 zp/h2XXZAzaiZsB+cQnIfykYf60kEaQDIyMa/OPFPZm9NDolWw5vfB4RhQxc4RSva1PngdWg3
 fPT8atp8eLaL+SuPFM4Bb5cbl9CFvTxL0nYR7UzisthxqQsdm968iCxf1nYUKZwh9ArMstfSj
 xZa6dAVfCIBq5EWcy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E2=80=A6
> +++ b/include/linux/regmap.h
=E2=80=A6
> @@ -122,26 +123,10 @@ struct reg_sequence {
>   */
>  #define regmap_read_poll_timeout(map, addr, val, cond, sleep_us, timeou=
t_us) \
>  ({ \
=E2=80=A6
> +	int __ret, __tmp; \
> +	__tmp =3D read_poll_timeout(regmap_read, __ret, __ret || (cond), \
> +			sleep_us, timeout_us, false, (map), (addr), &(val)); \
> +	__ret ?: __tmp; \
>  })

* Would you like to delete double underscores from these variable names?

* I find another implementation detail suspicious.
  Should the parameters =E2=80=9Csleep_us=E2=80=9D and =E2=80=9Ctimeout_us=
=E2=80=9D be enclosed by
  additional parentheses (similar to four other macro arguments)?

* Can the tag =E2=80=9CFixes=E2=80=9D be relevant also for such adjustment=
s?

Regards,
Markus

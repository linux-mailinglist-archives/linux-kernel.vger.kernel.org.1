Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF81FF60A
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 17:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgFRPCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 11:02:17 -0400
Received: from mout.web.de ([212.227.15.3]:45879 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725982AbgFRPCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:02:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592492514;
        bh=ePFt1NaB0yTJgDkxR/IDTmQFz/CnzVh+Xg5R1uhijFk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Ry020ELXtl0z/pAtCXuzFRnDM3fqOY0uR9AzmeSRAHWClxgKdTAiz/D/TEeKQDTG8
         hzmVB+mezZsI/AUkwejccr+qDX2OGqczcfmXuwGswAkiwo8FXrjmFDe6FNTNPE3d5N
         NZfyLIExvxiY9yfxwWrhZhzw9QR4gFevEWGn3kI8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.102.18]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRTzc-1jJRrm159k-00Shjs; Thu, 18
 Jun 2020 17:01:54 +0200
Subject: Re: [PATCH v2] coccinelle: misc: add array_size_dup script to detect
 missed overflow checks
To:     Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <julia.lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Kees Cook <keescook@chromium.org>
References: <54ac89f1-5f38-8909-a652-c658a5a1f36b@web.de>
 <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
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
Message-ID: <4e6083cc-01ed-caa2-a9fb-5f4645eb9503@web.de>
Date:   Thu, 18 Jun 2020 17:01:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <759d33d2-25a2-f55f-7e3a-7481ab5dd0fc@linux.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:aBDZHC7VEx01XkVBBm3L5iIq34E7ZsaBjxJIxkiWWrjfVOKjsr8
 foJuBbS7HdYh73C+ikhqmBuJB2JPVBNDIEZQ8BHJpvnzpce19v7278vXMWeCILXCJS1NnjW
 kwqAeLwP8FOLgZDrZUmM7J1U1+CU1B1kyHXbDjupYtJjQgAdDabKAnouxNnYm6uVJLhmgeF
 hroADb/UO5YANUTULaQtQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:s2YGaIzy7ok=:kmQAP2rJhabn7sGaDZMdgs
 1hyTd5/t0KH4qA6fv5Xi2DuAgyPjezEtNUE8NZYcrU+OjVOEd1rZzARuWfD6uhtzPhtF2QWnO
 +H5O2CgZZEKTQotu6Sa0tlVJYr9iAVH6fhP1Ju3o6Lbjb8BBAv1eb+OQ4Xjl/RF5k4Ekc0mvB
 cBv8PfG88gHv5WA/KqfCb4lLsFGEGDWrKjbKgN6KpZMTMSkPXWNXxLOoB8canyD+nwml1PIAv
 GFls+YlXGFxjyRI/cA7PtU/9Yt0UrF5ddiQDBzalEqsEimHnCGpczKPGFPHTcl89AzCjD3JHg
 R/bjzu6RPpjzUuE5yFbaBYPVUbekjUHQtQoWSVnYXa5WlfBnndbK/shLVrsl/qds2l/F5j3V2
 B/3mYCsz3YkqcCh4hXTwixaq428ukJlb9rzpnMqzgLF8bSbeSdB3iTPmAEv7t6a77dDbQZjei
 lmQijNd8BxWywqkDcNHmOEUY1whZNKFYHsCSFEr3BgKUzxJ8ngBMzyyu+sPBUCCOU4vFko89p
 cHFMQlmzY+CIUjcfJlCrBG1QPIOjx/h8nWWeC2lhcmijg12DnjWMV5oQ233xYANdNFoXd/BGX
 86m297YHPO0RZYfiOds9qJxpv1BCmFAfLqZtlTiO7x6rGlYUcVpLAzVnpRc5jt/wefHCznQKI
 CvCpkmn3LrFaI7ldQ9dsd2wF5rFMsrnOfbhDsEg/prtz24MljLkRrbtCjCMp772Eocl5q/xYr
 ZHU49sEjOYSiS1buE1NHkQ+/45RPM1YghBtWDQmiRPpKHXpmalFZMiAUMtxpDIVNjRAFol8iE
 GFbc+Wkf04p1jhmW+Kb4w5kcluVvnWUOXzvjVs/t6lipMaYECdBRfUj947pz1SFetUiMtjDis
 KKfOaKIDFXuBgd7a7hjLRh03yTEepaofdq8qGXKByxyNkU39mDOogO+j+q6Nt/guGtpf4XMhA
 E51puXyxxmVIwLlJOUuOyGa2FjMCXO/6avGS1utVfG1oZmbF2Ct5QiKrCnGFmSDIQ+FHdwnjD
 s2JKBkN7rw1Ay+sNEAGoypZTf2/5xHCENDG08/M+WPtD32TOnpDt84w2sb4DfrIhqx+ynsFAg
 /mhbW1iPuhEeIigDbKoOjeEjEKmO+zHp9c4Uj5/PrigamoE7VcWiPwJFeI4fe/1M5E2RwagN0
 2AImFpX5E9GqWTiedJJWI3z24GCiN7oPmwXuGB94lAQ6C9Q8qEnWOdBap/v7yomM5S26VpCNX
 rKoXA19x/72tEPkrD
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Where is the typo?

I tried to point a possible replacement out for the word =E2=80=9Coverlow=
=E2=80=9D by =E2=80=9Coverflow=E2=80=9D.


> I can't handle your suggestions

I hope that you got chances to take also my patch review comments into acc=
ount.


> because your mails constantly break the threads. I just can't find them
> after due to missed/wrong In-Reply-To headers.

There are some factors involved for this undesirable effect.

* My software selection contains open issues in the handling of mail links
  according to the communication interface =E2=80=9Cpublic inbox=E2=80=9D.

* Mailing list settings hinder more direct participation (for me).

* If you would specify more mail addresses for reviewers (like me) explici=
tly
  as recipients, the impression can hopefully become more positive again.


>>> +expression subE1 <=3D as.E1;
>>> +expression subE2 <=3D as.E2;
>>> +expression as.E1, as.E2, E3;
>>
>> How do you think about to use the following SmPL code variant?
>>
>> expression subE1 <=3D as.E1, subE2 <=3D as.E2, as.E1, as.E2, E3;
>
> It's less readable and harder to review.

Can a different code formatting help then?

expression subE1 <=3D as.E1, subE2 <=3D as.E2,
           as.E1, as.E2, E3;


>> I suggest to move the ampersand before the disjunction in such
>> SmPL code exclusion specifications.
>>
>> +      when !=3D & \(E1 \| E2 \| subE1 \| subE2\)
>
> Ok, I will fix this if there will be next version.

Other software extensions which you proposed recently were similarly affec=
ted
at a few places.


>> I would prefer an other code formatting at such places.
>>
>> +coccilib.report.print_report(p2[0],
>> +                             f"WARNING: array_size is already used (li=
ne {p1[0].line}) to compute the same size.")
>
> No. It's pointless to break the line to save 5 chars this way.

Did we get used to function parameter alignment?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/coding-style.rst?id=3D1b5044021070efa3259f3e9548dc35d1=
eb6aa844#n93

I suggest to reconsider potential concerns for line length limitations
according to such message strings.

Regards,
Markus

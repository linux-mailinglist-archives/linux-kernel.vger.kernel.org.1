Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D51D61F899D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jun 2020 18:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgFNQMj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Jun 2020 12:12:39 -0400
Received: from mout.web.de ([212.227.17.11]:58011 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726772AbgFNQMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 12:12:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1592151142;
        bh=6JbQhdoSICrP+1+JUc3VeyJ1lfYceH1iM3T14pw3xpQ=;
        h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
        b=L8t2Vk1552ObxoMZtsjiKDxILL6jOKy2GtQm93yWCdwSwJbdQt63n/K7lZmgzlSyS
         q7pnV8TcaPhfajx0JsV++8rpmX2u05bbYWDVpcZA2uHXdrSrdTgmydPPI2mn/nR8BV
         twWO9QGhFM0NbuWBh6Zk8k8U3+Xy3NyEzUGCmick=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.103.145]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N1LwP-1imvhV1pLH-012lLJ; Sun, 14
 Jun 2020 18:12:22 +0200
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] coccinelle issues
To:     Julia Lawall <julia.lawall@inria.fr>,
        Randy Dunlap <rdunlap@infradead.org>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <417df11f-3dea-9efc-212f-dcaa8c6dc331@web.de>
Date:   Sun, 14 Jun 2020 18:12:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:f1AJNcpo8g4qLbIaU0pFgKFYtlJWz/7hPJwp3B9WgmIYml8jf1+
 Mu5HaHAwb48i/rfwKTSxYtX2ukRi4P0liMsdfOIYbDH+c01x9MqFC1EIbLtdipJNYFs5pus
 HcfJE//e03Cym2ou6y6BEINi/Nw9vnXVNCSxEXM6ynCu35b9u3/Gd8Dmsu4Z5aGF1epjdjy
 oMe045iXdyA9lsuLAntwg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZSPTPY+tvlA=://YXrtrLk8yrBtM5Vk70B3
 COFq9MwMFLMkYDX5CBgxhtP3Usk3XOCDlLNkXRgqTtMfsTSNqp/uVaGW1cdiuVgnZZgbRAeFp
 +qRq3C/xtVpeWDsvFyIX54qviqVR8ZFs/OaGV0rpZjF8PG0imlDlDBNuRmlSZUeLROeGx/TUV
 0ryYPGoxIZWncNWc/AK3Kvb32B1PKMlUiQGJWqFY+/Dwp0+1oKXl+s7wERj2QT/26We84OvOL
 bNekaUxF2QU0Fe6T8qfDAAsVRmhuL9jrsUElQx1v2SkwzWWVMU0eRA2cCA6p8V5r92IMqbOZC
 3Nt8wADMgAOzCdil7ArxIwnb/dM7hIhlapawYhIgqQAdZcLsYCg7jFOOfQsMAStT0svPlMUsh
 MsWF9htTmZjY0i7DTQ+Z6WYLB2ngmYrCb3aDh5r/WVYc4wQ84/xT3LZvpZl5Yd9y22G1lraiV
 H+bLaa+WYKinrIiDHwI3L9SRCNPi3NQyQUPLlfYMRA8KNV6cogqwDcTrlDVsAzpbtF45du9ek
 DpPDgWTRDSD/AVijkHo8HdYNuaj8+75zfI/ORva8E//Ta8IJfcIGtuQ3O+Q71E14FL7P/sM2M
 ARlutNvPPJ1JdxRbdtgxDN1ri7zUK9MWiWYiyM/hgqHP0oSX4+YEYW06XiGFJ3byCBKqKDwgO
 DvoKVt4WwTZ2MMWnMWaWBee0OxSnwvUxvkdJEwy+fa5VYJ89ItfDmaqgAdeNG/mqAcZbxo8yJ
 aenCPi9est6mzpprJkuUblVUZu8/+Wtamdx6DbDtHD04mCBabVcGEAfANSvHqOkK230t8nn3Y
 +jfGFCwFXTS4VbQ+kEU76PZN+nu9QSr7pRQR1tarx4zwQIagU+oz9U/IYeOw8CTpt6NqUII+8
 2m1f9sMSj+CLROZtKdbRpoWl2ok/QnVKuzLw93TOyjK354EHkmJGHY2k/H7RCGqMt0kh0HoXq
 H8+ibQznJhb0PRNHUBHsahbuYxdMm7RB5qc3I5/9XexfQrM5nPzK4nS0BSBScLhppUs42yvVY
 VEsgDQ7IcEbj48ySCX6x1OSb8Zcda/pgoV4DvJyZaodqthwp8qBaHJqq4e/nki0oa1r1x788z
 cm6VbNB4QdgJ/LlsFwy3SqW4K3y19P2qp+02VTb/3znM0R+GCRse0nqd6AiI+LkIHhuioAANp
 D4zKBJD7EIkBVtaOQwvs4yJXK5+ePNJfNLrzxiFnEbDCBlphNRMs5mHGK+W4tN0fXBiC2BeSj
 fhlydXpy9iZAnB0cH
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Note2: https://github.com/coccinelle/coccinelle/blob/master/install.txt
> > says that 'spatch' is a script, but it seems to be a binary executable file.
>
> Actually, it is a script, and the fact that you say it is a binary may be
> the reason for your python problem.  Normally there is a script
> (scripts/spatch) that make install puts in place that refers back to where
> your Coccinelle is installed.

I suggest to take another look at the corresponding software development history.
The build infrastructures were occasionally updated in the meantime.

elfring@Sonne:~> SP=$(which spatch) && file $SP && du -h $SP
/usr/local/bin/spatch: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked, interpreter /lib64/ld-linux-x86-64.so.2, for GNU/Linux 3.2.0, with debug_info, not stripped
16M	/usr/local/bin/spatch

Regards,
Markus

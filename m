Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69045294CDB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 14:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440476AbgJUMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 08:39:41 -0400
Received: from sonic309-19.consmr.mail.sg3.yahoo.com ([106.10.244.82]:37762
        "EHLO sonic309-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2440461AbgJUMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 08:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603283978; bh=RchYhSnUH4D8ir65x6OKK1yxktPnAGhcFCbackPivPM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XyPf9O5Jbr6sqXl9b7dStmJqwsbNeYdBCmfFJDnYyvqym7yR9Rrs3YinZhzMZ6Jc2EsdSmRSzzTyWSQDYk3wicQuDHOoAXmU6ug4gFMscWVvLiSyIm1dvEwFgDA0HYkqlV4zhLGwVuHljbnT2IXzEX+oW3m7QV1JoL96PzQMqrHirnSQY52xd7x1Ai1IV0UbXcMizb9gv4nGbuMRPJszNvKnMQVReBXvN2QGJLPExPhnlzduiZltKW9QCZFvSUd5jYmzzix0SU8IvMIyezIp6JmEmOPsP6StdZWCyYQwTKvjW+1P2hBj1y+AYTCs3JTBAeJioWfEI1zjDrBcgwpTOA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603283978; bh=RwapwSvBoy6sRJ5QuMQ8v9u+CnEljOy1WUONaCRsNyX=; h=Date:From:Subject; b=qIyypm7ZUMe4UOQM7/BmZc28M6PsUd4p50h0lzMvOG64KsOpdoc8eudUjOmF4wJl63Psfwe6tgRJUFvaUxwfSFYytAOfDjFQZBcCmo7iioiS0aclD2fBJARZ26HxlTPntOrOSuyVvE10zpg78/NenZNwuORzCz61uKJYJMA2tiF1uHWJBL6jbJdHTx530e5hw6PkomWo9a29VphMGW6am6SWIVHP9DZuqXNGdBVeMwQXR549domOCHKL89S4MAe+HRHeI8LfRLR7OQsbBcpFJCXr3QRyHE43XY9ncseXNugi75jU8DTA2ELwyfqsfQiUOaiNj7dy2pgur0DpXtBLtg==
X-YMail-OSG: F2WVMmAVM1lJ4hnToSHGb9xk8iKORwgJKR_22TPCtOjedNKZV9KjOTECZj.DVdN
 nwUacrlLg4fhHlyu1ukELGCN3wz8hA66KTMAE2iv37zMSyVjY2hNBEkJZKlg5mcJHMzEJJaOn4st
 cGBAMmzyMMyxtp20Nlza4zXbeb.nW0MJzBoIwA.0XpMt1FdX8XdWptLlnb0Zu7bQxOP6nuxGOfne
 gxaOfqyp5P9MSQpT7ecb.bQuLFfLWoPgYow0MeWtXJSxhvUvjYrj9k.MOJiC93DwCkv7gHwyOsLH
 rhSkhCdUGmuHYds2LA0xy4RJkzGkkeanD63pSjSyQfhYz2qK4y5bqttOG6Sk5.UI1HnN2E5qDnmg
 ofU5Y0a2s0fQlvKCQo4gcQXHmnrr47jzmbin89n5G.lDHCiVjd8x4271S6rGPj7KKTAU3LI6jZ31
 N06nlFOxMAypEscFTRNemNEc5dXL80kJkutxmwbGijS8a5JNhbhGfW8UacKdM2ikKLTd8UjqXeu5
 VJtdvwb8UE9Jf0HmOCJgxdWVGfyAaUt0453gxtot9czxI5DeWOwnf1Q9ulsmYvvTPjNcBf0JFKZM
 MDkQUNjQLajav98UHoaaVES.QZZODX355mX28n53iu1mY5iX57W3EoEq.NnfaZaTIONtzqsXWCCY
 lSreZqf6xR0C8CaCZVNdkwjsAIMZXaNTsRHg5jP_bcjUxrsbFajBnyPjhZgFvl2kW1X_GBVCrqee
 RQXJHbiYlJNweoR8AQ5Hdr94T1NPVN96nihGeEkUj0yp3YENDQE9wCBVCo4N88qkKdI2.cl6KN5k
 KJIaxMqS8Rp8beMeC5XS48U6hYLXGVZj76szqImS4FMdk54XG86pEpT7_ahWjlxl67EHbQwjP.dc
 7fMGN_prdQY9cNsMf2V0C3v8d6rkhfCO88dVbmmhxZh3pk_eLXnPwskHQraiIFTYNcjCGKnJO427
 7h47LfKTBbd1rWWEZXR0g1iq7YPft2nlJsX_VDys0HlbdJlugkTKZ0NB.yKXQr0JxNOLQW4ZvWX.
 ZT2qXwOCzwCsjC6Ov_IMKgPIsMF5Jk67VQ4zt4S7TFgzSer5kY36SX8l4Fm3mTEQ8kcjzpQyqdVP
 PR30J2ofQjss7BmsyjtqLhI3aFT0K6xn0SY9ZCcP4FGx69lX_UYdajDCrEl2fq713OBpyIiyuMz8
 zoe_D.CVjcjLf8IMr.3Qej3WeWvvu5IhMUgpNYMa.Er5y0yLwpllp8OTi4xZDubsnOkXD5lCRxd_
 bxF6vQf9gpK.UeijVirfyBtJSK7O4XzFO1XoFfjAD0xjd0x8ESZb.CJF9aBgBjfylLvES8nOi2JN
 Pd2AwmNz9wWE4ZsGxDphfdvuZ.BaqT2esy8V.Y2Id7w7fMu8O7w0Q3KY25OCJU80hdM0P1wlVz6i
 audxLFTmDz5kc_aZKXETwnzXFKIr3qewq8o11hwu1u99U37wR14lQVygoF5uXzYvSWUBBzXhLtSK
 PiMs-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.sg3.yahoo.com with HTTP; Wed, 21 Oct 2020 12:39:38 +0000
Date:   Wed, 21 Oct 2020 12:39:35 +0000 (UTC)
From:   "Mrs. Grace Williams" <gw78986@gmail.com>
Reply-To: gw78986@gmail.com
Message-ID: <1269384403.407605.1603283975605@mail.yahoo.com>
Subject: FORM MRS.GRACE WILLIAMS
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1269384403.407605.1603283975605.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello To Whom It May Concern,
Dear Friend,

Please forgive me for stressing you with my predicaments as I know
that this letter may come to you as big surprise. Actually, as my
pastor advised me to reject earthly reward and thanks by handing the
project to someone I have never seen or met for a greater reward in
heaven waits for whoever can give such a costly donation. I came
across your E-mail from my personal search, and I decided to email you
directly believing that you will be honest to fulfill my final wish
before or after my death.

Meanwhile, I am Madam Grace Williams, 53 years, am from UK, married
JO Williams my mother she from South Korea, we live together in USA
before he dead. I am suffering from Adenocarcinoma Cancer of the lungs
for the past 8 years and from all indication my condition is really
deteriorating as my doctors have confirmed and courageously advised me
that I may not live beyond 2 weeks from now for the reason that my
tumor has reached a critical stage which has defiled all forms of
medical treatment.

Since my days are numbered, I=E2=80=99ve decided willingly to fulfill my
long-time vow to donate to the underprivileged the sum of Eight
Million Five Hundred Thousand Dollars I deposited in a different
account over 10 years now because I have tried to handle this project
by myself but I have seen that my health could not allow me to do so
anymore. My promise for the poor includes building of well-equipped
charity foundation hospital and a technical school for their survival.

If you will be honest, kind and willing to assist me handle this
charity project as I=E2=80=99ve mentioned here, I will like you to Contact =
me
through this email address (gracewillia01@gmail.com).

Best Regards!
Mrs. Grace Williams

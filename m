Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B5A1F11EB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 05:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728973AbgFHD4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 23:56:17 -0400
Received: from sonic303-19.consmr.mail.ir2.yahoo.com ([77.238.178.200]:36783
        "EHLO sonic303-19.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728876AbgFHD4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591588572; bh=+Ho5njnCMlDQe8kHP7dw9Dg3Uxkhs4ujp54qKvotlpQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=X/tdDttmY/HZ3UNcC/wgIIH9SRJgFfdPpgt7lUkavlimjsoC9MXGtaxR9wfLMDCpHAc0cCCpnr0FkQJLctJ0VdqjCQMm6+5Zr4dXnP2B3NsUT1CJMJ/wNkj/7hWvlhm6VwnHZkE995jJEoE84oHKd+52BTspBaQB+nMbkZXL+Qdc8hr7K6u3ZDhn+t492TypBF8BcAV6DDSrk2RQIMs03h0/hPnYMG56I1EGlw2bC3IszvmFev+oLE4bBRhRij6DceUvc8gC4S+/iiP7xF+0TKVQFTppHB88Ws8OmIX5qrnqB+YnSaJkp0t+J1dzdCo8skin3c1K3DiMROgH76wbJA==
X-YMail-OSG: 10dzMOEVM1mynF3tEsszkkLMSVVRiBAA17ynaC9k0U_Yezamt8DehyxIeRD.JxB
 5h76MhxDuK5X_XEuP6wIpkYYVAkhefWk6exJOfI4YDz1pgtUZ4WUxMis7c81ru9wUyB2.MOBeCMp
 MskRMQFpQsi9v0dh6itt67D0lDv0wbVPp3UdesnBaJcQcHLKqc._boPRSt9CkkliDlkDlnv34ftc
 ewqOcBVTgsffYTc5QMV1LcJFCX7cJBvhisJZaPx.HqdlMoxHCTudewYJ.4mugakki7fv9lVtTFyz
 53m4HnnJrKy4oZimHaatGDE2fxM1U1FNMfCy_kP6eQ4uJqYHKAspYjMIheEB.OWUig5J7AeKPp98
 vgIrj0Sa4_3VglWuL2A5KLpcmI8uBzlHvSNI7WPaWerEehfNcfnuNoMdf1hKg06W2PlbTmVYUnNo
 KY21R0a1sTH25HYzm4m8Vq2xB6u2V8vTO3Iuckv3MX7IOHkG9ZTyNQtiIRoagzds1awyCTgAw4RU
 VjqlSd5p8r1cadJLps_0DhCf.tX6aBgmjEYrW7eNtGo0uMSCihJL2JUYr0TcMzsM_pCaDOS4b5qo
 I1iVX_y5MBRtrxyuXVoZtHcvvNkYWExgjHuUolcWkSPzyeYp2ZvsXzkOnLCW6UdN74gVIpBdmWoL
 USrSvwRBUg9bWbu2GEKJ6HN.j6YUnvTm_DxIHKhw9HPfS15rD65oJz4D5p.Xi5QH4xFvRDztpXYd
 clqYRW_2bkqYI1nL260zASmri0OttIPsdHjmJaI5kv9Vv26tYVr6LnC8cwBw8XeMAKn_Z.XLsqFv
 l8vIa2p11ng4chsiJY75dHP4t3yIeDEvpzAzcvpuNpsYs4sfsjAvMooG47yGAPAH74ukvKjCKMuc
 rxhMFq8.ZVnqoaMGHs2x2e1g6bsbScKhgb.zt8Yimh4cAEooSx48.1RlI2EIS.PkWOAhmmdLdV3X
 Zf.pgSyH2D_tFvRQhYcalWE_.LfsXCb1lHVNRgywkUq2x1Ok1wq_CtaZOttaYBT7GupSQwqobd1w
 KxTXhYrku_ek_8LWxYLZf49AuH_4ImF3qlvUlq5neI0yAqyHbeNC_ncaibEy1ODPg4Us9WJ0..u6
 6SKvCR0wnYYsckkbSrZjhFX7vd2oiSQ2nJ1Vttfp9jxaDKfIp3zkaK3Fx_cguIdKQAsl0PnvNtnZ
 sjVp7otRS1PUZxbH4KWJ26T_Tr0RrZrnMzWkzgXPJcRA5NR_5mdFYkWpArwHvoDIFKpKK6atQTD4
 HsWyLQAQzwrWRxUmOQRgHv44GvxtapwsIJ3qWKVtbWXgNYUGtr8lBCG_FS269SeSdXxvbRiyK
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Mon, 8 Jun 2020 03:56:12 +0000
Date:   Mon, 8 Jun 2020 03:56:07 +0000 (UTC)
From:   Notification Result <RLBnk@consultant.com>
Reply-To: cashcentre@programmer.net
Message-ID: <1073785922.1171603.1591588567535@mail.yahoo.com>
Subject: APPROVAL OF YOUR FUND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1073785922.1171603.1591588567535.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



From:
The=C2=A0affiliate=C2=A0office=C2=A0of=C2=A0the:
*International=C2=A0Monetary=C2=A0Fund,
*International=C2=A0Fund=C2=A0Regulatory=C2=A0Board,
*Capital=C2=A0Flight=C2=A0Fund=C2=A0Regulation,
Reliance=C2=A0Bank=C2=A0Limited
London=C2=A0EC3R=C2=A08EB,
United=C2=A0Kingdom

=C2=A0Sub:=C2=A0Payment=C2=A0approval=C2=A0of=C2=A0GBP=C2=A33,150,000.00/

Good=C2=A0day,=C2=A0this=C2=A0is=C2=A0a=C2=A0comprehensive=C2=A0summary=C2=
=A0as=C2=A0to=C2=A0what=C2=A0have=C2=A0been=C2=A0agreed=C2=A0on=C2=A0your=
=C2=A0pending=C2=A0transfer.=C2=A0The=C2=A0hiccup=C2=A0which=C2=A0led=C2=A0=
to=C2=A0delay=C2=A0of=C2=A0the=C2=A0transfer=C2=A0of=C2=A0your=C2=A0funds=
=C2=A0into=C2=A0your=C2=A0account=C2=A0has=C2=A0been=C2=A0rectified=C2=A0in=
=C2=A0agreement=C2=A0with=C2=A0the=C2=A0Financial=C2=A0Regulatory=C2=A0Body=
=C2=A0of=C2=A0the=C2=A0United=C2=A0Kingdom.=C2=A0You=C2=A0do=C2=A0not=C2=A0=
have=C2=A0anything=C2=A0to=C2=A0fear=C2=A0or=C2=A0worry=C2=A0at=C2=A0all=C2=
=A0as=C2=A0the=C2=A0entire=C2=A0paper=C2=A0work=C2=A0have=C2=A0been=C2=A0co=
ncluded=C2=A0and=C2=A0the=C2=A0transfer=C2=A0approval=C2=A0documents=C2=A0h=
ave=C2=A0all=C2=A0been=C2=A0endorsed.

The=C2=A0transfer=C2=A0is=C2=A0approved=C2=A0to=C2=A0be=C2=A0completed=C2=
=A0into=C2=A0your=C2=A0account=C2=A0in=C2=A04=C2=A0days=C2=A0so=C2=A0that=
=C2=A0there=C2=A0will=C2=A0be=C2=A0no=C2=A0further=C2=A0hitches,=C2=A0pleas=
e,=C2=A0note=C2=A0that=C2=A0the=C2=A0final=C2=A0payment=C2=A0approval=C2=A0=
is=C2=A0endorsed=C2=A0in=C2=A0favour=C2=A0of=C2=A0the=C2=A0Reliance=C2=A0Ba=
nk=C2=A0as=C2=A0the=C2=A0accredited=C2=A0bank,=C2=A0therefore,=C2=A0we=C2=
=A0have=C2=A0received=C2=A0all=C2=A0your=C2=A0payment=C2=A0related=C2=A0pap=
ers=C2=A0to=C2=A0enable=C2=A0us=C2=A0transfer=C2=A0the=C2=A0funds=C2=A0to=
=C2=A0you.=C2=A0Kindly=C2=A0reply=C2=A0and=C2=A0confirm=C2=A0if=C2=A0you=C2=
=A0are=C2=A0still=C2=A0using=C2=A0the=C2=A0same=C2=A0bank=C2=A0account=C2=
=A0or,=C2=A0furnish=C2=A0your=C2=A0alternative=C2=A0bank=C2=A0account=C2=A0=
for=C2=A0immediate=C2=A0processing=C2=A0of=C2=A0the=C2=A0transfer=C2=A0into=
=C2=A0your=C2=A0account.

Waiting=C2=A0for=C2=A0you=C2=A0prompt=C2=A0reply.

Faithfully,
Mrs=C2=A0Leanna=C2=A0McEwan
Head=C2=A0of=C2=A0operation/services=C2=A0&
Commercial=C2=A0Director.
Reliance=C2=A0Bank=C2=A0Limited
Billingsgate,=C2=A0London=C2=A0EC3R=C2=A08EB,
United=C2=A0Kingdom
facsimile=C2=A0+44-155-5559-597
www.reliancebankltd.com

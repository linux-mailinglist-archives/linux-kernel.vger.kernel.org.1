Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 188F9203526
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 12:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgFVKyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 06:54:50 -0400
Received: from sonic309-24.consmr.mail.ir2.yahoo.com ([77.238.179.82]:41954
        "EHLO sonic309-24.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727798AbgFVKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:54:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1592823288; bh=u+2W15QLNb9HleqIDd+XjS10sGkxRA68vm2qT7T5JWU=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fnnK4OtihxtpdGNxX8yZKb9GYNm8lyL4l3yHmP+oTqPL4YH8Rx+A/nvwnSCkN2OJGGx0B/3o55bSHg9KqJORneJXZoh9w0C/I750TN5LskLR5RaZLIb/tZeI3B8yH2Q3FSgzbG3wzuW+ckLstFs/1SDfSrz+apQMQ0iVaWo+M6qAtGR58U6igwZcylTCferRFeDiPQm/HTKjWEg0nbWsY2DPBhSwNrFbjBrjOTq1u57oONyA1DeLN9qu2d8ITGI169BgudWBMDez9XO5ICX1Ju1VudZIHHQPspKUHF2WW8USJUOVTsW4cexD8GZL+m5KVRU4sg3/nw/h8b0cteUuOQ==
X-YMail-OSG: NQQ_4pgVM1l8UaDZ0uTNyqOgm2K2iXDpmfP9j6wnFpdGlUglGFTqeMV6GdYKBIs
 3iur1AJwJDg7PZalUGCQI7cSa9c0Ikpup1XSibC6AwnxVGgmUTPdIixh31Vvb1qKcphNfuVjte75
 QXPqjCRZG.mwOn_xDQ8afT_IXO3J55N5AEx24xOMd3Tjzu0ysnELv0JfA.I.C9rNVIIvYDHud3uN
 9NYVa76Tt1Xupygi_S05qmD3eneggehKpVvVT271z7AClNclrk.qVT_bscp54iQY_rcglh9qJEeY
 KV4pc5SyKw8VXeuB7xiJvj3pvsup5dJu2b3RWdDSAGu5tUEyzvFl8X63opAc4.XFOfmkET0ZGhCV
 osYKHi29zyWgPnQ8nWluvVaUE7BKEwJR61EwaH_fTYAPPnIpMcJerNpX7V302QeD2yX8_qJr1usj
 Sv5iYjsx8WNHB0h_D4Zi0Dkz68J7b03kxDUOW2ROHohcR.5sxAWTMN3Bmc9fyHFhWjcraB6WAcyF
 q38yvrqBOl6unGEVarydXPrQA1S8650dDWonKWC2PH1vyZzY1Mtf68J0DgH187a0I41hWdGKYokO
 ljue6vvRkCE22n45pCbdSFXrV8bThQF8iX6Gzb5NNbgEh1yngsYPAPv6_CKZPQcpoLRUA0MYYTVM
 I7S26vy1CjLfz_Dz6SzG2bcCLIzatt9Y.7V.gRFkY.nDhjnJQVKWAO1Z3WHs2kwV9OyVuxiboYQ_
 DrqZSHy1csegLtrRBbdiu7Di5KMAHeOz_SHV2._Rg5E9MPbk5DEra0BmBBRIecYX2V0Z1TgOdDKC
 W5.3jPKzMI.34rIMer.ZGvF6ecM6ADtf7QO45BzEFcpDB0twlM5H7IupoNTGvJs9jLcJDJm8TObb
 KgVGyNAe7mkwAndhXOYLJiJ5UAqWQGxqZe3Zs26A0ea3JYEYYbZWSZJJ_gDnqZGQp6dQ2oFtAJTN
 zSPurOOZl_n4WuNcE1ugef9uzYkqeK.MEoX.WMS_i1GoHpgZqUGx5ZAJTwuI5IhHAx2NzP214Sxx
 SswwDKrcuOftbBG3IRrDUv.sZwXMTY0Q4OTmcb_jz2c8F3m6tukDti7rSP9KW7La9orPUBYAuaEU
 BhWmCtEMgizF8G9zN37SKAQwNQdtIqDl171rPh33gOOivh7jaMN9.gO6SWxUEnUkNOhVfsARVeQo
 DJLHBW8khIdfk6zQ3KFYbVolm0xV7OpJ0J8lMcx5UwnbAXX5EbOonxWHtqwmO_5Ld9sW066DDq88
 QRZelyBW2ieSjVIIhtNwKHKAWU2GPQxpy1DMlmY9e_dG72dTdtsTW_lAPb0TASXrcYl6MehpJv7v
 I.A--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Mon, 22 Jun 2020 10:54:48 +0000
Date:   Mon, 22 Jun 2020 10:54:46 +0000 (UTC)
From:   "Mr. Ban Ki Moon" <bbankimoon42@gmail.com>
Reply-To: bkimoon65@gmail.com
Message-ID: <597075524.3263771.1592823286944@mail.yahoo.com>
Subject: Congratulation!
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <597075524.3263771.1592823286944.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16138 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Congratulation! Your Email Address was selected as a winner of =C2=A32000,0=
00.00 on Euro-Mega DRAW

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9132481DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 11:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgHRJ0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 05:26:42 -0400
Received: from sonic317-28.consmr.mail.bf2.yahoo.com ([74.6.129.83]:34787 "EHLO
        sonic317-28.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRJ0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597742800; bh=QDT11FSBX3UVcMqL/L7VsYO4wQOAHUBEusQIS5epyHo=; h=Date:From:Reply-To:Subject:References:From:Subject; b=afqKXna1J+3H7wEg65wcFKg1BuUBg4pPOkIuCNsT8ttJI2F9SFr/DyQ5SBBZcd9+zFX3UQ/uni5ps+1kCfntPnxEW1KMqY/O0tvun3KiCfe3p44a9yKLB2WsiYaMFdowhF7Ep8fmWArauEZWdblBXznawFKXolskoPRccMrGbUmxLzO0XhwkM0C0TI8xb3Oc8zFvJOcfNFL9Z8ZvUpqAyNmEZ3Exb+BEOeOG0+jqdkG3Ymu+ro/YapgmilwuskLSkzsdfTancUCNHCERobBGx94Cdt9r+kupPUA5vjR8//weQFCpDiLPmTzz8RxmJSns8jK3IGHPDATbBGdqtXH5Fw==
X-YMail-OSG: kJyuDlgVM1mSn5sknTHQQMbqrp1YAseq3JQYy8.dTEGIQWtOUntXCMiLDNuw.FO
 dsF30Lf_HeVeru6k.0lF68MXo_tlA7_4ICre0cDhVU5_WhEkVcbvm8Wls7bB219vyp6uH1f08xxw
 Cm7WuZh3Jrk3HifbjeQmQ3OEyUGDslcPZQFYMjjZ_miEys78ZIhxih8I3yf8iX_WtFKZvf8EA9Mw
 e2nk26mP8f48QuV9IwDlP4uI7lwKOQcHbQk2a2fubjOofj8ZjUL.yQ5tMhsQuOebjst98.f_zHvo
 uECCPatYoZru5GOfdcSMeZKQavTAnAH7fmm9r26YRussmcaXpDe3WTAlDc8lIRUtVqW2ZiHKgsyP
 RFjqyda8bRlUTGZft.Bn4t1yuYh0.2NpkTXVekynmWaa5_lPPPHLYZJUjymkmikRz1bC1Q_RNDIn
 PQpFILjCMmF02mCN_1G1KLN5jVet6Vha.k2HP0zu2znp3yRCZTt988S.7uhgWpBKTcifwzHV5.8o
 xd2z4_Nau.HnDPeyGe8O2GHFmc1gKJSzIaFTdfeRXEFWgCoOpGdBNrmIyOmiOiMc5ry5puGaJone
 gm1z.yukJJSlL0t8Ys6yhzXLR6GgoRDXszplrZTExnw5zOSJiTRwHJLWJc990gmpU_gDIYu7.L9v
 PwC_DISEY8nJ3KD.aOVHO2Alaxh8Hb6QZ3rRyGobg9iUWzY0ghaBxYDYyoRfpW4rWERh2iv87x5E
 bsIO62O0cvhehkzjvC1t3rFQOOx_dVdKAgmuosVQwpFzFnsyakBykAwU9Ju.SOJtnSTJvrNMkw2q
 cPK4X04HdD2Fsm6VfdU5_lTj990tV.4afJB8j3SMxvw_R4Ch15utQnVD5SsC.HqblJDVeoYZF.Ax
 lBLAx2TCimbmLVohxqGL_XLE4VTzn1iKhWjET_7iZoi_NalYe1ZpTIDBnNnXpT6rXb5ABqJyNd2s
 lRI5KGDq18MV713OomGtewEPXU9b2z3Mddhpjbl9ijtJxw6U7TgqzX.dmu5x1wOh1PWYrA..uzii
 7SQmXc6aNE2Iu2w7uOtz7R.VXOgwWANc2FWQMP74EbgqYWNeQXHLBY5UPxyn4aELsxfCtwg7wGbQ
 EE6jFmoSq2hGxF2Kv58FrmJS0iBYDu9jd8dePuXQRP8E4QzfahOIYJ2kk5rMu02L1cHpPBq3TKYx
 PUO_fe2Ue9DRr4._YzIOHpzyJy7nlwOuJo99FswRGTQPDqcly5bqOAfC2uvn1AlafsMOe3GtI1ms
 iwEuWNAFstyrnUYPgwj4RnSN27TK9wTuyG2TQgTKwMNd4gWMVaDCF2JmYKcy5pQsES0kNEMF_hAj
 Oahqbjv3.pe.yK6Z_B43RurZxxYN1mLe2LgKRNothjzcE
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.bf2.yahoo.com with HTTP; Tue, 18 Aug 2020 09:26:40 +0000
Date:   Tue, 18 Aug 2020 09:26:37 +0000 (UTC)
From:   "MRS.ALICE ARTHUR" <mrs.alicearthur232@gmail.com>
Reply-To: mrs.alicearthur12@gmail.com
Message-ID: <1155747194.3642765.1597742797266@mail.yahoo.com>
Subject: DEAR FRIEND
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1155747194.3642765.1597742797266.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



DEAR FRIEND


Compliment of the day to you. I am mrs.ALICE ARTHUR I am sending this brief
letter to solicit your partnership to transfer $9.3 Million US
Dollars.I shall send you more information and procedures when I receive
positive response From you. Please send me a message in My private
email address is ( mrs.alicearthur12@gmail.com )
Best Regards

mrs.ALICE ARTHUR.

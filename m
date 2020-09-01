Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE151259D97
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 19:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbgIARs4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 13:48:56 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:42057
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgIARst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 13:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598982528; bh=V09D8a1N75lUFkJxVR9aVpVPFU2IfPbM8afoyzXI9EQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=A4ZG/mXSKY10caoltvoznEQ6dZASKszUfa2hFKdtFPJbR5TAmUVkjyqnn8UrRMyCgSt1Pf8imajE+Hx1dGU8bnNoxVtgzuswfxoqZXHWhDNg94RCO+H0UdCAf3i6Y3qMZazcXDNHseK8ym/b4x8etbP1apMaM8VT0aRY7sHzeSJR+XHnMYXRIlbzbB6/gYmIcZ/Cl5kgnMWJFa/c/TUIpVxro13PvNCGRq3Y1vRv7nkkb30u4rORBaqXHtSdIg5AF9EP5JsZpR6p6WWIRChY2EYdXEIgqefhuNAo1dEPEpaWjPcrZfFPSPDYdS7dSPEfK8x5UlyMMmHIZqYf1RlDLA==
X-YMail-OSG: Czl.pb4VM1nNRWFudDN5ephyKrkR7xDjq4OD0QquwM_0PgNtFXZ6nJq3EXssiAP
 jY2hS1RItmpnPxun8ruGXy6Kk_tS2yxTDp9rRpCF5kxhe2JvuzK4IVpiB1Gctdz87OnYZaNkUHMG
 5YKKE5uV7EpkwONBujp.BrYdjrJ0MsqjOn9gfZVvsxBQL.OCcp3cnWy1Yz.pjIfKyRC1IKIzp2YD
 cLXSo2pkZla.8aDyaC05vAoKr6KYTN2QWVQCbdxgGIvuvVgQP5_.fwZNMOGUkVF8ZLPzVazU1zDg
 c4nfScoEjy18jiD7KlDFfK2yuUa7I6SPMi6u2hGKR_Ro5SFWchb7NKD283DcTt01EP6UbEOo5orO
 g.LBKjVfESg2Co94O_T9ZmREdDg3XuQMRbczne6mOVRhF23yZPJPzFr6b23qxE0fddoMYeJvZhRX
 DIBEzKIp0CTA65rs8vlFE4zdxTF7s8PCYukNubj01uUZX9x4bllKouI4ypCN3XKQYp2tC8ZYKwCz
 asMEU_C7NVaFDv9rawX2KhU1E1iCiaegfM55N_y_AVajW3RhFIrphPhvdAOHH02fEY9_JvaNcMH_
 x10emjxtF50pzxKkV8otK5b9lvxRUJnUAQAe4XGHsaiAxMlZntwlLR35kvbaIdrgHl0gDdcpqNZt
 cqUmHXdUtjdIsYby5yxfAUWwW8Q5V3oAZbuqOF2GWK.INp.YKbJSP02OZUaADyY3PLll77U9iJlI
 kA9YuSddxCgU2gewKe4aQGu1XXgQObeuiEU.S1XjI_hcHNgf7x75pHsf6KKbAfnoYsCHHqt0fu8b
 psEQbpzxBneJJF6cNgZXqizQTwkXLV6JJxyN0avlDP5go6.mj2zTTt8h5Hz7WyIkf5pYl1n8P5Aa
 KZvpRVeAMLPt.Z1vJlqYiggLGM3Q.PneX9gCqAeXarJHXrTrOz6WVbZrUrAQ5oJzf3xn0H85DI09
 .lOS9JQhjP7U0fEekcVbHDjNajK7jRucOi8g9la9TIKf_1GnrzwDBJhFZ1oerrliWnxnLvqdOJaV
 wqIQjsYTVTYUI4Aq_.SltmN2VUzH8BfoEJYOSgRG67ht0IzRARV8PejLupIqzmmPXmZFk2RtQ6Ue
 M0.m0U_MudB3Bn.GMNQZI1rc9ZqH.styvFQsVg1281aCHs.ql5alDhAJIUCVhQDV1ZsJn6yB.dsr
 3pYiJeFxp8Bs6PMIFzv79HKSgsavctTlfQ4TSPoD7mFFmsGUzeH_14IqTIxTmeQEOc273o6yBDbj
 loTzMbY7V4DtJ9SkJgz9WM_ygChHRz7q.FFxtDpnQ14B7WtrGoZmNYqTQBoaytiWs79anLRqZlcv
 BHnYF6Lsxy9ckAIA6VdlJuGJCsJcVXhpURvkQmiyZSpw8wqXchraHaxopGz5DK47hIP7HhHF5E9r
 z_Uw5wQ61FQwlILAXicxVoF.FjScZ4Z.m8P5nylKSaEAj71ahay4-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Tue, 1 Sep 2020 17:48:48 +0000
Date:   Tue, 1 Sep 2020 17:48:44 +0000 (UTC)
From:   Ahmed <mrahmedoue@gmail.com>
Reply-To: ouedraogoahmed@outlook.com
Message-ID: <1828172015.1193889.1598982524974@mail.yahoo.com>
Subject: With due respect.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1828172015.1193889.1598982524974.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I know that this mail will come to you as a surprise as we have never met before, but need not to worry as I am contacting you independently of my investigation and no one is informed of this communication. I need your urgent assistance in transferring the sum of $11.3million immediately to your private account.The money has been here in our Bank lying dormant for years now without anybody coming for the claim of it.

I want to release the money to you as the relative to our deceased customer (the account owner) who died a long with his supposed Next Of Kin since 16th October 2005. The Banking laws here does not allow such money to stay more than 15 years, because the money will be recalled to the Bank treasury account as unclaimed fund.

By indicating your interest I will send you the full details on how the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Ahmed Ouedraogo.

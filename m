Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD0F1F0A9B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 11:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbgFGJOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 05:14:45 -0400
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:46488 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726375AbgFGJOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 05:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591521283; bh=FxteAL4f7ZlzpT4ZdNdEGTtGaJUjMVyx0IzkN6XgoRQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Gjay3ykjulDZf3E29jVeNpZVX53JuJ66bthSjHBdv4FpGEzx+MNyUoK6YyN12v+UDOOMN/CfFIWO94OoHctE0x39M2z6Txy8H2EC89E1G5iPKkRi2naCOv4KMF71ppEeagkdI8nHw1HC98wML4DFhKoFUPOcd4yrfhZSMks8XSMcoZFt3bqWH/nJxPkq4bxb39XHRXh9fgm0SE7XbwlpxgXS5yjSQRWr27WR0yhxfoWjLyCT3YukHK70ZdjG9riYYOXKqDkUcSfbHK6e0DQsaJ02PwW7Q1ziWKjxk4oPQOtMXuZezoXIJl6G1kuvpycOcw9ekh9gMd8WqqDoc1DD/g==
X-YMail-OSG: U7gl9BwVM1k1cSoytfcacc6ufJfDuFsW4xnsiYZ2dF_MZEXQT48woD2CQNJVjMa
 F1KznMd47YC9CT3584avtZpBGBRSZtkiS5GKKuQJFOTDyhyURjC7Hz0Ew8V8RZ1gY11Ep8.azn3h
 CC_o_HljTJuXRphnNtFt3RivfoPBuZ.PiaVf.dl2y3.ZKS7ymr7cHb4DdfiBtQEOdC2WMmFmf6hp
 5Z7hSXv8GLaGG_Uj.hZYYiS_CmUpW4lRPSz7fL0nwetvdZ8GK1I2S2ZrOAWdEiV0StHFomvGNPiU
 9HNNqj9e4ZZ6v8eaBfUj0D2nE3cirPvd0dTHEnHEtgFPiwvwSnz.dITH8caeMgtZg6HSDBLsWlY0
 QRTv5WDMHYyzYl_UckgHKmPijSg1fPCJydC0iV5jPJO0s_O31qs7G4twkYB7QEygXGXBWWrMFHdO
 R7PJws5Xntu3uikPYCYwe2C2yCPqdVQWxYIGjZGIW4xG5jKOSd4Yuh_7JEx982YvtKYqT5d0LPe8
 0o7pY0n7E0DUFyUlQraz5Lciw_EdVRgUXhwmAM2J852UTE4gGB6ez_9gfhPtTaDSdGjYm9ZQhuzy
 SUx1UswY4tTqzOano3aZxOJRj1t0CH29c8PmIqQx0MKOX.Tiqw5I_sE0dLDMXKanddwb4iZ9y4yt
 3fkWvIxrfCg2RiNJOmU8x9nie8wzNC.LHFTpavmdEAa_nIsOfweiqN8wY1TjRtWAziB7vd2jcWvY
 IV4BjwNW6YEbqkhIuzbxktN1bItrMM116PQVtxvFBKigS3wCCwiwVdT.SHgW3vqcWLmoXEcy6rEh
 XxnlzJXkJoQ_co21Xmuo.YwmC5_dkeOIWtCHqto3cZWxCHAkVXCUPId3IjSPAF4DS7UrM7z897re
 .oBIKjsMUrae13nwQStBpAObTg8P3tRq0km1qUNTVkAua3rHezdlYnn7lzNS0V5q9vIEbvlcHZMb
 ihVMxcDz66D61dSM.GA3obBIADs_2nXSy58ap4nN9AgRvNS_EbaWB47AU3HYY_prsw5Y3FKp66cy
 1ExDykbH9VRqEX3yqst0gnH_euzaJSqB1WDZJj1q2B_iqutseIDh.rV.PD68uGIsZO_03xi8.INV
 F_iN7W8JM.5fx9_5cpMgo4Bce29JdlhBqghjoOtzj6Rs0q8i2mcBLyceIDHRdLwEjVFT4wfEI.Jj
 R861uWdUb3kW3UB2yI_._i5ohb6MnbSNSTlRCKyDjY574X6WxX2hrA32F2ahbA5_gdxCT4t8pH58
 Kz3v1k045XcH2DVZSf8Oj6NsZYDLQdbfrtO3cqKW1VTRQ5hv5vnYtGcYeU9EhPfkLf0cLfy_a
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Sun, 7 Jun 2020 09:14:43 +0000
Date:   Sun, 7 Jun 2020 09:14:38 +0000 (UTC)
From:   Mr Suleman Bello <mrsulemanbello863@gmail.com>
Reply-To: mrsfatimakargbo@outlook.com
Message-ID: <1952979051.322591.1591521278959@mail.yahoo.com>
Subject: Can i trust you?
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1952979051.322591.1591521278959.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

Please i want you to read this letter very carefully and i must apologize for berging this message into your mail box without any formal introduction due to the urgency and confidential of this issue and i know that this message will come to you as a surprise, Please this is not a joke and i will not like you to joke with it.I am Mr.Suleman Bello, a staff in African Development Bank (A.D.B) Ouagadougou, Burkina faso West Africa.I discovered existing dormant account for years. When I discovered that there had been neither continuation nor withdrawals from this account for this long period and according to the laws and constitution guiding this banking institution, any unserviceable account for more than (7) seven years, that fund will be transferred to national treasury as unclaimed fund.

I Hoped that you will not expose or betray this trust and confident that i am about to extablish with you for the mutual benefit of you and i,I need your urgent assistance in transferring the sum of $10.5 )million usd into your account within 7 banking days. This money has been dormant for years in our Bank, and The request of foreigner in this transaction is necessary because our late customer was a foreigner and a burkinabe cannot stand as next of kin to a foreigner.Because of the static of this transaction I want you to stand as the next of kin so that our bank will accord you the recognition and have the fund transferred to your account.

Upon your response, I shall then provide you with further information and more deities that will help you understand the transaction. I am expecting your urgent response to enable me inform you on how the business will be executed. Please I would like you to keep this transaction confidential and as a top secret or delete if you are not interested.

Thanks
Mr.Suleman Bello.

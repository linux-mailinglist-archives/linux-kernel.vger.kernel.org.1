Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38C382413B7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 01:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgHJXZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 19:25:11 -0400
Received: from sonic301-3.consmr.mail.bf2.yahoo.com ([74.6.129.42]:35148 "EHLO
        sonic301-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgHJXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 19:25:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597101910; bh=TCEah6dQDVULXjjJd0DMU7TiZ3f8rT/CjPbt58XpL8M=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fDLsl4n49IyRIn2BvSdiTZs9NdGA68HO7UWgDLAWeM3NnbCPszOczCtp9W5axj+DVHQfa9hOEbAbGZMfmhYKcjVMLmV6AIfWfgsB2IbqZIoh43JVDpCyMdzmUcIfIf3IV1ZiGozEe2y2qpFI4nSBRNgHMtVyNgQKjbWbQi8SlAOuvg7ARtpbsNaFCklVASr2fP5KcfvC6PQdAVesnyF2xvNU4/pnf3zsH2/cqlKYDMwnjGlAooAuT4GdEKxIpPzg39RvU0QInol4ILUpcVevlvjQOrvCcyAU7KFFBOFzYGu3qj2JeHuulA6Drh14QxwrfzlBOdX6seGX4FezDQNthQ==
X-YMail-OSG: cHTQwSwVM1nIEcefQeUU83m4RQ9rcIw5SjzlVYNrcamOaDO8LInaDm6mKBtpiEX
 PVjZv_sCe83Ou.ldWG_oqwJUTCe7WQX8rDb._giIlkOzPwQztXw5x9tXNpUO4Mjvj6zLu0FTAz1H
 DHqJlHrXp3VYh2pB1fOy.LFLQQs1tHI_cJWy6lY7uu99EJBdGt7jdKRob4Acvd5bH5d89lJjpYlt
 BGE7x_dS.lY9MI_tvxwdf4bWHuRUF75msOdgBKwDvw2x2_ntM.AyXAwUg1BD5R91X0o8u11ujHqd
 bPaV3q4Xu0m0y9u2AmU4TCZFLMqamPSwLhevGSbSiRVMH2UmV6q70YtofiKiGDUskpjzWfy.b6zi
 m734nXitKanhojuGHDzPJ_X_mzxxYNE23u6.QvYnI0Q_R8wXQ6TLDO1S_EnUa3Xje7u8FITXQjkJ
 2BQNhmw_ti24g84xaEIhSthLxPw3GKIruk.kz4R_uBjtCaH9MAmF9lsebFC0qDgGtX7A49EY2nPz
 YNIraCA2q0bkUo3b6yMDYuDnLg1MTouh.FoQcgRADDA9czkIarfhsV3AFVxoq2WusH15SvZWAIaq
 JJbv9pX2S6u3qM_90fbIXtX7sRDqqmXGZCwSmeGjZYo3IjNN0RnnVqurMTLHVOKMFl8wHQm4BPI7
 xq4z4Nbzcctvz1vH4NfiCIUz8lFjuuH_JbH.qYmJPsP4XoYw.9GVzbjjZkmEZnLWsEXig8fEjf1R
 Hb.lFJKtMInReSFbWfJ7N28i9K2lDk6ILp3K4rUbl4Pw5iNinYMjJybU_Xp7oQ1s3uS.xSOzBs6u
 f1Ffd63HY4xP3lTGZgsSHgzNrNLxR7_xmr3nuWeR_cjwZyT9LpssfHOIJabC7UG_HOiqIdmIUMXh
 73GNZa2sJyPZjcgEeJHjFSHWjWyArLvVvrDMGhEmhJ2qbY1DclXQo1N1c3wMsx2ZGOuH795sJJsS
 l1qikO1bWZjpN8VXO7ee5HFvIqgy20SLOAzMMzVU.6v0P07zJ1TQTr26Zx9l8zNHaGEGMzQxEr1D
 FqpVidceN6I4SbQBoA_0un1euCiXEccIWeWC.NsYuCHPVN8rKGoHCPbA9zuMqN4hpU_7CmljiJXT
 JXWtaQnNID2hH9Zz0Z8KTy6ZOtyIZ4Mc8vUkSpiKVSxv2AEZLQLUBc6rRYPzhp5TQ2Ewc7iQotnd
 1_87lxpmfmE3AeGGHspKMY0Szk5mj.6Ygufyo8hqoZED7FZlCW.ABOjvXih9j.CeVRil0xfDVBtB
 2Ghg4rs1GWyBoqgIVSWZlzuKVmQElEQF5FqOExOt6_.yt8jaDpb439GGIhgfELF98nMtbdyKxTJo
 5kkKagYQ6vZ0btJ2LK77jQbkN48.NHV8S30OwK042M79G.Zii9sSMGs_NwT.c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Mon, 10 Aug 2020 23:25:10 +0000
Date:   Mon, 10 Aug 2020 23:25:08 +0000 (UTC)
From:   "Mr. Mohamed Musa" <mrmohamedmusa739@gmail.com>
Reply-To: mohamedmusa1962@gmail.com
Message-ID: <532526762.2083530.1597101908463@mail.yahoo.com>
Subject: REPLY ME IMMEDIATELY
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <532526762.2083530.1597101908463.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Assalamu alaikum

My name is Mr. Mohamed Musa, I am a staff working with the Bank of Africa here in Ouagadougou,Burkina Faso.

I want you to help me in receiving the sum of Twenty Seven Million Two Hundred thousand Dollars ($27,200,000) into your Bank Account. This fund was deposited in the bank here by a foreign customer who died accidentally alongside with his entire family members many years ago.

Nobody had asked for this fund till now please contact me through my private email address: (mohamedmusa1962@gmail.com) for more details.

Mr. Mohamed Musa.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AB0286936
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgJGUiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:38:17 -0400
Received: from sonic302-3.consmr.mail.bf2.yahoo.com ([74.6.135.42]:46309 "EHLO
        sonic302-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726041AbgJGUiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:38:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602103093; bh=lZt6zGgItlgNlCAD+ZRtvUsnME7lCnJlzSFez5pfVOQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=sq9S2fuoeI0O9aVy1MsPZuIUoOCin+z6UpUjry5fhb7zsK5fW1PSWdrIFV8zdauKVeJqIhmA8E+k9XNP45g+EfSmH5VIA5ZdpvJSK1FuWYlU1cS66h61pk8mDa39MSGOt5egROn6kBEe2LqcH5qGgix4ShjaKt9+09HretkOro3p0ijHRmUtkki21ZdO7xM4r0nNJSQEBVL3evLBzcSqa9kHVB2bob0PnqJqpRl0itbs2+j0FfQ9ckyBBXcIFS3qgQBvInKcSTNluNcAolhM0GdvXZS0zAWR8sF1DKWSA+x7smp/wtYWdnCFhD+ao+xo1aJwN1K2IKVBGUlSnyknOA==
X-YMail-OSG: GSNkcTAVM1nFteOlpXsfDjOzUDoCQCqiSJDhw2fsZUH4x27Ret_kSxSFIeqJlu1
 8P7HduJQDGd0WUedOYRtDv6rtul2vPeB6xP0uqxocEakwx0hn6emw01l3YR6fKtTDqsTuCCEpEle
 16UI_WF7aAhyOtqRtn14Hg8LDHZPGXpsN6B7R..IFaX9vWNCG.8xwfozT0XX5ll3O9r82TBofbJV
 4MgZVUORp.5.5urQnsXHTuNwSLM1cswkkL70T2VMutw9gvdmI9tkNbD2YN0ijZWmiX8ivZS9dxk5
 khGcPp84KTLISv_7JvxqFJuTqEys_8nPpbpBSctiZJBosLdYGAFKROa_DQkUQNsNJMqcEPdoajso
 Z8MsR6RYREonoRS0qA1rBAYgyzcooxqzb6il78oUHlN8TVloSN_W0kDAMG5PxAjWXgUH0VdnOLXZ
 4d7O6bu_uJhundWCs4Ax3lNaJJUMdSEppAocQBI24fZhKKXZsHvJexUvhF1QE6xuYYmnqf67lEQ2
 4y5l8lehe.9.iLICU5oj8iZiHOgDOdnWvgm9hl4eCuPAfnac5AQfubVzyOiI2zbvB4Dr1TQGUZbd
 IpFVmtJ2yUC5dYyngvCYBaNHObHRcIl23MnijYnjzuJg6k6uizZoaCee_80kUA4jgEtKAUuZnqI0
 TAo8oSgaFqK_sppQqQ25JnTJ2IrZXAIk_1THAUJhGrv1ipZyYJFXWYbboz47LRuNhrkR4KtK0oNN
 Cy85BqVldCqkI2BQbL.E4m56wHPRqm1r1OUEsUnLnyyd4e_SXeSjvk8ubGG1zYgBwEXszurTdVq3
 W.2wrGS8G.qXZL2TlbKvD6BZ6rh3gLzAvDDlcHuxzzmSh5mFi6xzbWljoYWrHMtLpKxFq93604Ni
 kP43AB0VLFaTjMiv9szeSZD_Rh4kIwchzChOhfuHFrpzlNIBx3aTZu3BGo6tb1asL19saMTnKETY
 HsfDbkJK4JNVB62GOpeQZ8a4FaEQYwd8kb0quStmI_23CCe.mtJlEud.NvtME3jRsy5kvg9K2VEF
 Gmn.w1ZE96pRRpXO.M9wUiZXnPdVT7AQFhjwuWsZUsizhebS9AlhMu2aReTXXCft1Hj3kjtYKMgW
 Dn3SoVJpDzZbxZ45se_HcUf.fmvAGK0RSpYj4ACmACaB.f8pTxzpXUuw_L_qtueIYlJHoM.a55B0
 QlncSQCCbKfzrQkqVlwoOlJQUm9rpN4pWGoOgSyJ1sp34luv2ikP5FBhTIUFKgz6Uqq06lF_IKXe
 JUAl1RzgE3PFRGshAmCDKqVcUNZHqOGNsx2T8W26ob0DAQNLqnQumALMu1phX.PPjwKgE7Vi3m6f
 AVgxNgcpjS6SlmWIDOevvoTz3ak4ywqsaqNtBrTw5qOvqEnbjeRXfMJeBP5RoMjbsoSG.kzyJXL1
 xMhYl0yJQ39KZrwFWZx2FS7xKWdSMO3V5oYVDlC5XDtE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.bf2.yahoo.com with HTTP; Wed, 7 Oct 2020 20:38:13 +0000
Date:   Wed, 7 Oct 2020 20:38:12 +0000 (UTC)
From:   "Mr. Nor Hizam Hashim." <mr.norhizamhashim01@gmail.com>
Reply-To: mr.norhizamhashim@gmail.com
Message-ID: <356927829.238709.1602103092652@mail.yahoo.com>
Subject: Waiting for your urgent response.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <356927829.238709.1602103092652.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Sir or Madam

Please forgive me if my request is not acceptable by your kind person.

I am Mr. Nor Hizam Hashim, who works in ADB (BURKINA FASO) as a non-independent non-executive Director and President of AFRICAN DEVELOPMENT BANK. During our last banking audits, we discovered that an account abandoned belongs to one of our deceased foreign clients, the Mr. Wang Jian, co-founder and co-chair of the HNA Group, a conglomerate Chinese with important real estate properties throughout the US. in a accident during a business trip in France on Tuesday.

Go to this link:
https://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I got your contact from yahoo tourist search while I was searching for a foreign partner. I am assured of your capability and reliability to champion this business opportunity when I prayed about you.

I am writing to request your assistance to transfer the sum of $15,000,000.00 (fifteen million United States dollars) at its counts as Wang Jian's last foreign business partner, which I plan use the fund to invest in public benefit as follows

1. Establish an orphanage home to help orphaned children.
2. Build a hospital to help the poor.
3. Build an asylum for the elderly and homeless.

Meanwhile, before contacting you, I did an investigation staff to locate one of the relatives of the late Mr. Wang Jian who knows the account, but I didn't succeed. However, I took this decision to support orphans and less privileged children with this fund, because I don't want this fund transferred to our Account of Government treasury as unclaimed fund. I am willing to offer you the 50% of the fund for your support and assistant to transfer the fund to your account.

More detailed information will be sent to the desegregation explaining how the fund will be transferred to you Please continue to achieve the purpose.

Waiting for your urgent response.
Attentively
Mr. Nor Hizam Hashim.

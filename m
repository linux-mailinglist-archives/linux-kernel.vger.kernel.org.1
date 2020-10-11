Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93A7228A80E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730138AbgJKPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:50:46 -0400
Received: from sonic301-2.consmr.mail.bf2.yahoo.com ([74.6.129.41]:42427 "EHLO
        sonic301-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728967AbgJKPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:50:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602431443; bh=JUyig/X0eBuzPQnHzQ4Xupjr4Ixq3uZo31fzgq+8wjI=; h=Date:From:Reply-To:Subject:References:From:Subject; b=hao02c/tae6R4tW+oJn1DDvetgmUSe+N1AdE1z4w0qWlU1PCf1N8BSqtINoaiRNUhtOMfesKyFqvg9u77kXN75eL6JfA2dCpXUcefirOYud1Y5320Uodck+uviC2XX4ncCewZvQ3O0ZswoYLn5Mr+Q+VJnIJcdbBd2/rvKaJ5UpoOjrYDeyC7YP3Z2/rTYq2tyf9DL/f+q43HJ5g7hz/RPwkyu0kWPjC5dwheFs0nDt1nAXETibgiNrnAskpXJjOzIKyyLqesJO5lAZWaXgrQXzIHFCYlq9NZ6u3aaioNUDxTIklocY04RwGbHL3QqQDHHA88JXM0c8SHhIrcrPDpw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1602431443; bh=18mzV9xTUUhDDFfI9W2HFhz1iH8SA/01C7FgzLqbIVJ=; h=Date:From:Subject; b=mkZX9IZDdUsSPvc+f5Eek56WONUEJ39JDCKP4BGDb/7L0/qoCHJG7+b59AoxUMTxtUhK14WoJs90yqNmxO+LFdh2cd2oPtlI8kIyciTazR+LOV/agSEuFQXw8sfrysa9xQsa6/6vl/qBItivrFhPTsOJvGl+xYogABOmjQj0ubhzit58A90K/5Pq3nF5tkS+rGZaiQPpvURUo6FDf1XYrw4ytG2/R3/+f1mNDRq/DNYiXPhaxLL8adFLj+DdCAl1mzvBqiYGzH50XduBHQFjTHOminBeOwXzW0R0h2wWkWMs+LR1lvq6QnvWXRF7HHJ+sWAsHif1PTCL6CPQ7JHbnQ==
X-YMail-OSG: _Zy05KEVM1m5eE.uu0SJymqo114Jt0YAOADscT_e9PXTPqXp4U2KnUpxQtYw0iQ
 rudzXm2KmRq8eqBlk6QCGFY4RiU0Ju4aEVVJvMS1EfHqHy_yATFGKt2x7DWKJcQKtGtOcY9ROPM3
 zOItwgsHqdiPMaaczZK67rmO1iYjlbq5ZbAkeo9clqbxG5azCS1J14Ne_YkhK_KNhsngb7AISEp6
 BjFuD0oz_hy_UGfxe7ZZPCrixbLjsejl5rsRljm5N4WSXLsS1CUdjjcL1M95OQpb_5UQf4s29e_7
 Z3uwcHS3G7D4IIVXEeFu6l5ne.7Y1K7_ssq860aAvWsBs4n7gIz9ro4psayrGJCdcWKONKLM6GBR
 4QAqj2DfundouZXNeMXKwSCJL4FTay7UgbqpivBbz_je_f0HWXjdtFhrFZ7.EkIg0bhDkctsw3Ap
 jCcvIvLsWmgeJUFXEG9.foLbZ8n07nEqle1q8UOwz0C73CTjjwdx1SBbKDvHsuaMrh2EEhQU25vx
 FDYgmj06M9TLltWW3hXmCMbg6.6XC6XTvrcYf2.vOp6rfRl_yXf3qsEv.0Cw5frm0UWH3HZpY4RK
 JXpfg5yZTLPCScXxiMuzd5DIS1TbEVDE89xXm2JmeBX_j1vE1TxFRILjUx9tkzAz3E9FZl96s6Rm
 ffpzEW8cvJkVthTmFeKEgA4Vk.iCXHT8rsC.UjLBiYyQ0wzDHNTHWF5sElg84MYsuUxLwXKDaT05
 6wKYE1CZovRrtzN8kPWEkOsUa8YlAmiVP8mjkeWZ_VJOdOPD9pqPuaQP3K7_O4N.6k_QNoniU3cw
 JH63o6_qUYmXuS5WSScwTNw6GXWL8jFsCyoO7P.G7prpcETUy8_t1spCIvOSrE69avuu.BcwFqyZ
 O8OK8Z0t18rnWEbek6rvgp4efdqyY..MwH6hGgaJ4Fb3jxCWJkBTDoCHVTvBYltjk7VAa6b7tZvI
 Qo9nFg.5o_TuFW3tDE2fFigC1XEN01gMf.0xk6Q8T__VqhFymP0tJgqZLilRDU7FvlcL6ZnEhA1Y
 94Q.SnpFJtUj_.InyatKbNPORr3aABmZ7qaUxDmL58Jj2obdl2aA5u3tAeAK0i.Ra9lEEWufiYUA
 aMldxM47c9b9k95P8X2OmzccxR8l_QJCxxA0fIG0NaeVLEDfSNOGXbi9Zrr__oR_D151Y7URLL4T
 r2lri_KJC09AIWE1xfuXrQeynN6SmaDDbrhrWQ9wOV8BevQIoRpvzTA.g6_ng0v..A8rkPBQEroC
 LTQQebKAQH.QKPeCI9xV4oDg90rHmFTBYfVplmqbWzCj5r6MrQ5rA3.nrr1rtQt_cIEJAnbjbGSi
 SoOr.yxafbD_.lmyrrfox8pcV2J1JiRTKkZoGnO0RbxsrwaslFOBzbK9GcOBukgxJSTnGhVMUdMZ
 35khi3NTig60xxoPaxvYbVuVSEPAPRzXYZnhHn6x4kuCKId0N
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.bf2.yahoo.com with HTTP; Sun, 11 Oct 2020 15:50:43 +0000
Date:   Sun, 11 Oct 2020 15:50:10 +0000 (UTC)
From:   Mrs Lila Haber <mrslilaha.ber2016@gmail.com>
Reply-To: mrslilahabe2016@gmail.com
Message-ID: <1030014783.222257.1602431410556@mail.yahoo.com>
Subject: Dear good friend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1030014783.222257.1602431410556.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16795 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear good friend,

I greet you with the name in the of the LORD Almighty the giver of every good thing. Good day and compliments of the seasons, I know it is true that this letter may come to you as a surprise. Nevertheless, I humbly ask you to give me your attention and hear me well. but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Lila Haber aging widow of 57 years old suffering from long time illness. I have some funds I inherited from my late husband, the sum of (19.7Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.

I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the bank issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 30/percent of the total amount to help yourself in doing the project. I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our today's WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.

This fund is still with them and the bank management just wrote me as the true owner to come forward to receive the money for keeping it so long or rather issue a letter of authorization to somebody to receive it on my behalf since I cannot come over because of my illness or they get it confiscated. Presently, I'm with my laptop in a hospital here in where I have been undergoing treatment for cancer of the lungs. It is my last wish to see that this money is invested to any organization of your choice and distributed each year among the charity organization, the poor and the motherless babies  home. I want you as God fearing person, to also use this money to fund orphanages and widows; I took this decision, before I rest in peace because my time will soon be up. As soon as I receive your reply I shall give you the contact of them. I am absolutely assuring you that no trouble is involved in this money because this is my late husband money.

Yours faithfully

Mrs Lila Haber

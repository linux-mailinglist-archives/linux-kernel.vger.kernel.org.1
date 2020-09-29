Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D002E27D2AA
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728395AbgI2P1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 11:27:16 -0400
Received: from sonic313-56.consmr.mail.ne1.yahoo.com ([66.163.185.31]:33355
        "EHLO sonic313-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725497AbgI2P1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 11:27:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601393235; bh=Xr0ztq1I874QeBmeccNaswBgmnu3ktiw+E0tOg3mgcg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=J8l4kouUMQ3Eioh7aMcph7zTyuGD4NVp9dV5iihZ2Pz8HvV+teONyCL7rZ5Mlgt7/E5V6sR6qWcuAcA/KrWhI1qwsxV/bAC/QIgT9j3G6vVsTlh8K1aq42cyImxNoO7rInlqgA8cGx9IE4sZeP2paAMDSjyC5WYPd3iy0dkzjQobNFY1I5yFgN6KWCx/yDSyS9eewt9Y1EYgPXTUL5c0aaCWocJWNu2rO0OVrEQFytE1LG72n+L7tsddXwfx5kjtB6h/d0CG6U8Z6h8f+Mo8NmtzSfrBxuGtbm0n1Krt/0IUzKOAqyqCbiEf2B9u5knBrZPXdO/yphp0CwGRxdBikg==
X-YMail-OSG: jBbOjesVM1mv1PZRxQ__uAfsN9T1GymD1CbI44TEDXwCqtPn1qS1AdZDRbFYiM6
 mq6V0odzTRdn0lo7NEGBk7hR2e18gbdus9hKolcz2Ve_3kFPZagLNEzTPZIVnnH4pTib4zP1TS4c
 4jjBJgy8tBk6FJL1b2Gn_hAj6gw6u78RBHm8IevgiQujCSSwzq0dCHNbgAKlgTs5dOQ2YbUl.vC_
 OXF0XY1wE4bWGXN7lKgjC1sWRcYLsXsR34ri0kyRp3WDiignYBIknq_1rtxFuT.2wBJ8BmOY6taE
 Ecls3n1h6_vR7cLlBoHx1B7UCgMoqYkT4nG9IHcDzteIxs9actMbqLdblw7twEVlwAuqkUOb244B
 EhyfXmesfOriraGs22afkYUDMpXHEH0_mcjiZK3dIrQZKihvkqg4mK3dz6EDzAXCivHmYXEPwZX9
 dFzMfMlFuWFMY3ktkrYsI7JJFEkYQ9.nXErU0wkpFQIgS9fhkW0949M0EClIjNxythg_f6uDLJRy
 X3MoXg0IXh3ePznWq33LZiyrJLl.0TBmcWXFcQ.xo_JIl8HozoI3xROM9QRoZNt17i1dSm6MZl0r
 tGnbjXEL55Pq8T6201sDdnbc1_7d1D.64nPwjmA.wi9qf2yt.RprRPJtslY.KOyzhNzLGH.Jn6eT
 0sEIcmOkWU2_g9nn3SaHUZy88Dyu7ovDIstgUmrPKCXx9pJ9hyPxFB4QXtodFc5x3oBqEl4axqnf
 030m6xgr3Swf6TYzhv6bPFhus4wqQ2VvGl2T3T9J4xsND3hCZmuWyY2mGMVLp7PxfIzqN3sqQiip
 iLtrWmU7Lwkv65vfpnS9KGe78iyjxO2QbhRRJ97dbzuIVwo4xmXBMnLZws9.f_t_hviSoH6TNKcM
 vn9arugnMuqpx7qc4SbHBgo06yTSN0uJz10UDFQ7mzuulmIzPPcu2r2_ZFssxx9jpUkQsOIANAZi
 KB9waljQU_hcgQOzCC7pBY3_gmv_49FERrAokqQPO4FKLOUB5t2l6aph8russ2Td2YWNzS7WLQcl
 cOtpALUfaN109IgCvgFsvRXBYNLeIMRJj0fnYSpee0LP2RFPS5tY_xR7LJaop6jOq6KtXuMVqRYI
 gWBynxz6ZsoELN.mXuVHq_Yfqwni.8NFJy6gijMaMgijd6JWegk4eEeBCmcNcn5nnShrsMmC3fra
 ss0.s8HUef2unaBxzv9poxYIefOUsUsnZQzJyBIKJbM9W9ae3uUg_ihkro.KiIK4tQIWWluU5CuZ
 nQg4KEZ5tppCtzRPlXnJScMQTxV5Eo8CHkhf7P9yCgxh5zUzNMk68BOWY.78cgkTDd.FyM7XQOuC
 DhiZuqBc0AAm4M9IchqUUd45AynCuyz15iXXzIZErcXrdLejlClbnQEEwaaE.8kXayTe6oxNMzXP
 ATZf0hQUek5ia3sg3zEWF49Akg_ELVUt9M4Bllqq7qPIlwjUd
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Sep 2020 15:27:15 +0000
Date:   Tue, 29 Sep 2020 15:27:10 +0000 (UTC)
From:   susancoulibaly <susancoulibaly5@gmail.com>
Reply-To: susancoulibaly40@gmail.com
Message-ID: <494319329.238805.1601393230864@mail.yahoo.com>
Subject: Dearest
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <494319329.238805.1601393230864.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dearest,
 
I know this mail will come to you as a surprise since we haven't known or come across each other before considering the fact that I sourced your email contact through the Internet in search of trusted person who can assist me.
 
I am Miss Susan Warlord Ibrahim Coulibaly 24 years old female from the Republic of Ivory Coast,West Africa ,am the Daughter of Late Chief Sgt.Warlord Ibrahim Coulibaly (a.k.a General IB ). My late father was a well known Ivory Coast militia leader . He died on Thursday 28 April 2011 following a fight with the Republican Forces of Ivory Coast(FRCI). I am constrained to contact you because of the maltreatment which I am receiving from my step mother.
 
She planned to take away all my late father's treasury and properties from me since the unexpected death of my beloved Father. Meanwhile I wanted to travel to Europe, but she hide away my international passport and other valuable documents. Luckily she did not discover where I kept my father's File which contained important documents. Now I am presently staying in the Mission in Burkina Faso.
 
I am seeking for long term relationship and investment assistance. My father of blessed memory deposited the sum of US$ 27.5 Million in one bank in Burkina Faso with my name as the next of kin. I had contacted the Bank to clear the deposit but the Branch Manager told me that being a refugee, my status according to the local law does not authorize me to carry out the operation. However, he advised me to provide a trustee who will stand on my behalf. I had wanted to inform my stepmother about this deposit but I am afraid that she will not offer me anything after the release of the money.
 
Therefore, I decide to seek for your help in transferring the money into your bank account while I will relocate to your country and settle down with you. As you indicated your interest to help me I will give you the account number and the contact of the bank where my late beloved father deposited the money with my name as the next of kin. It is my intention to compensate you with 40% of the total money for your assistance and the balance shall be my investment in any profitable venture which you will recommend to me as have no any idea about foreign investment. Please all communications should be through this email address for confidential purpose (susancoulibaly40@gmail.com)


 
Thanking you a lot in anticipation of your quick response. I will give you details in my next mail after receiving your acceptance mail to help me ,
 
Yours sincerely
Miss Susan Warlord Ibrahim Coulibaly

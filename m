Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3BE1D31BF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 May 2020 15:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgENNrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 May 2020 09:47:53 -0400
Received: from sonic301-20.consmr.mail.sg3.yahoo.com ([106.10.242.83]:42013
        "EHLO sonic301-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726161AbgENNrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 09:47:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589464071; bh=KpLOSNk7Dsb2atJvabHeqrmdZdu2sv994fIPrqoYb3o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=sPgFOfBrWrld18Hdb4gTMXzyD2DFrdox7H0myBw1ROazahuBRp+0c6itkTtyBaLVVtzB9IGCbnYTuyi7wf3SxIs96srGOOPQjuWc5xcw2Llxrn4FF+apzyZKHLgImnQC4sE3lhM/bULFZtpy6/QhQn3tGJ+ZkaBWvu7JTVsWVbJXKKRH9EVX2WiB4j6tLWnB5ML00g9kV3CPwlSgNnbOp0awI59foi3sdFqg7ReccEpVyjhdLB48PKiE7sCLcKPK9q9jM0bBJr0tsxNkz6keMwKBit2CZ0qR+FqyC/2ozfVcUxpYan1bM9Q2UIN8dLHexgsuaL+6T7ETH5iOaVjWog==
X-YMail-OSG: EqtLuPsVM1mONuTokiPg_pTIHRKNmFhqJhyr_g6VNbJUapn3MFTf6cZCqgq6H8i
 LYEi4eal59kdyUZ89qRlb1g3Tp6WLCW6tOsR.Sz4KbMndQiM.vETwdZoQvxEPvePYlcJTUnIpEdk
 m5Pc9mrRuXO8EoVoUdelb0H.IKIu8TgU7gy9piyUr7cYsaONZfruCQbN4DLdGVCctYR5TckmInao
 3AkGGc_isGQv4lzLNYYcS_cPwv1IB6jaTDHbe2La0xSIE4oeiUq8zWnziY3wAm_u_i7_VHmzyxN9
 gwFNXebBXvuH4SZghdaS51EfQGllVQj4MkDR01E8D1I5Qt4XuS01UeQwFB14a_VrnkRAmJbYud0y
 9ff1xzf.BLxRyIE5PXx2FVddgAcdw0V6D6n3heAg0m21pHKbnJaxnDikcdcgSP0XFeusFnMWdry0
 xJYaCL_ajWWcG.hXOhK79njAT7gBkYY6xhBf3Jmk5i4n_eQ32lnPgEUlGZs.DPAzbx_MzJ65EWoU
 jTcK8E64JJYG9UsCnDpr82Vp6YIO52begdH8k47br5_5orWOe77flwpPZWg0oJRmcyNCawKjRRvz
 95BJtfp7r59KozE7xyT50b8l0bErBy3YLqCn6p8DydK4PNmdQxjtaW73Fm0GDeqvewRCg7jRsx.i
 pTwDj2vFjfR0FraQLiVolNhgs1XENgLafFc14Hzb3Z1pNnieORNgFKhPV0Gsz4zDmfEVymLg6x3a
 VDtnf9DLqpLBI3bCVUoZjcTW21BtCrKIl4d_6XyZRsd.M_ux1UftPwjKsabtThYAjcvR9MaKjsph
 cWli_Bj0WVjkrEUM1fhn9ay4GsdWOYl3..SKiuiyHtuks5wMi0OAx.HqnKLMSsc.pNw0qldu2Efj
 MTZFdV4NFt1mDtFkw1pImZwRea.5BluJmAhNyK.N38rffJuwoB5ic3kE77S4Aun6rgnkv3xkWG7a
 5JCqjXHlBFTpMO83z5KQYVrL_a8vjC7gqCAOZWzSLQ68765aL0JINpkqbHA7YR1ZbrN3T0VArCQN
 ivAQqrU7V0RprWZbjOgBnFRuW6CLjdPeGcUjEFgGi5LbEQx.mkEnqH3KiIIuQOuE58JSpavVmu3u
 6B0CsrHia4UqEkjnlMyCxt5E7MA4OZ1jzLdQ2mG7XJYJbeiblpnmUWrSS00Mi3deTjEEcCto8qAd
 o__0uY5hdxRDd2aoDKAndTIggAOfBwK7nP.xtMIBUQbQACvp5JzHIM6Cn4xF3SJSVkWQQlluW_xh
 VsBjYZiU5Sh5H0LDm5MTMibxrWTp9VskGP7XJlezk.kmmNIAFx0sVhNemFZfUQou..cnFY8UPYmq
 .v9dVmatzB27aVGLzjQbkq.YCYJHnOT.BfQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.sg3.yahoo.com with HTTP; Thu, 14 May 2020 13:47:51 +0000
Date:   Thu, 14 May 2020 13:47:50 +0000 (UTC)
From:   "Mr.Sani Ali" <mrsania52@gmail.com>
Reply-To: ubaatmdepartmentbf@gmail.com
Message-ID: <1878760449.197005.1589464070742@mail.yahoo.com>
Subject: Goodnews for you.Recieve your 'ATM CARD'urgently
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1878760449.197005.1589464070742.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15941 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Old Friend,

How are you doing? Hope you haven't forgotten me; I am Mr.Sani Ali, former manager in a well respected bank of Africa, Burkina Faso in west Africa, who contacted you some time ago to assist me in a business. Though, you weren't able to assist me up to the conclusion stage in that transaction by then is very much happy to inform you about my success in getting the fund moved to Iran under the assistance, and co-operation of a new partner from Iran. Presently, I am in Germany for investment projects with my share of the total sum.

Meanwhile, I didn't forget your past efforts, and attempts to assist me on the moving of the fund, and I makes sure that you aren't left behind or out from the benefits of the transaction. Hence have kept aside for you the total sum of: $4 75,000 (four hundred, and seventy-five thousand, Us-dollars) in the United Bank for Africa ATM department. I have compensated you with that above said amount for all your past efforts, and attempt to assist me in that past successful matters. I have appreciated your kind efforts at that time very much, so feel very free to contact Mrs. Sharon Mohy, via with below email address the bank ATM department manager for sending of your ATM credit card that contained the above sum in your name.

And make sure that you instructed her on how to send the deposited ' ATM CARD ' to you and please do let me know immediately you receive the ' ATM CARD' so that we can share the joy together after all the stress at those past times ago. At the moment, am very busy over here in Germany because of the investment projects of which my partner and I are having at hands presently, and finally remember that i had left an instruction to the ATM department manager Mrs. Sharon Mohy.

Therefore, as soonest as you contacts her for the said 'ATM CARD' to be released and sent to you, she will surely send the 'ATM CARD' to you. Below is the contact of the ATM Department of the bank, Burkina Faso. West Africa.

Contact person:-

Mrs. Sharon Mohy.
United Bank for Africa ATM Department,
Ouagadougou, Burkina Faso. West Africa.
Email Address: (ubaatmdepartmentbf@gmail.com)

Tanks from
Mr.Sani Ali

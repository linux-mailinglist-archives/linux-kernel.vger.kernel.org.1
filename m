Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE31F221906
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 02:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgGPAnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 20:43:39 -0400
Received: from sonic316-21.consmr.mail.ne1.yahoo.com ([66.163.187.147]:37634
        "EHLO sonic316-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgGPAnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 20:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1594860218; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=U+wB8fGVDS4XetaAW0YY3qHot/n9C2CCPb9ASxClRBmuxxqMaD3bXEBZDIoK2rryCjRmvpJpzwFfZlIa3fqBURcGmSqlsnQ09ZwGWzJt+HK7ii5Fk6vfxLbw9LAc4ONti5jmeFYkflDds9W5pKPK/oHsAltOPGdo2xRvywJQB84U+M+iuHHS9h3zRyOFeAtvN4RaPyA26hf+XV6RchuIFALYTJ3SaYE+AkIClz3Q4wyXfJMRSXJMOZyIPHMk1rO1uJg0JHHnosxQsJ7tKD+gbKmhCZborqKt2OJJNFgyDg1xMyIGvFbkZRPsZXW0MJ077x3V6H4AENOxasF6F4g53Q==
X-YMail-OSG: 4taW8NYVM1lihQP0IettkhKlYb_BLY4ndyT0aD_ZO7IkArw50WR9InnuR7C2wzo
 pc9OBi5btWna78VEJYnuhWAahRGYChf1oEs3KCREZ.HmMzeAkjcvYkyaXtZ5opov9Zsz3QyHLBPn
 ahlRKpgcAYdsZrKij9cyUszJU6C.OShzF0_odmj9FnjF8fgvNC0GjBGV6Vi3AlyMM5T23b30TA4Q
 kOKxrtrdEu3iknD2OmAHDZaD.N9oFN.Dlnj9eQFmjRQk6HIV5Gf.8fwldXA8VCy6pdGSRy0ubj6j
 Z85dbPl0f7cFoLK74zdKWJI8QX67tVGnbXqB7YJVmThM.ITlVuebr09Osc8C_pYodQjKgy7ZfzqZ
 xHDDS_a6LYwIXlLFpmdND2y4HCu3jOfkNkM6dXVclyC6zzVep46tmSbTtVg5FkF8v_lrBdpmYqyt
 DtjSG8XTEltB.1mcwhy7pf3hr0PysN7NmXROb35nH46HL.ZON.vI4C_O66R39eoZKQYtn63EaRkY
 QZxl1FSULCB1PE2aixb38_Za8O77u5Yw5lb3W2IgXEEQAFeQvs_UJGomNx0YDcMbm8lypDbYs5l.
 8i20baKQz1UXoTRPTPXggEdbMVxZTFH6QqZXEkdU0Wb3fJK7wqo8ORxF6zJYaIwlu50PQu3yzYnC
 7y2ioqdIXsvIN39t419pUg0K1Wp0eMnGc7gTDr.1HVzJAgdEG7USHh89Z9qgwTcsfiesyWWBKw8e
 kwZ0pnVwZZ4QndRV9iygBFYL5ZFrQix9wiluh1yUon7Oit1mvwCxN3lRtC6jGzI3uSQrB0hioah2
 kzvHPeBCKW0CnZt399hVDi2YEVS8q17eT8waKVsc5aRuijZANbhC8blOsp.iOQsJx5kPDySFPmfP
 222jT.aHf4msAzGCQok42SBzK5QwpQdCZ.AvriM9spa5F1mfMRQnmtZndarEmLioS3MYKejbKrrf
 9goh1kzSFmS3khjAP.HxTzoW.5iR.4XdSbHS4a1mPd8vPLzJ0ViuuSVgblVqL2tdUt6vtagHfXCL
 dluQBhnaxNFBsmIkk8XVtcLiijvoQE5p.cTMxqQ_BEtX9f2egc.HQQxUWO5k3JRChzrySBStwkEk
 TeM_GKTHrIFK83dymWVcz0dmZQZGQ4ZDAEtxoP7jD9S3zDxHJ8LK1ns7ZowRAfQTwVraJqS64Un.
 AG3KlJWqdAuUVXVFrrAjxfGnrvGnoYIfl6xLKGve8Xd6WO2AxpVnDczpJcL9x0bV_qkWOkzrMlX6
 rJikc9uv114af_DLMHXlVQVwlqSgp8HKvKuACWQHhWiw1DHwRH9Ipox6a6hwLYLqUDG3Q6To-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Thu, 16 Jul 2020 00:43:38 +0000
Date:   Thu, 16 Jul 2020 00:43:32 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaaaliyahbrunel@gmail.com>
Reply-To: mrsminaaaliyahbrunel1@gmail.com
Message-ID: <364574036.2388432.1594860212939@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <364574036.2388432.1594860212939.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64; rv:43.0) Gecko/20100101 Firefox/43.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel

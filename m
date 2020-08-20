Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4384724B9BA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 13:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgHTLyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 07:54:05 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:39997 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730769AbgHTLta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 07:49:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597924167; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=fVpA2PaOHl4uT1O1PBOuxcRp5LiuEcFxW9MMLHESOiTOzs1jml3sbBxlmivU+U32GIAql8neFn5+r+aZ6z2gnJEhzCug7Cbv/8X+nvVJlctCTpELiOkY43oGR5Ef45qCSr8iUps1CYNMs88OFShPFk0BbKvMJ5FDC5YpOEvNvwW47PwCcTvCRx78pnMqVHGymrweSFuHT/gxsXPYU3V+Af4Hh57E+KqKTybtDLiwD4c7zI9YA6GJZKrsVU3Dh/g7cMUgSykkrUv2MxV8M6+cvkyKjdppi6/UUnl1DPeRUELh9Pn+AEj6soNOOlooNngAkZC92EtzXU9AmsFyZSlN6Q==
X-YMail-OSG: C.VdJtEVM1nOGwiNQkN5Xjte_LdWU.QcDy0brPn2UN.V7OlZS5v1wG2CiFjMtqc
 PRRi6YArvGMGICBkzs0FyIUZWrV2Ji6B2u7nrcvizYuRXugsavqAosxaA0019qZAt3pf1.aGmV8e
 NI62IoQvsj7LMwgSZrtreWL6_6z6IZBjxjyQSYW8HKVQVWj0QmhKavcG2wQbXTqmWK2Q8ibCOZCH
 3Fi2D7.4oc5_mkpyrWlxcimfLl3wo9OwO3D5vp9p8d_U8.4BIGfUQ9CSpBFpJtzRfOHfIbcjlzt9
 lId5nIBzoXPs193xkuofQ6w2j2WIiCrKw_BWX1a3ZUWLJ7G.wdDfu3KTMTU5..8zK21Icamsp0dE
 0u.aWHt7PqDr8.usG_JR_0YzGfnmLFJ.4sLSZm6QJI3BIgV.Ook_gLYtlwekk2v49_OB434qsmwr
 gcSJS25IRnyYw3N7_mB8AvFQxX0lvv9TCm8lvMoKuQYlDudNdIDZ0m9uc8j.qfvxGexx.Lvi19Ai
 vIdCsAY1PUJ5kKsWbeVdh1DFDGuucEK0XtPHkSkhKX0QxfI.C1bFdIQTdyMYff5_m145oHpdy0ki
 R.ZN3wJ.O_y7b2oqUdvku_lAQvTRKkNYhltXxyBBAuAxcVOTTP5bNdahXXzWpM7nznNkxQPz1Srn
 2Gi3b_btE6UfDSthFxgdQPAT_F.SJJBTpaZFsZS3oxNs.4QSpV3MmXns4v_ks2nQv4LUIyBjlnIh
 tR6OEpCWJIv7ZOFKzTt6Uve2Owriy2DQrzcpblqX1WLxRaLCRNL2Y5sb5eAQBtp78YyyCIzUEbv6
 aw7fIR3TK6AoShRNeyub_HAe_n1M54wRm4Psq5rtDpf2G6x2SIBEanr2wVDWnL5isOUSFbjgtTQr
 M8v9C3c7zR4NH_9mdbcCMcyS5NIvcquPw0RphjyzzCVW1ekJAPzHUiJSwoGdEjw3KFpzhXyf6sBG
 BPHjrVJk5lwv41tbbNPg1IXRzvDT0gyJ.abUuL40z5_tibD4yVZ3FHxp_61Uv813N97fdrEnModt
 tMw082yqhCG3LaBMvUYnTX1pp_Hiy.k.hc4T9Xw_PbGJmDvyAbMj6N8K1kG6E7u76SiMqCD880Vl
 TszH7BD.DzbdW.xemBdkWLPiZ7gfkGBbLpteHbN626ysXIxQXHw_D4OA_nRa1eL9bzBstbISmqhI
 aie_lFDZ_fnLxmxptL0TYQLKS3X4Ll0CU93RgrN9m18axH7Thl3rIHUjIVNKKOiKF6MU0Fu77A0R
 2faonhtpZ6eRpshOA8yHDIKSrtSC2KczDI5P3cyUMqy6ockyh5NQh9SlFW3hXws0IcwK2W5xw_c5
 FPqcfd88lhSYvJpBe_I1tIRbeYOAw23CjEXiYdn6MfjReYuDYGl2m
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Thu, 20 Aug 2020 11:49:27 +0000
Date:   Thu, 20 Aug 2020 11:49:22 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsannahbruun4@gmail.com>
Reply-To: mrsminaabrunel653@gmail.com
Message-ID: <450024180.3660223.1597924162646@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <450024180.3660223.1597924162646.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

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

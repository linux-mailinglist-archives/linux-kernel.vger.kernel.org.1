Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED041CC3C2
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 20:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbgEISu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 May 2020 14:50:29 -0400
Received: from sonic309-25.consmr.mail.ir2.yahoo.com ([77.238.179.83]:37171
        "EHLO sonic309-25.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728005AbgEISu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 14:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589050226; bh=q1Er/SdqxATomBDx27mJAnsQxxrJWpCL+Y8MaW3053A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=KYrB3iuud7SRX9nsj+vszLgDEE9AmJyQ/AouucQHZZZFr4HYF3g1q2Ug6F0owmJ+uNUyx8E0sWUgULYi7zyJtQ07W3MQqJMzC/4i0FjFEQ9YJlTXvVqQcA8WFC3mem1CcuClNE2+Ip/LvH7htQbGYWEtEi+4tJ2Vg/eV+UT1ucwuOfD9x1g73c1miFJx11/uC7CCTz8pgwlkbIh+ZNL1k7ZBTo9FXoC2RsZl+fLs8R3Ls34WlSnN8OTfKb5zOn+yQFhUoMmIhYmuBdLf4bEJ+pDEqeXoViN4ng3Ly4abb/oNJmukRmvar1avoBU54Mxj+FMu8YXo1Z53HaZwsXQTdQ==
X-YMail-OSG: oKo66FwVM1m.GxpzYW3llSaXdWlLuDiciI2AcfUOU0fGX0o2GMotIrabhmxT2tB
 XwXmEbX3J8WGgdLpb5JQKVG8i_gFj19Hqoq.P5GmgVndPpVogU_A2zNn2YtgytYWyyrzrysB22b2
 9rmctuIg4E06dXyrMm.Dbur5Mh7vaqTkqHlC51Zmo5ja_xFyUdNQtdrr50WMxLDS2iRDRH3QoEwm
 379I1gpE1_ln81YqMW3YTkB1.T5qEK0WpUkGiK.cZaQgJVaghf6o1v2cELEI_SIBcfuviOXmt_tj
 fUfYEHZbzbzvzg_G0p.CmvVBZOfS0mRRqDvjKq_J42_Zn7B.VMcxV7O46IW_Shkyo.U0JORu3GyF
 kIBBjERFsN5NEBIug.IHLdmvwV8qrgwe61xHQRlSY69lf5vmVGedJ8mBh5IXXDE0MyrScoBy4dlw
 RVd0g2W7Vq2j6vrfi1pt2DEfZH2j7rgHgJl9DNUor.fOEifslfQRKHotPR1NGXW8qd7fIDrwP28c
 pgWz0imyH4eirKLXgU.36Elk6cQYGN8LmNMuATK1UDTLFayOHqOFQdOK7Z.s9JyRwGN_dfxszmzY
 P6pmspX_f.YF1IBBHj0bpEjzocpFIzER0I6sVLyCg5AfT.BlZxJMlQUYg50c14jg5KwkUIU2or3Q
 jH22QZSja0pXLzvu6XdiCW_3ir0Kedto3b6IgdXEH7PHfmnwcdI6AZc6lwnc.1kN9uXnPduBEunK
 uGT.Nc5DaqO2ng_Uejx4wtgF60OjwxJPLaWHuRlemEVyMuQMCK7.sYmXD7MgIxeK1BdL_gIt2wtS
 Gu1Y19eTD3.MxPE5pXzps_Rn6sH5YesooauDHB4hN.eJGPWf0DiG04JdSb2fCiWYkBydg7IqFL22
 7FfgRt2u7_DZqzMmRTLHFNoL8tej.4qanJvkeJb4cJxvS84AqawOuM5BoipGsyZ9xcc1qxAKZLPK
 PosFkLj7LDHBBcF_4.0WrEynMv4hPzNBRZ2CLoLAqG.AxxRstycmdkxZoeA2ZQS9Y2_uZzSXstY1
 J1Y5JB9GGNz4UQvDf5.TJXCY5uFjoKYFlmZji9_1xVGA2t02Y_owyaoJNiuehICtIUtazZ7REjhB
 wGQjKTAF8NcvGfEUV69LBbJwtLfLTDU9aUUYKOgEDh9JsxhIo6ogDJ_mNVHNxByXJZhTBFkw_wHj
 Goped0V_PfQBWzZVEHXGgOjWTmEmD3QjZuL2MZToDgd17z0xRHUaej9Mb9tT0sx7BgiBI32SrznC
 gtWWdhhZlyvoTQG2UCicGS2E1v1YjXmjVNqfbBSv97W6mCugw.YuLHPXQ0hLnR6oVbOi6SjWO
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ir2.yahoo.com with HTTP; Sat, 9 May 2020 18:50:26 +0000
Date:   Sat, 9 May 2020 18:50:21 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunelm@gmail.com>
Reply-To: mrs.minaabrunel2021@aol.com
Message-ID: <1477954482.1290917.1589050221564@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1477954482.1290917.1589050221564.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15902 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
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
llion Euro) Eight million, Five hundred thousand Euros in a bank in Rome th=
e capital city of Italy in Southern Europe. The money was from the sale of =
his company and death benefits payment and entitlements of my deceased husb=
and by his company.

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

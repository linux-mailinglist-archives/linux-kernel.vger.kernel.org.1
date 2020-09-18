Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5F52708E7
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Sep 2020 00:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgIRWWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Sep 2020 18:22:51 -0400
Received: from sonic312-20.consmr.mail.sg3.yahoo.com ([106.10.244.210]:42124
        "EHLO sonic312-20.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726134AbgIRWWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Sep 2020 18:22:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600467765; bh=rL9Nereyf6z11xgF2Y4betqrYfTpmZ3zohYWpfFPbDg=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OYCYTyaupNUvZ16CoFi/byOYCyL8mVLOu9Vts5eUXJMHu5WtLJSYTzJsLA3adqegdwkQ7IP7ihy1KzFaLoqk9+NLHZ90pigeIPnDkN66z4hWcY69Cv8ISFpqOJAMTjKH9m5vabBSqGaX3hKKX4lVLyFk9OpunFfqgNJ18w4v/ze38wZKgbXn5clS2Oq/cp3iZfZovVV9JjhAy7w6ne8o4OtmU9DgrVGhQ28nSU7mTw/Ta6Bl8LvBONmlPQahpFj5GMqojSI9PZJhGikU5c/II1nTN8+dydiOnKa2dccDK4/1nmTqoOsfCc+7UOQjC5ZusULFGxt/k+YFxff3/CtUoQ==
X-YMail-OSG: akjqfQMVM1lC60dOhqjmXPoHVTWwgA4vNeOBj5A3b2XWgDTH2_9CMql.YmffCYb
 OrulWkfmgtmgU_5m8z9fCz5s4tcntom8I2FIIBpnY.lwGvir.UkHS02xERTlOhpIWG2iwucbyYyq
 xIwJfGnY6RcPzzDw3vI2MFtAe_nlC8tlujQVYpzwv77gKdfTaBytQJOk8k96JSQpZyLgdyFRtkVm
 .NH4PjY8BKm57vsdfhwBhJYoDJ4nAYoOCSpavkGp_VcPtJLU8WmD4Jp6G9Gnc9MH3yQh1Qe2GGcl
 s3AMTm9hnaWh9KF2ke6euAbFmo5UGlWDiXWSWfq.8soBCufgCHMwA9jxa6uEapCPxdLIJVD_f69m
 3Zpl9XrlZAGzBNRa5yJe55PHGsWbzmHxfBtqfPAjveOlzqa1vW7sDPpK6pRCnHdU2qF9ldnAbubq
 ZKF5FRrRMQkA985ogmGn3kZfPE5LRqLBWIqUO5YqYNWOHsdOI2IDEEt1EjT5Thp6XBgvBbKAsuFw
 ZvcyfehwPPxO.eHgveF_mcv10J9voCGl9LJYnkno6zoIXJLIJcjUEVWFCZKm1aROplLKsLEUIgu0
 jCQBpPR790reDIcsphyux1BJeczxMLhObS.LuZ.ts3SIy2Tw5V2_ndUm.tbLUf2mfbB3WBukjeg9
 5a01OKJDhdt5D1ZfLNhvo5B43EqiFlnMODqInHzcI6Rq7XYWY0vom4K.ZEIK_pq841obeygVAmPA
 GhxRqTFaaGphSpxy8b5lNIU31ytx.dbX65rLLRLx1LCYfyp27fi6oDmdhJiKyvcweUDQDHSypr5p
 6rOEusmITYbZDWPSfDJiICZOjLByuqIGVE9VJbezua7yiiyKplqZ.7cIJV._L8Ih8Clum7KZ77J5
 6JT6yUKEE.XF0nYVWj7a_3p8JnwUdAUrK0cVJOTFcxLpYt.PY.y77Cq28PjU3GVDaRU41MkpQNAu
 GutjU3i9eTqLkX5R3KZPuWTjJs12Y7fEbcTBGsVTtsxn0SoMY26ji7uAZLI3nXCQ8ibo8Pg8___u
 J8jr9aM379FjWaBjF4fyrvnGSlwkCzQXQUYlq_hSgtu95gxLYOdq1HNLC.KPhza_oPr5v50m.rmk
 LxVC.ngJHNcbFOcVuKrvsXprQIgQJ24oriDFfTLUQXLGrrVZtxQT3K77.OJJHbdaKSUDYswafOTm
 a2Y4rjUFVJW99UQ0yWNksmDeXdF6.HEi06qMlMCJUJ3hFgHIoiHMXq94E1q6DoRyvecHT6VU5z5d
 0yPoA3pvaM2ohps1stXFjgRN49Fx2DUErvuLm4ZgYf.fqqvmN0O39wxLGUV91NmM98.UUrzNp2Ed
 Td8bFBGTGmEvoUqBbSp14hWnzk1pXtNPT2m9s3CRMCSyWIeyKRK88sH28cEhZNejH37T9Hcn7wkj
 h7BD9vDxwxrm3pIbVXEsZnGMUh2mNZwY5AlwVO_eiCxg9GQqBDj_Kbdd6pV23mg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Fri, 18 Sep 2020 22:22:45 +0000
Date:   Fri, 18 Sep 2020 22:22:41 +0000 (UTC)
From:   "Mr. Abdul Salam" <abdulsalam80044@gmail.com>
Reply-To: as6174759@gmail.com
Message-ID: <186350838.2823745.1600467761275@mail.yahoo.com>
Subject: With Due Respect,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <186350838.2823745.1600467761275.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:47.0) Gecko/20100101 Firefox/47.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear Friend,

Before I introduce myself, I wish to inform you that this letter is not a h=
oax mail and I urge you to treat it serious. This letter must come to you a=
s a big surprise, but I believe it is only a day that people meet and becom=
e great friends and business partners. Please I want you to read this lette=
r very carefully and I must apologize for barging this message into your ma=
il box without any formal introduction due to the urgency and confidentiali=
ty of this business and I know that this message will come to you as a surp=
rise. Please this is not a joke and I will not like you to joke with it ok,=
 with due respect to your person and much sincerity of purpose, I make this=
 contact with you as I believe that you can be of great assistance to me. M=
y name is Mr. Abdul Salam, from Burkina Faso, West Africa. I work in United=
 Bank for Africa (UBA) as telex manager, please see this as a confidential =
message and do not reveal it to another person and let me know whether you =
can be of assistance regarding my proposal below because it is top secret.

I am about to retire from active Banking service to start a new life but I =
am skeptical to reveal this particular secret to a stranger. You must assur=
e me that everything will be handled confidentially because we are not goin=
g to suffer again in life. It has been 10 years now that most of the greedy=
 African Politicians used our bank to launder money overseas through the he=
lp of their Political advisers. Most of the funds which they transferred ou=
t of the shores of Africa were gold and oil money that was supposed to have=
 been used to develop the continent. Their Political advisers always inflat=
ed the amounts before transferring to foreign accounts, so I also used the =
opportunity to divert part of the funds hence I am aware that there is no o=
fficial trace of how much was transferred as all the accounts used for such=
 transfers were being closed after transfer. I acted as the Bank Officer to=
 most of the politicians and when I discovered that they were using me to s=
ucceed in their greedy act; I also cleaned some of their banking records fr=
om the Bank files and no one cared to ask me because the money was too much=
 for them to control. They laundered over $5billion Dollars during the proc=
ess.

Before I send this message to you, I have already diverted ($10.5million Do=
llars) to an escrow account belonging to no one in the bank. The bank is an=
xious now to know who the beneficiary to the funds is because they have mad=
e a lot of profits with the funds. It is more than Eight years now and most=
 of the politicians are no longer using our bank to transfer funds overseas=
. The ($10.5million Dollars) has been laying waste in our bank and I don=E2=
=80=99t want to retire from the bank without transferring the funds to a fo=
reign account to enable me share the proceeds with the receiver (a foreigne=
r). The money will be shared 60% for me and 40% for you. There is no one co=
ming to ask you about the funds because I secured everything. I only want y=
ou to assist me by providing a reliable bank account where the funds can be=
 transferred.

You are not to face any difficulties or legal implications as I am going to=
 handle the transfer personally. If you are capable of receiving the funds,=
 do let me know immediately to enable me give you a detailed information on=
 what to do. For me, I have not stolen the money from anyone because the ot=
her people that took the whole money did not face any problems. This is my =
chance to grab my own life opportunity but you must keep the details of the=
 funds secret to avoid any leakages as no one in the bank knows about my pl=
ans. Please get back to me if you are interested and capable to handle this=
 project, I shall intimate you on what to do when I hear from your confirma=
tion and acceptance. If you are capable of being my trusted associate, do d=
eclare your consent to me I am looking forward to hear from you immediately=
 for further information.
Thanks with my best regards.
Mr. Abdul Salam,
Telex Manager
United Bank for Africa (UBA)
Burkina Faso

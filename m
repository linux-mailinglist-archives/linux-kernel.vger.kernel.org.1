Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307EA294F5A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 16:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443822AbgJUO6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 10:58:40 -0400
Received: from sonic311-13.consmr.mail.bf2.yahoo.com ([74.6.131.123]:35803
        "EHLO sonic311-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2443106AbgJUO6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 10:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1603292319; bh=FfoGMgqq9iBFymLti3II/7ynCTQfh4+5RrgyGRqeUvs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=PbvOA+7bb9iGepLKetRlhrDlj+TX28OQZ+hYH40F96ht6D3p/uUUnnlTc2tEs4vxerONI1rjT5tIi6k7QnWpHVOrxmy/F6r1RNb+TzOniq04Ab/4fcgCyNKyZ3oYiNz4bTu5Phiq5O8PBJobAS5XjmhxZGAnlbB3XjziVxcallhjXmhHkZD95hVtA+9nBiL3XIsr2a4BXBy1hZ3UDmvU5Fu2yQ8BUnZBpqxO2wsRPuTVCDSxgajfOTXhMsKD/6gZ7yWftA01betMJWp6ypGtp/ZB3OTbRqEPo0do0G3t/n90j4a24VlqXHGxFU70VO65iybkLkO7+A6RjE6YoTd5Mg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1603292319; bh=zE3ATCAJGQqjPfVg1n6ZEa9UvYgoOVhdW4l/IXexwqH=; h=Date:From:Subject; b=BaCmMoctl+kdkoxmUyUauansjxE1DmQ5RAFbJlS/vepu16YiPyE8Z69uqT4Fy18vlOst/GZ22Z5HcDt12gGgxm/ftalDReDspFIfthSnfgbufrT82thmGj6MxzH9DRDeXEoNDw3Rz6e8kyjYbvwbF/sa7pxVQGbnsKhz1AoT3FDP/1MIVAi0aaed03J1gTbMtDEARQld6TV03WhsEQHBdMnGDDGK51Hy1J0Pmhy+QZ0Alb8m46s5zIl6pPx9RZIshRrsQ5pyvsgV3VDeB0aIs6PeofUNVl9cAALY8n+8r4FLzAat3rEq9CjB2lf3yxacg6FQ6uW2TnZEuRnMx6UOAQ==
X-YMail-OSG: 9U4TGGsVM1liTPZQX6bw1OIGqEwVNY1PjCZGsz6h.nC5A9GA5x1SpTuFuLqA.tF
 6JIoD1x0eFULrAhm8CEBeaxc6C0BVv8t7WAgEjykanQZPks5.vfN0ndFwOTSkOak56DuKZ7gcA0V
 19FnPT5AxqwQWFu_uOMbzMmi6itPwV6laufviA58A6jARHBKq8uml55W6_gvYS2SLelQ6wLaeqW2
 NZgzGXNYBkoTyZGdGabuJfwHUWZj6jI2BtHfmiulNLMjzCl61tv8phlsTQ8tz_fsl9ZY2NyyKQUS
 bLZscZcw5GlLzKY8VhBtdtwyYnholJ4X2pyZyZtSiACFioC8esZ6bUrhRrcxVoWDW3WFQCRRQdT4
 BWHNm6rDGYLFEllWWT93VoitF_jSBetbhwpp3pIOO3uZYYA54Ly0AtX6gzc4GdG8ZvGxFnyekEgv
 pX80huI5vSwpf6qjWlRJDZHftASHEeTqhbIVKvq43yzWLayw0mgW54mqRB0u13aCukBxUGYdx986
 byTK_OoKP7mXHnwGofIa0hOnJ16_qErJlY92mAAD.aG2qkwrCRueVMDvD5Ub02Q4ilZw.2m_33PL
 cwrNa_V.y6cRf7BRiRJBI6izBUyKikGdFsnsU1hDL3ri01flAhRu.bathOQSoaq5ynFGqJ67m0Xk
 bcaUNw_HPaT_oQ05040waUD05sd.d2S_6lUTB.0YX.Tpc80P240t0wNlglLVH.xfXRMuAZZ_5JTk
 C41b8UEVFo7XqhQUBhUBIwZEXT_Qf3_fv._upfvDPKRzgP7qNPjGYyi4wFunQRgibaWJ71vCsqkh
 94k7eEYNK166.SVrz2uX2vwkJhCi80lWOqjYAxHafOQ.DYjjXeDJrtaT0NCzY.SOJK4DLJ8O0PxH
 e9OF9wn536XSQNyyxlc.F3k6HpAUyGZ6lXIdvsl5WgSSxyxS4vXvRchDGaq8qB6eir_I6DmkD4xE
 aOYP4GWRde6TWtPyR8Qp10kRmPezFBegTcg71Hzsd2rThvEtMLI14IDvzvAmdmz2czYm1GAz3KA.
 N0KFx.pKZhQ5Kb325CrLol51CVsQUak1h7JI.8fhg_tW2KP8._XV8r.qAd.jNV0f1XobFSnMsqJY
 k9d0NFqaoEpzf__k_nQLfVsn5Kdh1d5IFStnAriNGk8dd05boQgFzhO7oTKzJxeL2GSlyaooPMRG
 HAc0XfTM5e5W4UCQCtooVB76N1HyVmpCeoVCRly1CQU.sX86ekUXTY0k9SBdg8hKqrrFIi2IsLLB
 dO4KCjThm4.kHx3BdHgp5mr4sjwIyitO.s3HM_YzJL0OtYbjGjUrsqiVn2KpIrhBXBYRCdNtCkD7
 DSWObAPIvWJ.ctN0.cYIPAIdO_gbdKe3NGDJ6ZbepyoGfN0oBzIBZ_Q8sggaBmOqSNL5RFeZrfQm
 aXRa3a2afVkgpAJ1bnlQ7rCj4ahgrbSUBzcaD26akrTU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.bf2.yahoo.com with HTTP; Wed, 21 Oct 2020 14:58:39 +0000
Date:   Wed, 21 Oct 2020 14:58:37 +0000 (UTC)
From:   Rassaq Rasmane <rasmanerassaq@aol.com>
Reply-To: princerassaqrasmane20@gmail.com
Message-ID: <1904400120.1397798.1603292317452@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1904400120.1397798.1603292317452.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

I am delighted to write you this mail. Nowadays internet has been highly ab=
used. But i can assure you my claims are real and genuine. I am Prince Rass=
aq Rasmane, a young African who is passionate about the living standards of=
 his people. I am contacting you on behalf of my father the king of my vill=
age by name HRH. king Abdoul Rasmane 11th of Obokoma village, Bittuh west A=
frica, located around the border of Ghana and the eastern part of Burkina F=
aso.

There is a British/American buyer who is a business man and a dealer in Afr=
ican antiquities who initially expressed interest through his agent who cam=
e to Africa in 2011 in buying some antiquities which are our village herita=
ge of 470 years old but only for the objection of the village head.

Now, the concerned people in the village, e.g. the notables, the elders and=
 the villagers have spoken to the village king and a willingness to dispose=
 the antiquities for sale has been expressed. This is to raise fund that wi=
ll be realized from the sales for community development and also to put in =
place some social amenities like good hospitals, good schools, bridges and =
good roads that will improve the living conditions of the people in the vil=
lage.

Our village contacted the British buyer and he expressed his readiness to m=
ake payment against these antiquities if it is shipped out of Africa. He fu=
rther briefed us that he does not want to come down to Africa for any reaso=
n at the moment because he is so tight down now with his businesses and als=
o considering the issue of Corona virus.

He equally denied disclosing his buying price to us so long as the antiquit=
ies are still in Africa. That if seller should get this antiques out of Afr=
ica through a representative or facilitator he will sign a business contrac=
t with him and buy from him, maybe visit his country to confirm objects and=
 pay. This is a 100% legal rare vintage Artifacts that is worth millions of=
 dollars in the international market but we only ask for a reduced sum.

Dear, if you are interested we will forward you the address of the British =
buyer and photographs of these antiquities so that you can contact the buye=
r on our behalf and negotiate the price with him as here in the village we =
don=E2=80=99t have the opportunity to be exposed to international market.

Once you have reached agreement with the buyer we shall begin arrangements =
to immediately ship the three status collection Antiques to you so that buy=
er may conclude the transaction with you. Once sold, you are to deduct your=
 20% commission and transfer rest fund to us so we can begin our community =
projects. We will take a lot of delight if you treat this business with ser=
iousness and give it an esteem position. We await your prompt response rega=
rding this issue.

Please contact me through the above email (princerassaqrasmane20@gmail.com)

Best regards,
Prince Rassaq Rasmane

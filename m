Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C813A27EBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 17:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729367AbgI3PFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 11:05:15 -0400
Received: from sonic314-13.consmr.mail.bf2.yahoo.com ([74.6.132.123]:46245
        "EHLO sonic314-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725872AbgI3PFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 11:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1601478313; bh=FfoGMgqq9iBFymLti3II/7ynCTQfh4+5RrgyGRqeUvs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=MJbu7ENMLJSHVJeJF5dw7SObqLqh3gyZ4401dyyqTZW3qufz4gFnppTu/h5v3icLgHcPD+ZjhNlp075lhXWNQeuoo90AXIZe3h2LppCPwlgCS1LfpRLskD9LqIPuiFe6HzVWjAa3tglQ1j+FoYEkWXGGUf1aC96+Jq0kGggmnaOcw1QathO8LJsU5Udomaj4OgEWrS5fqqzI+mmO2HFB0Oxl64zejKuGzAggejsM3/YXnj/W30Wl7tQ0D18slQB4Qc+9p2n9J2447vZhRNdV5DvShpMTkBBTg8J5zzjQYJp3Ip+1dOEH6YHisk0D9mC4rhE3mTZ7AWW9uANxYPuaXQ==
X-YMail-OSG: 364S9ykVM1k7FXUHNZLBoPU2hjfzLPQteorzeek7ITGYSx2MsFVAstv2m5RFRdv
 L4hUp5WF03eo1CHdhN4HAfrzWzn1HvyIA68Zj2Nk__9iY_eEuU5VRkjfazd0eMRE_o6.nUu8TFaq
 nvV5xq.Z1TNf.1j90DyI0HnFXFpov7es7Mbchl8J0QZJU_cvTyLVKlroWBPDTOGJ4Nk7aBbEEL.r
 cMd7SYyHN2kfE5iUH8yBLDBCsT0m6KCk7khkBsyHaLqMWOcipOR8qcLU4RxJMfJcehp6r8KMmCj2
 yYO78Cn8klSA6Rqcs_kj0.491Ucipd5WfpfIqOAkMuhVNSFdilkVGolK3g7Qk87khbPnKHLgqqtf
 h1smMhnOBRyZrq3WdVedNG8oeddGCDGf7ckKXXSfZxxfYMvQ6XHt3skPz5XaeVInmgH_XLNF3Sn3
 W6yuVsPCk4rtHtsu0eMNggD_VChHwPBNaHQMmSVwMYdIQi7TAXjqX0j22nfeGtKBk.T4vs_AL8kA
 S0Lfla8P57qwTXlLJ3xwATZJhJIAWy2cRPddJ1zmcnT9L2qK15rSTBisOKv2Tstx_6vmlhMExdV6
 _h6p3lc.K23nP86VciptNe_k6VjJp9pKaO2IA_KtS9FTHuxuz3x9PNwyMulBGvt0lnDFgqINQeol
 GMEcOBgQmEjktUioq5yYAfpQAfYMWBoiMes1OmWGPq3Q2wjCma1uSG1LqFYf1uY0t1UMNfInCuRf
 90ZGe_H8UMZUOFEpOzko3k1tUpQ4QHixhGXB.w8S.0Y4_x6uh0p9b2D9SPuugnOo9rFXhfehZoOz
 pSLfokFQW.aNGf0cX1RCLrZO_m0b1uCKL.iSePuaCAuniuObFYdqNHiI9T2xvNSCvCZf7dkONxLV
 74YjjD2j8uV3IKUNAdu5RqZIgb19P1FJXlpOBl.7e82Kplvb_5Hrum1mpv7L1zTRCzfdSxia0K1_
 gwigKUCAt8BUrI_0OVAJDnWIPCRrxEA4VI5t3fbvGH7s9rM0HTIWjEWZvHFoswwnAL_56cYhKYyd
 9C0h4ODnBO.Uo5oylBcmK6srrKrHKO0Jsrlq_kLl1Sq6Y1SkkBMpHaZskKXw5mG09y2hDBlXy5DO
 _wFovs352Cre1tab_VXmaGjursOH500oC3uq_Yz2YgFOq0efsl5Tueb_mCp2QZ0FFKNB9Ifgkmrv
 ZjpL.JcsjWMhIXbCyiaqoCdedCZNQ6szry0jRVbGBb0iuz1amm9vs83p0j6jbJJlxXWCU4gVA8YY
 tvCF8LU3a.IqecWJCCndaPU7fVj1Pxy6muEPrR7_ckGD5ld9Cllw0fQgDTIjnxkuSUYUhvC_xZV5
 EA.qp1XbwP9Nquo6wnOteN.8TyBFhDe_hzm3KYRqqRkKxNvQpwwX0SjBG6zjOS5cZzQpezFCrMk_
 xS_vd_2gi0.CSDUjj1j5PFmJY_AgFDzOv7cw1q59w1ss.ec0G
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.bf2.yahoo.com with HTTP; Wed, 30 Sep 2020 15:05:13 +0000
Date:   Wed, 30 Sep 2020 15:05:12 +0000 (UTC)
From:   Rassaq Rasmane <rasmanerassaq@aol.com>
Reply-To: princerassaqrasmane20@gmail.com
Message-ID: <438449637.300628.1601478312847@mail.yahoo.com>
Subject: Greetings
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <438449637.300628.1601478312847.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:81.0) Gecko/20100101 Firefox/81.0
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

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B81321E7225
	for <lists+linux-kernel@lfdr.de>; Fri, 29 May 2020 03:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390778AbgE2BoZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 21:44:25 -0400
Received: from sonic308-3.consmr.mail.bf2.yahoo.com ([74.6.130.42]:43445 "EHLO
        sonic308-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390601AbgE2BoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 21:44:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590716660; bh=YjoMWJbzwim5rmbOfzRawArenzz2ibTTWXogglyySJ0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Ui+8GP6NWA/X+l8d3UjXIEB6BbV6+OwJYUuVo/Vhk+GNRDs02io0rl5iyH/iEmECt1j1Es5Vyp6Bh+r4G0XHCc3joCgOPPfUKqNLmVc56CIh7lj+8uDrrsSgfM9fn7Dc/e0Sspiwh/QYUgd5I8dVOmi2kszBQ5Go2mgl/mX+TiNSb0L7LE+rsNWAhrx4oRS8O1OayN9KwDOmowIHm/Bc+XCc0+47zzf531fVYGa2g4hyvy2wyTvbg7se0rhfKUTLv8kQ1Umv0kMjMEbSsvL8K0jsJfEW2rHoyjJFQX3W4GjoLW2QYkYv9rttoehTeNkO7jSEWXGpp38SEDqlenVJ6A==
X-YMail-OSG: xlmqNFAVM1mQEDMlc0mboZ4V70vm4GbeYuWEPyXRb1qEZu_Q2gjGaki9yBvOcT7
 0VvEEP4u2q_Car4KEnFqjUPEGJUE3CBpbqHr7npx5Jar2yOrd01QY.E0PHMUhNJeUtJhnl4ODBoF
 kFP_A6I3zE0baiYXYbZMd71FV.gNK9guGaVe_Kk31Gd.59cwVIgBcspCnzjJs_c41p7Tzy2IPZdd
 UZX1E5EgPMSAP0E2xBza30WBd7az_d5G21bw.rOOX1W3e3QhzZnyf2LVHBkm6K17Lm2SUK54qRn2
 jcRsWvZ3Ll9R_reHXgqF0u05OaFmBHwKEgy3z.NEmk6s6Bz0g4JRznWtwOtmc6y2bsuwCvZ_Qx5F
 SKW7O.V3_PYy3N6aAa2Y2EoV5OleCQ.OKOoaSPAC_jqaF4J.n98ZI91p2csP8Aaivc6mFk8Z7mEg
 co9sW4U78E9p.9WozRwpn9NoX9_10Jd3wy0Hj3_JVYpzlRYSxAeCt1AXaFadMtQgCPV5iu3L0.BR
 5Ruwxqbx7BV4tpap_XqzORD3ZWIJBndRLgpvdDavczfBsVAsjZlbb3zgcm_IEJwUNahZFFezZmRt
 pLoMkB9X_zwz2CzVgK8hGFRscw9M5s5NUVITQjIP1C1XywvJyciH.V78bPBj4M6.lFiNI5gyTFqC
 AS_XCAPMLGVIaqeJ_nM93tNDATwuqcBMn9e2oIjRMFL6adZgJZPsH2U2Uvekvw0zjz5IjTTbFvbp
 DzBgK47g.DOEPEjwaCc2.iPxzuLhXCK5u_mdcXt3hWXCKPFcncpYsS_nTS8IrHvO81pYFOYy.qzF
 pGgPTI1h82_f5UvV7wfaBI_UMGNHtn_OABkpcJErfd8tCx_IXF3nT5al3Sf_pj.pySfJEjr3Q8Dk
 pNOK1onuGmUP_X8L.ScKJCSMQ5cTt1oxvOXR8poIjWcTTG2EY3ueVtMVXqUkWVGzED7w_.0kcuzX
 KS8_Yv8JgbMUOHZE.Mc0qtYYsoXVXdrBd3cZmT0vDTyzEnGUysPTkJR1sjr3UYZhWR1Qv0NwG0r3
 oEAKMmJ7v_C_fDY_bIN3P6DuXiZccdXBj6rKGXd9N60sAoZF_genCzw5Wj5oh1nAe0yfrrSL_xXp
 CAUYa9VJb3czc.uQ_WlIVnZyRGoYZ6ewoxtxCi3_3vbkQKd7DGtsMjLV4zOFVKZ6bkfAlVHZJhe7
 dKvPph2fnRUW_XUVubBpueJ27XNMt9BUxLrvNq3UfDTYYUBuXGtFqenDYxayQO0twbsaMz08yOPj
 3AIaoTdjXCRG5iXf3IcB.U1pbI2Nbc1qciN9N3Wq27SC4d_IhG0xq4IeYvq5D7r6KoybXoWUefvG
 n4Ko-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.bf2.yahoo.com with HTTP; Fri, 29 May 2020 01:44:20 +0000
Date:   Fri, 29 May 2020 01:44:18 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsminaabrunel2@gmail.com>
Reply-To: smrsminaabrunel63@gmail.com
Message-ID: <669533066.972960.1590716658717@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <669533066.972960.1590716658717.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15959 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My=C2=A0Dear=C2=A0in=C2=A0the=C2=A0lord


My=C2=A0name=C2=A0is=C2=A0Mrs.=C2=A0Mina=C2=A0A.=C2=A0Brunel=C2=A0I=C2=A0am=
=C2=A0a=C2=A0Norway=C2=A0Citizen=C2=A0who=C2=A0is=C2=A0living=C2=A0in=C2=A0=
Burkina=C2=A0Faso,=C2=A0I=C2=A0am=C2=A0married=C2=A0to=C2=A0Mr.=C2=A0Brunel=
=C2=A0Patrice,=C2=A0a=C2=A0politicians=C2=A0who=C2=A0owns=C2=A0a=C2=A0small=
=C2=A0gold=C2=A0company=C2=A0in=C2=A0Burkina=C2=A0Faso;=C2=A0He=C2=A0died=
=C2=A0of=C2=A0Leprosy=C2=A0and=C2=A0Radesyge,=C2=A0in=C2=A0year=C2=A0Februa=
ry=C2=A02010,=C2=A0During=C2=A0his=C2=A0lifetime=C2=A0he=C2=A0deposited=C2=
=A0the=C2=A0sum=C2=A0of=C2=A0=E2=82=AC=C2=A08.5=C2=A0Million=C2=A0Euro)=C2=
=A0Eight=C2=A0million,=C2=A0Five=C2=A0hundred=C2=A0thousand=C2=A0Euros=C2=
=A0in=C2=A0a=C2=A0bank=C2=A0in=C2=A0Ouagadougou=C2=A0the=C2=A0capital=C2=A0=
city=C2=A0of=C2=A0of=C2=A0Burkina=C2=A0in=C2=A0West=C2=A0Africa.=C2=A0The=
=C2=A0money=C2=A0was=C2=A0from=C2=A0the=C2=A0sale=C2=A0of=C2=A0his=C2=A0com=
pany=C2=A0and=C2=A0death=C2=A0benefits=C2=A0payment=C2=A0and=C2=A0entitleme=
nts=C2=A0of=C2=A0my=C2=A0deceased=C2=A0husband=C2=A0by=C2=A0his=C2=A0compan=
y.

I=C2=A0am=C2=A0sending=C2=A0you=C2=A0this=C2=A0message=C2=A0with=C2=A0heavy=
=C2=A0tears=C2=A0in=C2=A0my=C2=A0eyes=C2=A0and=C2=A0great=C2=A0sorrow=C2=A0=
in=C2=A0my=C2=A0heart,=C2=A0and=C2=A0also=C2=A0praying=C2=A0that=C2=A0it=C2=
=A0will=C2=A0reach=C2=A0you=C2=A0in=C2=A0good=C2=A0health=C2=A0because=C2=
=A0I=C2=A0am=C2=A0not=C2=A0in=C2=A0good=C2=A0health,=C2=A0I=C2=A0sleep=C2=
=A0every=C2=A0night=C2=A0without=C2=A0knowing=C2=A0if=C2=A0I=C2=A0may=C2=A0=
be=C2=A0alive=C2=A0to=C2=A0see=C2=A0the=C2=A0next=C2=A0day.=C2=A0I=C2=A0am=
=C2=A0suffering=C2=A0from=C2=A0long=C2=A0time=C2=A0cancer=C2=A0and=C2=A0pre=
sently=C2=A0I=C2=A0am=C2=A0partially=C2=A0suffering=C2=A0from=C2=A0Leprosy,=
=C2=A0which=C2=A0has=C2=A0become=C2=A0difficult=C2=A0for=C2=A0me=C2=A0to=C2=
=A0move=C2=A0around.=C2=A0I=C2=A0was=C2=A0married=C2=A0to=C2=A0my=C2=A0late=
=C2=A0husband=C2=A0for=C2=A0more=C2=A0than=C2=A06=C2=A0years=C2=A0without=
=C2=A0having=C2=A0a=C2=A0child=C2=A0and=C2=A0my=C2=A0doctor=C2=A0confided=
=C2=A0that=C2=A0I=C2=A0have=C2=A0less=C2=A0chance=C2=A0to=C2=A0live,=C2=A0h=
aving=C2=A0to=C2=A0know=C2=A0when=C2=A0the=C2=A0cup=C2=A0of=C2=A0death=C2=
=A0will=C2=A0come,=C2=A0I=C2=A0decided=C2=A0to=C2=A0contact=C2=A0you=C2=A0t=
o=C2=A0claim=C2=A0the=C2=A0fund=C2=A0since=C2=A0I=C2=A0don't=C2=A0have=C2=
=A0any=C2=A0relation=C2=A0I=C2=A0grew=C2=A0up=C2=A0from=C2=A0an=C2=A0orphan=
age=C2=A0home.

I=C2=A0have=C2=A0decided=C2=A0to=C2=A0donate=C2=A0this=C2=A0money=C2=A0for=
=C2=A0the=C2=A0support=C2=A0of=C2=A0helping=C2=A0Motherless=C2=A0babies/Les=
s=C2=A0privileged/Widows=C2=A0and=C2=A0churches=C2=A0also=C2=A0to=C2=A0buil=
d=C2=A0the=C2=A0house=C2=A0of=C2=A0God=C2=A0because=C2=A0I=C2=A0am=C2=A0dyi=
ng=C2=A0and=C2=A0diagnosed=C2=A0with=C2=A0cancer=C2=A0for=C2=A0about=C2=A03=
=C2=A0years=C2=A0ago.=C2=A0I=C2=A0have=C2=A0decided=C2=A0to=C2=A0donate=C2=
=A0from=C2=A0what=C2=A0I=C2=A0have=C2=A0inherited=C2=A0from=C2=A0my=C2=A0la=
te=C2=A0husband=C2=A0to=C2=A0you=C2=A0for=C2=A0the=C2=A0good=C2=A0work=C2=
=A0of=C2=A0Almighty=C2=A0God;=C2=A0I=C2=A0will=C2=A0be=C2=A0going=C2=A0in=
=C2=A0for=C2=A0an=C2=A0operation=C2=A0surgery=C2=A0soon.

Now=C2=A0I=C2=A0want=C2=A0you=C2=A0to=C2=A0stand=C2=A0as=C2=A0my=C2=A0next=
=C2=A0of=C2=A0kin=C2=A0to=C2=A0claim=C2=A0the=C2=A0funds=C2=A0for=C2=A0char=
ity=C2=A0purposes.=C2=A0Because=C2=A0of=C2=A0this=C2=A0money=C2=A0remains=
=C2=A0unclaimed=C2=A0after=C2=A0my=C2=A0death,=C2=A0the=C2=A0bank=C2=A0exec=
utives=C2=A0or=C2=A0the=C2=A0government=C2=A0will=C2=A0take=C2=A0the=C2=A0m=
oney=C2=A0as=C2=A0unclaimed=C2=A0fund=C2=A0and=C2=A0maybe=C2=A0use=C2=A0it=
=C2=A0for=C2=A0selfishness=C2=A0and=C2=A0worthless=C2=A0ventures,=C2=A0I=C2=
=A0need=C2=A0a=C2=A0very=C2=A0honest=C2=A0person=C2=A0who=C2=A0can=C2=A0cla=
im=C2=A0this=C2=A0money=C2=A0and=C2=A0use=C2=A0it=C2=A0for=C2=A0Charity=C2=
=A0works,=C2=A0for=C2=A0orphanages,=C2=A0widows=C2=A0and=C2=A0also=C2=A0bui=
ld=C2=A0schools=C2=A0and=C2=A0churches=C2=A0for=C2=A0less=C2=A0privilege=C2=
=A0that=C2=A0will=C2=A0be=C2=A0named=C2=A0after=C2=A0my=C2=A0late=C2=A0husb=
and=C2=A0and=C2=A0my=C2=A0name.

I=C2=A0need=C2=A0your=C2=A0urgent=C2=A0answer=C2=A0to=C2=A0know=C2=A0if=C2=
=A0you=C2=A0will=C2=A0be=C2=A0able=C2=A0to=C2=A0execute=C2=A0this=C2=A0proj=
ect,=C2=A0and=C2=A0I=C2=A0will=C2=A0give=C2=A0you=C2=A0more=C2=A0informatio=
n=C2=A0on=C2=A0how=C2=A0the=C2=A0fund=C2=A0will=C2=A0be=C2=A0transferred=C2=
=A0to=C2=A0your=C2=A0bank=C2=A0account=C2=A0or=C2=A0online=C2=A0banking.

Thanks
Mrs.=C2=A0Mina=C2=A0A.=C2=A0Brunel

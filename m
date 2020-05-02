Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA6EA1C2754
	for <lists+linux-kernel@lfdr.de>; Sat,  2 May 2020 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgEBRyN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 May 2020 13:54:13 -0400
Received: from sonic305-2.consmr.mail.bf2.yahoo.com ([74.6.133.41]:39160 "EHLO
        sonic305-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727880AbgEBRyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 13:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588442051; bh=YjoMWJbzwim5rmbOfzRawArenzz2ibTTWXogglyySJ0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=eV40QK9dBxTwV2++/p6s6gq2POUXnnR7dk1Lly+VJ04hv21gMIy47+l0WEBA+8Y+NgqKqXUHKrd2X/MGTupuog9O3KCXnPLJyib3uLmU4mpZdw6pufGITEIdqCedKWJ8HtmZ3+H28yVV4su242ewGcUc67e/U5lTpFoweX9cX5gFUSZHDiU+wTOpIo94Pz5KukTWwr7aKPqx1OglzYLQJISOlb7EMNUy3yZVfko41ybqtRd0+/EZkc4i3hu7qvqw1kMAj67iEEEz7TkvLbN5QtgHrrFlbv0yirNYMWXz0oEExCr/uRhDvF7Va574NAxrUa/oXjoMFeRYSjtugtGZ+Q==
X-YMail-OSG: adoyCjUVM1nAfC9TZ9iuvF9CzgU7brnH12smPwrRChoRwXbPCbE9AM6bvLS7eBe
 AFLiSgVgBSxhDj7ZHhw5.AwhQHPGNIWMCm5Uc8a3O0k0BiMSEu59_X_PXRh0sfYrPQjAFyv4nCls
 0EuktDvcg4WWrHv39ZGseWL48dnYpdpllxtbouNRaDSd7Eiq9rcEDaf.sCrbEAjg3GyGc65IVU6l
 DGo.TpFnK2xDo9f75AyHN9.0wa0XR0MQutlAWNS6nDYEtwXNLE6fxdAUkQ7rjcQejC22Ohcq4pQZ
 3I5iy2B.Q6NBPYVhmLbnMvuFL31nHZhXG3F0jBRHYdtzWQiGqV0bvguD_9KAWm3JcfPzmFo55Rpj
 yLxy216XidItMUg_JI1xazvrNkDfSyEvr__QR7IRrT46Nu2Rcs7eQhLbJ1MGr8ig8OVniRCAFKf7
 h3915Ee6JSJ7gljlVnIJKOukCCkuW0rPpATffogLL3NaGKXdbOaMOgEs25cewFWSamWagvljkro5
 Qs7IIOCuk7LtoYYudR2UZoWo3IgtdpbPFF_nBsV_30ekQ0oddC8s2ZTeT2RLfY7m3PwsxsSBLPW6
 2.ChuDDn1WOVDSXKdmlF196ZarKMyLMqK5okRmrtGsw0faaY.9E4LohzxSyL6ba8wB6YNySWbpzA
 5Bvv_4w.NRaDQ.EJb0DBqHn.SFbXtc7boUFjxMTmNRLVptwIcF3XO_H1XkBgNAUG7M8eGV4pRAmr
 ACpyk263CgWx0IHT3EaRvFHPaYixDVvl_9jhiFwkvsVV.SQjhQOQ_dg5tQzU3LgkRotGl7IxjYM3
 d2OTa23LBaq1WNLS_gIfemAz.EMQM_FjTJ9Qf63C92SrXs_4fIBuMkGDTITgQoFHDeL3eN64Vmja
 iDAYKbG.oDWz0zF5Ey8DVaZbt3l2WK5MPZKT_Ghau4jB2mUaEY9BwhjRPglHhSTIowLGuMKmn7Ea
 CJEYwpBzntplovznacHims4F2UoNQy30yYJaZvSAlmxA50BUwVmhVyZTBjIT8d77hMiYADQ7OBkc
 4O83FJj.OlSULhFQeNgTx_hfuZGUikbbozTJDtM7PPztYH15BqY.HE5sFPNVKdFlRDBhjyeY7.QR
 wGY7kZTaL8sFrVDfKDXL8zms7cig5eKaTS2JYeZM2kF7HsKp4YbcRV0SZV86DZ.YPj16yGqvL7xX
 _pR_8KeEUXqU79oa0QVuQsgFjvxqjK8OVYpxiChafZWGf2DbXa1lbuDZHCl9Byb4e71R5iK.ypZL
 mH.iJcnEvA2_0YosOnV6Ay4muLRX3YzMUAd2O5kVmUtM_fQtATK2yy1egYefAt.kH44DBZufxVcf
 hi6MVwrvH
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Sat, 2 May 2020 17:54:11 +0000
Date:   Sat, 2 May 2020 17:54:06 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrsannahbruun4@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1280548170.156334.1588442046719@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1280548170.156334.1588442046719.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15756 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.129 Safari/537.36
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

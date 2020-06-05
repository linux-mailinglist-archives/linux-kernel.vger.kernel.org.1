Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 803181EFE1E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jun 2020 18:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgFEQjC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 12:39:02 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:39464
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725961AbgFEQjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 12:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591375140; bh=AIwBwUHTaEHyPnJGCa360tT471PO2aWLNBCKYhg7jZY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=awprFxa57RFIaxMOttVvFmezTOyClAHAbmlz8hql+wPAIRVc/WHIqivuPSKJ3YohHP7kfkYlFZ4+JujZb5RAnUYa/ylTOVhT+TVXlmY5m654WSvKvAHboxAvAELJ2k2ohRURmpbvwuBLoi0CsYOyFjoZTsOvyca9y/Ry7DdsMtZdOKbRPcaHluABtkp1hCtBcQ7OEIWvyfpbux2pHI3wWzVaHLbstM4rLAZuGYb13a4wBUvFc4N1NwvWcAMHpxGdk4hMNViLkrV+/XHIBHATZFojRgcRJImuGjy3T3XX7gV3tsQUPd+lKsxoLU8ectLJhe3GOAVXc7lD9Dx5unHFJQ==
X-YMail-OSG: e3DN8REVM1lddwW0S.skZ8NzdS1zZWzWH.iwOD4UZLCBviIbwY6oFdfOaNRW7d_
 7Zb52bFlWlUk2BRXWzJRxihr2z3Fi_Jd9hGWtG8.nqozqR987C86KsFd3BbAkqwxMsOmUizhIiuZ
 KkZS1stNvlxIr1UEZ9zeS8r8b8bYzEBzPyJOTdlT56MTu5nhuYlobS58eJ94jcW3ZYXjIoeNPJx3
 bUU0pwIWAkYLVV4UiMjXn23fRDIiakSvuO3pDPGFKTDfFLAoKuX2cmrgtcTqt197vInJDsTKReB2
 6z_j3hP_RzSb4RQavnCfipkJ0XPFi2QoRZtgvH1OPjAy276tHgRV1yjOc91Pkd33tCLuWJSRVnpp
 O.kxSmwN5RNgI.bIxW8m4NP2YseT3czM_h65lLkC6Gp1XfDOCVqCoRZLQe9xvq503HnFmdmivnQm
 05LI631kTC2k_6Ci4Idq3T1EFjj.CiCXEVqwB0FaTq5V.c3i769nI7omhFPdozb4QAnBu.VGRjuR
 HudI6t4OPV3gfAWfAqgDpbRYS3SE8DUMrjuJln5alMXLWaEvcakhfRTQuIMPta4uB.SP_ZMQbg4B
 uWa6T5HpBgploCVwiLzl24gq4k.MreoG1zjfwBj5SxS25mcod3atUE6A7NNSSbN7sqbaSVhp1R1X
 nFzf3rtGmUdR3SNt6bwL8XsANh9uznqX4d4ONREuz4TbAqxxGJ79sF8Tb6Rt.lF3Eq1HNi24_EPx
 u_HasYqMmQvzn4QzdsV54kw_jpbn0rcY6xLN0q_ZLhu.NEAFxrXdR0S8AiUcOXuP3ozRxYUV02p5
 LSYjerQvtdwGpSBkDOCEahsp8ufFvAPm6b.UfVGq0wqmzd8JtRXs.GYpdemJXQ_d9ScE32RUshdD
 .gqagXcz.itnbxtv6LQmfyZzEMTqs53Nlr_HBFQ77cL3OrA8Kep8XFgP_a8WdvNFE5I.83UTV0mt
 54PTAHmR2BZ2wtCbkTfdT4FmFs995J8BUrJU602QHR4VOuhbNBtSi3iu0KWdtDQU6qV5tBOpJRvo
 lxSMioTUtd.BlPuqkzuGRfcRixxatr9AknRTWofNPdv4ltVJVPulKmxQEacvZVNDGvx3Rn9WBkPi
 u2Hv0cqJ7rRi7YxH2reTmm7EF4OBJ4aLzXBJcAfsB8hR0ikRyvEQL9YHFUZG98c5Ddk1E3ksmDgk
 MfuCJhCUNciz2kdvTSj_Bz_907xZ9hVN9ZAuw3ZmOw._qyFCYx4Zyx1IhkBU5Uw6ZmNpyn0rUdoB
 zKP3MtsfDa8xRoy88E.y_2dIPWqkLt3TFXysCGmKKqXxzUTEja25csqgyo7qEX7pwQ7ZOQYzZm_L
 O_0IEF_cRZwRCqLJso7d7QB4pQuCtuB1R
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 5 Jun 2020 16:39:00 +0000
Date:   Fri, 5 Jun 2020 16:38:56 +0000 (UTC)
From:   AISHA GADDAFI <mrsaishaalqadafi1976@gmail.com>
Reply-To: mrsaishagadafi1976@gmail.com
Message-ID: <347765126.2305857.1591375136012@mail.yahoo.com>
Subject: Lieber Freund,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <347765126.2305857.1591375136012.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:77.0) Gecko/20100101 Firefox/77.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Assalamu Alaikum Lieber Freund,

Darf ich dieses Medium nutzen, um eine gegenseitige Kommunikation mit Ihnen=
 zu er=C3=B6ffnen und Ihre Akzeptanz f=C3=BCr Investitionen in Ihr Land unt=
er Ihrer Leitung als mein Partner zu suchen. Mein Name ist Aisha Gaddafi un=
d ich lebe derzeit im Oman. Ich bin Witwe und alleinerziehende Mutter mit d=
rei Kindern einzige biologische Tochter des verstorbenen libyschen Pr=C3=A4=
sidenten (verstorbener Oberst Muammar Gaddafi) und derzeit stehe ich unter =
politischem Asylschutz der omanischen Regierung.

Ich habe Mittel im Wert von "Siebenundzwanzig Millionen f=C3=BCnfhunderttau=
send US-Dollar" - 27.500.000,00 US-Dollar, die ich Ihnen f=C3=BCr ein Inves=
titionsprojekt in Ihrem Land anvertrauen m=C3=B6chte. Wenn Sie bereit sind,=
 dieses Projekt in meinem Namen abzuwickeln, antworten Sie bitte dringend D=
amit ich Ihnen weitere Details zum Starten des =C3=9Cbertragungsprozesses z=
ur Verf=C3=BCgung stellen kann.

Ich werde Ihre dringende Antwort =C3=BCber meine E-Mail-Adresse unten sch=
=C3=A4tzen:=20

mrzaishaalqadafi1976@gmail.com=20

Freundliche Gr=C3=BC=C3=9Fe
Aisha Gaddafi

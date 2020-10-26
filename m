Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A464A298B5C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 12:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773098AbgJZLKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 07:10:22 -0400
Received: from sonic301-13.consmr.mail.ne1.yahoo.com ([66.163.184.246]:35475
        "EHLO sonic301-13.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391819AbgJZLKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 07:10:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603710621; bh=MmVwVkCtyKjKx5b9fhEetkLl8vXT9gc/h4HtD5Ln64A=; h=Date:From:Reply-To:Subject:References:From:Subject; b=ctdC2ss2xKqpWmUMpdDxOpt/VBjQtDlYOXyVLRX+jfnRkywuUM4rL3cfxL2xVfk1q4SfZ4QIRVI+eE6wkScdp6ruiXoxRmcc//kGCS8DogdH+SWOxKsyAd3Xetfu6wEfDzIZX3hOXKej9WBIW9ZOl1nGjG5ObzXBRnHFfVB181MggBTN9bxmILrNyJEOuONS9rMnT6hD3jfECIMVitcUgeuhbqTvWMX6gkHFtoG1q+0Zuw/djaNMHA4uljRCxhjoB8LfQ9x5lfFDV0ftN72UNGSGUXRfX0nYSctheHbU86Gm9NUjbZ2MQsUFajoC2m4T3WnoW4+Khm9FjmEcSUnMgw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603710621; bh=CAR83yonQ/xP6M1PInW2C6flNkLdXRlW6Tzr0k/ZKNV=; h=Date:From:Subject; b=MO7zZIOBBhSpXTofGVQxFNWvfWF5UA82WB5XXY000R0+dtrC2DBDs3GG67+u1oUpODaVrY7z2A7ODlMHnNhRF7G1H5D8kAPxKBfxLBh+yf9nH+22EyF8h7vHD4mdqhujGYt4W802c3S9wGVkWRCEivsegvbHM/Z1+ZsbYxHUF6UHJ8Np/yYgmtDea929U/n3YSOmJvLz2TMkrRYiOkgBKC9bwz8c3tJohHSlE+KAq9vLOoniaLlJZvOE8DPzSYRr+Nwu/QSCYbYPpwMKuk/kDy9JUh7Gva0zLKBjBtd76K4CkoqKhfjTxr/ljdPUNFzD1tg3Dl/BWoHXh1cLFuTytA==
X-YMail-OSG: Je4.LJsVM1mGjaNdDbp.JKvH2JUWiMvFM_gGTslpu3GvZOUwxgOlUy4o5WRabcd
 cdW._8nJozPCkH.mPjKGvD2CaP6UBZFLSe5XBlSvAOnZrj3IlgwutTPBkmpMQNHBGwBybnaHd_Ya
 FEb6oJyhwZ4flpLwUuAsx0wPdBI578x3HrITX8CgH9IRvgGtOS75eMGO.5hgpx0fN21ShyDw6QhB
 5GuyinOsfdoDm_nGqqqO3CDz9QSOn.SF7K66cW8GOCxfhuDTupmmF1djb9UMqrKlPu97DQLaCwAz
 I1sleCG2zwEglh7hMaqmFOetwov.RaL71.PMNMcCQ9MD7XyCP6OQIsgrh6BjvUduJ2zG7eyUL.Wp
 m.Pc6fdyP.BbqVjZCV_4YROY_KyGl4oElw1UcRj.jJPdqBnTboHNOxKxHuvZMP8P8rGRtcYD8pAF
 hWASkXzaVrj8kea.pluS7UoA9tgclIO9927mH8HWaiyX2FRLCvX.1mTpXxN700Xt7URxhu7E4R2.
 BdBIt6d7ZN0tCsf85KpCFiB7Pt1KzHE.Q0zCCC0FLvep1CLLHquHAx6JCIi6biZo.nDjLReGOjnf
 NMFkJSlkbTl1GpVrDcwFMQNQJXHtS4aXIwML4imJDQ8DqHfA7cBJqhmcJTPPcfSb8oxvPU_8Kt0s
 Kty35LXef78PA8m3kfofhhcG.l_ZtTqgBuw2YiPU5iZytIomGiheA6gw2GtlzqAyglS.qMNhKu9u
 XO4TuqT0iqsqxd89sRvjY3UcA6e7BS7WelkyZhk4ZyAtitE1nMZbXJB4WLouoN4SxnzZ9VdHZ6Iu
 hF3kkx0alfrj0Dce.8iLUOQ_KbGcLul2HLSt6EhXYkbFWEphzQX4LUI4nSAlsEOCmjsa4MIfEIde
 461zOnzQgZknL9qM1l3_e7hSEH3h5u1SQk4vBoTvMx_g3.up.bfSx32to1lk0t8w1ooILc441qyk
 Z7hPpqO8b6paXP5U07ZIk8H95IkjP5snhTdyo4EgyR_tx.EIDqnFFz27n51CRjFZ48M630fsQNaZ
 OBNkp1VH2cduTjf0NkQRDcfG6b_0ATuS8uQCHhlJK2HcBxnK.hSEjCDa8fj7F342LwxfhGp0EwPg
 T3c5ufv8PG4BTdzczrBRa3Zx_gPhz5G_06ItUYTbX8_KgjddAAH94ALEbiB9lVPW9hgGk28BasJK
 xnvOobEBIbZg8j3EaKUjRpnRSmikmYttY4wRUJIme59Ah5LmuNSli2kus2vaPhpLR2jrAgyUn9OC
 aMfLBmcLrSQ1L3V1N88pc33qK9JnshxHTjAKbeUG0v0rkXlWbee0bcV2ewDntmm4RogBIE78MwH5
 8XyH6ZVyV4IvqTdMpYGBCOX222FdlixOdw4Uryyl.j6o.x9cB2vY6cWRt5y6Y92YidVa0zurmF4V
 GZ14arUiCQiw1ffZY5ButqklZx7_W9u66sqwAQAfqCxgE1NEvAuFl75.jfBBvbwEmud3whwNxJP9
 Y0999R3ATNHlHCCJcONWhhXjHmGj8ljPamoz.IDXIOczguXIYy4UGfbb82DFVyj7Vn5itl9idsa1
 qGdFfw6ML0N_LdUNZiGxepMIHPlh9nm3c6UBr6ieOl9OJBWyTao0jraw9PeuBfZOUvcsfyJg3zsI
 XoMXu1uXNdr1Wgw_NNgj3CmHr0s9hOZ1WGZGlDY1T_skqpsC3IIs7ngq7K0S7oZb7EmzTW_qz2zE
 UbwFTXitxzS861ylbffmx_.whDz_0vqSZPnXDGdo6mNFvZIrrPfj46BP7MvOvj0X8AfhgMQpwTdW
 6PCUtIb0uZI7VhMS.uLIf0z_94xtWm5uIpmV895nYFn.vQ15mt2r.jLjU6tq7Xe_et_8f6er9bC4
 8GJhVrdrNXjFymzpcpiPnT1hsT97IRTIr33KQdIsrqAOM5MlXUHmu9EHd0HDy6pWhO8cbCONik3J
 ztq2NswsXN9mZ_IRwfm9VpUfm6kUYLNebA9WgKvBP8xQjI6o00Wqrsiv5K9Q1ih1aWefnpHokdHK
 ol6k0a5eZRTfmampjeDTAYiaTCHhUrawgyph.Nz3wTfm49FWy_E9lO2D.84FOTC_UzCisASrQuUc
 SarBDJRKcdNN4m.hskKBMzWsJSOznrdoYPN.Vgq30P6UzosCI.BCAMdeYIbRgWyRE23BGvvMq.X4
 ZG3Pn040X7GKu4MIA_wFEeWI02Eo13iySaQxOP_7GXwfrpUzpNdG3ol4v3LPNgVoSIz2kSpGxV8E
 NrKjWSGrHorKYZOPPued9MltvRohRunPx.4AAyOoVVlCtGS4eFIaeVoLFnWVcupXb0sJEdp85hZ3
 EUpFf6f.GPaxOU2wtV1otx.NKb2vjiCrFcoLdFqaBvvdSydrKdR7SGrFMeJGy7Cc5eJWwgLuibue
 AflAJRwufV91PsQMq1s1..VnnqrEeA3FGDHz7elt.Q7Lsz77Waeu5QqUv0.UlMg0d_8S3IXE9OrI
 aL.vRfpGhf54jfPKKDYXuLkCkr5pzPdw_NgSgv7_ZpgeaGZbZ_MdW68OR_AQM16FE0EKTouG3Nby
 gCyOPjQFWal2FJWt7aPv4cd7XeUepl7rIci2HmrLPfNfNSRbJFQhZljjQ6tCp8UZH46hnavfDuUn
 HPAWzUJm9BIBcPLxT_fe1nqCTmDZSvDJ6r3BnOZn6z2GGQQnRsvJbQEr8j.rZQTlSNr467PRjwKd
 PEYKDL9RkeMFJeS2hP_cQfcNgSZPikYUGWu.vWTBsK.SP9u1z3jn_ABA_TBx5g1pmU5fRLGiL1M7
 0zngs0mqBhsSQJvbIiDDhNwHYIq22vIA0MOvTGzrxSbBRZYT.7da5rw_nq8Ly1J5wUjrOqKuHe0h
 gZ_a5q74uyEuO3d39WWp071QNUmWsgiZ1ioN2wWz9NBk_.5FUO28iqcMbZwNXFO1IKht1lAceosA
 R3dm7nZ3XNxQ.58Lr_6vqJ5IzWDPFfhsLgU.EEkflsVhjRqUA7ggn0BZNnxx6rcAH0VpZCWVXGbs
 hWg5J5liRU6KI8vd1F3.zKYAgwxYzYmaGR5.ZA9_6aBdcDCeQ8553NI96kY_RDfK6XIo2HlANCJF
 0VV3oRWanVhU08J6yu47CF3rKZJSwQT7rGNH9n903iOWJT03QCNPgRaNaaAkTL2__QXfICulJsJR
 Yd4Yx0gwLg_j613PYi3iWJvE320SFjnOpofmas2kwbHBcFBks8eYW_LoSz6tfjTzvRgmxVnJe8i8
 mrqwnehanXQAXizx.I0NoTmAljiJzR8irDXVbzmrySaKi.NLoi9OiJ1aSm.8z9jY89HNlTdgXtqM
 _Pbe.h3Z0iqqh073w9IA2u17VTsVEpKCjQCq4XCbl8Naik3pnb8Vl.D2cJdQoEE7WY87jZuMXwR6
 zE4oRDYh0v9fvghl5K8wI1WRUo7kSjQArrLTFz0GXNVDUlSlbBvvz10zN.sy.VhBYQqHmypG7g9f
 op_DYOqQaZuE9.yybFF9lyZkNtikN2P8tqVfRDlgOH20cH00KggFeQrN4jMRaA80BiZs1563CQIG
 Z7.lgNvMNElJgZoRQTAxEA4Cf9qpEierkLLwMdE8SXgc1HQfI0d4ikXfS.nwBfB_QwyDv13FjCW8
 Fw9Mih14kxjUvE0.bDkTt8r3jqA9LkmWEez0to2d0o3zisLGQB5dGaZJUsrDLGLt3HsKac.0lpZK
 PcX6fwAYTEuWlW9CL2uTFttdkmCZ4ma0_jAy1h4Ig.IslPxB6mlZFNba5WlmQlm_vkeYjJWcteRb
 ryeWD3Gu6gffOjXsr9cfEUXLTZaHuU7_YiSLxCKzhfrDUT9lSRz8uv1N7q271bHZSZRrZq85UtIU
 MXredKkJvlznjJfelk.Q64Y5KAmwCzGVrp.3pZP.QEw3JMYmw1qISTNGnpKk.UiDGn.GMzrQx2w1
 YfQNAe2_WaDM5uVcCKjU0b0ntqBDInMwAtGXD8hachPrLyXx.DPPlO_qDjLxbWYiQ5fH5SXTQSGD
 d7PFINOcKGuwfX1jAT5QnIKbbKj5sQF6H.WBxyYvCEprOcc6Z4RZa.EH7Q_YIGA--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Mon, 26 Oct 2020 11:10:21 +0000
Date:   Mon, 26 Oct 2020 11:08:20 +0000 (UTC)
From:   ATM CARD CENTER <acc4@amason.net.in>
Reply-To: willi.khumalo@outlook.com
Message-ID: <154366375.3331641.1603710500740@mail.yahoo.com>
Subject: Payment
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <154366375.3331641.1603710500740.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.2; rv:81.0) Gecko/20100101 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



HSBC PLC South Africa
International Credit settlement
ATM Card Division.

Attn: Fund Owner,

This is to inform you that we have verified your payments file and
found out that you have not received your payment, due to you have not
fulfilled the obligations given to you in respect of your payment
regulation with South African Reserve Bank.

We have been informed that you are still dealing with none officials
in the bank all your attempt to secure the release of the fund to you.
We wish to advice you that such an illegal act like this has to stop,
if you wish to receive your payment since we have decided to bring a
solution to your problem. Right now we have arranged your payment
through our swift card payment center HSBC PLC SOUTH AFRICA which is
the latest instruction from Office of the president, Pretoria, South
Africa to settle your overdue payment, you will not send any more
money in this transaction except the ATM card activation fee of $150 only, your payment will come to you through our ATM Card Center.

This card center will send you an ATM card which you will use to
withdraw your money in any ATM all Part of the world. But the maximum
is US$20,000.00(Twenty Thousand Dollars) per day, if you are
interested/ready to receive your fund this way please let us know by
contracting the card payment center along with the payment of $150 for your ATM card activation fee and also send the following information:

1. Your full name
2. Phone and fax number
3. Address were you want them to send the ATM Card
4. A copy of your identification
5. Proof of the payment of $150 for your ATM card activation

The ATM card payment center has been mandated to issue out ATM cards
or Transfer the funds to beneficiary on option of payments by
beneficiary. Also for your information you should stop any further
communication with any other person(s) or officer(s). This is to avoid
any hitches in finalizing your payment.

Please contact the Card Division details bellow
Name: Mr. Bradley Johnson
Bank: HSBC PLC SOUTH AFRICA
Email. infohsbcb@accountant.com

Note: furthermore, because of the importance of this bulletin; we
hereby issued you our code of conduct which is (811) so you have to
indicate this code when contacting HSBC Card Division.

Thanks

ATM Card Division
Johannesburg South Africa

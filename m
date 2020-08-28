Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780BF255B45
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 15:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgH1NhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 09:37:01 -0400
Received: from sonic312-20.consmr.mail.bf2.yahoo.com ([74.6.128.82]:33740 "EHLO
        sonic312-20.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729410AbgH1NbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598621446; bh=zXaFIo8mjTpXao4VNtylOhTc/LqLzQin3ncX1bFuSgM=; h=Date:From:Reply-To:Subject:References:From:Subject; b=umgRTzYbOVG0BydnZUwZAInR09RN4ogj96Kv/GZXQoRmnfLJ92h9arI0ymon5fzvYU38TezE7RTnTuHXP9bIcbVFgqFIFTvQmF/QNhAkHJB9dsHlbwH2BVyr3awoHNLiXNOhtAgHODDHSK9xmnCY7UsOckYmqDujnGEaVt/Nr6OHLuEOicC7cPSdXAREZwXhk9N96pz1qwiU7ZWqRo1A/MI3fbGPGioKH8LME+77tSm2ltqwfGAANjf2Q8+/QVV4f3jq//XoAp0iiq9nTsOafGiaVNZhpjZdLFHAzDW5Hs2GLEs1r/Djor6TtHftp1wd8rgHHjWN08NTKEvKHseX3A==
X-YMail-OSG: Er3YvYkVM1lfrbGlMZB2r4aDKTD9AirOddmjbBOU.7hjc3jYSWpdhFGVkLfUf11
 JcqZsia_cfwdE6npYxQQOpWoIeiUjM8TbZZG84eJciVffdfQKuaGE4RPoyNRjzvIwtZTMEsqd8mE
 hY1.z6hyhSHS0iIYNjkjeYNqMhFfay1.VdNKxJoCnRjoXppP.2SUc4_14cyGcbi1MsCbZ9.W4BBd
 aGjiRiJotTl5btEPCgyBCcmgDWvRejPj.fKECoF.mOx2R5FhbBMunI.IxRski_ntu7b0SbRXt3HQ
 CNOPfdZbrASombDbfjBbUgSOAZDV4H5ZPzItCC1XlDq4pTb.KBLVkVmlWx2XCjs4QCjVEx0f2dxg
 QNvPGonHYh_Ac4hgmMDQpLc7RBVoBEBaFr4tOOOPtaf9CzgunIHuxCfqVpiKCwYe13ivEm1TWs4j
 kC9DQkXJ.hmf00jE1dG1Dk4d_MD7ZMYF6rKrULFUy6DQlpCs.iNXNZR7KaKFr13kwsmJDycrkoxl
 LSYgYGMmSBaxhFUSJIWfWy_.WcHngLc8u3Gu3oOUYOZM4b_K7yWVOypiScv8o7Ie.29cj7KOhBsL
 PUDycaRIF60vZscCKYQ3gpwJskjBXBdA__LuQWK2XzMMIxSYRM5RikNE9OShexmMFDrDUnK7CKSE
 q4htG_bn_KQ3K7W40mthaelr7sUYOhzf9GneRvWGX70YGVvNP0WUiDsj4X99pXBmy1IonaaB5abS
 CkfHWDdVL1lBpG5ZL77QDY9PifqaylRsxGJFSLGsIKriuse__Nfgflbf1tDgjSvxiQK5LbqCl8_l
 WDw7em5p.OMm3DkI1T7gu3PlmOQ5D.2Tbp191TQaCpGzyHwPHagiEiPfxisY_xq3AEIvCdJ2lVqR
 vZMu9eO0mzGyW_xiU46ynd5kcS53B9t9EdO9WPAipR6BuwjqebMZSqBCyf4i72pxewSbmgO3Q8fd
 K.Qse76xZUYLURGp6NsjFrJB.4WiyjVvOXS18.YD2wHXZSPnSzX2hK4VYScZWieME9h2rAPFjqE9
 bvqHOsuHbC0pKYPTpcdbR6OzbX1vAti682V5.u6JzdUeZ1ryIHHN24QhNwLeBEEdQS79Puu7n70R
 sUIloHV8.fC4SinzQNr1G_xSKvhlgZuQY1yrDsbjR.ovQIv0b9nTvFmf.8OdaUVVP0sqrF3Mkc9Q
 J3rcM2gT0s_6kQkGeAliFWIvjItFisMPSQPiIp9dKFo9u4_qDRRiXMwLoWBeTRZ7hgUrMscu70Bu
 TmW3qfEmMqILigBKm6igbd_8I_jf4hh03k1Yai3IbADbGOlEoTLBMTq0rUjucCa_jmT0muYKPeCu
 xkgyumZfhH8tvHDYy89KvfJfuV0AfIps7z5AE6lVgcBEwfx1KDeB4LeZUcKMcANoSTQdwSCy65S_
 LeV4MQN0Rgw22mF98IpXA9lwevIm34IUNA8000_fqZDckR.9c
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Fri, 28 Aug 2020 13:30:46 +0000
Date:   Fri, 28 Aug 2020 13:30:44 +0000 (UTC)
From:   KUBAN MANFI <nolanbraten4@gmail.com>
Reply-To: fadiansi55@gmail.com
Message-ID: <28592325.6638224.1598621444691@mail.yahoo.com>
Subject:   VERY CONFIDENTIAL.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <28592325.6638224.1598621444691.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Compliment of the season,

My names are Mr. Kuban Manfi, i work a department manager in one of the reputable banks here in Africa.

I have a lucrative and profitable business which i would like to introduce to you. Please this is very confidential and if you are interested kindly get back to me for more details.

Thanks
Mr.Kuban Manfi

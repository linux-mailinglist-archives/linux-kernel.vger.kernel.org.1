Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1242D2718BE
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgIUALY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Sep 2020 20:11:24 -0400
Received: from sonic307-3.consmr.mail.bf2.yahoo.com ([74.6.134.42]:40417 "EHLO
        sonic307-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbgIUALY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Sep 2020 20:11:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1600647083; bh=eJncruarbQhVr8dbHlNQ4067pViUZYGleWWGxPeBzSs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=jLUjbUaFRkZrVg21z8oNdLSwvBPF2+bQ30qHdaEnCAIpJShao+jNIeh0NYd84QLTkMhvVD4uUvhDN+cdAmcMdUVaQFaInHKg5Ba+r7TUgsqPAdmxazBliN/0CMy2Yaqwbwje9T4+CyW8oUbwBYHTFmTvIudE7FLV7q0IGBZvoLNXsnGAygHygHKsrTJBxBnHMoMIJYaDfGjC3XJAlGw9CBzPCxa3hd51uhyyfPOgKAhAcRJ4QEbO4NIBQs1BQuqSORgnkCwB7ksGTw93t+azqHirwZBmAasEKMUJ7w8A7vCek7luhIKar1GkGPKfYlHNTtkSal4YNjUKR9XIkhrauw==
X-YMail-OSG: 6Yfc_joVM1nr3Xlvm4teN3MeshiWwp8NOkAZdv7O0st6vJpGzzKRivPhT5sjhBb
 w_Ki1rLNVNUV8hUV2s6TCLXcqXnJsKjofals6VMQ0ozEcCz0lhBzOHV3mJEp2wC85Zcf6IIIYgeU
 6v09pRpbGx2_qC9EHcZtEUxKQlsEp5sz5fQifKonBz0fVeGwIry13xAlD6EIzpRXySjwIDqmLzLu
 NhNa_RTPn6n8D1Djx7vkVv_lpoJrNBKDxHkLN9pLNAz0onwdqP1IEFRg3EIMswmpFqSLVIpsnH7k
 HTOyGacbev1SWnYv3odQX_IIiadtJeBZRpjlFfLYn9ns.N0oAZzdqY9ObHVkPqS1XUuIaelAPJk_
 ACmzjDVk6U5Xo7IPXJJbjceghDwghnOTSUF.Jk6enmAn4oOLN65ErnyGrKgOONA48DfbPj43C6sZ
 lUb.3EDBXDfk58P2qCdiSl2OZ5CwDHJhP9uJqJv6szjPiEm6unS81et7bo6fdtsHFfB0PWy0nYTq
 JLrBORKJeZ9GBLV9kDMU7wGUzkpRaBhX1SPt_CUGyKJz1KlaYJy_VjxDzW8GueyJIINAewA2_qrv
 iKZ25M.6SNBtl4F3aGopC3iWEFwHiWYPEOayZKRpsclPRQVD35jBuSJ5Jh5AUWTkbOOobJtiFBWc
 FK7cA7ELOoou6AS9bMiCyC0fo3gr836.byJ8hcfeRNpHfyG5mtAeBGSODHoucMUDY.L96PFWuAiq
 wr2FTr.HJNgwaXxaA334ebhxZ6iPkirLNHLsEssoap7cj.EHz3XB9gQSz.XQMNZ6.sSfXHayZOmB
 UePaJt7e7Wj.ifk5ctCpR.AkItn7jHhvx8dtry4p40fm.iC6VkWiXZ.wKrA7jdpcAw6U4BtzMJwB
 .f80LrzBktQ3I5ERiENjB2HrWVfEZ.P59IRlNrJnlvGiz_bv2IgD6tGq_TrSFGIKrMVT1peRCd1.
 9jmb4h14BkJWOn4RoX4NSVwQ4hJ8.G.xGCWe2Ti.xAXWK7BKBUsPo85r9JzH7Sqi0vd1TeCSJlg3
 whAISJKxRm8E0aMULjYb1McLvQa7Uocb2k4J.3S76UiKJjAjuvvfWJ7lpjkBD3p779OoWcc885BY
 d0_iosOBdCGVbXB7Jb2pmn81zgEYTNeVvyI4xvN_EIO9QXofDiADInMB8xTAc4CxZ0uzCOFNXQAv
 m8cbMPpUz_NwYGbdqt_fgj7g434gLMzdhXnK40jcYazmRgWOoKbRyulNrsYvnSNWCe3voT13aALo
 oIsT4iQOXqhO5jB8UJgG8XKKcBeuMeu65eZ41CzaU26OJXN8AO5w2YP_AoYF7PZZk2dE3Lj.Synk
 r_7OOUq.B3w.83Dy7Lbsy1OBVAdXr4ap3j1Du2w3zrQdjZrQD.dTXKDmjn.BRM8IvPtm6nOE4ZJA
 fDTeqcZxra_CfEnuoFYxQrFKW4zSItQJ0zYVw2deHidtwFfrjKSs048bI
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Mon, 21 Sep 2020 00:11:23 +0000
Date:   Mon, 21 Sep 2020 00:11:19 +0000 (UTC)
From:   "Mrs. Elizabeth Kari," <alihamadu04@gmail.com>
Reply-To: mrselizabethkari@gmail.com
Message-ID: <2007170847.4166663.1600647079423@mail.yahoo.com>
Subject: Hello Dear,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2007170847.4166663.1600647079423.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/85.0.4183.102 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello Dear,
Am a dying woman here in the hospital, i was diagnose as a cancer
patient 2 years ago. I am A business woman
dealing with Gold Exportation. I have a charitable and unfufilment
project that am about to handover to you, if you are interested please
Reply
hope to hear from you.
Regard
Mrs.Elizabeth Kari,

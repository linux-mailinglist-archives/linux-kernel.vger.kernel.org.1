Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C7C2567ED
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 15:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgH2Ngl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 09:36:41 -0400
Received: from sonic306-21.consmr.mail.ne1.yahoo.com ([66.163.189.83]:33653
        "EHLO sonic306-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727913AbgH2Ngg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598708195; bh=V09D8a1N75lUFkJxVR9aVpVPFU2IfPbM8afoyzXI9EQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uTOzpCPtVZ6um660KQdhn2u18CbJCXF045syeZrmOQS7e5HeUsZQr16ccb/8O1L/pUdcdoCVUUz7ksNPomvcK3MMojWio0TWnsz8N3racSLm5NVWkZlAj8LZrHiOazPc3X/IqE/zKSgCmPsLs9NUuRyvMj/f+I8wKGSlFX+a2TVSAJQHnV8NmbZ7fdaQnAi9X2+YgguS4WnqR4pmpc38vwtNBJxUxrji5r/6PeY1s9lGI1K/YKxKYqjP/ty6bEsy1mkJsYC1rAGaGheVN6TAU+u/LvNzCuVrlpKZtulgEzFMSF1YMtQlk9pFy3pwC0hxE3eB58l6qlKJtQs+hO+aPQ==
X-YMail-OSG: j.VwY8sVM1lQ6NREIPk_VYQovAPMl74XNoGkTf.oAYNDkEekVNVJ7bOgq1gs0YV
 xeRdjSmeoY0RZdxL6QV6PcSlyWzn0tcIBbE74KVxxk3McVUa8kGLV0s818H_IdS4Tqcn85Hk04qt
 vkeAqXtZ1IJ16IqYSZNOVfYxIXghs0.gp246fRLVf2zNT7wir8fBRzLTaLh6jVbRPFPem_P8uQ5K
 4r5fTamUCOwtpy9wgh7yV6zCbx3JzziJTYvmGxRM4BvVgxtsLEzvaniIy6Y_ZUVg0v9IdsNjFATV
 dikYuf95pUZc0LLReJ9SkIrrAAIiIuM5N8W4vCKIoNZFXtpGRvgKVoXvE6e1t7azDpzYhaauF7x7
 9zyEr.dv0EPggei9.Z5opE7R4S.xk1Fum0qsjfk27MlnhHFG14rk1UlQng7vmbA063vngJhvnACw
 aHJxDD6JF3OzgzRMQbyQ3ApaVrk5ecE9fSXvxtgwj_HXsHhSwytNcwtBJgHnYRa8F0ugE8ICohPP
 v2vKSZnbMoKpcRXb5vEYc.5dErz3417wEPPvrpY.WkqPU.NeODGMZ2XFMdUrRerJU36En39id2p.
 UVsHBokyuQbxC6_14Ii2l1O6F0f0aDS685GxLVhoctbeyCJgCwUYSEUxS67QqFMEnPo02AQ0BqGV
 rnS59O4fbu0p4dbZv1U0n7VXw753gp_0tJ4h1xNRb6s5O119BMiz1XiEurLbjnd26P9IoUDxfrIc
 YABXz20A.Xb7mYj.2IC4NRRNElLBIaAUHTlljEkq.NB9YT5af9Sk9qkXCaIRCiXZ2sYSLqrxGUKD
 eJv0redJj2QkeEkdQiU3bWG9lS2_f7Nt4YfrAW282LMAQnxndWpcWoSOEaLr3xjRPfVUOeEWdsYJ
 6wLDY6AmIWXe63OQCvNta3M7jLDxMb.DZgH2RW4fzx7F7odlx2cJSy_Hw3_7rSokIFTO4jvsypju
 bYarpQHk10RliqCHoVt.whlbk_kbS7yYP6EL_aPqYSctN464.R2.rR4Su11l0Z78UTmMZUFoGLyl
 MPfinpVtaxikQvSnX84LS9Yjxrk4iFupGihuCIQHVDHX9IC5Zq46.FZEzz0g7ktO80YQqAhIr_h8
 SmMNEgr5dfLjAMyCx1804Z4iA4cMPHdBjvGj3WuWnY2Xv_PUBttfJG49.skRkqwfsvHBfP6xAHYu
 Pp6LVlMvBv9YFsFQvYDkXKZrjqctGjP_ubhcfLDCDJb2zRHiBDNbwoR_gGTqA0RPWiTKRgnuw9jD
 YeofuH7j6wKj6w1GbA_e2UPikVb.okOGkK4Z2aDgYrraQffvljjEs6xlbgdeih_e5Hu8d_0mZogC
 vLmQYQ.c09MHt.Doyao.rpOvBVP_x9ZIw7rrXFYICcDH1YxTSYlZRWJue5KSmzKMv1N7qp4Cyyex
 g2AoV636MvRx4iXQ5WycNw7kCd5CllkljtDXHeiDt3pndRtBnVUvwYg--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Sat, 29 Aug 2020 13:36:35 +0000
Date:   Sat, 29 Aug 2020 13:36:34 +0000 (UTC)
From:   Ahmed <mrahmedoue@gmail.com>
Reply-To: ouedraogoahmed@outlook.com
Message-ID: <1626605907.129014.1598708194400@mail.yahoo.com>
Subject: WITH DUE RESPECT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1626605907.129014.1598708194400.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I know that this mail will come to you as a surprise as we have never met before, but need not to worry as I am contacting you independently of my investigation and no one is informed of this communication. I need your urgent assistance in transferring the sum of $11.3million immediately to your private account.The money has been here in our Bank lying dormant for years now without anybody coming for the claim of it.

I want to release the money to you as the relative to our deceased customer (the account owner) who died a long with his supposed Next Of Kin since 16th October 2005. The Banking laws here does not allow such money to stay more than 15 years, because the money will be recalled to the Bank treasury account as unclaimed fund.

By indicating your interest I will send you the full details on how the business will be executed.

Please respond urgently and delete if you are not interested.

Best Regards,
Ahmed Ouedraogo.

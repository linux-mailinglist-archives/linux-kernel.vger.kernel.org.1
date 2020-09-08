Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90161261B76
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 21:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731275AbgIHTDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 15:03:14 -0400
Received: from sonic307-9.consmr.mail.ne1.yahoo.com ([66.163.190.32]:43753
        "EHLO sonic307-9.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731284AbgIHQHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:07:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599581253; bh=V09D8a1N75lUFkJxVR9aVpVPFU2IfPbM8afoyzXI9EQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=EauDlIZ91voyVE3cqtsbUkyp+acRfHLOkfX4Lc5bjUFjkCpyxYPQ3UikhDifZtDdEiFCQwVPXoZWQWL91IK/8FGCPwZiXt433d867irlld7wJYxNjUUoxKugaVapClziYo5iU8rElYGaZYdQS13WBr/Qx12kkFV5ELyt9fcFfDB6VVui9YdLnYocK6Ty/IKPJvxvM5oVaOKdW12hVby6n7rhinzeY67Coh3UxtXSAUDXFdnOeAnkSJ3CEyTqKI3lMRhOpSsDh0/q9iUDDAX1ZERzJbCE6agIQ+HajmjHwtOhMjfrvvTxkgHm40LOySguaY/YTUnlWtPklifkZ3ABTg==
X-YMail-OSG: SLG_uyIVM1n5fJq5i0UmZBPL0SyLq_LlwG9fPMPzfP1ugcEdLnRln88QWGccTjt
 u2taoob6PHoEwNgOyRRDNdmJLD30nFOXCeBdqTXDNjV.kk1Smbd0fh5jjG6Uz9FGNwUzY5PqNSDw
 yrsqG1QAL1.7ZrV0FP3jjFPFXEdgT3nTmsM2CPFBzkEX3D.d.uOzdZV0Rx062Csqh1fpO4U0EgVh
 OSYTyMJT_PrCzNUvjxNYM4LgESGfkAx_KLWklquwBfwZ6EFWYTlh5q7cUuhQVju9wzUJXsJX87rs
 CzTcrcTY20Dgzu9XwGIuNEI6lX5qP5SMK.CLTE0O_oh8X1dgHFjDlfL10eHAgBUnk_20d3s7YiYa
 6tbMyNWNqipa.hBkTXz1Skx11SqurAWHLOm6Cll.KAyV3ix3r7rlEsaGd4ENPDK1KMD4zoxvVdH0
 yten1ppiNB7Bc_GsgBks_Vln8tMt0hrp781t58Onhgwul_eUnuVSpg3Hen_VWxqtBRyRiM0Lwskr
 uEowg8pSz_JA1BJ771NMtriBfblSKLmytAmUEhOXbDOKuTS3quEA1A9HNgm9v12Bp7TV1o7nqJdG
 IdbeCLT448tgVgYBWpIRCABav7TTPg_X1i5RBEMCvAtoXEWSveQaLXeiY1ehW0BSkW8TDS37siSL
 _BgCUS3tFu9die0wxhImLTOlpFRoBQU7E0RUyBlCrPNepNoAhzOJerfrzIr5CFZb8yxU1YMNnm__
 Ex5Ir24BCz0m4z3byfYzmjN6oZiAXeGek1VqtSOPXVeA5_pRcsqRyr8VaU_gHMwxD2SNIGQi.Z1P
 8sffFGmfBBXWn6h_J.NfHCSxwM4UugYPtbTwmV63E4q1HJvlRcz7CqZEvvwkPwGclKlawkRNXH_n
 EIBeLMDo2cWQ5PpQkWTjFMf5zGVk15ByxAD6UNJGn3DsOQGWN8agqR1x6r0UtE.059wYhGfpdDbw
 7znTdNRKxP4otY4ecEoxEPSPxtLtAc0MkT6pOk.9MLReD3r4i9EsyYzHT9eyg.ciAaAieVviXGnK
 mCTX1M_LPCWcbbItKjIxFumHFC0t_ZGdHlZG.P_Opz0TSpZNLFnGWr1DWQ.GnpuggpU.dZbUiyEw
 Ip5Pk2OFjdGT0Rve6clt6wlXWf5_L16bcjTimGqBHrs2mCv6YTa1pOfTj8SV9f9TxzJI3QU6sr.A
 AXujdId_PsueEyumWC44tdqKFEbiJOn83WsDisLfWqGaPrVAR9Bnf26ymFg2ixz95RUklwKOGfVs
 9inN5tW06I_JKFdlbgdIVWZBB2yPA4nq9C6QGkYckzJJK3XgcgWuXhwWlrkUoKUMr7rKDocMTNkh
 and5udcvZpUidSEEMJlROvcMx9FEWZdFL.ni3MeB3yrCP9_j5_6JieRFaI.PlUO5f5Qz2T7VlIL7
 wAhNZwBsVArZYLlbpLNbgXyFYD_7xF0flMDwIckjrwr0smyQnYw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 8 Sep 2020 16:07:33 +0000
Date:   Tue, 8 Sep 2020 16:07:32 +0000 (UTC)
From:   Ahmed <mrahmedoue@gmail.com>
Reply-To: ouedraogoahmed@outlook.com
Message-ID: <1123903349.4400012.1599581252128@mail.yahoo.com>
Subject: HELLO DEAR .
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1123903349.4400012.1599581252128.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
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

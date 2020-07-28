Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43A66230FFF
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgG1QlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 12:41:11 -0400
Received: from sonic312-24.consmr.mail.ne1.yahoo.com ([66.163.191.205]:36717
        "EHLO sonic312-24.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726548AbgG1QlL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:41:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595954470; bh=eVWQE8aO6isO2IoHTAvouja63Qo1x862VnNlRn9e1Ww=; h=Date:From:Reply-To:Subject:References:From:Subject; b=OZn+t2LbyM4B0l3/ATMCPsKWCjBCA1w1ooQvwhWx374whiQJJokLoCY0jILpNuNZR2NkDAXYiN4/6JGt+J1HmqvXJ/JMibxEKOzOSl104kkNC9da1C0itsh7gfVVwi6MvPu/8uVcN5Rwcp6jmYOkjN/VmWHKNv5QdEzkJZNlerD4WTAVv2R747SydNdcCt1OuCFdSd4hDAGsSLLp7dD8wkqoenkr4RT+JZ0IlfoU3dxX54VRAQc1rhV00DSmoK1IESx8ddIVdrEe/uP5MLpeu3ZrDLjijGR0r21x1+Iy+2cOpAWcgOLb3fAI7InPyBE52eC6p7ScgK7pJ8IlLPz60g==
X-YMail-OSG: TEAAKX0VM1k6R9W15W66b53tvXs5VAgr_xBqI8BooFKTDKsAdIBKcuQScGcyYw_
 Sp.kr1SC5PCIXnF_FdQGuetXPyTq.pDc5oA77wSKaKZpKNZP2nV5gpaKxGAriKfyqJ5AaXVqwNoS
 w3y9iyFBPoviJwc554fDlYIz6q7HOZH8dk57un1nbMfihY9DwK_DmEe7HoIxFfUKJLZawpJFnxxn
 EHt2SNDGnIXyEUijugxfMF.6Z9UanQP1ofOEmQu4qRlmKdafXW3t3rxB5yMiud2Dl5gJrJy.ZJPp
 yr3_fDgtsKMB1Wcqes3mwcdgjrIulo6NeIti2uWji5wabeDndzcx1iT_NVAGQEzGoG6AfUQm91Wk
 vETJc_Vf_7RMnaZLLggVNNHfvNWS99LhGaBnYjeBYSRsCp3igpTUS0NdodprhOkDOKTa1bV6cb4F
 rErZ6sTmy7qOIQm6YTsgvaLet9CmOioiVevqzhWSguf0aw3.X4slNe4bArv79BKbF_WMe49LGsee
 UdrhAReig_sVgV8XWJgagZJLENNVo7vsjQecVEQwbfKfZphldcRvfbseM.NvzOIMG0qhNdrD.liI
 A3WTO872jrlglid9k5zcldMZDqfwzT.mItOuYMnn6jG8UY41Pf5QK8jwdXcDl64N1.vMr5..t7dW
 J7lG3C1lvO6TP3oBJaVCSvkkYBzx90A.XS2DHMJEgHn50ib3VGYC7aRUu3YdPGmyEjgmD8Io5i0w
 EEGkR11RHdCuoH6v9WhpNsahmqQjohNx.L9z3goky6.7KewdDQARh0Nuxbb0nAfjIV9jW.y6xykQ
 CFTUT6iCTy_3kwQ6QJ86nZJML9uum.jvZHABdl7fEKoEm04A4sEkYUkiJ6t5uP.Wa6Z6m0ZSjxQS
 q0BSOmlPNQRPbttuSle7IUHge5RfH6eRP.ScJrJ1lhLIPa0NEptLfT2c49hwlvDv4CqdVQoqVlnG
 RAaPmEbmXiA65R68xNT_XuEN0uPm9Wp.cQXHNtTR3ZvGTaPHU2Nboh7rXbq47uCC7_T3AxuHWNQG
 7zwUBuIYL5YcEhxA50zYPYJHLnFBAzAa69lyY_5dXS0Wady9vDvFMKimdeOq5of2pxZbiUfZPWe2
 kEdTLUv5zPAyrC76A1GsEWUK6OrZkLT0wyKPXqiR125zq6VhxpGcPEmCha0ZJY04yqkxKmG.AeeD
 khm844Lg1IKh1AX85bvZQ3Xg2mz1RT_d_TSrQhPHSdrs03vIG8nUY_zld6YxY4jEYRHK7eEzooVQ
 CnG7_jgFgtUoqaQwtONPSKxhurT4cm2XuE7IVGWW40oR0qM6pKaAOg5zssKx1SoScjxz_YwEeiJk
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Tue, 28 Jul 2020 16:41:10 +0000
Date:   Tue, 28 Jul 2020 16:41:08 +0000 (UTC)
From:   BILL Exchange manager & Audit Department 
        <mrahmadmikhail@gmail.com>
Reply-To: karimore245@gmail.com
Message-ID: <910665150.8413934.1595954468931@mail.yahoo.com>
Subject: URGENT RESPONSE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <910665150.8413934.1595954468931.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




Dear Friend,

I am Mr. KARIM TRAORE Working with a reputable bank here in Burkina Faso as the manager in audit department. During our last banking audits we discovered an abandoned account belongs to one of our deceased customer, late Mr. Hamid Amine Razzaq, a billionaire businessman.

Meanwhile, before i contacted you i have done personal investigation in locating any of his relatives who knows about the account, but i came out unsuccessful. I am writing to request your assistance in transferring the sum of 10.500.000.00 (Ten million Five Hundred Thousand Dollars) into your account.

I decided to contact you to act as his foreign business partner so that my bank will accord you the recognition and have the fund transfer into your account. More details information will be forwarded to you.

I am expecting to read from you soon.
Best Regards
Mr. KARIM TRAORE.

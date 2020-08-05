Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04A523C2C9
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Aug 2020 02:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgHEAyo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 20:54:44 -0400
Received: from sonic307-3.consmr.mail.bf2.yahoo.com ([74.6.134.42]:42209 "EHLO
        sonic307-3.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725864AbgHEAyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 20:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596588883; bh=V09D8a1N75lUFkJxVR9aVpVPFU2IfPbM8afoyzXI9EQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=dM8eHMM+VVWtJ3dhZBkn1C4VPMjpjgA18koZDX5GtB0ZVI+Gn9Q1CJYV5fgqagmnNm5iNP7EbDVOcc3it7Et6l9keaS3VX5czxVJIjDGIyqgDAfgMrc/EgzCcWx53h5lme/xHlRmCO42neMCHs9Wp3D1Z7wsQM946gWGDi2O5RvMSnJIf8wjcB8CVbigcJVCNnGOIsBAVSk+uMo70+GImtoFF9MxNErlUltoI4cBjrQVo5Y2vK86kb6ahhe6tTIJsdlloLZDYWFpVM9roc/vNIzWD9CS9ZYYfEpz1K0zgyYlT+7hjC7tbGkyjxh5r07a6m1l9lpsAvmGZr+5ndBO2Q==
X-YMail-OSG: yss2GckVM1mAYW_VO.v674lVcHwIHygoPMJ08zBIZ26XUQRoJixrV.ifT6K.T4K
 8SJ8j5Jitlx38aBFtqNtE_S7xdDdJD5HHppHc8HfJVKhsHIHvg1PMaiZsJ.jEz3vGGgclplw3kO5
 ohpTf3iK.QRNGFL89bk.oYuBn4uyeHvJzPK30oP7T8es2AwFRDFO3yZVSq4eLUELM0rj.j0e65Gr
 3fuCpWnEyRC6FEPpead2Jc5y.TVzjKNzZznhiFpIEf_AbgCTcbO.E4v_uPUZeOvcuoSvNDFHflF6
 O4CVr90.s5c8Ud4ETHdY8Oc3B7xDxAdz5oHvuQs2CHVUpqbHDvcCUDxZ1ba3Rwp5JZY8LOdyDhDd
 JfUJUsC9AWtYU6S0ZUXsu5vd.DUn5v45VR1LPho70irfvUQlDGPxxdcDLuMmenX0d3_1fpRO9XOs
 H1QD6Ksw.h67Ymu7zTaNvOP90GZxwHZF.xQ0ap32KwAyjGqfwdgpTEwlK2O6GKS2hyfkGhMINZrY
 1TEYmepKXsrpsbtJ3fzKPUvnSEyfQ72OrHDqVCYj1KvRqwb8B8scqw2y6LuGqVhPWkxEpiS0Sxtb
 tiOu9OXX2pel6yQYqJzVqAb8.bCzDV9RPuDFf0kH7kQ0Gc.nIY62DCR2_1bHHZuoyqB4polimyPY
 5dyyHpDQOGnpzsM8mfXIto7xm1IaNb5TWgZoDEeJiTHd_etMSbAS0H5jN7S5NwiJwQpk6RX5cx_1
 lwvWx1OAkv9683qOOH7lmyguBH2nJi2ryToZafpg6pSKdt_P9O9Zt6oIbKCiMuolk5t6CH13Gf_M
 X58f2uaDigIhgEdhBtMvFDlRQxN.QPBuvBUu3C9egjg_dIDDTFi81MTNr77wpHOadlBEHHN0GVX7
 q3lYEHGVe0wBvO_uWg21R9fm0y6PMYWim2Vs95wYD5O7Cp3lMWdNzbK5UuQUS2_c0QmtEWRcvrqi
 NtvZj9G2Us.c8RM5cM92pRWT9iIEcXxKSqiJOquYfKGRllPiL7f8Lx2oOHWRhpy3hPO2dauK_arF
 CIwoEkYEWVThDru924RsQtQWWQVCOjjsVr9dMfLkN5qvKgK5uz5lAxpyf71ZIePp5kXAf4FVVUa3
 li4s_yoyroo7KyQ3hWxUS5jx3OBOhtb9a_9BXzFhtik7C_jqvl_8MtG..y_euH8Y9Cpfub_D7Lw8
 WDjO4cdQ3OiV79JnfDdlbhqcfmLq.EkrSNv5Y10MkZcjmz1efxpzrLFUR4Gi02OVV4yuUHci7tq0
 Uw7UUi9._C.kRMbmE3ryUzZx8tCMM
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.bf2.yahoo.com with HTTP; Wed, 5 Aug 2020 00:54:43 +0000
Date:   Wed, 5 Aug 2020 00:54:38 +0000 (UTC)
From:   Ahmed <mrahmedoue@gmail.com>
Reply-To: ouedraogoahmed@outlook.com
Message-ID: <1534548109.48463.1596588878382@mail.yahoo.com>
Subject: HELLO DEAR.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1534548109.48463.1596588878382.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:74.0) Gecko/20100101 Firefox/74.0
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

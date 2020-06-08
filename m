Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0A71F1B1D
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 16:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730009AbgFHOgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Jun 2020 10:36:31 -0400
Received: from sonic309-13.consmr.mail.bf2.yahoo.com ([74.6.129.123]:45933
        "EHLO sonic309-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgFHOgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 10:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591626989; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tlR4+Dw4tFgnZIwjt4M2S6ckmHZhOcnS5TFfkMVbd568AGFm6uKV7ytPz4d34ll2Q/82/VhesvpxTKydFH2GS0mFNBHI8fWW+aAqPiC3MxHJjdbuzLaRIdvBWE3qMBvS+enYyfoFjhgDGev73xEHqXB2WdFZ6sPaSuIJBj5vbBwb/xxurUL55ZarWuTQhDTUFZrU8M2nZezr/z2KZwnE8z2lz0vP4oxB31hxp5GaZkhgONzlHQX4IiF0IE+dJwfSJZHY/Eq4G76Hh+mkL8u0JvTDx3xq9uu/IQYCFZjfyYO09q6webYGYpBqldPp8C7ESZMri0H1smeYqWJSn47bOg==
X-YMail-OSG: EFRGx7MVM1mfiZfVcBjjlDFqcc6031V_2pBPE96mPsL.zt6pqJWBCFMijV8hMpc
 Lbrfb1yA6Ovr52GFBCqYh61zzoBSzWXlmo_ZeujZsxHIqmUbKdxUcNVWyvxa9li8G08YEpcX87Bn
 jqOW.hS2M05yasTjxlZqBUWHoVB20YNsnQG6bgnp6kKZppQd8QGI6dTx8gheHb8mVnEvsJ_HLAkW
 DBFILqWQz5g4S5uJ3PTuBCsYG6hsN8FKraqRuIEkVlugqozbeUTeJx4wBxRmz1hTJlEFLx0dl2Hx
 6PAiN6cnIBPMazaQZbhVZPEwXAG6WoTZHDh5xr1r2_ZxeOk_ReenKQk91Mkuf16lOy47dcqAlGjS
 h2RR22z.o0mnU95UD8CaCu4ysprOGtcXLzOh1ZpS.F1dulNHd_owMnjuWraTffAeKFQuNqcjKy9X
 YsBp90vxZaKjsr18gyIO2IPbLwTzPr0TswZPycT9i2wTLn0.AaBtMEb9GIdfBmCPjhttRpSgd9c4
 FHbm0ZQ39gCEHMjO5yS2up5S64x.bDFHJl7TTDK0Kzvs1FUXQ6ZnExsBs3j_.MMhOICx2yxgbzWB
 Dcv9clJnkHakoW9UiGEVN.F5D9WcJ1QQLo1UaMjUFL.PSaAWYrV2dW7_Mv5YmSfeTcqPM7czxEzr
 Va.vc_NO0rMTJxZ756up.ihinajJO.XFAtcT40_AulWneuHWLtmHS3NdgPxMzx.N7u8rFL0zpFmE
 tmV0batmt4JBfsFDbcsrW4TAEr5TIcxOKNJuXFXyrDH1FdHkn3boPQ1VAaLqpfpZ_7aWmk0yUiF2
 Qtopv8x.VoVeJzDF9QIz5OW3cOiWBzwxtaB7Jq_84CDoGDw0toh5BBt9RH39v3gw_drJzbLSgTig
 4ohKSJBBlXiFYtyDcqplZhrIMjfzzprQfLLip2bezhh0jWM2It3ku4jFfNVL_Xad4uC066ZZn4ri
 _wCa49OfEJNriDI14pmi7pu6.ALJp.Dg7eyT4WtjKvmZvmIeyzLefxSTwDq3SwtOnv1w_YymANXi
 t89hDUpGa.zotJvZV04HhxiYo02MOvzgtOMmF4ewZqDRUaOKc87Pd8JankhzMTn_v9S18t04il5U
 J7AS8XrEvxJstN4L3Q9mGiDRwSVT5kfJo0ojke2MCeYz3l3IlFK_Ks2mZA33V7fa3yWEPMHFcSYI
 wHKd5JKXHz0.r9JUU_9ClG45krQRHRPPruLGDIhRcjVJMnC8E71Zdqn54y4ufpKIldXsDFnndkcL
 S_pKx1sLoL66BoeKSrFPK9SY6zQtQ3w8TloGhYgPvDj051O6FvJjUrn9kZKbJ6J2TG28iYwTw1Ig
 C
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.bf2.yahoo.com with HTTP; Mon, 8 Jun 2020 14:36:29 +0000
Date:   Mon, 8 Jun 2020 14:36:27 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <2045371408.652350.1591626987516@mail.yahoo.com>
Subject: BUSINESS FROM(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <2045371408.652350.1591626987516.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:76.0) Gecko/20100101 Firefox/76.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.

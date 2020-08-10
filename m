Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40B162405F3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgHJMcu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 08:32:50 -0400
Received: from sonic303-54.consmr.mail.ne1.yahoo.com ([66.163.188.180]:35808
        "EHLO sonic303-54.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726450AbgHJMcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597062767; bh=rEaUwHKYndtlTGQd1sVG1k+Ery/k+jQaHg2LkuM/QbA=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Z9l+UmYR3dprYH7Buk1jv0zVX255PZiCmlE1dO1Eh/o9lByxhCVTQhAnLvocQi01Y1tCYqEr84v41Pw68WIQUY8eC4LV9veewkYtNpjKnlsU4TYZBHOJi5G3XGxnWEl5iBWEyzrAYwL44iBxnr8ie2Xwayvr/wSK+cPTHPQ1267ejOwSl/dpyYmoPt0j2vsjyDOsvVTR8EKRlKsSMhjKfeB3hKAH/V7QKOBw433URvHbZspYt2oCW6scyfrZ2eC/42bjfdct2uMqAD7HcO1jj0Zz1p42kLKaQUZ04IVkTUMz4uVKK6Uec/lwS3fa6brmyvw9ituYQeiq0fMVvvyxhg==
X-YMail-OSG: XwOcMWsVM1m6IeFkpe44t97LGHvRTksECJ8K8hazIosZ3dZ8rfLLx0EgJqYkNSp
 Fdz.ubmHqiBmG1HY.8ES3gS59T0EL17nl38rfVszc7rkHJHzHIgCUxOnrJgyACVprC8C4akDUcrn
 VL.uob9butrsLL_hsovKtYiuQPmmNyGfjGI1kzCvwopfLPevojSRb8CT8pySNS8KiCS3m5RFLAGG
 xXCgR93ISi11npjXUFLdcGKVm6avfJtEz.XABVIRZDUWKuS2V4bCbmzm8Njsb524urolyWotvGTH
 uscA4HyBKNuhgzRHm.XTbJLKJZq1rd8FwF06T3wZGr.UWGA7jlcfWbUMYQ8SnTw__Sf7KccarjEx
 EZdYg_UOCBEgUW4Zr30tcowqJrY_XXogVVWLw4.XN5THlrD7N4CXymNhhWlujlUyr98j7HMzTPl2
 Wg.nHivKLr4jEHvCr7jJAxq6UNz7mu1jSQtYNeWTXCQoxdY1_xq9qcMShzs6azPOclvc8uBDdO4B
 UbPJykXrasaIUW5QE4vOoPjdI2BRag52oj_sUG4.uj4G9WNbpWdgdIEosIX9cKhFUixxgcBfTQJZ
 YK4PM1ECjQUfCieH6q6Rngy2GtmDBHUxr4AJi3_tQr3o2_SM5qi2WxdByCc2N4RabeRaD2oFe6YS
 vvmYfN8D7ZNRpN6qx9B.Ox_7Nt7iY.tpxN3eAphpvsfJyWVYMaKtM_KRDXXFcXbksbJeyl0zWhPc
 G4h218aJJnI9SnxEBH_rJTN0Afky9eZsDeRyWGFYN6Q3vDrkduyxOj4Ay7zr5EcsNN4GEIJo_w0O
 yJrlbW0bqtstaiBWhEIpjovRzECj8dSo9lINyRvhDcM__dKyvl4x7_DjW0u22s5nSMuLzWYEluGo
 6IC61ET0IK7YloSq_Jamw7gjDzu6yvwn9lSDuH7IBkpcg.hswYQ3eOEeoOScnOaliRHcSiO1WyHc
 9W_yzF.AflRanNjiPblb0kFuD7f6kO3OsQrCom0b402KsYSIDyoZ5mkkzJ_.OZXP2wwkH3zUG7lW
 GAeciOUclif7tO7n7xkPinjhP1hs0HCxnLBS9b262XP.lDTTGbmwBU_6o7J5yQ5XfFeZLdCDNesN
 QbBNakLbdSkap19jGgnGBEmGrFldLR5Jr52EBY9m0gHirxmHuVbMEI6DBOXO2iLAmxdTn8WI_sn0
 nGUimp3P6K4i9mS0_LnCklGLgOvjGLGobrvNVVhxrN4ZzNheJYMz7zoHLJI.PHCf8gcFnXS8yz9U
 peUshykQ8Fka1qHA9.MoKiq9Q3x8q_l8dlGc9rnMiaKpFjqomo1DvMBO6xQa1tS3u6GWee9sUViE
 9tC6K8YIKLDA9ieMD7kUDfTeTdnrTrlKiY40KqLD040CjGMN.zFeNBPFShVm8AOF5XAdk5ByiR3M
 26npTQw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Mon, 10 Aug 2020 12:32:47 +0000
Date:   Mon, 10 Aug 2020 12:30:46 +0000 (UTC)
From:   "Relief Funding." <tm98@ncsct.in>
Reply-To: rosesmith@live.co.uk
Message-ID: <349872402.2478858.1597062646441@mail.yahoo.com>
Subject: Relief Funding.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <349872402.2478858.1597062646441.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.105 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear: Beneficiary,

An irrevocable payment guarantee of =C2=A3250,000,00 GBP has been issued by=
 the UN/ World Bank Group and the International Monetary Fund (IMF) on Covi=
d- 19 relief .

Kindly forward the below details correctly to enable us proceed on your fil=
e as instructed by IMF AND UN Monetary Unit.

1. Your Full Name:
2. Address Where You Want the Courier Company to Send Your ATM Card
To or (P.O Box) :
3. Your Age:
4. Occupation:
5. Telephone Numbers:
6. Country:

Regards.

Mr. Harry Burns.
Director ATM Payment Department
(Barclays Bank Of London Plc)

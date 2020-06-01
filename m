Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CFA1EA26E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jun 2020 13:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgFALKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Jun 2020 07:10:42 -0400
Received: from sonic312-25.consmr.mail.ir2.yahoo.com ([77.238.178.96]:45673
        "EHLO sonic312-25.consmr.mail.ir2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725972AbgFALKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:10:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1591009839; bh=H3gKHl4RqMwoj7KbFbTKtC1J07KnzNVMHzHGUcEuEkU=; h=Date:From:Reply-To:Subject:References:From:Subject; b=LEyLsdqZu4+XXzj/A9cYPefQMw+uZXERsHyJ08WYBKjAD+QLAgURi9HlpT7TseHZGtohKn1j8J7cu1PH1Q+hFu868/q4nhDGdPbxLFwuTmu5aDv3BGu+zo4fWnUrkJ8RvC8nBy2/6z1yo2r+Opx46m0b7/T1K2X8lMThZ2t91FMB8vra2BcVgXk886dpipRf5PveKRoKa7idqT9UUW9R/b3Mr29DeFoAxQdzoI75EGJXhCvyHPFVJ6X0tcfNYmtGzBVXRiymtGQyA2b6M0DUmqQCNJAalg2mgoXvCjMGMbNdSrSvKK38oFLbV1pTWX9/satbPi0SJkQtnCmPJMuwmg==
X-YMail-OSG: HJlSgmsVM1m7vDmdqkb8cJ2PHimOJhBWlU1m35wBK5_koad3hnjz4WXqSs1Aqmp
 Z6JaeVUb6RZfkopUcWEelBSXKJ__kZn39Typ1fFvMyz4JvfjoZk3tTC85msTFnRhqprW_45YhqIB
 Sk0NaSXeVTowKTe57g9ymqyZLX2pR.qfBrEhpgtWeZuS4tGY9rkAhbO_vCLTsPhx_rX5otKbWRER
 BOo8wrGpTnmCPVOHIjxGw6vOGwHiehToggyqH0M_JcVoSydLN2C.fEoBjc5Fe9kzWb2HuL3Q5OZC
 UEeM109c3gnV1qRyyOgmViZPdZesODRoKC3OZkjUIqcWaOUGSRq84dM.JsgYL1WzegGgW0IfWVW3
 sX8KhmGbe1SUx6kJNKX9z9rRuV32a2v_gAPemrcQLeAcfVuG4aV9OpEzN.R6koTtRJOIdgVDf0kC
 ihigwHytqhAr4UL.wPX61zR5xoQ8WaJTMVdOGO.zCNLyQDZ85tB20yoqciC_o2YCCSBKEWnBQIzH
 cv6fJepaOUsW0NUFXCbqdhMDa50XV_BbNzZz_f7gULxrmpplhn3PdI1gbCa_BDE0vcSUlFHPjnlu
 2fIEqsI9D2TDL4f27n9UzI86epXtmfCsp5oUmdF5Tz9JBqhhQMKpqAK4ryr7ILMz5OTcbZ49BaLO
 fR5dCTAkd4TYxh0au80.z5vtWjT6WiuJUxsX3zjaqRfsebXN_OfoQF5DFolw9sqz2Qn8GTgGHTlK
 ZKdisPUUx0.w_Ai49QDCMi6rh4WLHsE9DNo2xTq1Z3GAPjg5AnoUzmuVRqcY3qbYbXWfFX2qrLDw
 nvg3HcDk6zE2lerT.XlBrq9ia04CIxHDbDWnXpFDnHuJBdkQMiMVKkfbrlA2fvjlhoL0a5L0c9T5
 oS2Z60RR7_CdLfn0Vxy4dxGvKajWGXIXfS40lUIMMF0IMkzNDbrxzZTDd73xTuJ_0hBUCx6ir9fT
 TfvNZUD8yNrGZpHwJNExtvjkzM8YdpZzSglcn_mnW35trQTcJ1GbsxJaJm5BCrqXwrbp5BeSHd28
 Eu318UxGgBQfXcISIpgeHrxaVqCLcxNJuI4MLwWiW2LvPcoEx3lToiex6KE4ROqKhTv5EOiFMgeW
 Fz.yk0RokkQfqd2lhCM7Jdpr2VLZCUE9AmMxIosmA_yJxgDiAObuVpfQgaLyFqmuz7_IvSZMrN3J
 4DPsmT18_NNJSnsC7qs9ZlUO3zHvIR99nddeqfKW7jdppiRNxYij1fipxtuqqNpxXK2FWEVJD7hd
 DG7SOS5OO8XeYPSkfJLfpFBvxqiNe1V4z9jpAya5280yAewxLtrUNOsfzxfTyOmgirmOBWj.ZRmg
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 1 Jun 2020 11:10:39 +0000
Date:   Mon, 1 Jun 2020 11:10:36 +0000 (UTC)
From:   farah Yusif <farah.yusif@aol.com>
Reply-To: farah.yusif@aol.com
Message-ID: <753488893.1341323.1591009836344@mail.yahoo.com>
Subject: Nice to meet you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <753488893.1341323.1591009836344.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Nice to meet you

With warm heart, I offer my friendship and greetings, I hope this message meet you in good time. However, Mine names are Farah Yusif i am a female of 24 years old. I have sent you mail twice but you never replied any of them , i have been wondering if the messages ever gets to your inbox. I humbly ask that you reply this message, to enable me disclose the reason I have been trying to reach out to you. I do apologize for infringing on your privacy.

Greetings from Farah Yusif

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5462E241646
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 08:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbgHKGY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 02:24:57 -0400
Received: from sonic306-1.consmr.mail.bf2.yahoo.com ([74.6.132.40]:37529 "EHLO
        sonic306-1.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgHKGY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 02:24:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597127094; bh=gH13qpDo1pe7E7DmJ6M5fxIu4YXvqPHbDbzMZhOfCDs=; h=Date:From:Reply-To:Subject:References:From:Subject; b=AyyuhT3S7v4FYQL9vVa/6HrXZWW31ojJ5ruhtyth8DS0Tit/P1fKfftX5ASwGVcPD4EYbFecLIxwUkNdnp11K0uYFMp4JpydR/DgdQLpO4Fmdj6keFv0Vi9Yij3iXZFOjVMjNgaGZJBUlQvKqSGaMyegtjdtLxoXnk01/N8F5z4otDqQRdndYlB52wiQGnAG7PqP6k4jyHXevMEuVjQd25t3ICUN+Ca9Op7JA7pMJqMqQCIQoiWIVz1U1XEwzRv727iWXAYJ3yoQVFkAMoH9H3+1whQqgp09iNwMSCO2mB8Id6FNwWraQD/ag5RW3MeSVgVH+NJkPrpQkx1UUveUdQ==
X-YMail-OSG: 1qL5JtgVM1nQj4zZs4g_n4dYGjm6hIAk7CB17dlHV.5J1posbgn_AHvuhkF.OWU
 RG_ClopnXAeHC._1amvZhBL9yFVcYjsBrdpveetjP.YepegafLiMp5WuSn45.g1rtcjEHpuA6PMp
 SrxaneqArXsfATG2VRKOzIrKJ7ENuLfpYzlwzrOyaqX9gG19RHOQToiwE1N8MXndqkbkRUKePbtQ
 wKs_.s0H2YUU3yrlSH7o0Oy6rF_olOwh9OhEERZ7fKm_i9WUV.YZqtZY6aYoxzWwyGmhPjtC7kct
 qMK4S39L3MCDFIz.jFJs4fB5GoNEPiKY2.L2618yglOxMak5IOe72Ku2RcogNmQKWSBaGXnWE9F6
 R_0rFG_yLae7XWTvwx61CuSziY44lr5K360sJPF5QLIiz1puAyUoaqrxwpMiebmCF0vv2QLl.XFK
 .Lv_j8_GLAW8YHq6S2t3v5luTKBDW_6J2lHFjj.74W.VI8lYq7ruUNeBe4He.9r2166bSo9ai.fZ
 Bg20QwYHCx.Ju7Ro4HtUw_ynzu9pAImInaAnyrZAi644m6Zbcti7uDaqOUAyGJsWbkJ2gnZ0ajEW
 OpdYtSjSfheBnR4CzCqn8jRZhuekHMwdeIajsr4uPGyCKLmxo5ekwrpPl.OvcopVZiWZtvSMhQid
 0FTE4VwtLS2WUgeYxoeo4uOCky1zHX0vFWVVosagIcqJIImND8bzubyVzWMAsGoWoEp8QuM4.D53
 032tdFCcs79yL7wqsIKKbfGwlj41nCXIp7xWLSZIcP947rPtpoXnzkIgAUUXl5dSOtQosctraUJL
 XT9VtfyTr0CoVaWF0oArG6ncwv8T3Y60xElS2O5N7wqHTKenYZVRo2ytQ8MXMhxwcQpknlKGjQcA
 0VOFkIayZRulja9rPTr8919SKzmW9Z3oPfQnvyQXOzhv5iHF5su2ibPr0_3kZnxL.jFCKAqldWM6
 x2g6t2GEThEfJT2rtq1_9YSr3QxaGE59ieHOFsQIVjOlscCGIY_tSV8fKHLAbLEvAiJHEYFUsmqL
 InJBMfKQJO3cu_JJXmzi_ETRTFA3IWMxjCBL_gatamv4lf_yukhWgVtMsb_fMKVXaRpNsD9N7NVQ
 lr3rFQNtw7jydMVbfCJp_fHZOTRwONH6OijId6Ze8y_0iTKH4Y4h9XDkCAiz9iDE6RIFpLlBHamK
 Ee07j0oPzACccDppbjqlB9bjns8WWyMsZx8qtcgW5j2Sl0CoK5kuNiytrOH9bXyoK1y62Hxs8hTi
 fO3Pv9J_SJ.Iut1aDlccZfnlgdcWVBUDRzBOXpDx_xvBXendVX2YlDS3HM9QdaAS79Sz_xySFoV0
 S3ljGDNCsSgJkkkYgOqQIeaeUy2PSi_M2i5.a3MVTU4FITR01uxMWFnGlMszDgB76tlLOz3UExvM
 .yGA-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Tue, 11 Aug 2020 06:24:54 +0000
Date:   Tue, 11 Aug 2020 06:24:51 +0000 (UTC)
From:   Miss Amina Ibrahim <missaminaibrahim001@gmail.com>
Reply-To: missaminaibra@gmail.com
Message-ID: <1089003043.83615.1597127091053@mail.yahoo.com>
Subject: My Name is Miss Amina Ibrahim from Libya, I am 23 years old
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1089003043.83615.1597127091053.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/42.0.2311.90 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My Name is Miss Amina Ibrahim from Libya, I am 23 years old, I am in St.Christopher's Parish for refugee in Burkina Faso under United Nations High commission for Refugee, I lost my parents in the recent war in Libya, right now am in Burkina Faso, please save my life i am in danger need your help in transferring my inheritance my father left behind for me in a Bank in Burkina Faso here, I have every document for the transfer, all I need is a foreigner who will stand as the foreign partner to my father and beneficiary of the fund. The money deposited in the Bank was US10.5 MILLION UNITED STATES DOLLAR) with 15 kilo Gold I have confirmed from the bank in Burkina Faso where the Gold was deposited.

Please I just need this fund to be transfer to your account so that I will come over to your country and complete my education as you know that my country have been in deep crisis due to the war in Libya and I cannot go back there again because I have nobody again all of my family were killed in the war.

Please read this proposal as urgent and get to me as well.

Yours Faithfully,

Miss Amina Ibrahim.

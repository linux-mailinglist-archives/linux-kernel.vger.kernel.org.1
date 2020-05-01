Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7A991C190C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 May 2020 17:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbgEAPKs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 May 2020 11:10:48 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:34533
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728856AbgEAPKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:10:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1588345846; bh=lMwnL/6WltFrTd0TmVnY+7WY/Sq+3khHK9hYAyAunB4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=kfOWk3DgScGQUzmPvlVHNs1bEmZ3sfXlHKng0dewImkQutsigeqf1s/SpJD+Ew2fbV1tnd+wrWUV59IKIlcQlu3+kvzVHfpZ041nhkgxRuYWsjzp8q33xkFr3ULhDu/W0H95pyCNSfXhx+LAqw/34dxeOS7p2+LeHWSApDVflK8f8udLmWST1Ug7nOhsaxZzjuDQWVhsB+49r43qISW8ckqEQYGNNRT41r6Dz+FLS4hjZ2MsUgLvCSvfw6YsxIoIRZZA/EG8lACcROESn7X5LLKxGkTrVTgPrR3z1PQBuFMRuAyixbQgQjsXfk2pr1o3x1M+AFIEKt5ggoNV7lAQEA==
X-YMail-OSG: sgZnPHoVM1kcLQ_CD4ACrvyaDHOR723LXG6MRClNZkrc6PnL7FrObgae483n5fm
 GiKTmsKKhqOzGp2q527Is1C53OcpSBL69Q4lZR1VN_BTjHqWEo_kYWvNa6lj59.uCI0sZUgJytCz
 7JJkjIFhvfAFbURy7oYr1cSNrT7YZiZH0TDFp9Lh7FZEp_KSdJskD0g0dEmkCgZtxj_2NmMTn.C8
 U8o_PAVdNMDxtBrBY72ZWUoEFs7QyuAuD16yhf0xoAdDHoO4Fb9yStKBuQKCP2OCRgzNcwHMLctS
 5hUy0uF7tT6iGd6eJSoiEqanYGrVsyF6_frK4UlUsFrWNkElku_p72xQvzQ_MZ9jLTuT9EoVZLWz
 ugUfa7ObhqbXUdySDsdreQaZMR.WmY3_KMXUtcTmAPq.9hcIAn_dFxdbypFJJDglTKfNYvTjaigT
 0gbXKswAQHpaxgx3xXrdAJnjVkTsBZwLUivYFnciVmN2qkmN3pIWWuiRKKfRb0gZS8QJNmUMrrKK
 67X1guSbeSbeOBXh0evChFnGl1vdeY3oQGumm_bXwBdl3.ZQq.kIsq7dDSMxiFawxfNFffrCYSFf
 4H3vfTBbAdJAW.NdIXZEJCz8pPS_DokIXBWGdldq6.i8sioWynPmVbJWUy6lrQ9_M8nwjW_UIBlv
 Ba.hQwUrZlQN2etw2TUsjRRjA.sfxcHVa4XqSdt0vRdc9wdSoYXxeb11lcXjls0I_AhDMpvROlNq
 .NfGLWGfHQ0maQ_UuXgYtItF5jy8EcgTl.PAlJX2jFQivm9KnVbrJdVjjRMqYPRdBbXkAtkiRAgX
 nKvrqscMYDAJfqHNf2_2dmHb2vcul2LJ1_1fBUkglEm_.I0mUaWLXczh.WpZK7gfYXSq6pjqyUok
 a1TZT7F2ysPsI1.FfKhPb.HI_72GAYgnma2YKvnYyY1ouUiAEoq3xMb.jywjhvPSkwVK43LiY1xu
 iCAqzMnMubZuM.a3zaCO3KJ_0PRwk4NcOHFK9FgqIeOpXQdP.6hEV2IZJPg1bldBmcGG2VaZYmGU
 2rrfksTDNzJJFezmHkM74hODYmZjRyq9dN057qGPGhy5nhxdYwD6kGu9D.mM9Uvs8XOjmS20wSSb
 IMfeY9cLs8VA55fpre8aoOOd7GnSYFaTCgwuxrqIodvc9MHkTDEq2MWV5uo9I0xiObhMllFdKt9t
 NXiDWWY1NnsXURGMOurEOsVTZlk.XWcsduq0.sBXhGJYItL4LD7uRu6U1BXQvt8564A9unh13Rlp
 eViDELzrW9LauN9HywO8hSJO8jHD5FgDzmHGfOZf3yoJpDN1XQlj3yIMPj03VN3nOfPpuT3AMOA-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Fri, 1 May 2020 15:10:46 +0000
Date:   Fri, 1 May 2020 15:10:44 +0000 (UTC)
From:   Rose Gordon <rosegordonor@gmail.com>
Reply-To: rosegordonor@gmail.com
Message-ID: <541367390.265417.1588345844952@mail.yahoo.com>
Subject:  Greetings to you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <541367390.265417.1588345844952.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15820 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:66.0) Gecko/20100101 Firefox/66.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings to you,
I hope that this letter finds you in the best of health and spirit. My name is Rose Gordan, Please I kindly request for your attention, I have a very important business to discuss with you privately and in a much matured manner but i will give the details upon receipt of your response,

Thank you in advance!

Yours sincerely,
Rose.

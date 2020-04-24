Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF7011B6E37
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Apr 2020 08:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgDXGc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Apr 2020 02:32:56 -0400
Received: from sonic317-34.consmr.mail.ne1.yahoo.com ([66.163.184.45]:37051
        "EHLO sonic317-34.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725898AbgDXGcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 02:32:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aol.com; s=a2048; t=1587709974; bh=AqTqPd7Yqg8DOmvUuZttdbqkBxYMeDS9kIHkcAfrMuY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mUuRl+gfNyHXh8UUV/NDPanjapxMEjl2DkBDWjTSVv+AbunR3Sz+Q/X5wZs2dHRAnZJOZKhFF+G1NodhrKHba8pHy7/8eu3nZUpJAvTSa/nee+2t6HZYyK9/PsV8hJwA3QTCIRRigRDRb1h3ogJgj3p62MXYn4sE16gCc+Hr9VhumPxLGKztOHZqzCeOwmXPuK9VvSH/gqCVSF942+uUb8M35Yu0hv7nAareJ/FYSne4Wqtn8wiaHuRF0ehRZo0TDCX/XjdDl3RqU7e2X69sa9GXxKqYMfV+t/yBg03mP96+MySJymAf17Qm84LVTOau+/cV2FAvA4ORVSbjbzK5Dg==
X-YMail-OSG: ErNBUk4VM1lsIemJnesiTc3Q6S.cjDz6RAFYxOaPwv0NZfz4k8ZXaH6nqKlRRhL
 w8kysRL3uwWehNF1IPveWsxTmqXMiBp_SU3UaLsObeyOIDX86i0WGm4sFx.K230SSF5LL8_eM9TQ
 9D1.XYSx8X6S5acnaKwzxSyL27r2A7spveA_rCEXnj.TGPp6S80XBJopKBQYD4P6BffkBC38oNou
 EnANrFyt2tNmTe_NiSqJT_13YC_6hqeCSYEYH9qGstAk.kQoRDIRvvIrDA7LbSA6xj1rNIfpX7Bh
 biJqW9rlG4ezkvjpkf_6zqHdWJlxViFWpnwbk0HmpFVm6TN4IEep6lTaFtNrWS0yux17zXrLm0W9
 dHpZ_OdTjAdWM_wgEXsZrPyCW1gas_aNTdC.OZG7LYnvcjwlF3klPmAnk1F.nnItRnTznXPqZz7d
 fat6bfkrty_hPHrtvspXU3Chn2baVCMrdDDbNhPnL83p1zmOOPJemAxChlUC.m5TRoqkCWIcBxok
 mCKFP84vHPuGL3CJD1gV6toYB9ZFqsRLnNKSIOf89JTTBsY0nxoqzr48OYttLKBzXATOHgHBnxFp
 G9pBwyD3Ieo1WHTMCgKHIvgv9dcoTIuNZ7hVsIZY8lNA_uxau8sfCzB4jRrp90qEhSf72Qc0F3B4
 8e.v6OlTXEciHXyLyUdJPI8AFixXjfceH314gFPKnwzBtR8GJvsqF6WEZ4FdEgUtE1GupshjjvTC
 Z6Nsqb9EyvKWWBzoRzw7QQEHFNcno1Oh0R6.UlK5bMKPmkefsujvtH6EI4se4e6ORt7xuF1_QaZ_
 n5lg0eL0fSYSxhosMBNUqwWUfXIg415sShmHbvOqg8RU0iWzhnzZkNwaZF0qWNEk5zldZBsFjkF_
 TZhKj7rvepVrcmzLxQHlCTIFUfjOqSfwyk0CizChhgadNr8UgcEA0ex.v18ruhKpiCVzB7g6uTfF
 Z9C6z6edsCjMJKxf1J0h9rYx_xzbVn2AfJUA1Tv9NmH2L038bK7tvwYB0w8rLl1JnqxjFodETHFh
 GQAs1ErYUD3FmztB1rXukIQXvigSxSLaUHSYZHybeVMjFrn4cJGB9pWmG0GVoApNkm9geK2P9h8a
 R_PfLOJOcw6iOY5r0_F3MsYw0B_qbvCeUuDN_IFld8lVWqkuKorp8woliP0oTk9VPHN1ibSeXAeB
 Z6DHYGMIRgTk6gfPOSr4GfUt7J9nbVtiuJ8Jf9EMTuYKmnjZMQLlQpBvUlURU7hmxrX8WSzcFFtE
 Tt.N7BzIKC873vGQ46Ri2OfU_rpu2e._Rls_HR9Y2nNw3K9POClxYSMnJE0MUIy62gqj3NKbulw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Fri, 24 Apr 2020 06:32:54 +0000
Date:   Fri, 24 Apr 2020 06:32:53 +0000 (UTC)
From:   "Mrs Yvonne .D. Balalaika" <mrs.ivvonebalakiwal@aol.com>
Reply-To: ivvone.balakiwal01@gmail.com
Message-ID: <1680656999.51179.1587709973629@mail.yahoo.com>
Subject:  TO HELP THE POOR CHILDREN IN NATION URGENT.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1680656999.51179.1587709973629.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15776 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Sincere Greetings,

I am  Mrs Yvonne Balalaika.D, I decided to donate what I have to you for investment towards the good work of charity organization, and also to help the motherless and the less privileged ones and to carry out a charitable works in your Country and around the World on my Behalf.

I am diagnosing of throat Cancer, hospitalize for good 2 years and some months now and quite obvious that I have few days to live, and I am a Widow no child; I decided to will/donate the sum of $ 9.5 million to you for the good work of God, and also to help the motherless and less privilege and also forth assistance of the widows. At the moment I can not take any telephone calls right now due to the fact that my relatives (that have squandered the funds for this purpose before) are around me and my health status also. I have adjusted my will and my lawyer is aware.

I have willed those properties to you by quoting my Personal File Routing and Account Information. And I have also notified the bank that I am willing that properties to you for a good, effective and prudent work.

It is right to say that I have been directed to do this by God.

I will be going in for a surgery soon and I want to make sure that I make this donation before undergoing this surgery. I will need your support to make this dream come through, could you let me know your interest to enable me give you further information.And I hereby advice to contact me by this email address  ( mrslvvonebalakiwal02@citromail.hu )

Looking forward to hearing from you  soon,

Yours sincerely,                                                                                               
Mrs Yvonne Balalaika.D

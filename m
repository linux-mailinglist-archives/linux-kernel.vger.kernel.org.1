Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA851EBB81
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jun 2020 14:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFBMVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Jun 2020 08:21:04 -0400
Received: from sonic315-13.consmr.mail.bf2.yahoo.com ([74.6.134.123]:36383
        "EHLO sonic315-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbgFBMVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 08:21:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591100462; bh=WCnWLq8BPrdCMbkdv9jA9CokrT0OCUMl5RLneP5fHRo=; h=Date:From:Reply-To:Subject:References:From:Subject; b=Fpu4N7+0WfXO35eCxO+cPvRQF3yXA0Xu6GrAPzxxmbb+5uiFXGhbBhmKiiU7v0gmBEMyTDN1crXu8eSftMipGRJ/v+Q9HbDqVw0iLjqVob36RxRjP66tdBc0937ls9/CoxfkvLGFr/rZBdZkrafTYufxLZaByvJtk+SliDZOZqregRm7lE2wCX9lvxntxaUBBfzgAORvkpbE+itmP0SM7TxoclOxOQ7B2qKyfh4xU0e0cU4uT3xRWlOAm4F/Ng7+A/ci2/GzfHk/S4SuQHNCYs7nH6JFuMt0s0vikL7A+fc2EvF8tPCtpAX07XXuukXaXUFBcYDvdPgep7VB0kwd8A==
X-YMail-OSG: WKvQns4VM1m3jH65x9k9RB6_zK0c_gBGjn7L90fpwfzXjMnVlu9JTgjfpcK3Htz
 9uDPcHh3XlikRdClpTuYorbhf5L00nc51AdJ0KrXKzbdHgK5Ok79.Dgsp7H23iQH_KgG90GHVcR9
 eanK.Trj0ZaswzbT9NJN6fcaU2Qfvxn7F_OEySam_UBJc0awK6CPd6YYFp5QHJvzTvC.YvuIDDdx
 9.qqfEl9lS9PiIKqxgtZ95EmabxItCW.AstMcVGqE3VMHKen24kFKB2oti.uHiZriT8kJs7A3CdY
 JuVx1dsCw4ymNQDeKLLWLqa7opB6umA4LM_554JmirVAhNuC7wK_AEqziO3U3C8Xy0HR9HMs8UJB
 JUfmrl3R0T79r8EzLWXpQlEHk3KxDNubgqjPOml2_EbJBgiZart5AAcH5sYERPo0kaI.Gei0KhkO
 YxAdVvmW8V16hgSYmTjimvj3IoQk6QORGztR.LcTXyFmCEcfBKqyFNFVCqF0X.b0Z_Xu2PIXmtBg
 KbkaSyYfrmn1X7ZwexKIM_OwBdc14knGntE0uMDWKRsrkC6gxsOSTHtUaV3Q7f7Wh70O8y8r3u7K
 BJbxGZ2908RdueD4TRI1cGWgvfMQNUXHamk7fpi9XYRM9nQpKQlJBb6j04Vt63wqXjD35RWYD574
 2U6uoTqzAPuMpVpQTsPeAdUEIzRMd4e7vSYu7vmqut9P8FWRgzjTnMJoewaETmz47kpthPoqB8q5
 EYmhSt1IaC4NyDfy_XF_I2AFVcuW2uXwBJL9_eH5_GLi6PaCaWHb9p0p2yxbUrKP8iBhnUWn43XL
 zhbjDzBvv5Mar18.0Slh6UmU434jaXlYRnMc2LtT98HZ216_0EU8jnlgc74Qc8VQLEuBxp5zf89h
 uOX9HCvdfVHQio0RKu6MQUtybodAlq6pWN085X0zBguZvlGKjv98qGpzPUm1AKVSZv5Oy37c632x
 ibl8.DCVyV95AMPbQI2dldquNS_B47gsBIsw9YRbo6tH2cfzJ3qpNJlgo6cyHYQ1c_.0poCX4qCW
 aSI1h2Muu2GR60vmygFPSvKY9cuWqATs2VPPQ5CU6rCmjpBaB3tm6lztyMOCTFlXHFfoR4fZVYT1
 X1E1tpTmjKNtirwAXjGW4l_h_KaVr.viXp1J.F1oX6eoP_cGPKj6pJFoohfPeY5_Ps6e0FMsfqEZ
 BLgjnEdsKHsUytzcfZJi6mwyYGVTPQohO_xhyrQz1DhuaxSMsMdw9lzWSKfrVznKMeBZuFUYKFaT
 BGH_NQ.Q2VHk83h27QS1EAsLC3rR7GuJvu.F1WequBVm8NyeIdvNM8HFIrKtKtQbfftmhOLMKS6t
 D50Y6Dc5aUOvASst8VMvFu7JbTJbn2GBqBXmv
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Tue, 2 Jun 2020 12:21:02 +0000
Date:   Tue, 2 Jun 2020 12:20:59 +0000 (UTC)
From:   Richard Kabore <richardkabore1212@gmail.com>
Reply-To: richard.kabore122@gmail.com
Message-ID: <154813635.953718.1591100459067@mail.yahoo.com>
Subject: PROPOSITION
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <154813635.953718.1591100459067.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16037 YMailNodin Mozilla/5.0 (Windows NT 6.1; ) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.61 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org





Dear Sir/Ma,

Good day to you, i hope this message meet you in good fate. I have a proposition to offer which i know will be of immense benefit to both of us. I need you to work with me as my partner in executing a legitimate business deal. Kindly indicate your interest by replying to my private email on [richard.kabore122@gmail.com]

Yours Sincerely,

Mr Richard Kabore.

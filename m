Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0067D1AEA0B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 07:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgDRFoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 01:44:07 -0400
Received: from sonic308-10.consmr.mail.ne1.yahoo.com ([66.163.187.33]:40434
        "EHLO sonic308-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725300AbgDRFoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 01:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587188646; bh=85FejEn00gIkX4TgTiJo2MrF+4KusxIBycp5MFD4a0Q=; h=Date:From:Reply-To:Subject:References:From:Subject; b=kBtLiAGySWL/VszdrCcK3ME6tgBAuL4mjjk7PribsyZbLRlhQbg4j85jLt6klG9KBQ0lRy4yjqJfvy7S4k9QmemQjaNDiiHzOOu6Yx/qaOuy80/vl/XJWAaHtQjnD6+pKCwwk52S5SCL3NLDGUGmH/smJdIdnSp7gS4qc/0FziDw4s5Hkt8RdXuXHiS4hxWRe2SGuinO5sOlJJOj1nPYzB92hAgy96s7wpCKrfwrxlz3hgZCDh7S99igMerdVGAaCMS3uCRwuIM3YZTdkx/btuZRzIaqXPWtsVYgXsgECmg2sbvBN0uf2nJfKrqnzJduPbuIqjIRMBzr2gRQcE0ejg==
X-YMail-OSG: ThuebKMVM1mxRfYL7FN1Dp6ZPsajllc9Z1XpWAS_aO8XU0nSMBty_iSKb9y7Y_b
 FNi2lqjALD7biV2Wr_fSjWp5y1f7i_oK6wdrFksxp5Axtp6ipmjHKwfiZ_o1U7brYboQ_a.D7zkY
 ngWFlxpHfc76QRGMPsCk60l2UWeX9V2jKbjvm7onGMQ0aD9nVbaxYGF2boGsvHHSXOqzths2S3GH
 ACXVtHZLYVwX2HOuUWebllukL_NUYKYsIV3mUW6W3WqczGAeAJtYSncmYt7lv.2mV2JOrBtcy0fC
 5I_9PGJPkeg80qqobU4Qgh0J_5nhdfBND9Jef7I7tg6uSyOeDjOlxnNkulQxrUSxEqmM5Jw3nYll
 yXgULOVtIXb17Ca3PMyXTr5iFB8K30X1G8CJwIW2LGVHuK6mxBYOYVMOWRdD5ztM6WsdaYaemyE0
 Iq_UbZ4AYA_bdid4tz5Xs35ZGXjH6uISxYLZxosEW0A9BRjHFyvxWbAhQl7.iqly2cCa8Lw8LCJe
 97we8n_NHsLPiZewpVrhyBfjjROVOM49QuUyX8kmJ_M88LjmT5WQA2eWZMezIdhF307ExrYEiILu
 ZLI2bYCriua9y.WlnLmj7LOtn4updi.XZnAiRrNezkHcBhBFdBDdZXRke_o9lk8IR2jBIIVS.aAY
 iiO5pCJzUK_RkmDSGl5Lupc1OxMbA093du1HcAITGgAaGcNk.R1lDwEz.r8BgO5q4RVAwu36w1Wu
 bH0n9Qy.27yqBRta59rNJCMu4kUHhpmc402KhmXpF3XWHNofF324s9tDBluslvQWmlxWEsNEkxyg
 CXAuSAeDGQu68TnYailiOC8Z15kAxlFdQP2feTOQd57_wD6PG5Qraz4SRQ9lpfx60LhP.Mswq4Nh
 VTbFnzCkyyI1ClZwwg8.6LfmtmlSU7Qx2sEO73MKIUyZu9gtchnOFn9uYWp74A3sWVDOogKPoUlV
 SlWJR92FkO1NP6QNVeidJMhMr8NB6xc.cP5Gs9Hn.8KWrsD4K_J4h1DJL2dnsqoim2mRKSZLg54_
 dOlM71WVCdvMxnk7RJt1LmRa16IOMN8VVg35Z_ts9shUUlXmygban9gjWZv055GrwD9V1_YOd0c0
 Zd1490a5.wc4GYCGjmgz7guNWbXsXPniuAeHnDzWmc_QbaYeqVddO1YMRYYdY8SWpDW0em.BU5dN
 bimb0LpEMdVS6zjqvSMR60KOzg4x_ZWSyJoxRnWVZMWiMSDtreKQoY6.KDxsbx7YkYwpqusm6Ckr
 y4feSagELy_70GZE3NeMnRxdaWlG.FdMdlNnqxzkScSRvPKzO_CLOWqWHGaKwc7Mrh86uD5h1Idi
 Ck0061YRD7TxhAMbyiFZDI5f36G0yj0hqPpXxoWiXZms-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ne1.yahoo.com with HTTP; Sat, 18 Apr 2020 05:44:06 +0000
Date:   Sat, 18 Apr 2020 05:44:04 +0000 (UTC)
From:   Lisa Mikerriding <lisamikerriding8@gmail.com>
Reply-To: lisamikerriding8@gmail.com
Message-ID: <276795038.2573126.1587188644384@mail.yahoo.com>
Subject: DEAR: FRIEND.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <276795038.2573126.1587188644384.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15651 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



DEAR: FRIEND.

My name is Lisa Mikerriding I am sending this brief letter to solicit your support and partnership to transfer $10.5 million US Dollars. This money belongs to my late father Mike Riddering, my father and my mother were among those that were killed on 2016 terrorist attack at Splendid Hotel Ouagadougou Burkina Faso, my mother did not die instantly but she later gave up at the hospital.

we are from USA but reside in Burkina Faso, my father is an American missionary, before my father died with my mother at Splendid hotel,

Check out the web; (https://www.bbc.com/news/world-africa-35332792) for more understanding, I shall send you more information and the bank details when I receive positive response from you to follow up.
Contact me through this my private e-mail
 lisamikerriding8@gmail.com

Thanks

Ms.Lisa Mikerriding

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F36D24000F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 22:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbgHIU5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 16:57:42 -0400
Received: from sonic312-21.consmr.mail.bf2.yahoo.com ([74.6.128.83]:36874 "EHLO
        sonic312-21.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726307AbgHIU5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 16:57:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597006658; bh=vSZ7gQ8F13hDNYtYk6t77g8qrdmtAY1S6LJUlA/r/r4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mjhmlVHLplOKMoqSOYlldbvrVt5TMQpQjj2VDDW6pkyS7PdJoLBEFDjU58ooq1MsEEdEscqhJ+ffTeZxdz3VMoi3MdirQ2WtVWrBmdRjx32dsXhZXTdc+KlZwAyOvAdSzTQBAGINz1pUsnFwWIVZ2Y8b9fexujIr0DV8wzA8wNTWDdmAJAWYKqwth42BP7FgUdR7te86H566kAQhKnxP4sryNOjt1ttr8MleQYoQyfJ0RG3YR3PHAUZ+HbgFoxg6muOpVOROVDg6L6EBF5UnBxDJd3dlmIZaoXpXPT0QAwvuE91pol599ctA7K18BDfExCu8UHQeqHST6Wp128GEmw==
X-YMail-OSG: a4vBFUcVM1lWaTk8IojCRJkpjmcdJXPU0saSzXQKWyIV0z6jJ8Vn6dvR7j52I7Z
 fc3xLLVhqgAOLkSmaCOb5EB5lwVXbPIt_zG23Y7_Fd7bkc79KIepUwn0T40YhRMqCH7HDoht76Dp
 v4l5opGtq_RAaKRLe0DmClgUBPZ5mYQDU25GJDxzlzLrGBQNSrWJUW0NtuE5nDrHISCfKkxrKXzT
 K3M_XzB_NeC78vsuLQeCi2Y4LSKSAtEv.2rhTG3op7rvitY6CDd_npsjBPpDBcWZrPmTsT4CGdqB
 ur7JbJsSRAAj5DLSKT0QZ5CpdMi2iV1cac9Od1_DQQI0h9kfATXpWlMt_5v9Ma5ZWEhFsEphAc_u
 CO8G9LmLDXXk3ccwKYuEdx0phDFJKaChjTKh9KqkXNOI.vUIHa_HPG_rLhLDbWKu3nzAWsvzpIjX
 I2_q2t9Mg0qujn88fwB88HAn3fbvVNXvviXybWxDeKE1LHiJayJq1s0aYJZ22d_SN7Gg1zfegqa9
 KitsixEBB7vuppn5veYRVtccX0tf_pYpHteg2JWvjIgL_bmSroZeytiSTU9yyOMYYrbXViriTpWh
 pcaIzfun7x3.hN4_Wp28vGz38CTDbDmFSDtn0xGXhkgyHCUn1vKqoFaBCcD1UNPI.jguWAlTpPRu
 Y.5TMLwv5sL1RjPjKPAIQvt6z61rXPIdclGc2wrsYZZ5cZt4FjiCwhfiG2n630IG3kb0UHD0JiwL
 ZY6v5rXWAdQTaqlA2nLijzD6d.2F49y3ZwoiLZ0846BN7I..PXWvE7.lygygMWCvlaCDWnz63Hqv
 MwVdEZbHztRAHBIzYAsLHolmj1Z7OPoSdJCPrGf_bZOCE3SziCLdT..iQqBY1EAUxw5sLK2uy.dq
 Ukj3wnpTuRXElvvABrLdqfDelekRc2UGcJ5jknNKUyZuODW25pVErdl6JlG_hjQisCrQTXv4uj23
 wWwmrhBX1F3m898n9dNliaFty7FlnjbmjhCJYv_yqicXW7PbJb_VY6CVeRwPS2E53xuwVofcQfTb
 yrg8IgLDTsqZku53yFTnmTYFVf67aq_l2j.pgLR2aeDDfZpx3.Dk1Dgk8pkVxxDVc4nwvIB24r.t
 K6bKZrCQXLvGBFMWjVTPheIvWxfvgU5XAKCkIykYY0nZ_wcWk2PgejWg9iQwlFZCVevZ3HXAiF3L
 V1TnMz7cSEV4jjp37tY2UtyG6Yo7HH7XMKou5z7LdOfnT4oaBDDR33ucCrrBY4yJojN.s1AxoWCr
 XqQSAz4U37fuRlMvRMPvvUNKdNSje3miifBZb9RB3rlyR5n6mVLFtTwgbZi1owIQyexnrqUPVzjP
 GctR2uR8D7z2P0DV_8j35JTW0LdCDabxT3tNErSsJrXQ5oCqqI5WfJa47
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.bf2.yahoo.com with HTTP; Sun, 9 Aug 2020 20:57:38 +0000
Date:   Sun, 9 Aug 2020 20:57:38 +0000 (UTC)
From:   Mrs Faiza Mohammed <faizamo501@gmail.com>
Reply-To: faiza_mo303@yahoo.com
Message-ID: <1717288071.1607621.1597006658371@mail.yahoo.com>
Subject: Hello My Dear,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1717288071.1607621.1597006658371.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 5.1; rv:52.0) Gecko/20100101 Firefox/52.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello My Dear,

Please do not feel disturbed for contacting you, based on the critical condition I find mine self though, it's not financial problem, but my health you might have know that cancer is not what to talk home about, I am married to Mr.Umair Mohammed who worked with Tunisia embassy in Burkina Faso for nine years before he died in the year 2012.We were married for eleven years without a child. He died after a brief illness that lasted for five days.

Since his death I decided not to remarry, When my late husband was alive he deposited the sum of US$ 9.2m (Nine million two hundred thousand dollars) in a bank in Burkina Faso, Presently this money is still in bank. And My Doctor told me that I don't have much time to live because of the cancer problem, Having known my condition I decided to hand you over this fond to take care of the less-privileged people, you will utilize this money the way I am going to instruct herein. I want you to take 30 Percent of the total money for your personal use While 70% of the money will go to charity" people and helping the orphanage.

I don't want my husband's efforts to be used by the Government. I grew up as an Orphan and I don't have anybody as my family member,

I am expecting your response to private faiza_mo303@yahoo.com

Regards,

Mrs.Faiza Mohammed.
written from Hospital.

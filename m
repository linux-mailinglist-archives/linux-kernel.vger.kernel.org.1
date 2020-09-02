Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABE325A863
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Sep 2020 11:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgIBJLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Sep 2020 05:11:42 -0400
Received: from sonic313-13.consmr.mail.bf2.yahoo.com ([74.6.133.123]:45170
        "EHLO sonic313-13.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgIBJLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 05:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599037893; bh=zS4B1yRTnNuvY3t+UCspgZgSTCynme8L74fJQbF/Eug=; h=Date:From:Reply-To:Subject:References:From:Subject; b=tZUrVBf6ULY9TYNJ4d8hYIVPoreT5/ciZPRsDW17KHJauqVM6NuDdKIfrU6Khoe0eJ8vKw9Lt0Rj5cReR4zmOA6NDNqIDIhaYvyC3YAEXyWsJdxvocHjQLACEis3CVzPn0GKvom9rF2G00KkvfF8IIqCXpS/ECP2B3fzgbpXJv6t6mkMAJWpV1+g2nLRZTvBEyl3E+bXN3+aJ8YIXL7K6b5f6io6f+eT02pyt3yYBBxRlfdnvarCithdxtZzy/K+soFnQR/aFckU5EHX4IdD4/WsuECjx7Ff9ajij8/D33NEyc/pdcYm57VbC0sKG+5ZcfTkEI1juFFhnsKoY2KLvQ==
X-YMail-OSG: wuyMNFEVM1n5nzgzrKTCrD2buUntQVm3.sEuMYWX.Zfnxf0qYGbgWYpxp6Wvu54
 tVbiC2Xmbg5QGDc_lj7sgoTARxpoHSYq_IW2TJNOz2cZL7lcOTrNU98ocG3g..jwFK._8OVTfrqO
 8fGSPHqgnb4m9o_5jjTH8m7HUgTmkcFcDbtX0GGkl6ZwWHOffWhqKIPEHvGQCclLStq8CyySEids
 rx4UIcwMy6rDyXuHOmJnMqTlitnbhfQTGynsZ1GaHQ3I9lcCW_9NYD..cpALcujCBjIb8F7iaOpW
 B3DM4rhWr0PobMKxrW7CQ_GFQi8wWIOIazhMLiPHhvCAd2XNP7Y..A6pLDArij2WSP92T7UKZpTr
 qchUFTexTskwCI42INPiLFN4USJo_2TYKssSccBPmSC8pplWTyJQEJy4bm4pSJzVhgTBxjKhwVlF
 OZCcnQP_89R0_y40sL32mwlx_lORLh8hChzoQ9G_LWfz26bm6C8YterJy0lKJot.BZcGZlLA5XgU
 gt3dBsqMxMouZgd.G2E2FqXDvmb9nJl_bhIlziTHfy8nWcbahyDnvCNM0LlfXvU4mQocuxD2YONQ
 hM_1evEJehqY_XaCOyAl3jSjx1JjEROlRaEjxAa82xHTaSb4D6dgo08hRBNtrXBoxM_6h2q4hIf6
 4dYGYIZ.zoRkcUm04si.6R8WveJlRYH69NnkON8cI8v9KA6PA_rIetATs_6b1b1SQ1TKx53rfy7I
 6kCksufEJWlq8pJ_2yc3IL9lxgq3nDQ_Iz2kzKTgTjqQJz9uIZOiuRJHXQV0sCeTyt3agnB4GtNg
 lw4.6B7YEH5bfDfw3NJDow1otJrZ9Hnf4qKeljs4XHDkCWRvYxhjzgjADoWThdWFc1ZSyIjm_Mld
 lLRtoPdPrt4HQnHFTwmUqjv7.CscsVeHn.tHXgQvsuXX27uv_eaE0zIUIosn2n4DpTPJfjSaBmNV
 hWYGv704pxwqYRFTikaZLI7TMWgP.JWpelrWSvVoVDPt1RX0T5_.YARad49bwgapb4rBSIklZRXn
 LBG3NXMSwWjI_sirSsvoQqATW10MUzOWlwv2P310P2QIwXCL4JLbT0C4EBeFp.Yg_lZk.fpRTlcE
 rgLfAsT3FIBaTI.F8Qqk.iTnbKWor.5FbWBlUowlqi02XlKUY5UOOPX9CSDD2p6ZgypNutE_ChNq
 2fEUYzqtfOyrs5VCvZlRr3YDnIt_sd.ct_qOYgSEVUo9gljCfTjio7_9F_R5XpdkfZ5gXvFM9fDm
 w3h_tVPy7JQvNGW5wiYfpSCJkU_QjWVzFr2dc8Iq2J2c4S13UXSplQlAJSL_7ZMzw5_sMHs2iQ3r
 lcJwBadqHwgNfQU8wXCQNAqxUKxLghSlMeIrkDBUCyZGTLw0iB6aQEFsi6fcTk9c5tazDbL3sKu6
 KDUzUo8FocaA6DO9OrQ3G5Nj9lp.7Z5in4Kc0AB2phMzR_P13P9Ja9Q.NaaxnhMSwvhbOSVU-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic313.consmr.mail.bf2.yahoo.com with HTTP; Wed, 2 Sep 2020 09:11:33 +0000
Date:   Wed, 2 Sep 2020 09:11:28 +0000 (UTC)
From:   MRS SABAH IBRAHIM <mrs01sabah@gmail.com>
Reply-To: mrs2018sabahibrahim1@gmail.com
Message-ID: <274226644.1452255.1599037888880@mail.yahoo.com>
Subject: Compensation for your effort
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <274226644.1452255.1599037888880.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 5.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/49.0.2623.112 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,

How are you I hope you are very fine with your entire family? If so glory be to  Almighty God.
I'm happy to inform you about my success in getting those funds transferred under the cooperation of a new partner from  GREECE, Presently i'm in GREECE for a better treatment  and building of the orphanage home projects with the total  money.

Meanwhile, I didn't forget your past efforts and attempts to assist me in transferring those funds and use it for the building of the orphanage home and helping the less privilege.

Please contact my nurse in Burkina Faso, her  name is Mrs. Manal Yusuf , ask her to send you the compensation of $600,000.00USD which i have credited with  the ECOBANK bank into an ATM card before i traveled for my treatment, you will indicate your contact as my else's business associate that tried to help me, but it could not work out for us, and I appreciated your good efforts at that time very much. so feel free and get in touched with the nurse Mrs. Manal Yusuf (email: mrs1manalyusuf@gmail.com  ) and instruct her the address where to send the ATM card to you.

Please i am in the hospital here, i would not have much time to check emails or  respond to you, but in case you have any important message do send me as an update, i might instruct the doctor to check it and respond to you, meanwhile, once you received the ATM CARD,  do not delay to inform me.

Finally, remember that I had forwarded an instruction to the nurse on your behalf to deliver the ATM  card to you, so feel free to get in touch with her by email  she will send the ATM card to you without any delay.

Thank you and God bless you.
MRS SABAH IBRAHIM

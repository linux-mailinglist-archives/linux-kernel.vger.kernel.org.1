Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435C61CF30A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 13:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729418AbgELLFM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 07:05:12 -0400
Received: from sonic307-56.consmr.mail.ne1.yahoo.com ([66.163.190.31]:45275
        "EHLO sonic307-56.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgELLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 07:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1589281510; bh=zZF+nYbPr59HIn/8E5u2BCzPfYuyClLNCBJrk4cphss=; h=Date:From:Reply-To:Subject:References:From:Subject; b=mGx3F08WYZllOUpIuWylYSHXM14/w4nprjUUGSULqo3JFXyarY+RDp225Szv5u6P53if5kAxT+d20ZI/8YzY7aeIO+bG0rBwWZQOXot7rIkQCWOh9HJsKrf/HCcUfhAebRP2rSpLUA2/5sb6H4eV7rqpcLVJ74TseJSwVOPNoZSWo7oVf4BDZnlmsw3QYioTBpqs1HL/hZM+BAZfLeMAO4/9vWGFmoXFjdoZ8zJakdFwh6r0nkPCad6XNZ30ch7HqnRuCSj1sNfipC7VG9IfidIIrP2rOieJFVwfUUUF0rFc0fp3nfSFPG+Q6RJLuE2YCZHWCU5nLUt4/ZfpTlcJrA==
X-YMail-OSG: 4rEEChYVM1lMVkD6pRXMWCO0qbVTIwSM72fHPyHnzRmVRt0MUUXPBn5hiz5ISXu
 Dkn5fErwzRspBT4VByr9HBEoXrvAecobDykMScEbtOcb3HSdnv4R_UCmhW2qTSoAZ1PwUMSZrLQI
 Cdu8p8h9SjHV5SY0plMoBRl1Oiaoj7KX8IBWCNbUPIG34PLcgFg8l5cnem84CCDZVClaybeZglJo
 dCNX.edE_h801aWosCgwVWkGQtOv8cYJm84HN2_jjWQg1.mjHkgTtfGluqzs9kAcXN4CljHpvMsY
 lLQMni.W._K_ikwt56olYLzhpgRsdU3Rd1IGBvOjqBjlUDCGP2fmGyJDl2J7gny4WqFsEEqNKQ94
 uCTsAMJHiHVoVokkEmHe.Z3yGRHeToqu7Jqd1Rlq1lJjLcfrgYBJVjbv6QyILQFAc7H4no2WVCB_
 NscWAdqWnZb9Lh8Gy4DfH_Un7mTbk5bJGANSgntioHIdqbc9wty8aUSe8XNdHBvqG5gZu93ZXMPW
 GdBiQZXLVebeZ6ESfxh1oJj_i9c01ovKHwpzpmYkn1X4byjQyFm9.1L17CZp3L79petvleWNVDmi
 uM30Bhow8XgfFuQeMqxd.aghTiuaESbGd3X9988Wd3oODMbz45CLpBPLwhoP1gdCZnMK6ivfFcVI
 ZQRNDD_FAZLlMqaaDijR9q1zPL60ZpkVHzen2yXHq1ZFEAe94A4gIWol7vNihJPHxCv7DJiTXKuy
 v5B49mZP0ZoVB852DiBr8N_KJsqWBPzNB30ul4VhqaLQs01xrFUKxsVnIHDA_cn_j1OJS1RO5UoJ
 kKbcVBm0fJ9xaTXnz6rWFq.8u6zQhaC6buPb.iqy2R8c.UdRfZKv3hAMcjbnA8aFYkfsUtfQm62I
 j8g0I9YwrD2uLKSMzbOTeHzOUy4_QnebTx5uSbHI9Zk8XBGYLcwsdbA6nr7yJhoKeTWt74M0yDam
 rG4w4NaQks6PQjZ3eBEYVQlODEwFemv8dHobh2ecD2eckph1GmO5H2zHdnljf6NeruyYSIKJhKYk
 3IfHwM68XkP___CAzWyTTDedpOCQjzv2CJwlDkl0_dv1yH2BUjEhuYdez_ZOESrvUJ.by1sUdpgw
 6YBOWjA.QAojl8WfjqWgGy8Tmcp5XAkJbv1QlTeWBv3fAkUkSwckYvVoqHh.NVAp8ScuxdAqTcx7
 n6KpxXxLU_fl_d3ZqzjHizhFBxe.2wBb0m2VKe6rrAzCpBZ5Gp2wSVet0s5Hlq9F2.VLmuUePUha
 tcsV8oR_UCSkzvISFz0a8tP47juXLGWYmCIk5Pi65RtuuFq6siJhP7Vi4r1IBy4xiurNBh3B3aGZ
 8_.0SUkAWosa1dZ1CmFEvV9LhbcB4.IPYwUbPROytBvyWcKVk380Vv9Wap02zJYddCgX8jQo4aUJ
 JiPvIFkE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 12 May 2020 11:05:10 +0000
Date:   Tue, 12 May 2020 11:05:05 +0000 (UTC)
From:   Francis <hashimfrancis42@gmail.com>
Reply-To: hashimfrancis42@gmail.com
Message-ID: <1781086.1918565.1589281505659@mail.yahoo.com>
Subject: Dear Sir/ Madam,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1781086.1918565.1589281505659.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15902 YMailNodin Mozilla/4.0 (compatible; MSIE 8.0; Windows NT 6.1; Trident/4.0; SLCC2; .NET CLR 2.0.50727; .NET CLR 3.5.30729; .NET CLR 3.0.30729; InfoPath.3)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir/ Madam,

Please forgive me if my request is not acceptable by your kind person.

I am Mr.Francis Hashim, Working at One of the bank here in (Burkina Faso) as the Independent Non Executive Director & Audit Committee. During our last banking Audits we discovered an abandoned account belongs to one of our Foreign Deceased Customer, Late Mr. Wang Jian, The Co-founder and Co chairman of HNA Group, a Chinese conglomerate with significant real estate ownerships across the U.S, died in an accident while on a business trip in France on Tuesday.

Please go through this
link:https://observer.com/2018/07/wang-jian-hna-founder-dies-tragic-fall/

I am writing to request your assistance in transferring the sum of $15.000.000.00 (Fifteen Million United States Dollars) into your account as the Late Mr. Wang Jian Foreign Business Partner. Meanwhile, before I contacted you I have done personal investigation in locating any of Late Mr. Wang Jian relatives who knows about the account, but I came out unsuccessful.

I will like to bring to your notice that I have made all the necessary arrangements with my colleagues to transfer the funds into your nominated bank account without any problem. Upon your consideration and acceptance of this offer, I am willing to offer you 40% for your assistant, while 60% for me which I am planning to invest into a profitable business venture in your country.

More details information will be forwarded to you to breakdown explaining comprehensively what require of you. Reply me on my private E-Mail Address: hashimfrancis42@gmail.com


Waiting for your urgent reply,
Best Regards
Mr.Francis Hashim.

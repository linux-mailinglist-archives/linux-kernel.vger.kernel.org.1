Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 548CA2320E3
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jul 2020 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbgG2Orl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jul 2020 10:47:41 -0400
Received: from sonic316-20.consmr.mail.ne1.yahoo.com ([66.163.187.146]:35486
        "EHLO sonic316-20.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726353AbgG2Orl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:47:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596034060; bh=frecwKuhI+/snRdUkLEaZ1uRzOkmNOLXMS41Vwdb/SQ=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aamycZoENc0mGZ2jvb2CCHW0Krs3JyR1uBYaJEMC5583uvcn4kaOueFBnjtJhZzFrfikWEqSGrg6J+qvqJ3sgy6ZmUAxUwl3Mo5LX+Ih1+b3Uv1yhPs3ZpiplGKt9TveqkmRxIF348b1VVc0d6th2NBz4zsX4VGWv0CFBINp5ufP0n0nMdeWCyueC3BaVic9zTVKF33kQHw1T+U2Bls2ABIrE3Oz4NRt4vm1/viSjrl/ZE/FAWvuk66YvCYlpRHQHDd4pTGhvZHaZuKsmqqn9YdlcP+A9TVYvibhc+/ppEhEcUkhG7DgeTk5e07QwBWHczsv0tzxoyXObYA+GGBsJw==
X-YMail-OSG: E2C2.HoVM1k37S7sk.NRakaDgUn202YzRwJ2EqdZ4Xmgx3UqYC4QHizwTFMFHkI
 G1Q3W25Th2vzgTR3L_4RmD0qMsZn5noRuY2okfC73bFVrBObrTVeJ6_bMoaRV26yO90l2rOMS_ra
 DMHVjJBXcBec3bSkVB_3FT8XDq8Cdu9dvWmu_jW6vX3J_yoZWbpwks7fFV2bPNcxtWwbErbrYAGp
 1AcQAZd_N_JQZtYb8BQVR0tsL7rGOybfH.is93UuQtBu1ipok8fUtmvdf82xTt93b7t.YMEFC8pQ
 fP3_G2eRaao8ENDbbo73vzxk86cCLXmB68XPZvttzTtrWz280lYkfnzRs3eZsrFN2Ff8TujhukgW
 hRwnvxbyyURwj8IAjwaPq5ngal3f.I6VfIbEpjnlFTmrDmNOL5fQJ.9WI.rLVRtFu9V7.Nb2cfUv
 9KU8tQu81.ouWbjub55Fv2hOZso98RKin2qLiUeaw0HQqk_trJBxvmTMrjy31nHtEkKo3p.jw3xS
 2qGvMOkQW3i7yMasaUrqez81h_gdSXiivoqkjWBsw.9gCT4cqfyzROL2xK6bHPZCC77wINfxmsyU
 65fxWK96xGz8mzZTY1b9WVWaw6ZeARoXBq.QzcCxYx.mUlsBpwAYaQPzbPxNYzgtjmsHpwvvTYdC
 vU90kp9pjdVVqN8mlFZwyrZkbQg4noSrNCe0AowiuK1yfie.8gc7qi1n_J4qvxcuXjlMhX0_TXuP
 26cEQYUy7UtqkUQ6e4gBjTp4c4WGdHM3BjQ89V.nUbPpe8Q2G0U7pv2yK5sYthywzrAmVtoX3TfA
 BiUlXrWQjhYDwBgU_pj4ngKk52x._gW3Im79txNI0OX43fIrMJcsZ8Y0QBV2KVZafYjFPkts1nkr
 k0y01Xt.VwkKMEsIdgSdnEfxaSiqQ_fBg6FkbW9t0p7ZjUdvIy2IyDob6Nn4JpFEF1uCpe_ZOpNJ
 5.AJZHY8yfU6QF.cEUru_ehdzRZclC90TtG5LmYEvB1tJbecSXGrinasZW4aoOaKf6lEZBg3jeKv
 sPPAlnW5StPh8Q0HXZzkLprCsTOYyEbPZ56yjk3zpY0y3wKc3KAlPtVKledc4uzIpAs21FR6ngSU
 0tnwBQYEbkSwl5CJbAyUu5YCajdhmok.goAcdNemJV3crvBnvrFWuwUXI7nREOqS87cQIMsrW2NP
 r90f5XQRE74zGlw3Bv0QBZ_M2g9jp1hvYQXZYYis3x3GIZbOTMEfQyUYLRQZq5STYE6MmrcbXmXc
 dQBdRwxHrwI7XMO6JREpFW7asDw9i8D.OLI.inQHhnBJuJdSulb.4R7IYhZhjatS42W9pIuoBYOB
 s
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Wed, 29 Jul 2020 14:47:40 +0000
Date:   Wed, 29 Jul 2020 14:47:38 +0000 (UTC)
From:   Mr Arthur Weinrach <bchurch72@frontiernet.net>
Reply-To: arthurhraec@gmail.com
Message-ID: <948023525.6257485.1596034058123@mail.yahoo.com>
Subject: Very,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <948023525.6257485.1596034058123.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello , Greetings to you!

 My name is Mr Arthur Weinrach, I am 50 and i work with the ECOWAS bank as the

auditing manager. I have emailed you earlier without a response, in my

first email I mentioned about my client an Engineer ,who share the same

surname with you or he might be your relation and his now dead.

 Please help to receive the deposit of US$15.5Million from a dormant A/c

before it gets confiscated by the bank. Get back to me for more details,

listed below for the security of this transaction.

 1, Private email address -

2, Full Name -

3, Nationality -

4, Profession -

5, Marital Statue -

6. Date of Birth -

7. Telephone -

 I look forward hearing from you as soon as possible If you are willing to

proceed with me. Please NOTE; if this proposal does not interest you or not

capable of handling it, kindly deletes it and forget about this offer

because it's not a joke neither a child's play. My email:

dh2288133@gmail.com

 I await your prompt reply.

 Yours faithfully,

Mr Arthur Weinrach

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDAC1E4AA8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 18:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391425AbgE0Qo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 12:44:57 -0400
Received: from sonic305-2.consmr.mail.bf2.yahoo.com ([74.6.133.41]:40961 "EHLO
        sonic305-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387952AbgE0Qo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 12:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1590597895; bh=TYgdp/zNeW9P5rVjVpFopjba7a+Fm8hxyemx2bQVZd8=; h=Date:From:Reply-To:Subject:References:From:Subject; b=TA1Mwmjlv7IjI4IIv4UhNrxkBHKgTNUOX3R2t9lAde1B7O2HNw4nBFjaX4CtgIEasygWwluuJGItV2SRTW0q6xIox042JxHHBLxFO83uEH+XH9F4E0FatUqVjOPlcHHbGMRPCioypNKs4CLYH+kmZkFvTz6W+cPBYDcJD0YQozVprLnNzvg6ahb5BfTz087vwhR4EytWDlob6YzjcXwUPqYMgBA0WT+exZmSvR+tDyCk6RP08jxCpaMIsuhhRSnqzynUb0Pj0nJNTxhslwFe6hFKDWuHcyHVdfTikHwSRUppLoZmNrWmdqv57YVYztwlULkxXO0l3udm/0P8odaWyA==
X-YMail-OSG: CKxjK4UVM1n61rbdIsJFUXzV1iZ4cp.uoex28WTRK0w52wCTAIJAuCZF1m2N64B
 HbEYEUE53LQTcw3ob9kX54FEE8_2WQigmC2tKmOJwJsHJESbxxSX94_K4QeQaX52LnQ_6KrcqSDO
 G_e9mnV9iMdDH49LfnY5vHewIx0j0pZkAySQtvIsFFPpF1GKJB0mMZIQcbGzO5Kimc8uEF12cONr
 tsQoI20cdxNa.YvZuJ8W6VMAiy8FzVeE1YYyv.Vk3vv6HDtM1B1rfGDkhl60pWlwLcNnld06VXGz
 E3gXU29CiOt2zNtovhCdVW_xEVqswVwNfiC6B64pvn3hwVdYhPDvmJxUkWDSykuGj57ywr86zpsS
 XVNpVgHOeV4TnldIJqz4inFBCgoiJ_WV5SoXJpOAKRvb5yaGMrpR6miqsXpWJIvMM5kBV.sHtCTd
 7xEgwstZ4TR7LnM4ITwVasDb1sJsVXkZgcsfM74pzXlYkDljEqwtDprXHPqUG_p9I7PkkqdT9Rio
 GDuhJC47wK5rQ4ckUd1Xyy4wad5WtZJjb7BWFbqKPqUD.HCyX.hoaFstGpjqW1eLLJW5Sa1Ef8Tw
 hdiIWqY5_5ppQ8prn2jLhUAxMdO8KTH..cr_M8r.Bu6WH_kIZhrXuCM27ClKfqWonigWuUHHvqlz
 SzG.QmBS08Q3GSMjMXXz_68k75P0Iq3Zir7vi.IzF2JDbWf09r96PmtfwpR7aBeYl8_NPgVZVwpX
 e9K0GnpD5VhwldzrwsU8kN.4Dv0Lf30j_BPG1WSb5xW.xtVp_9T9Qq3m40rYFAcyG5KdjUR7pX3A
 n0ISXi1TL4f5lkAq3Hq7IuagrWyhxg38LdjLF8sZnm_t2u0OmL3jYmGZJp8Abpr8coO1a.LnshAi
 dbpFuqHwc9xT7nB.IkNc6CxtNJl1XkLHKdPCBhy6O0zvurdiixAJVuZVItNOppnAZP_hzcLMfgvs
 Aok7FJAgNwCCN.ajESn2.x6BbOrR672P5wUJJl1ZVBWPTE0Ckk5YOxjk6Y3AyHu1sOuxovVR34fQ
 cjdN88qt9d6ktPBWVuqBEHc06lA2uy2.kGhgQq_aaM3bcd9FgTVT.eQ0zzUuYahJ5UmGoz8RTCE_
 P5nAKYGMWgRK4VHaI_dWm55Bwn36.gCF28p4jZaEMsQx9FyKfFpGjxZI_JUgPqRxH6abmRu_pGeI
 ddOojH0ww3X0Y672aSW5jb9Ta9yeU0xZ.hmPykuqKQ9tuWQI6kopTKOtSGVAGPKeAXvAdPyr1sM6
 cbkCu_r.KA.vTSMs.yqYdmzzP3WAZYQBXVl3vajgvjh72408P5Wm1iQXGWkXKRH0wk0WaidU7xE8
 axZttGAKL.TJya_QhivBzmNtILxI7Fw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic305.consmr.mail.bf2.yahoo.com with HTTP; Wed, 27 May 2020 16:44:55 +0000
Date:   Wed, 27 May 2020 16:44:54 +0000 (UTC)
From:   "Mrs.mcompola" <mrs.qanbanden999@gmail.com>
Reply-To: mcompola444@gmail.com
Message-ID: <918074059.347611.1590597894014@mail.yahoo.com>
Subject: Dear Friend, My present internet connection is very slow in case
 you
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <918074059.347611.1590597894014.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15959 YMailNodin Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend, My present internet connection is very slow in case you
received my email in your spam

How are you today?.With due respect to your person and much sincerity
of purpose,Well it is a pleasure to contact you on this regard and i
pray that this will turn out to be everlasting relationship for both
of us. However it's just my urgent need for a Foreign partner that
made me to contact you for this Transaction,I got your contact from
internet, while searching for a reliable someone that I can go into
partnership with. I am Mrs.mcompola, from BURKINA FASO, West
Africa .Presently i work in the Bank as bill and exchange manager.

I have the opportunity of transferring the left over fund $5.4 Million
us dollars of one of my Bank clients who died in the collapsing of the
world trade center on september 11th 2001.I have placed this fund to
and escrow account without name of beneficiary.i will use my position
here in the bank to effect a hitch free transfer of the fund to your
bank account and there will be no trace.

I agree that 40% of this money will be for you as my foriegn
partner,50% for me while 10% will be for the expenses that will occur
in this transaction .If you are really interested in my proposal
further details of the Transfer will be forwarded unto you as soon as
I receive your willingness mail for successful transfer.

Yours Faithfully,
Mrs.mcompola444@gmail.com

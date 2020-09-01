Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2680258645
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 05:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgIADkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Aug 2020 23:40:01 -0400
Received: from sonic304-56.consmr.mail.bf2.yahoo.com ([74.6.128.31]:45612 "EHLO
        sonic304-56.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgIADkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 23:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1598931599; bh=lJYVaiDATjla84gWJfGLUgPBIk1ls/SQaELqT22q9P4=; h=Date:From:Reply-To:Subject:References:From:Subject; b=WjKjVMEtg7kPNxFogBbJKKX6CPaYMIF6NCzt/AGNxxOSNybW3osD5BmewZEz7M+tTyvjribqvGTYE0G3G6wlXEE+aInJvQxuNqLFdP2MdweP77IcA542A9LALGPbUbxfRaQCPnFbaKBLM7CwdKgHMHPSiq66+CNxjOIJBJQJp2fuGTG71vgOOdXnE8FnZPlw+FBE/xAkSUuTuYNm4y6kgCO+eKBd0SnzX3+eM1A7ZbWr2NSrCUSX0yhIyNLtPurbPXZ5mF9KgGqIqeGgJOHe6wm2toKW2oGVUZU+Ce04vlyF/CqhfJ5wtq2ZqB2cMGN1RLWUEukBneZ0IxrT6JkBuw==
X-YMail-OSG: VsUHM8gVM1kThE_SFYCpR2nXGZS4lReM6.CJt6KfKm.AMzGYWdDRm0GdBH1oMaP
 M1Wm1NbAkOoURZrJZsZm8D68jGcL3TObbzPXgq6OBfJC1bTLT6x.lSEu3rjUyd.SkMQg5vs4MvU_
 j7PwlIRsi1MAKjfhoVMkwfVw4LolxJgLDrkwo1WeY0gy4D08LnheqF5LfbTbbBDv.JkQOLBpfUr0
 xsUYYwZH8ulsEetPYBgrMWJcw8gizOmefdsAKeGuBymWmD2SpafH_tvO2enIDkrZUtXe.YsmTPtm
 froXShZN0.Agco3rr.UQbSlscHRHXo0WxGH2ymqjwAtpiaambDgtMyWQCXoNt0inLY.kabIyoNKP
 tiYQMWRfwAGT_Pi17W9.dYZUqwCIFkcf0mvbIyYGp0c3gPn1RRRkqBSqFVp3odwGuRZE0kI2JLGf
 3miWJ4QaGmQGG9IfZOvT24ZR5DmvKkhU0qTwW4m7YBLLEwtLWWrjKgcvAv.VYXUsXKqMZE0YxCTw
 oNSWGms7.nd3cNKEvRV23senY5lgau6xcwTkXSmmFimnwjtsb0n2CKFeKP3nbTjrc7ya52HgPTLZ
 GlGfWAJnNvRm3danLheWZ6z6ByJ.yOwo6hs9zBurzRyT3bAxJ3dw96D21X5Rkg8ZvCLI1JiUwh7G
 BEhvK89s9rNdZ6Y89l11FqQUxsT_wbX05D1VO6z3dMCqGDD1C75WH2Qv0CMgI0Ho_wqxipbuWg1A
 aRPbaZAobF0rLqK0n.XU82r2wzIbfTLT5u6G8zV0TJZku5W127fCXjfUq7Rpd4IDBpukYaO0_Xo4
 jA_fJtEqK8m1OPo6PdorvzukPxSk4YgDETGHeM2tWOKbH4dzds6YK7K7JM2T.m1CkdtsCYNHTMTr
 yYIQ5Cy7Hs_ecbU8jijf5kwgU56DS0STV4_nBmTvXfGFdk8p5CIhzW9wJHxHEDzE7eKTBREGq5Ey
 ZX_4jy4SGiKnyRhSWZ4F_4Qy_EP.O91ngETLDZDXuu_WAES0X5ly37ueIFzwIda66j_pkIwmZMSX
 Djwh177Rb2NjpJcWwPMb4aeev1n3I8Tro8f7D_YskkIyy5iNhDqaJAZay5sBbTDZSH1uy50cRB4Q
 JjFayDjE9pkNkpW6IaNUAZF2o147f4Sp_Qb_UVkHOf1gR8RHpTthbd1SlL6PFqw2RXyR4mYrIMd.
 sfuBXZkqkYSghPNf3PGL_UJi0xwoeG.6c.w4clZdIvltJXjMZmT2h8Gm.2Th6vLlvhe3VPqpdhE9
 bJcH.7A21zqp0_wPfHvTMfNBEw73TQkmhzKHFzrzz80tmf4h92pjCE6X1v_uWpufyVGXOOtwMlGY
 CUS_CIBSuoFTw116PtjyPpwhCOqU.J7kTtptMMqe3bQlgljLntnBrCTISUXYQWXXkGGKyl7pPu_o
 m3mc_M1oR58_.ydjuf9Qa4qOZjr5UKFPYFYHPPYYYIGE-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Tue, 1 Sep 2020 03:39:59 +0000
Date:   Tue, 1 Sep 2020 03:39:54 +0000 (UTC)
From:   Mrs Rukia Nimine <rukianimine925@gmail.com>
Reply-To: rukianimine56@gmail.com
Message-ID: <158097397.960989.1598931594542@mail.yahoo.com>
Subject: I'AM SUFFERING FROM CANCER OF THE HEART
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <158097397.960989.1598931594542.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16565 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I'AM SUFFERING FROM CANCER OF THE HEART


Dear Friend.


Greetings to you in the name of the Lord God Almighty am MRS RUKIA NIMINE F=
rom (Paris) France, but am based in Burkina Faso Africa for eight years now=
 as a business woman dealing on gold exportation and cotton Sales. But I ha=
ve been suffering from this deadly disease called cancer for long and the d=
octor just said I have just few days to leave. I know it will be difficult =
for you to believe my story now, but this is the situation I found myself i=
n, it=E2=80=99s not my desire to be on a sick bed today but God knows best,

Now that I am about to end the race like this, without any family Members a=
nd no child. I have $5.8 Million US DOLLARS in BANK OF AFRICA (B.O.A) Burki=
na Faso it=E2=80=99s all my life savings, I instructed the Bank to give it =
to St Andrews Missionary and Home Kizito Orphanage in Burkina Faso. But my =
mind is not at rest because i do not trust them, I am writing this letter n=
ow through the help of my computer beside my sick bed.

I will instruct the bank to transfer this fund to you as a foreigner but yo=
u have to promise me that you will take 40 Percent(%) of the total money fo=
r your personal use While 60 Percent (%) of the money will go to charity, O=
rphanages and less Privileges" people in the street and helping the Needed.=
 I grew up as an Orphan and I don't have anybody as my family member, just =
to Endeavour that the house of God is maintained. Am doing this so that God=
 will forgive my sins and accept my soul because these sicknesses have suff=
ered me so much.

As soon as I receive your reply I shall give you the contact of the bank an=
d I will also instruct my Bank Manger to issue you an authority letter that=
 will prove you the present beneficiary of the money in the bank that is if=
 you assure me that you will act accordingly as I Stated herein.


I look forward to getting a reply from you.

Thanks and God bless you,

MRS RUKIA NIMINE

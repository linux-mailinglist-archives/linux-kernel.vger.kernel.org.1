Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E98A9229733
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 13:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgGVLMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 07:12:23 -0400
Received: from sonic304-9.consmr.mail.bf2.yahoo.com ([74.6.128.32]:34539 "EHLO
        sonic304-9.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726028AbgGVLMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1595416341; bh=NajTNMrfMLb6UXcjRhYpYerQX8PtVBLz0oFgaMINSWY=; h=Date:From:Reply-To:Subject:References:From:Subject; b=VQCndyh4808w+2KY6wYD/nswAKOvu5rMF85LInQHfuWCYBj9tifOVPvBnSQJJF59413vHCqGFyJUyMoIjLhL+tyq6a5dhuQAH1j4MJQ/YHoiVu18tEKKAMR468olIEOmtn2VxIcf3H9cAmaCthIc93TPDlnW1ESsLoJ5l4PjCjizBfVqgnlpa7hk6gpubmvK2As29LjS4arxEm0eThsTU+wLUGvKD1QKkAAfGoFt97TgltpXOugYZhFw4uGdDqConjUJjPdgdfRLGHl4x9jlnJl6TWX5BpW0yrihEiguoaEIRm0pAGovpsFNMg/QVyjyNUjLp6zWPVo2FCVna8newQ==
X-YMail-OSG: l1pOd6IVM1nsVjwOlPJUZiiTB2yi3uZ44vAEf.nA1PQmaZW58vQBfuTkXzdcnqB
 OCfx50_zJ7YFDXPLBuddY3KpOvDDwZAMQtamxwM_0ua4znjuXmKMSTUHoch4FWIFivvjJCOkDYVe
 w_O3lsnT_w4JoD6Dn.Jy1I4Op5sbMQQyVmcu649yIG9ovApHjuBd4FNA59tlui8bbos.6vFzq.CR
 s0Xto3FpXhNhRyuX4VQiFl3SftrT_Ge4yJinBn_6Bg5pUVZtWfGbDc0lrvcGEItg6GyfWDKCVmm0
 .SFicjpsqRkgnCq0gziRsEIgDoU9wocHLGFyX9GDD3a7BsJjy1ofPyhY3szBszogEqGtiXFCv37j
 zOkvHrEYrLTZqayRyYrMlIbKbS3NSWUdeaq2Jm7oGeuL_AP_5Wpex7nBiU1Gcu5NnJspe094uOtJ
 3G1Bcf8yERP1uQO9ePCrKiPoNa1LyXUVvi4wVCR2fY_HXlgCsHdu3EmDUIlV8bJELs_2tDVqMt1n
 2K3UYng1HOwOa60dFuQWBsOJvqWSfz21k60pyLqF98Eegsdi0mFQ9GW3DjNdoSXYhd0UejswK3zF
 igvJZhK1DHeDxqtG1daPYQmBdsB3a5ZGGAOtb7j_JWy9eSk5VoFphaaj2rnjVhm8bsZ7s.AtobH.
 lxwgJjgTKlM5y81rH.IUemJ.7dQIqmtzA3rruMqgPwl7NYAm7MUnB4XAfzCYH3RkNntDMkAmYn5b
 XxVrHI6HHrNLnKYUTZmR6LVVfFL_2bDigGe.M3aEd815HBNQ4JSVwP1d9a.n1kqmLva28QslFtfp
 z6BfMoqzkpm.hNqdtBcEbMUOYLy0xK.ZDZefaI7iQ1RS720jQmmQ7ZSckYQZ2j06cvJUalArFVVa
 _KNysDfmhNdLVUOd5rZsO4C58uf_lPzQ3g1isNdL3RaeQaee1Kxpla5e1ag3mmGAgETytbAC89p4
 gBynEE2Xwt.2SojOaeWtejiHl.ckj8Kmgf.MjcEWc7Xn86HrV_6zrnvfXd1GKMnrGMWXVlLQcFW0
 7E4RnNI_Ly1mfMIjMoswDsive92kPIogK78G8OOlhg.IbHczfd0gAnVAIaPb6waP.6r2p0DpEv0v
 Zp6i7k90RpryXl4V4m0145O8jBAQQCgIHQs2aIksm86Tgd6m4mIA8hpd.6RPbo39gBTuUAaB6yAQ
 ok0Sl3hJTGH_wCu2g7deS5S8ujPdI0SaT7C15uGuPGM7B6fI0w39RyZbS4yQaCX.SRCZ2JnDdNJ9
 V08Olo5qnWhZklhky9AdmjtETo__FkD1PSzNOcgJMOr6YTaoKvwEy4gd34KsgICZlLjz6zLgRyco
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.bf2.yahoo.com with HTTP; Wed, 22 Jul 2020 11:12:21 +0000
Date:   Wed, 22 Jul 2020 11:12:17 +0000 (UTC)
From:   Ms Lisa Hugh <lisa.hugh111@gmail.com>
Reply-To: ms.lisahugh000@gmail.com
Message-ID: <1026966467.3792122.1595416337794@mail.yahoo.com>
Subject: BUSINESS MASSAGE FROM(Ms Lisa hugh).
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1026966467.3792122.1595416337794.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101 Firefox/78.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I am Ms Lisa hugh, work with the department of Audit and accounting manager here in the Bank(B.O.A).

Please i need your assistance for the transferring of thIs fund to your bank account for both of us benefit for life time investment, amount (US$4.5M DOLLARS).

I have every inquiry details to make the bank believe you and release the fund in within 5 banking working days with your full co-operation with me for success.

Note/ 50% for you why 50% for me after success of the transfer to your bank account.

Below information is what i need from you so will can be reaching each other

1)Full name ...
2)Private telephone number...
3)Age...
4)Nationality...
5)Occupation ...


Thanks.

Ms Lisa hugh.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9F623FE53
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Aug 2020 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbgHIMn2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Aug 2020 08:43:28 -0400
Received: from sonic312-19.consmr.mail.sg3.yahoo.com ([106.10.244.209]:33448
        "EHLO sonic312-19.consmr.mail.sg3.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbgHIMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 08:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com.ph; s=s2048; t=1596977003; bh=0iDlXFTI4TESKRtunoKHUg4JkgRhW0EZhRkg+i2dGfE=; h=Date:From:Reply-To:Subject:References:From:Subject; b=XhlH34lK2QRRusw1rbJKyscHPQd3XlBq3o/l6tpysGYW7WEhWlBKtNb8W5PKcFP0ZQ/kmdz64O+i+TCve17qGdU9U7pAivhOIwe5CLGyJX11RkybQ91TnnmELCip5AMn/56az2GB71CJHbZWaRgWYBfPIg88JRzW2sS4v2tTdAisRQJJUmCk1OyuCSzCd8L8GDnhUbqe5PS2a+l6HUBKh5cKBgYX74L36FrzcVC73vQ/jRx2Yk7kxb3/mM1KkZgv0eSqa0qDocp/VCm0RkRwu5O52UuMauay0l5DsVNbe7boxs86gS+s6YaYB1da28iBpS7ZuZVdw8VNrP3nQQ8ckQ==
X-YMail-OSG: hQhZLucVM1mBfq3hFE.Sc8KMN0YczsySNFltGQ3Do0cNRrmkJgYFNtO3XRCGQk4
 bdDe9VHJVRmc3ka09rLxm8ZjCzU3wwcEgcOeOTC5ZhbJSFklJokWZYbULlFRNM35sFgvhgw1KRmb
 B_9UkP8Wn6ByT7WY2GlNu4YMTn0xp6o62o.oEzW07Ih_H1RciqnoVm8qdBlSMKpR483.x45F2kUL
 cUQJlclMGXW__TUsU9DueOgCW6n9FoZGLAhJ2Dhiz47tYHZSMUIb40_1dIYzAz35YWQ4MOpqLwLN
 g1NDdgPuk00Cf6hMmPoInpHfm70TSh2Iy1zMBJuoLNWsP0lqn3RhPibQerTeOenbkwkaC_NCKq9q
 GoP2f3dgmRvUysJHN1iwG_HUOb1NqsO_vrz6Oq1KYApLCAfmy6sJdsRFboou8oLcP6KmwUDPKzoN
 npti82irC0x8UMD628LWH09XjUoZv1qp5FwFvxkqpq3j9OwhU_3iLhqsD6ERZnFoH1Jf3lMAs24.
 01WJV_ZVYe0m8WolUglIoqT45.BwE6iydsJ.twY0B35eDxAIkqUl7DM8oM2t8mOgNCyx0vNZRlB7
 fMb2Aw_Zus3yHU93siwhzIvHguoKESy_.AN6e5VlrWO8oH0481lLGJ8DmptUZ.XoQ3PpzKjePPe6
 YJqPfvwLnWf.E72AoAj3qQnZBLW1Sld60dV9rZNgl.l1DKCslojGVXTbyr2OQ77oaE1LXKZ5A8dw
 tW2m2Ww8G.lZNswE5g.k7ICmoiUHwbVG4GM_Ml4zoMKe0OqOHriGmsOksObqGYtgDiUxy2fLS4zy
 4wEQrqdWVWCZDbo_ZLJtHDEH0hs.zZAA.hYZ_oB1wkVMK8r_7i9VeSazYog4v0z1ZzjXgRycPO5e
 ePmBmAJhGL0L8mT4eHobvXnjrwcKnodIkn9Q.j4p9c2rWUIHts3ZraL2_lY6FEWKvNKNjT2CeVp1
 6G7qqlEdndT_6vAKro5RqTOZw9cwifadYrT6pfyTwDMMCW8yRtproz_NLA7gLu86GwyrL78OY5pV
 AlHb9AgqAiyfnDilX0svr9lgd6.ciVst8445b3TR0nT1surPWORutltdvYm4mkmw86w18fvE_SKp
 y5zIA0mffKekPcPjo.iw0T607Bw9XA1jC_WKFYoLCLbzlSAdwpO1hRErQNDtCCOMgBCJJrEy3MQp
 wvrASiHkaiDbNR_sYChe6bkq5KFJkigMS74D9C0o6vcR0fnm9lxm8mrSVcowuMdhnrPHbfNsKP2x
 LnDaru1ml7GHHg2frdtxi8VMLwea6liYN5Ix77fCNv.SMiav._fwiOF2qo8STqqmqcnXUZvYI_Z_
 nQ_PI0bP.2WUZ4F04NHQP30JBJIXyuUw7eEPeHmYyL.mLr0WOAA7gyjzp9Ae06fFJKR37
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.sg3.yahoo.com with HTTP; Sun, 9 Aug 2020 12:43:23 +0000
Date:   Sun, 9 Aug 2020 12:43:21 +0000 (UTC)
From:   "Mr.Dickson Nsebeh" <lastinpkt@yahoo.com.ph>
Reply-To: waxson.a@yahoo.com
Message-ID: <1168612853.1289970.1596977001774@mail.yahoo.com>
Subject: Re: Your Assistance For Investment.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1168612853.1289970.1596977001774.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16436 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Friend,
Please, I come to you with good reason.

My name is Mr.Dickson Nsebeh, a banker by profession,  with position of ( Assistant Manager ) I will be going on retirement end of September 2020.

Please can i trust you to release the sum of $9.3 Million Dollars, to you for safe keeping in any account there in your country ?. You will have 40% as your share while 60% will be for me to move into any investment you will suggest for me.
Please kindly reply me with your information as stated below for more details and how to execute this transfer to your provided account as soon as possible.

Your Full Name...
Your Age.......
Your Home Address..
Your Occupation...
Your Country......
Your Cellular N0...

Am waiting for your response. God bless you.

Mr.Dickson Nsebeh.
Reply to> waxson.a@yahoo.com

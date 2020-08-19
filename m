Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 606C5249674
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgHSHGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:06:19 -0400
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:40935
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727034AbgHSHGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:06:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1597820771; bh=OCp2NQ1DG8WDrE2HT9ykXjnTFISlxhUILAf78oJl1As=; h=Date:From:Reply-To:Subject:References:From:Subject; b=rXknsM00B0dTfAOvyBr+BDyCypIZ8ZvsCi01OY7qpczxa/0VsdhSkSsK+DmUl7jkMWDSrqNhHHnKqcrMwsqqcJI3nSElMtOVP1XYJOsOdaVbdwMKcIhcZYzwZSXNUZbFo2c+ARc8vIU1xpqYssaF9gVvr1swR6E7icbUUnre4wxw0SRoRx2DMOmn1Cs2MkI2jqoCeYbsbFR5VpsqwREYKzHs29Es9yWtbnfZHzVOu+SxEw7lTgAj3mGi7NomDD/p/BODVT+rhkfz8/hVfoUQM1f4I1miTwf9RSeCu4ZsDPqgYDoqwqoqzFeQEL/1qIyfQ/6Hh/QV5aWpAFZ5CItc5w==
X-YMail-OSG: pi7zDmsVM1koEl39ekL3ahKNidG1Dm0OI37hybm1hTapsKZuGDCpZh_zV58gnY6
 lZqnOMpuq2zX3xXd42hOoqhUy0hPbjL0RtXYrYxFlavGHkVEq8hsFGdDcVRH3j2gmh6sxRBlwEjd
 af8CZP0G8flyfRewhUKauO9BImbCRG3ZOz9NFgrQVXZf4K3IKhpeki5LnrQxzDQA8YPRitEO9KNU
 38BhZ3BZutj8EzqlWPrIcTf5lXCGVpvG6Qb5x2cs7r7aAUbZ8Sohkmsu7SmGpUU_b8c6BVCHv09A
 94bbcX3_XlROkIKxl.lhUrUAhqSSwPxuccSB6Dy7VK.c2WU7Hb_uuwAANSLhS2swX7ECkTK41Uhv
 nATk611ROZ5yFiV5v3FNIzEHu7lqqGxUs3WQ1GBzAr4jshJlGAD5c0WMzFLEtIDRaz8zMp8aL9OV
 1BtgZ.0tQTkpdBwrl_yBv1mSVZhvre1PqeD_IZcDpIx7rUPd5fUORHnuQMC.ozri7XuLFh5qUmbK
 SuVrY5hfSCLDh.fvV58biIzdMqLEkOH83LmIoV9QFUqVHMZiDdCzMhzsZR4Q_UqdULO_XfG_Hrr4
 ijzDITmCWE3bKd2xULFaLlwOnCF5Q1Qa488FbL.Grqtl42MADfKHbqWzTR0fwfC64.BJR6av1aUX
 gZd19DYfM9NPGxFclFLI5toH.WtIBqL.nWhevwZIZf6PEUxngXJ5JuQbldqLZ0tWkTeqhA7HAAJv
 TR9WNowqfkVmxYmtXaPJXZBNkKNeEr3A0TdGs2zhyk7TtB0i76bT6GprOuIxaX6Rm3rczIBrhZ1F
 vgCsxBNhq1pHVsknxNTyl34WOzLOK1qJ1njFh6CdU29fZxRUNTcNMsu_aTHZhxPyW0OQCz0r9JeN
 kCadr0LqgkbarXNGlNokOrB1ghBW9ggNB7.I7q4zlIjFz7Lw9gpvsR5W6rGdylX_MkhEjAuMDBAr
 rBcP5TY7a8Cg1afBeVJowdQ_v.YZ3tRoEFs3toqi9hXYK21dDLBKjiQv6yKpZTXlKW9EWI1B7Lwv
 UV9tPYOMmJ.v83iuAbj_BjiazcqmamP6JOz_6qkfmG8fcZ80CtBdlBqKAs0K_X225914zRzan2Fx
 5XjfMVBsWMELCxpmlPbBmpWlnmj6e_CY4XczZS.4VqT7XJmqsfJ3eeip8F_MdpLYqTQz1jjCEhXn
 9XOKNM4wZDMl..s9vYWRV8NdhCH.9wbpDOkE6Vwu8dXsJnbmbiSvcBcpyU1algyqj9ZPHnt2fA7J
 QZ6GIblWemuPuPonx1000_zTGOEiyBze0dciYn1XFw1mnOJUeerZuHJ83LUqI4ytwoR_VDmvdN7G
 uIh1X3aD4cJz6SCDYx_2MkYWorybmdg8Mlrt_sA.jJ9M-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Wed, 19 Aug 2020 07:06:11 +0000
Date:   Wed, 19 Aug 2020 07:06:10 +0000 (UTC)
From:   Mrs Elodie Antoine <eodieantoine@gmail.com>
Reply-To: elodieantoin678@yahoo.com
Message-ID: <245912323.3151799.1597820770983@mail.yahoo.com>
Subject: Greetings from Mrs Elodie Antoine,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <245912323.3151799.1597820770983.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16455 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Greetings from Mrs Elodie Antoine,

Calvary Greetings in the name of the LORD Almighty and Our LORD JESUS CHRIST the giver of every good thing. Good day,i know this letter will definitely come to you as a huge surprise, but I implore you to take the time to go through it carefully as the decision you make will go off a long way to determine my future and continued existence. I am Mrs Elodie Antoine
aging widow of 59 years old suffering from long time illness. I have some funds I inherited from my late husband,

The sum of (US$4.5 Million Dollars) and I needed a very honest and God fearing who can withdraw this money then use the funds for Charity works. I WISH TO GIVE THIS FUNDS TO YOU FOR CHARITY WORKS. I found your email address from the internet after honest prayers to the LORD to bring me a helper and i decided to contact you if you may be willing and interested to handle these trust funds in good faith before anything happens to me.
I accept this decision because I do not have any child who will inherit this money after I die. I want your urgent reply to me so that I will give you the deposit receipt which the COMPANY issued to me as next of kin for immediate transfer of the money to your account in your country, to start the good work of God, I want you to use the 15/percent of the total amount to help yourself in doing the project.


I am desperately in keen need of assistance and I have summoned up courage to contact you for this task, you must not fail me and the millions of the poor people in our todays WORLD. This is no stolen money and there are no dangers involved,100% RISK FREE with full legal proof. Please if you would be able to use the funds for the Charity works kindly let me know immediately.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish. I want you to take 15 percent of the total money for your personal use while 85% of the money will go to charity.I will appreciate your utmost confidentiality and trust in this matter to accomplish my heart desire, as I don't want anything that will jeopardize my last wish.


kindly respond for further details.

Thanks and God bless you,

Mrs Elodie Antoine

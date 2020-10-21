Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14E8D294D89
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441711AbgJUNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:32:08 -0400
Received: from sonic312-23.consmr.mail.ne1.yahoo.com ([66.163.191.204]:33474
        "EHLO sonic312-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2441697AbgJUNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:32:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603287126; bh=0PX+jxJZorH33AooMJbhSejVjcLg4jW80tUvecFvT9o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=uUcyuqSRZg5svK5+6uyhLwBw1ZHJRnQdwLoE6+QOdsCv7Txr9RmYjU/fV9d9W+gYvaH+Kf+ONzkORGYKqAjRdIOKahx13TDukuMmLdxj3EWC5NJBUXC76j3gZhkVyFeIcaZHKqRTpX3GvvGd5WP1kZH6nSjcinbGMuRuLY+UzwxvbjCFRApuHX8rAlds1MKrP+r2JkyqJETWA6q88MW+HslHio9mKgcwTtMYVkTjfikR229tHN2uVXpUZRzE6qzPkYDElJMuMtMMQRPAhgzJ2kTWtihbFhlVm+JLd5rZtjiNJ/hkZDTNLhnlCHcRv1huD4jiw4slFxL+RDt53WpTBA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603287126; bh=NIPPTs7sadiZrNxVkydGV0Nw0QUDjyGJ/DEZhoHOJQr=; h=Date:From:Subject; b=lohzdoHfVkngpO/6HtPSI6cgKnxJf0m374VyhEayKH1c4LWXFd6gGrd2sRgabIwW//tCvIpSaCpFVZKJOQ5GpC6zxCYqqz/JYTbwbQSnrY2ygfm67e7A8k0n/oh5LFEAFdiZyUmPCq5xixC+1DTg93HPuLwmSL7wC3wzRTvi7SnyIyHx65l4X/W6RHXOL8xL9KE4otgCqzAkCX5ZY9gZMv1+pTtRLmvYtnMUjgGjorxNeE8WhhDYRsCFvOVnillFAbhDmFO0KylKIBT84tGHwI+unBDDgxQF7afkaKqooxyXMZZxkIj5UBLeJeEfScNv4AfsYJiBAkGUZlqHwytlrg==
X-YMail-OSG: db47lD4VM1mR2Big18p6id70BtkqoEq6qLxwiD5Q.XwILK4CR7KwqxmrN30rhZG
 aje3U5M2zvhpfvHx6blaaNSNbgajp.Sq2zEh87EWo6phXZl.VC95XaTCGg7v_qa8pP4As8_1CK7c
 BQCC0qjUfQ177.rMXPIwK3IVjmGiBQTHaC7G6vfwn060QiHd9BKu97VCYfc1lzcXClmp7Zp9ZdNX
 XsRYKdg4B6l8531DwTSVpnzTNYhEfBspLnAFTQOq.WX.q5s8Z1uAWa0.2.LA4woo2fdSrXjls1BF
 sQhuJU5BXBkS2RerDDVda_nkiL7SVuJr6gcfXX1G0eAGZFjDIbf8iZIVvFju7tki0mEZpbZN3Lp4
 t8nzcGcYyvezOuXtTpfrhnP0VZE8bjevTgJQ8qSnVYcxmJXK.jCmtes.Z9w2MRoBFJ1XpDyx00ys
 bJu8297R2mNmp3Pns1upAn8OxwtLJGyAgC.Uno_T0BWS0GI9cuLXz3QNOaNrSv_nAG3ZZSGIRbu1
 sFxNMApH1X8VrHmicpyH2l4rdDP_n_zwLYvfZwYaSJ2i3RT7Dyu2Z0gcjhI2qAwFFubRC4slgTSO
 n40oS0_4G4ycDRlkeYBXJv5be1oCyieZ2GxaF8fr1FgJKPve4CP2tLiwW1hP0mKz.QkDfNJNo5bt
 58vm52saNA_Lgru14cz6h9OB7X6eGCDqdCMALCq5jPj0Bcj10eLy8P3QIY5L7fvq920muRHR_GgV
 N7CB6N25UkcutduKg862kAr6833jJKv2gMW.GleoijBp4YCm.yEStE2QwqRmbmahZ6zIgVCpmsuf
 gBRatascymk_BivrmX6qJrgWrnFCGrJrDVZGkqSl3DoGDIRQkiFYQ_5okXieoOZUC1T8wdifT5L5
 hrGgDSQxPeavAqM0bQ1WPPNwzwNIuSikc8pTOsfWjP7jncY2lHNI0rA9djyXpG9fVHNCjZp6SuzQ
 9waHi8RaxKGO6ID6ef0RAkT0msXIRt7dS1XNrsCFZ4SOQ0z.wtYPNJXzEYXpEGyfxBi7k4npfwrw
 CWckOmxxoSvlUD3ERwEhKXCsuwWRSZg67sB4uo3XQdU5WmsclkmzpMXm2rUFX6g.GgPu8SZL5MuL
 lFtRe.almhiTTgPVadqYPLpMMhS1FOvB0Hg1NE20PjXLvnzNz2OcZOIs_88dGUAnRw0PrLh2igBq
 6xGMDUje1ZK1FY1leBCo6bT1wzL44TXUh.s_.cSSvpaWB6J9YWJE0s8fNJM2tekzTDP7wNNCrg.o
 Dq4RogzzeFeBDrxnochpd4UikYX3DjMhH7nHa.1mlr79i5SkZ2IbL6mIE07QxwhpK5.BBUj0pP5B
 xqsKSg6kBEgnz7NXrgMZlcSJApr9wcOS.zeLgWs7ciaFjyFDmnXS2ZHVVelY1_byddCLCrsXUneo
 OimRiTTRf1Gpvd66GfvcuGC_bfCAGUy.GNeLShYDUG6e1
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ne1.yahoo.com with HTTP; Wed, 21 Oct 2020 13:32:06 +0000
Date:   Wed, 21 Oct 2020 13:32:03 +0000 (UTC)
From:   rita <ritarichard330@gmail.com>
Reply-To: ritarichardr03@gmail.com
Message-ID: <322150120.1903069.1603287123092@mail.yahoo.com>
Subject: Dear friend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <322150120.1903069.1603287123092.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailMini Mozilla/5.0 (Android 8.1.0; Mobile; rv:81.0) Gecko/81.0 Firefox/81.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear friend,

Can you have time to do this?

It is a pleasure to have contact with you, based on the critical
condition I find myself, however, is not a financial problem, but my
health, you may have known that cancer is not what to talk about at
home I have been in the hospital for 5 months now, My name is Mrs
Rita Richard I am married to Mr.Abaul, who worked with
the Tunisian embassy in Burkina Faso for nine years before he died in
2008. We were married for eleven years without Children. He died after
a brief illness that lasted five days.

I am Mrs.Rita Richard, please I want you to help me use this money
US $ 8.2 million (Eight million two hundred thousand dollars) for
orphans and poor old people who have nothing to eat In your
community it is my spirit direction that I choose you to help me
complete this offer i really need sincere and honest person.

I am a cancer patient and now my doctors told me that I do not have a
long time to live because of the cancer problem and I don't want to
live this money in the bank Instead I decided to use it for older
people who can't work again and orphans who have nothing to eat,

Can you have time to do this? On your return i will tell you more on
what i want you to do. please send me a message in my Email box and here is

my ritarichardr03@gmail.com


I wait your answer.

My greetings,

Mrs.Rita Richard

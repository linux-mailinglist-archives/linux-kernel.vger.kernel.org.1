Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD3F23514B
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 10:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgHAI4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 04:56:16 -0400
Received: from sonic315-15.consmr.mail.bf2.yahoo.com ([74.6.134.125]:45436
        "EHLO sonic315-15.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726211AbgHAI4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 04:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1596272175; bh=OCp2NQ1DG8WDrE2HT9ykXjnTFISlxhUILAf78oJl1As=; h=Date:From:Reply-To:Subject:References:From:Subject; b=cSlUCCiJciEvODhySSssp57hHDayo5jDDCH4Kb/tYDSqR4de7ziIJGuCdq9ywJgO1HgOrPl/z0XitTXm0lON+K21zBRbFz6XGlVjDBDEWVriH+S2pI+AgbvkPv8fhaFDDI3FjONF6eTAFjycY4lzqoftxe9GPYpLu2MWgQfzwk1E7SozMV8G8EDmGsizpNNiVXihkorGDg3AQz5DDh1AgK2NOcbDlw6q6ouyZ7BZyq5eSnujnBm/xOs3T7zDtJ3M/P/i95z5+0v3zTz+TRRMETJ7hrc7Pc9AsrSzkgMs27t5uCfjHrlIQta0JWvrkGf4KNeQXme2LSuMy6vDRGw0dg==
X-YMail-OSG: mLHwlEsVM1lhVfJ1qYrpoyKNVW6c2ywE.W2Fl7wCneoxc.sBc0NQileND0_6cFK
 .SkONBb4BkxPyNmluGrnmENEhp7SWNboq_RAOcJgaD4HYnpojDRVu5b8FmO2c_qrNjZ8RANo3TTw
 Yw5jdz_S7hH063BlIEcFUia52y2ozw4E4Jcinu7LV9YnQpETB_SzCZdk150wu8z6la5HjPU6AorD
 uNv8VmiPIS8E2zT97p0S4JWRt37aVRSwX4LaG17f862tCT6MsA3E71eeAYXKfDm3kbxckUzxw71f
 savd3p6sGWCT3bGUt3AerT4qh69jc3o.mR0p_mcEnOhUpU.faPrhL2AUoB8uHA2lT7rvyLn4iEcq
 GoYYctWWjgA84JlHBGRoSyzOmpA0qr_a2ZlNZQhs.veCo9GAGiTlUAbL3FjCI4DPLrFvSaPdKUdv
 RfnnRwMmwuxyvkonQQxOgYv2HAXbbPX2it1R8711od5voYhqRc5ttQ4bAAIkC3aNlijQhLUCmXeH
 PO5hG5hW_6BAZnPGlX_IEC5MRI7ogUpiBO5bGT4oAS_lNALesOuhEtJFJLTtlrfSFfPXp3nA_PX_
 m77LA5zkPKfqd7lfRvG_nYa4h2n.sy3EZo8DbiH3U83m3qa9vwoh3mX5OxZ8fQH_YJBO1qlhcEkD
 xOQcbUa05JnYD5GATzco3q4pkEiTLpQ5JQqK08wk0dV_et4uuOL6Kjpgy7ituYhnvbmB4il9ya8f
 8RDkqkqPPlxaW4QiCEZMUQ9Cbb1vvR5VCQ3qnqDA3JzZvg3RpOiBab1nzqEBzW6og_jotP1bImmd
 QDBRBzE.dgeMC.e7hLC5kcnMn2_3duUTEOg0zs4BLm_sZ4.WKZGLDXFPMtq5M8cTUEdXAwNabaZx
 rs4pATjgiAIMETlEEx.GM228Ow2kH14dcahwE9Ih8W4ARXe_xtPURKqQLgt6DFpLhjxqxeh2TX41
 E9pYpv2qqTcTCrt1d_db6z_spL3IIT9udW.LOG0AhPIYSvXTxfZnmquxiVn7WibsJbTxwlJoa1gj
 mS7ZtdpepjzDk1PQ2bWlM7pzfnl.FjkIGNOO7vgVS9QP5.PIK0okhC545IJ8IjM8US9vWkV8NJdM
 NOFnD43kHGbl5v6du7CTsNy6ABZ8wGKzWNVNidGvgtBNrcamKJ4QcfoswFANX3AGzisHodbiOQsg
 _RR6_aXATA5U07ZGNU7j13Ugm8YRYZ8v08D24Fu0bpmiqIBDHR9r_ZchYQ2OtVntFJ1dxWboJLqz
 7u6gLeTUS2rAsx.UTDPIF95eiWhp.v9lHaD3UXbGqcBTcj.GmyHID1yxx00lPddH.SD38xL9rPQ-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic315.consmr.mail.bf2.yahoo.com with HTTP; Sat, 1 Aug 2020 08:56:15 +0000
Date:   Sat, 1 Aug 2020 08:56:11 +0000 (UTC)
From:   Mrs Elodie Antoine <eodieantoine@gmail.com>
Reply-To: elodieantoin678@yahoo.com
Message-ID: <1308109300.7302392.1596272171468@mail.yahoo.com>
Subject: Greetings from Mrs Elodie Antoine,
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <1308109300.7302392.1596272171468.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16271 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:79.0) Gecko/20100101 Firefox/79.0
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

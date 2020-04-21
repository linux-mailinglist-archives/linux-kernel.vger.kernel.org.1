Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6D21B2E3C
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Apr 2020 19:24:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729105AbgDURX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Apr 2020 13:23:57 -0400
Received: from sonic304-21.consmr.mail.ne1.yahoo.com ([66.163.191.147]:33050
        "EHLO sonic304-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725930AbgDURX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 13:23:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587489834; bh=+NKq2YP/4c3bLm2HmGhxa/KCZOXr0NIUKHs/ECuC0yk=; h=Date:From:Reply-To:Subject:References:From:Subject; b=CoMF//G9CZ4EhMX/GC8sJ8FuNJvxsSskg/8849ddDsTguC1G1OR4UgiVnBVUoNwe0Ip/huCNuymGmZtCm0OXveww9M0z2wva/WOD1AB8/UFT68sBObHnpbyu8A2d8Gi/D4maCdi6apJiIHB8A+6wtKzaYGytXT9Gy+KT8rIofIaKLZlnVZqQEOYcwEWjjvmykPKqHtFut3DQcWr2HiQh28v70PkuvmfpsLMUfmIP9fLvCbmyU8d9IfNpNxTKYuoTudOUkMHYNJmg2AxpUyF/oNej2Z2093axtj9lHSkNwB57GqE8PGd8WZHx8TzlnTFbo2shdUbBe8N5cd+Rkelf+w==
X-YMail-OSG: wf5OJGcVM1kAArWWO3fYkQsQ3YaHt5ZMoONQuI6MSGG3YOxfQ.sahSTY9RLUEaP
 .OGLGlB3GKDqJ_1AH1398B3Nre6Xc8N6DdMgq_XxbQKmzwqzI1IxL9TUJMOCbVGs6zlptizb4nty
 5lmJFgYK4MSgxkw2FRoIPRyFhYX9YfLpuHVwGvY4lKr1mQawf0Ql00CP1oFqAI60viJnAfi8.hc0
 tfanegoTz1TiJ5Jca8LIG37v8ju94tqdjPihR_2SALVi2Qk6PYajv9qbDNBTVRJc8Q5PLVWYjSt5
 157ukwQ0C48aDbpOCS1SheqssJ8OHiB6L21Brbmu5pv_yrGj2MCussy5q9KDwp4uDOqtUyU2U9gM
 0Oj2uYa_LY3g.rBoB.HAp30kZ7o9nBoatuYK4.zKM779xZD18tGOduGKzx0suEBbilgSrPcwU9hE
 QR2kdZiuFB2LElo5ULrQNiLZtO13noeLHeiSaAiFyi3xHSwaLGNFt9qB7ejclmL2Li4kz9Wc_kwO
 ofHDug_aOuv89XhPYXacyypJLxUgWiy_bc9O.OXoosg53CazOVOhZo5A9otjGNk90nKwGA.7zwW7
 WCf_Be1vIGkBHytd_5ux5_0kaW9CowRbg0E8NjfplLr5lgWjwPnb.zNAkso9sukhyKuoXGNOzaBd
 bewHg.XtM1iQWTuWm47C86dX5XebQTZYBswSiKphtDnB.WepcE_Dx_NlaLOjjRhnUzwm9S3l3LSu
 6NhFGxTS9EWfiU318UQexIDsKkwEGEOPM_inkcZq2V07WuKoRcjGNNHCwrTQAut62f_LfJnOj.Sb
 QZ4c0FAYAatn5H3nSawXCKkrATMG.r9gX6DDxbvy9jCtBW_MYY6sNlwjwk_e2pv.VdsHxjvdJIKC
 eiwUZa8o34sYZiteBieKZgv7JxdB3KXuUWc0DwMOdSCGwUiy7Z9kDqfbsGLFv1j6pyAw8zVwbBW0
 Cq1P0Kom6ZJkKtJaRLqFH5FMx6I_V_vjU3VkWO1s56v9aa3yC8aUbVlE_NkDeJYzXiIBo6NQMPrR
 DVT2K2lpC9zCKQohGmEznKVSbAC3mp8eyqqlLNdjz2krYD7sQr28uYiSsTJYs_PAU31pUd_7xJWO
 Z_7THy.H.H9FVObMOQwhuk0C0w8lctavbNxZCyr25M3wYWS4gVXvlelec5NlmSqN5SyzE3je3yQN
 hPc9FGko3NPuTKYImfSkMF1fe1s5B7tce6H7v5pYaOGpTYJ0ngS1fgI42k_nVWQaPbSRlEFhLJLR
 j1o3rx4kFXkSKJHH1NjKxzUKB.c_2cWof18TIDHDQGoS4ITZhcfE9VHUJ2PfaGZ0EVrBU0ThcpTY
 6XHw60w--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic304.consmr.mail.ne1.yahoo.com with HTTP; Tue, 21 Apr 2020 17:23:54 +0000
Date:   Tue, 21 Apr 2020 17:23:50 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <mrs.mainaabrunel126@gmail.com>
Reply-To: mrs.minaabrunel30@gmail.com
Message-ID: <1515331421.406263.1587489830185@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1515331421.406263.1587489830185.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.15739 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:75.0) Gecko/20100101 Firefox/75.0
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politician who owns a small =
gold company in Burkina Faso; He died of Leprosy and Radesyge, in the year =
February 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Mi=
llion Euro) Eight million, Five hundred thousand Euros in a bank in Ouagado=
ugou the capital city of Burkina Faso in West Africa. The money was from th=
e sale of his company and death benefits payment and entitlements of my dec=
eased husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel

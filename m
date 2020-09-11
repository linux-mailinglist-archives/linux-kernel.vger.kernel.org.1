Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29AA026645D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 18:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgIKQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 12:37:04 -0400
Received: from sonic306-8.consmr.mail.bf2.yahoo.com ([74.6.132.47]:33153 "EHLO
        sonic306-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726073AbgIKPNu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:13:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1599837215; bh=KhejUjG+aIFEdaJtUCWO7uMjCXcLLdLXH7PJ9JLxOyc=; h=Date:From:Reply-To:Subject:References:From:Subject; b=aNM+wX+8ocEWiBS2O1ESJ+dVrWh+9OJfkOGz/jE/HW6OhXH7sZqP7hM6uro7E3JCe0zIxmdJwANr3F/78kmWr0SByf1ADuxX/sg/hTw5tksETmrmxou6GQM2F1q709d7JKb4uk3wpcGd6LWFGgfIsLbnm2Q8NsmNWjSPwwENpdI0HFtvQnpheRH6RV0aqViWnD4VXeqVfCYlPzTK9EpSC0bJZGCY8Lrlyqu4xKD/NzRDmKYML7jCYDrvIR4Y5cbMjKzNxYCNv/wT7Z78BTtqq4rQ/m0pDh10tHHfVIgTlQlAeLglpNgqIqZA4/2vaR1c+wKbNVvKLm+sdCNyMBcglQ==
X-YMail-OSG: d.JwdRcVM1mVBCghaVBWHKb0K5b5MtyOcCu_h9epMCCDslBkwymP62wAEnAR7cd
 AH..lhjjTx.kzPHVGfuC9_4LVf.FrGw1KW.4FhhMkKLPSQfW00ggB3w6fbS0lsLRBEfy0MevBC0V
 puiNvigiOs_vYW.XtRc3wcilWuhaRPNf1amATqmBRK.vjL8O0_NLl0is5RPVsmCnchJ63K_PFzPA
 ztGiNs_MsKZEKHnQ_fTYLlVOmfEmnKCa1Ak13_cL8uawn7mL0SXdrV6jGyWglIxTspDVOyvdCxJx
 raW8nvIgQMQFGtOY2jtDYY3hANNUEi21nF7qRxIuic0bTOc50MPOFq7DRtuyOK2Zl_aVeo7JaWbF
 slwZ8x.lj9bf2ikoFIasj_v0.LkSKgBMjoyi.bIz7BWsmPxzAPYgDj4fiDyWV.FVlgz.izHhM4z.
 7UpxQrCitFelP2m.fbgLXBNK6SyNsDWoFWyCFW3wIWtriY1YMFnNnhivLejRBbH8_Sdgl9Ri4dj0
 1MhKrDblrwzhxz9T4beFS2N_26fzk4qhEvzpHSkTHLKGyqWiaF9MzMH7Ug_avysC5hItS4uEG1I7
 5U7b5B2xAZhYOL7Yjxq13l5MYR8f342Qyz0hVgQSqTl5_f3fBmBpkVjV4El62mc7.0RnVOLfID04
 EZxtvMImuM1Rk8wpBl4iWq7JwIzVF0cm6mRPZqNJNphYuMvc7CKzw7gOgmxseuN_VKcC8t7VJdZA
 0gj9TTcjjaqW5Izbhdmr1k5YIp8tMa6lkXG8JYD4SBeP7hc5C6R_1sI6TvqJe9MZT19Rz6wC1Zfu
 X4Gm2IWhLYnfEj8_KNc6b.70iPXcB5qFIpC2eNIEh_yfpKwmaGV9fZJ5kF8Gilqvs2UQscmpEAp8
 KLs3uG1JRvWUtq0sOzsxTG40uJd4HZTRGAqx_kZRojJL5wkFQ8NOeMnNJ6HgZNa1TpdV8VOxrNnn
 CWNqI5.mzXdQUWLgdIBU4yS4hsb_coHuZGZCVnMpOJWXYFh3XMeBv8Iy_Jdx.vKfAB7qz1aOgdY3
 5.sHnkKTcTwGotfDYv3uFfMR6I7v6bBtaA1Zs0E1eDPVGh5obTv42U87EynkuXwbxaJsIxrP8Xw_
 jL7Yy7LeavltsFpaW7o2E4mB80TkhQlnXbBc34Kcy1gwz5u1ZLOq2jh.jVkz9gQfXWZXTZNRIiSW
 9yWvIj6U5ATL5DehIcXNb4H4BBphNO5J3d1gdNO7ZYRNVO5tf9WOIwIaYCW9YvOBK0jC9g39p1Hs
 d5_gysn2mxzLQEKdlQpNXvOCfDlkoDKf6mLB2Q4VKVdLvgQ7hJr236QsoFStZadVBcGUJn8hISmS
 axm6nlgCV7P7YzXOPmqggZZTS.822xeqjnwasT_dMoSaB1YEj_ByFnVSmPtOlNtJXlHbZV8how21
 cyeM0TiLC.AJqNU_HMBpFhjHrJXhbd47s8fYlKpYjL9cfD6UCOOpbZSIGvJEGlCfzQ_S.xOcESOf
 o
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 11 Sep 2020 15:13:35 +0000
Date:   Fri, 11 Sep 2020 15:02:34 +0000 (UTC)
From:   "Mrs. Maureen Hinckley" <mau11@righbv.in>
Reply-To: maurhinck4@gmail.com
Message-ID: <2022699321.1101095.1599836554052@mail.yahoo.com>
Subject: RE
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <2022699321.1101095.1599836554052.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16583 YMailNodin Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/84.0.4147.135 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



I am Maureen Hinckley and my foundation is donating (Five hundred and fifty=
 thousand USD) to you. Contact us via my email at (maurhinck4@gmail.com) fo=
r further details.

Best Regards,
Mrs. Maureen Hinckley,
Copyright =C2=A92020 The Maureen Hinckley Foundation All Rights Reserved.

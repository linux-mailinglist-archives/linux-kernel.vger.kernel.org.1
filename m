Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55BB827DCC4
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728651AbgI2Xhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 19:37:35 -0400
Received: from sonic314-21.consmr.mail.ne1.yahoo.com ([66.163.189.147]:41807
        "EHLO sonic314-21.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726637AbgI2Xhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 19:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1601422654; bh=4mWY6N2pvhoYteLll3TsJcj/b3lxDL9fu4mR9DmIf4o=; h=Date:From:Reply-To:Subject:References:From:Subject; b=du/kdJghrJ9WKUPUJv1G+6N8ztVwj27e4zvV3bs1m4v2f5XHURAZaOaWJyiMDELmdFWpxHpnE4DjyndQ27/yCu5c4Rtb6mwdNFpBXRidA7REcKKKfdaWVvUftXzViG2j7fObsPVZ1gKKeBSe8CjbeUbT7DmDK1T8tO4F1GJiODA0y0xoBUMneAEHeGroKM9x4MX5lfGlHSorjZvbah15YyW9b6j/X7OapfY83b3H6GryqiqpOk5zSC2PijJorzJlEynl8FdRYAInCphumTav3Tm/hDLXPKxRoTdW6Dgm0DECEzhlb8m481YD+mHjIRZGNzknEztMszH5e2f1HDBZSg==
X-YMail-OSG: PCjAF6IVM1kGYNn6DJ0fIKeuG5HqjRkbYQEz4lN.7WNYuvA_PohChR8oFxJ26re
 QsNrCQAv2ggIFv15Lcxog6EMp3ZRlCkNY65fZ0ZHjzvvY3ZyM0eM0REA672RSsEMuGdMhFYWGIWj
 CEWHNP61RXppRaWJEPi7GVakEElhV6KQCXL4G3ioeJM.q9Ly7cOwHk0d8EDPSsTdetbxBG7BQcSS
 0vO8nBNpEIMeZEWTIcNYCTg.6IW0f4c9ZRzS3ml0QGWtMp5lADcVzvwBXQppP9UIuFS7KC3rJxLP
 .j5RPDRTp.M3hYLkom1NV_uGpQafZZDLJmcgLrgju_6gug6rPLZUib4ku_nz19jdUzuJgkmLQn5x
 gTykcm7cr5EGYRFa8brC9F3SmcftF4OHyBgGYbpwCAmyk0I9WtKhOdPm1fr0GZLLXB6Ed38oK9w.
 B815tGayGbyLYASWwZwLxV7qFpafllpFzRwXzdWmz_a.nHcdALKm657aLG5Mn3XoaU.a9S4NpT3Z
 d0LXTBzDng3ZmW4RUTWSHsv4S0bD9_g8ki6l5kKIR7NR_CNjvqSReqZ956VPW6.t9HxMKZ8rRouJ
 DQIneCJbsuJSGZM_e1P.kOxzazn2Pfxl1tWtuSe0BVC96UDjdP3DZt4fY7al5_nervbnA1yBEyIA
 qghKui4j3Qcr0wVjsgvLL3k65WOXdgneNGsfJJQVa2zYQ.Hb0WcmAwhd.Lu7FkCK6S1PJNQG4JCE
 W1s2qvE2Ek_2E37k3hLrBR21gOi6WdhUIf92GlmT.7AfWGGm0wh3m4_q0Q8YBvucOgqWA4H8BNdr
 yToCL0zZwIeLVa_Dfgaofd5rSibznmxPfmitTgiPqoF__fvnH7sSo5Y_fGSX5_dgpZ3CMFJ7ty36
 pCbahaY.IhpMmX9tkYu_K.rKyVwE1HK3SxOF6AFgkBjNBW9ck0q.EFMKnetGK2rYvwo.WcvzCn98
 4zdIYErBdJ5ZTZehLK8oCTczZdMAncvTrG8oPUHTCR57T2J_KDkne8.S_GZSoShF8MmrB86MFpmT
 Uv95.S4vD.pvhOGN03gfIxDO0a7hrjypwEuT8KvwIBKOpKLQAkrLkj3uBY9tnB2rHUcmI8RhEE6B
 1o8hKdpNLbV0G4zCvZFdswAOnr3Qnq6xwoUac65TiMou7hz2DPO7dsFfI1hr92D0qpqKll48xH7t
 jZcD8qvFSuplXwzjcUWaZjUN2SL4tKU0Cna4TcyHhBZ6P1LPip_4HyLqey.ROzfnVUSC1xezyVpi
 vwUWEODqQtar6g1_lcz5SUZ1s1yp9T53D4429j.P3Xn5UZFiTC6gJqI5HLhNd1.sxkuzHTTzUwzA
 4MVXl9zMenxWJN7LzmTunTv8Gg4ofx8sDATfJZuMj9dRXcjiOTDiXmzM8tbth1SB8Yxxp9aLHf1O
 t2.5x7GvusLdPk0f_mhJ4XNCm6_lBjfKEGOLSoWkeqdYUUddq
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Sep 2020 23:37:34 +0000
Date:   Tue, 29 Sep 2020 23:37:29 +0000 (UTC)
From:   "Mr. Milla" <millasth804@gmail.com>
Reply-To: millasmith7010@gmail.com
Message-ID: <358748219.122146.1601422649190@mail.yahoo.com>
Subject: compensation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <358748219.122146.1601422649190.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16718 YMailNodin Mozilla/5.0 (Windows NT 6.1; rv:80.0) Gecko/20100101 Firefox/80.0
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Dear Friend,

I'm sorry but happy to inform you about my success in getting those funds t=
ransferred under the cooperation of a new partner from Vietnam, though I tr=
ied my best to involve you in the business but God decided the whole situat=
ions. Presently I=E2=80=99m in Vietnam for investment projects with my own =
share of the total sum. Meanwhile, I didn't forget your past efforts and at=
tempts to assist me in transferring those funds despite that it failed us s=
ome how.

Now contact my secretary in Burkina Faso her name is Mr. Milla Smith on her=
 e-mail address below millasmith7010@gmail.com ask her to send you the tota=
l of $450,000.00 which I kept for your compensation for all the past effort=
s and attempts to assist me in this matter. I appreciated your efforts at t=
hat time very much. So feel free and get in touched with my secretary Mr. M=
illa Smith and instruct her where to send the amount to you. Please do let =
me know immediately you receive it so that we can share joy after all the s=
ufferness at that time.

In the moment, I=E2=80=99m very busy here because of the investment project=
s which I and the new partner are having at hand, finally, remember that I =
had forwarded instruction to the secretary on your behalf to receive that m=
oney, so feel free to get in touch with Mr. Milla Smith she will send the a=
mount to you without any delay OK. Extend my greetings to your family.

My Best regards
Yours brother
Mr. Abu Salam
Greetings from Vietnam

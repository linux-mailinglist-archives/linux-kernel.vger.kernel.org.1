Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C85701E685A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 May 2020 19:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405406AbgE1RJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 May 2020 13:09:34 -0400
Received: from mout.web.de ([212.227.15.14]:57239 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405314AbgE1RJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 13:09:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590685759;
        bh=p69aR/nzaRPTpqEpuHitn5IvyCINJBKAMa323BW+lFY=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=g+g9aK35W80VreSFHoYkUcbrmKo3i8elKoo4gS2qujGz4g/zIaT/XIeWEyWvD6AWX
         F5GCTvolFCT8AE1syLLEdTn1HHxzWmQOzwYiiBx4vz9z5ahfZu7DsXgVG021vAXBo+
         jYkQQBNDAba3T1YSuWb5QTHi69j0kbAYi2OeJMbY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.244.30.242]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsJP4-1ikc4q3nPG-00tgiv; Thu, 28
 May 2020 19:09:19 +0200
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] Bluetooth: btmtkuart: Improve exception handling in
 btmtuart_probe()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Chuhong Yuan <hslester96@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org
Message-ID: <dd458e1d-26cf-2cc6-4fdb-fb464f9c3ac6@web.de>
Date:   Thu, 28 May 2020 19:09:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HFJVBKBfwx0BNkuJVnzSfsep+qen5ugQ2lnxQrmomHOtQfGba7Z
 rJiWEr4b3kJL2GNgc9vP/hSOvBCEdkSuGQ3jHIVvxslVHZc5VZ/0qNPkKN3UlaAg2VSefSj
 ejdyEEA3yBSElB/TBHtYbcVt2e3tqsCZrEHKSLlmFTcHLUTui1WLpsywmVS7aT484Cx5MlP
 EuPm7xaDFTuFWLXCjZCsw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:LZNn0mmb3u0=:6LsgHWgEz2hDXrj8PKKaB+
 U50BTzHMVQh30L6ETjehkxyOXZRwf8wuCYIYMvBU8TV/4hFYjid9h8cJTaONmYr4umbUSc3vP
 GyldNHjjwZxT6LUBujJvU/JtgefcORHdCc31XRo+nLjLKaJQB5O1qlXt4dTHevrOvsH4dZdpR
 cR1FuAusyTes0KtBWEuWgnWy539s8ltkf67JUNGmNK2U3r27nsCQprynQVE09QxcguNGCXq8g
 vXs+hJM9fabWY5PiNwVF+P4A0m+jRYzFjNDwh41dkSy5xz2N1R1b1jdRQViVdPcbMeIqf8W7G
 DyX86uPfk9kc/5lUGDE4Px2n3SCI9FtOxs9roputVg+H9accphilh6t+xgZQ01VlhcD6y95Cq
 ayqdKdlJxg2fZAqW44i506OYQpSpZVZxEXOS4Oh12sxpsDYpp5Lm/B9BKhA2gUj89ioOoa61a
 mstAEa/eUgDYllnvwCXNYHhoFn2o0S3yMbqLG3WkEjSbJvY8mDccQNFKwl2qNcQhNZcDM0LtP
 k5gmO/OxPPh3pF0Q6kJur7876DcEfo4JCWmR4qJCovu8M2nqC62LnrIIKeRhOiDpcVVYXyRzr
 of9w2SNvMJ4sPPxE7vubDU5nMou9gL+jyUZsdUE3+Nz5hPHgHty5MhlUhVZHGIihK7YXbmpcL
 T6asi8L3WdYPW1awMBay9mCa3hMr3cr8F1Js8aDV5Z9Mf5tdLKyGErrUtSpFXbkFs8weMObST
 RAEnaxWMv78xGlz4Gh4JekK2cKzKmbL72EoaQdLJRIADnqTw5bT8EckGyC/CNUWvnJktJSDg+
 pG8BubmpVF2qAGpWMavUtzuP7l2EG0o8vphzEKylV9kxNADg4+FDPsGgg9KNzBllUWEcVHDhq
 PPz+GGNrQhVkOenHkUHMY3XwTa7Pj/Hn/pgxP3Gf1zYofYoM0aWoIeHJdtluI9FrJHkBr6pSp
 7ZVvor7o+xIDXjel1Fy4AM3Ilz8p/DDrJytakNvs27e9rWNyAKlJW0WEwxXLoqGbouWNKqVRG
 Fyn0lqHnMA/M5t85U3ATOTwxNBOVpoT1EkGi9eCTjGacsuFgqHw+7XB/w8sxgQWvOnvK13kFv
 yvVmW7nqvLKxoR09Oz3XRn1Agor+saY6SsXJ05qZQSLZ46Mu09jj4drm48K73bEyu/R2YAUSV
 9LBlmkW2SmcmsdSETolSTsYMHzGgnTdroJ6PeCNTa/itA7S1LMQF920kyVlohc22UwgC1Ikxa
 IZpoYBPXhEiAC5fzc
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> btmtuart_probe() misses several function calls in its error paths,
> including hci_free_dev() and clk_disable_unprepare().
> Refactor the code and call correct undo functions to fix the error
> paths.

How do you think about a wording variant like the following?

   Change description:
   Calls of the functions =E2=80=9Cclk_disable_unprepare=E2=80=9D and =E2=
=80=9Chci_free_dev=E2=80=9D
   were missing for the exception handling.
   Thus add the missed function calls together with corresponding
   jump targets.


Would you like to add the tag =E2=80=9CFixes=E2=80=9D to the commit messag=
e?

Regards,
Markus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34619E980
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Apr 2020 07:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgDEFod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Apr 2020 01:44:33 -0400
Received: from mout.web.de ([212.227.17.11]:44841 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgDEFod (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 01:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1586065449;
        bh=brGusnsgJLeBeqMMHWxkDmr89vsvsG1dzfk1f6jqn7E=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=oBtnQfSriGbO4tpig0PxuFfkwQX4+jB83mAfzfqg9DUrIV0Jw4aIkzcc5fWg5c/qX
         uJyKfWEwMEz9kJB6KtWvEIcgYe8pXkA4YCbXd/dsqBihb2pXnkHzElErk5CNeJb7jH
         Mh5zVeYuO5LQ/2HkmQ4Hj6QcmnXvbBbEKGDDb/G4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.99.70]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQ6LH-1jPd2x3fpj-005I10; Sun, 05
 Apr 2020 07:44:08 +0200
Subject: Re: Clarification for software development opportunities
To:     =?UTF-8?B?5ZSQ5b2s?= <tangbin@cmss.chinamobile.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <eae7170c-4371-4865-7b85-589c0ed2b5b6@web.de>
 <2020040423261552036811@cmss.chinamobile.com>
 <e71d56f1-6fce-5e2d-9719-1385ef3b0811@web.de>
 <2020040505380926003012@cmss.chinamobile.com>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <95c5e77d-e993-f12e-11d6-9a43b9afc230@web.de>
Date:   Sun, 5 Apr 2020 07:44:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <2020040505380926003012@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Lxum9BaajizllUR9MH4Li7ED624dMohLC7xKtZilz/FWbnVcrns
 FHlEuN8u2vU3nV4cyzyW9b8yzxxO01VWuJgc+sNVGxj602r8/ZErp12kpjYdVHJ6Ph9XpDx
 lsCivJrY5uH4ScznCM5HzTunNnSqIvlp/8b8Sa2v9TUWlaJNnny074r3dF3vrykBnOtIwj+
 O5Cq6wKyT4FUzKG6wvRxg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:PtAnAY5OrtA=:VliNn5RqwiUycVLmp1zlCl
 NoAuoGS8OFPQFZknpjearInsiQp509HlcAKtccKPDMtMLvHT32SBQ9E5v97fhnNp1/2y/ZcsZ
 wjR7uZ9Ntj/KSCrOYEyAlvz8olIovypHhEA2UNbPy/cIOSfzo792a59S/s7lMLWCNZxWzoaLW
 1VU02+dR1e9paoQwiH0gPTh7CoqQ9FFA1iOxCaiTticqrLRZBEr4RJApyOHW3cG9NeNWGYzXe
 a7IxyrzEvmI1LArY86E7kPzsuTd3s6L3DA/C9C/1HfRzN6n2dbviFslRPw/R9hbZOPoottYIF
 bNYjBlW8mE+/mteGk4PTfUrNyeB1U5313gSU38OCC4Ay2sAA5IMqZDxyYCeX5c7qgQYEQbca6
 zinogHkeEKGE0QGCoi9evhowV1GSzFY/5RnWlnYCpOp8lDW0RSZZgjlt8+GkphsnrT/tKG7c4
 dKs7FDlTG6CI3IgvLKE6vC2FBKjUrCfigqUuwplQpCaHnaVnOqixlY2VWOGtNDKDoyMlCRmoT
 9ZaJhb10a+Ea9GgZ3mw2VJcIDRwn6XrZ1FFOtyZpo7pae2d1kK/rpO/2PGRiQi1RaeitLv5Pk
 IStgasrgPaEQrev966UdGpYq/Nf8JlgB1hOkOuLNSk39lbjOxs65tI4bGtYjdWmKRaZD1V/iL
 Q5c/eNlW4OeknX23i3uWcRBcr3fL92cd2kFsOUicTL3umOAE3QCvWDxhCZeIl4gosCVjqnJto
 uinmTRcLEhpCtvzQfP3J1WNeBUDjYU4z6KPxe3xpUJwi8ZsaNl2Mjx/P/G8aqkNiV6md82967
 f8W1FwPc6FmYFESV2NUnCPcvVRMhfNVuuPgHinqHddbqX1pqVOQgP/5VlSbmhJPhN2aJwTGew
 zbLELI6o26XBSQW9PbDVKrM55X/k8Lk4EFHuFlaB2rs1J5pHjaPHNj5agEpjWB2bjzWMSz9Za
 fyxVm/iGErYnxP3BUAUrHeoZFaUvVm2lD11GGSW2rGsCjDrA8iq1Jt4hRAkRYYA56yiy5Sann
 OXI0bDHDYOkkW3P4IpmFnSOKwDidj0pzaVNWyi7qsFwoHt9mJku6ZR6up3OBF6aO/7Zdu1tP0
 7x8k2Nw1mjAIW3096ydJc268SWf2lgbnpMC7wpVqpBignOwitN9PQzjrFSIFtUGNodhmwPM9p
 MOYg7giczIpaTL711v9doVwViUZJwQttGpEqiO3gynZ6afuXyKcodMOQH8fg1jRZLlAuO8IVX
 4TqpI6BTIU4NPFKad
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know what is Coccinelle software, I will check it out.

I am curious under which circumstances the development tool box will be adjusted.
http://coccinelle.lip6.fr/


> When I receive critical emails from others, I am happy that this is my study plan.

This view sounds positive.


> Previously, I was happy and looking forward to providing patches to the community.

Such feedback is nice.


> But when I noticed that you were sending similar patches over and over again,

This can be an usual effect from the application of known source code
analysis approaches.


> I realized that if I want to increase my patch count,

I suggest to reconsider corresponding development goals.


> I would not be able to reuse some files I had already found,

This can occasionally happen when some contributors try to achieve something
in similar areas.

* Would you like to clarify opportunities for further contributions?

* Do you find globally distributed collaboration interesting?


> which made me sad.

* I find your feeling unfortunate.

* I hope that your view can become more positive again.


> So,thank you for giving me a lesson.

This was eventually my intention partly.

I imagine that possibilities can be improved also for teaching and education.

Regards,
Markus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6C1D210828
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 11:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729300AbgGAJbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 05:31:16 -0400
Received: from mout.web.de ([217.72.192.78]:53785 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726715AbgGAJbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593595853;
        bh=/Sbx8ISVZWjBltKr2UyT7tGTulPMsGRe9R4QnT3f9pw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HF9EL6w2M1LZ8VwoGJe3D9KL63wPcTSomyFrpvkYrbcvcmxXYg7Yt2waTVCrOxE/A
         gC7nYaC29kuJZIoAB8Wh4Dh6dk/KTgqoCn58lpWvGPFbi46B/a6EwKraRKem/WDZHl
         VSBK7J0Waa1tYaLZicp+TAZEHjCCyKZR8li1Lqrs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MLPNm-1jr72l1Lyk-000aEP; Wed, 01
 Jul 2020 11:30:53 +0200
Subject: Re: [PATCH v4 12/14] irqchip/riscv-intc: Fix potential resource leak
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <1593569786-11500-1-git-send-email-yangtiezhu@loongson.cn>
 <1593569786-11500-13-git-send-email-yangtiezhu@loongson.cn>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <78ab5f7d-3c64-6125-cf8e-822e7b0106ef@web.de>
Date:   Wed, 1 Jul 2020 11:30:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1593569786-11500-13-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kkgUR0O355Y2iZQxsx2fpPWf2QbBDh1L+zfhAJL+auvsc2N6HSj
 9iUn2gQ/BdpMMWITyWP5mJkuo7AJagLhyl9/eyHRHveH5Vv6y+gmGamLNF9+UbSL0eFCXEM
 TFpX7ADI5P0cmiXO1vsshEFOeuM21skP7rsnoKI0wnJU5ooQWB069aVt3k+XNui2YkTRWZr
 3GcGhvFCNrc7a1l99plpw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:KKcKCQalvOA=:z09fncitljUOzJMAqvp1Pg
 LXq8ePVKQl1J1794WJ8J+Vp3IFBrkYRod8kRJJALJ7yKDWDl1Z8fET4cvajB0wtLrCGsgTXLm
 +n0veMb2yrNn8RtzmyeohMkXKP2j1Pb9g4QDu0zbqlfRLGVwt/MXAbcKx8QyX/WmRSLCts3EW
 wPF9JuDaE7Ms/K/n2Fpq2rFaUzb4jIjJUFPrHGeHeQDvoxay4DPWO5dQy/8epcuIM2N7smloc
 mcNg3dBjQv7Y8L/38mrn8bUxC0IdcisY8xKgNlmEiWWvsxMj1ggEAkYpfP3cvoir9ZcL1q/WC
 878WbNZeBG29jrpB5977XWQQuZslaB1BH1mK7rcIhZVS6nGQxsf3lY97GJQMYwTf2/bSuLHMX
 VEBtrndwr7cWM0eidQ10hiPmBAw5UKh0K/5ZJBoJQdLSY13sQNtip8uz3dRaPOqH79nPWBERI
 sp9DmJrlRuEnroLsRlyApwBx0oh+TftNjsOQ3wAjNkmlDgOGZRvbMkEoGnAPdhQuXH0nEEIq0
 MmNPW1jmxCnpHelgApbJeL8V+vMBBMIGd7nzFzBril8BFJaal5awbQi2JJcFjTQtA3JUcOeCP
 4TxtdbqQzJXiLTBPZiSX74xwlK5m/0sJXkvp3r3XA+Pmmu0mt8iq98M8uwZCcwoG/nvI+oaMb
 gQyz5i/RSg3cCiwjWFl8S2n3wMn/kuFULRlKMLiyOTadG5UiSk5UacPA8HtLdZHqkHAffVkTU
 5qycOu6remdec4hy6VvQL76DgQUuDaTZkz367rE2CHzkYKDBUHIG9C76AKre6OtCWEJan8mmm
 NjhYO3lnnnR/tf1MQ5smSArA718sCQFv6efsHhcsyYzH+SiS1mJGRsQsB33SwBaMKrlrxf1bP
 Gu5DSyolLxL8ZurGm4d2ozOoyLCdL03jOFW81ky2lsD57HZ2VX9hC/QmoIYgED5x3e2U2qDXD
 kDVLpJaV/XP6L2Cf+4IZYgS8sKsspMEyLEPdbxU7wNLMnmLrXHsOyHNx/yo5NxtZ3JWs6+bo4
 ofF1LKE/S8QBFgazca2lvMU/chJ3nU7Su+4TF0faBfkf50Y4/OJIJTTRWHGs1fYh3q+/YH6FP
 G2Au8qjPYhfzXY0IoUB5Y222MFZbXzVsL5zOvHFiuR/VOXWrYFH7JbvnaR6lVSoFPq2Bj9isz
 GyW1YjoIZkB/1qt/6/qylQp4VaL/HLktvP3V99xzZ2efnTewMKG93RMZ4EcmJHTykwPaa7fDu
 d77q+QSNUkXKYiKSZ
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In the function riscv_intc_init(), system resource "intc_domain"
> was not released in the error case, fix it.

Another small wording adjustment:
  =E2=80=A6 in an error case. Thus add a call of the function =E2=80=9Cirq=
_domain_remove=E2=80=9D
  in the if branch.

Regards,
Markus

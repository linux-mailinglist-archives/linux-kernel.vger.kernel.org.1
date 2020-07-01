Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB9211038
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 18:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732352AbgGAQGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 12:06:39 -0400
Received: from mout.web.de ([212.227.15.3]:40559 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731941AbgGAQGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:06:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1593619572;
        bh=TqZgLTEEOaYXnIul52z8uQhXmkI8iGig1MfiVYTtUKw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=FyH47ehYgRb4d3vj2HCbUqpPR5vLPtT07w/cno/y5BwtYgZXOWTYDtGNa2StAAoj7
         PEKpEqOuqJJ/XafxaF/gCWss3TLACyRM/6n5A2D6ev2RFY5pO1pqwg5k6vyTv3slKX
         J8jXxkQdbTi7WAGSuvnsjW+h7vzFuaQN7V0Qm7s4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.41.17]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LZvw5-1j5Tab0g4D-00lm0o; Wed, 01
 Jul 2020 18:06:12 +0200
Subject: Re: [PATCH v2] Documentation: Coccinelle: fix typos and command
 example
To:     Julia Lawall <julia.lawall@inria.fr>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Gilles Muller <Gilles.Muller@lip6.fr>
References: <0616dd0c-bb86-be2b-3dc6-1c695a92c3ca@infradead.org>
 <alpine.DEB.2.22.394.2007011728400.2540@hadrien>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <50499bfd-faed-5736-16b9-edca10d9633f@web.de>
Date:   Wed, 1 Jul 2020 18:06:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2007011728400.2540@hadrien>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:f2Vc7OxaioR6v0ADimsz6Q4DlbsS4t6pvbeKoJ8JQQlp6v1Tlf+
 sBEh02ZWoPqPGzvYLM5UgLG9xuBneNowTgROMffd5DUVK+fazZTtRQQRGAt5mA1W4VxHRrQ
 E3GMNdzvT2RiudgOVPZeRWvjB4jmC5+5e31+apCTonpZKCmCkFxzk5T21FDuvB2D5RLgSBt
 aDmQvZeGLHNdj/JtAxXcg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:fng2GLfSmec=:3YbKWC6Qe7XEM9oCq9Okis
 4PSaiEeUpSL9bnjC0srl38HW1RYZWWTT6r1hpWlKr61VbhsGLR7ohT644n6mna4naBETHYL/m
 gdb2HaltxHrmBikz+feAX4GjDwkGzZNEwI5XhGaKKYPOuNSFRnLuHgWvtiA6MXRgkXePVZ4CQ
 AkXKyK78UHTSeiTZaZjYUYYb+JP6uykb9Wc1wk0/VVx1BiWLK8cKJeJYFxuFdNK4AY09azk2A
 9hOe+XQJ2tyDcWPUP11VBp9mDSndgYJH7I4dXZzR94oWtIUDGxmhIA0y0Bq7Jr7e39b6MpLai
 Y/pTi0fQU/BMpBFADfzbhCt4bMe2jQu4MqL+xazX5bRzv/J/0qJCpEXkcKOlP5vsVSt9d9ejv
 fcWQBu9WMGJcbkEMlCispqEw8bIHV+qTHLhJvKS+1sUmgaBz+RpUs53iZcKV3A+P0bnC6NvhM
 vydn5Rvre3TRwuX3kc3miWrgnaEx8BcLNyBEI4i6vAvhqRX6cTwtOda3K1gZkSVfQBfzSc8eu
 lqXXrgMjpm8MM9PfTXXmIkD86Pgn4V6+HJ8tqqI5EwsMdyhZ9/9KHbpKYGQpdKoq8ZpYB0UCo
 hnVVQ01VzW+qZe3Il3p2SZccn9M9kGEstj+OgZjjisA15tZ4LoJ+vVPBWyUK2TRm17bT9zBso
 o6IJszAUmva6VLYt3CFI2GaZ548Vqn+6AZnfIBEPr195Zd4ZYE4YcelhcD2Lmsu+4mP8HspAl
 Mk151smHg0mPkBH1qJm8Zn1sVgRqt3blqkXs5hbBZHx2ZKmzStkoim/K1a/2eeaXWNs6iF+/Y
 lLPYaOtmGNkPDl07HoiIac8kVTm+e90fTN9rSxSNVPcrV7ibfvw9YViwzyVnGkdel2ni37ZEB
 10WrF1i6T5etVOguEGQJqiq0y/A4GSrrtWBNJyBwXQYpwmquIyGzoe5vudV1SeKF5JARSj27Z
 +HY9t3B3WRgVvNF4hg+D/UrdhdqXr/MNb+tCBzsniUsnkUwsXIMtsrfOjqb01nsiY5Gco5epR
 nM3R44JxvVYNCfq2Cfxab6NZK/bvwnyh6gp3CBQ73QZsVRn2L2PZhlWxF642ikNjb+CXiv4nK
 sN2/5SSO82Mm7Z0t7R6W1a2+IR+9Lp92+pdyyWIOyCRk0vt9b4MZH4nHJ/jfgHY8ZVoNTnzW1
 6LZWBNtGUT4wSQ1dqvV6XTbwTvQ22NKPn+EGS88cFhHPABMtTtj0CSuJLTmpevnnvy6AU2Ube
 HxYz50c9jL0YMKbAzmhxJfakRPL5h+6O73dhVCw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> - add "path/to/file.c" when using Coccinelle to check a single file
=E2=80=A6
> Acked-by: Julia Lawall <julia.lawall@inria.fr>

Do you really acknowledge that the specified make command is working
in the expected way?

Would you like to mention any source file then for which known
source code analysis (or transformation) results should be presented?

Regards,
Markus

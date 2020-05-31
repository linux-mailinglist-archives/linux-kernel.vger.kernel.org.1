Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1EF81E9979
	for <lists+linux-kernel@lfdr.de>; Sun, 31 May 2020 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgEaRhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 May 2020 13:37:04 -0400
Received: from mout.web.de ([212.227.15.3]:46991 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbgEaRhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 13:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590946612;
        bh=SVERIApNx6CcoteAIRSItXSmuOVrgD+0E7FESvzzqmk=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=sFSfkqEQHNdQ0+tp0LsQlHKph3ii+VsG9coEowFTiy7K9FnZHIyi/ef7eFOCQCGhI
         ei2Oi2bdbu7HpKsgjqZFkQ0VDX0bSlb/KSFn14NUjDrhP0WeaasJHOMgmqL06IboZe
         hUG77KEgPmH+vCjqtyoJZUmXwwWDPYix3gynHyZY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.19.10]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LnjNH-1j4COS4275-00hxDI; Sun, 31
 May 2020 19:36:52 +0200
To:     Denis Efremov <efremov@linux.com>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/2] Coccinelle: extend memdup_user transformation with
 GFP_USER
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <2631dbba-f38c-02fd-6c20-e4fe7ed2c00f@web.de>
Date:   Sun, 31 May 2020 19:36:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Tuupy3dthw2LI9M/7s7fL9h56Z3jOBmgmPvMHhKgQQtT9wcrS/F
 TaiF/qf9hqZGIBGiroVQCMJgReEohC9TFZmaKlZSgxZzAiWRqPU9NCX8TOBYCTRPyVLrYb0
 lLZzCWW50IKcAb0458eOumtxh8pymbuw4rk2RzLEo6ItvVuysLFzGzILs3rqiBW8doH0YG5
 buaFErTWvrPVMpHKUkOlA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:hDb/+y+a5YU=:qZE/mhgDQr8Pt1/Ea0yYKs
 lkOvDlarRiTd+Es6CB4nmygnMWodB4z8S2/01oQ0RcAM8aqlgHVlmQdVtTZZM4JrUNIPo+R5a
 VakPK6xHSIe3F5czbcX5qhJmFlPOQ5+GYIEZWYNk+CQLZit0I06HzGVdSDNQjSDktfzIZrAfO
 J5ti/QJfSzbki1Q6Jc9/LV93UTzqKlq5EJXfduf4I2lPIbbwCFJqynT3qDIGWm5OuZu+bvB6D
 5yoLXxmCPL/PQa62ANvVLsgVcKe5WWpkivmqiaqJrPMyME5kiiGmvtF8rnlC6ItzXOSTqeBNf
 Qa/WH1Keydyu0Xq1JECmdvhTs1wR2U0/plvAUuZH5pylrqlzdSpi3zII4xzNIzBTnJN7Vb40B
 tU7rNtGZCHjlPvYkDZiXSdeOP1tpPX/WXL2Qzpwf0Yfy+ltOv1UIXsRC0uWGqTau2XTBqPt9s
 fcUQowXFGGAyrLyAQRMXHKcu5CysWmCyCTyo7e06jKfXMFAs3KtoyZjvIE3snkAQZqTd99QDA
 6ed8ya2HcU5yoU2IjHAQiFs4XWjMlYljFvdTp5cu/LLbIiyQTPLkvslYCnaFNee53X5It4rwe
 sSHypXGcGkErA1pjTGagkIxjH9bm/x6nOQQyGJ6y9/cQGLk/FaDOC/gN/+IGVmiBoXRSoq17N
 usCOl5vREXmHy1+Bmhrzev0Aew4MsYk1RXVWXArkloR3InGSMwNcjIO2K9TiCVymemh5+quQz
 mEei/KySHO3TzL1WT0jMMB5dR71FyhrpInKHNWcih8H8XpdEiteIB+8jPDt49lCYiA0sBiXbU
 IPuwA+OiHmE43yYZEACNnFN1Uz9FDnC9V6yHjRNLmsK01d1NwAa5pgHRLDsUZB3wzbFxEg0LB
 l+FByhPOhud3uu0kAzOiFCjXk4I/CgL2TTnOJufW6IZrMhAsIPJ1+A1Gl/8z3GO0oUYyiK37y
 jKbeuA/IWgfOFfU+k/4EzUKzFOeoGhHyBKtdbXvFhm2MmbpHpl2OfUobtsWRuGh0MhVhXo69S
 4ZMNagvJwF3Db1WxYIamn4iJoBU8cswKsmRqedt3kHq6gRO/zdChfAJ9sAQlVvcBtayEWoXVe
 pt7/SvYVVxAmOAaIioKdz9RPqMtFKbPok3ZeeR+4qt5H6ZszqCtOifUEIXTxxKgh3p/fe6nh2
 jhRd0lo7LiIVbBzdqehlpr5zzG4Wk2anh546/ofHcJzvx5jJ/QhrwwADXCVxRCo0E56jLTEzx
 63hEnE8lXE1AuG/59
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Match GFP_USER allocations with memdup_user.cocci rule.

Can this software extension help also for the clarification of the topic
=E2=80=9CSafer source code analysis by "memdup_user.cocci"=E2=80=9D?
https://github.com/coccinelle/coccinelle/issues/78

Regards,
Markus

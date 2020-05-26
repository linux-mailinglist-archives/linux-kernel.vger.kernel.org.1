Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665C81BF73A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 13:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgD3L4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 07:56:39 -0400
Received: from mout.web.de ([212.227.15.3]:52751 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgD3L4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 07:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588247784;
        bh=VGV4Fw2sNEq8D8bF6x0dfHewG3Zs/VQNCW6HfTq7oas=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=mhEJE/AaHsHvaVu9RVBT9dwFLjcJo5t6iZUYYxWJbGXHUH1zpxE91K8oHzdVMO7Jh
         YQjbXIUASjX6mioywyIoxm6LNfoDqJlbBidHJqKeeluAMwnHGNeji7J3z2t9HVLeRx
         0fZM2W+fcniXTuJ8ErOJL/+v2tGFT6RUvAUU5xQw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.175.216]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MOAmi-1jZbS82lIC-005aTk; Thu, 30
 Apr 2020 13:56:24 +0200
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v2] drm/mcde: dsi: Fix return value check in
 mcde_dsi_bind()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7be53832-592b-7837-0688-0f1fb98673fb@web.de>
Date:   Thu, 30 Apr 2020 13:56:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4J40lGAYvX/cTfCr1dsT0eIK1GlOrCIKAXj9itU3RAOIioP5XbD
 4jFJOy2ZpHULqeuW5iN9hnGzP/lcHzAPKqlpnL0YuFjdKFUh25E4cYfmBvzbE+9wpYiHicR
 zUoaFWNwdpl8cuFDmC7MuDMn+qBe7YR3V9N+nhQtusfUfRk+wSwal4nduUEgfx2R24iF6mJ
 ArZBvbZJrpklK6NXY7z8w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JGOSLXAgGyU=:so3VXLOqyBtcHkr1e26Yr1
 ww/clhOLJCLxFFbX4coUnB5Z8zjijXCW/eE6AoPczB8hqDmUY25c8/ZbwKtbQ4kPvC0alEEUy
 ZKGtPc58+j00duflmc5DcYDCgeroGsR47Rp9GhYv74Ujv7Q9gpSrWLcTmHaYgNCFeMt8+9xrI
 lHqFviTsE1E6vFkY1kTAd4q9SgjKPjtWIId3SOIsZ4n9GroPjhjDvCdENbBk67Hbs2ppHyXWX
 cvMZdgumvrfOJ3peHpWdxXdR2HqWxTjeShwNsXNWqC3KNe2IbCd2NNfWKGKItMxHqEdVszkC2
 t5xtoW4rvsUMkbT0qIKISHasNPAOraledKZdFKjZ2xxdQVDagPordKvEZcReFJ1tJw5YSfX1c
 HVxSPRDo98S/nSj2EvtS+jAyk9HrK8V3vhklsdt3fEdwEOvLjVkSrjF/UtCjReFr1l5ZWfsEM
 1Fmqo27FgpQy/WWRT26seg5sRYJoyomTr2xXCrlEAXWRsR3iqXvVYFSZYABJTtUraHFY7wPEH
 kIe7mdB4Vygxs5jTZlejoFOhnCFFtbQgZFM8MNtOjqYvwLbSKwI/VayHovdt0/vvCDnIYjwAS
 2LV5GtPW4IvGjcMs7WjppET6TS9GU3DGFxrusF5OJOZ6qq6j2udk3j/IWGkP7yrr6mbK33M4Y
 phiRvhlqp/xMps3dB9lUhmfFc4AzBMEZ1sv+il4fFkYBW++5tXGiHxGLH5zWyd2AUpnjUkqRd
 JJWpmGBv5yk96n2IJbOeAcDDSPhFlfpGgDamqjym7etW5eSgutyHwGl3U+N2BF4QI4PVJHAyN
 EE9lJlZqxjkJ/S5+tt22RgjdwCkeZ4BHMliCwb5wJYH695OyO6tsOdp4YJB8eRjHl/kbiLOvU
 67mjToIfEIbKKJUISMiey1t62eANlqDh8q20jfwuq14lCZvbeJrk12EDU15Pw8h1E3Xs7OgJu
 x5zSCSxR+9gEJJIddpWYvAgbYBA/i4SnVHMbAcnKRuGxExOa/c2pFKWJbhsGEXfsQ6MJBuRdX
 6kmnSs3b7XOL4HBiRBQAc55vjbx+ShHG9xtFebXTFgRBNSKaohmwx+Rz/VTH84j7PUuK6rkoU
 fln4go6icsNGlavUnEIgFFx4Lhx4saHM9XPyKBNwpi2qpjmU5PKk7fAIr53iUHLPFq3+TlRwW
 LzU+RS75dPoQKX3kPzXNYInjxJyceTh7cURIQ8Ededbq0MZaHKmT7sjdlkYA2vb84WafXV3Ap
 eLfrSs9WzuoIdA/Xx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The of_drm_find_bridge() function returns NULL on error, it doesn't retu=
rn
> error pointers so this check doesn't work.

How do you think about a wording variant like the following?

   Change description:
   An error pointer check was performed after a call of the
   function =E2=80=9Cof_drm_find_bridge=E2=80=9D despite of the detail
   that failures are indicated for the bridge search
   by null pointers instead.
   Thus adjust a check for the failure predicate
   and the corresponding exception handling.


Regards,
Markus

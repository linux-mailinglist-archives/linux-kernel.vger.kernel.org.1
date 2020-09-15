Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDE3E26A2D7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Sep 2020 12:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIOKLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Sep 2020 06:11:55 -0400
Received: from mout.web.de ([217.72.192.78]:55627 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbgIOKLs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Sep 2020 06:11:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600164700;
        bh=UogIhfq9qNNjo/T+q6FmRMfIDnT2whLvdoBDxqlHAEs=;
        h=X-UI-Sender-Class:To:From:Subject:Date;
        b=mo2oBME0u5fne9FEa4B5xkFugDV6prx2KU5zNkWvyvOU8C7Qprr54aO/xUbJyf3nd
         ITGswlFR08pV9NGLLVdWtm6032Xpe6eiVyFz5fqZOsAYQWjqgPHl238P6KFgQxKBtM
         x1EXFG2DztgDdKiCStTJ/tOxE+8Py71F+/quAsTI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.3.160] ([91.64.89.12]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lc8c5-1kjniw49q9-00jZs1; Tue, 15
 Sep 2020 12:11:40 +0200
To:     linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Chris Wilson <chris@chris-wilson.co.uk>
From:   Dirk Neukirchen <dirkneukirchen@web.de>
Subject: Haswell Regression in 5.9-rcX and lower 5.7.x, 5.8.x #2024 - Revert
 47f8253d2b89 ("drm/i915/gen7: Clear all EU/L3 residual contexts") ?
Message-ID: <fc85dfc7-7f82-51f3-4fae-efea02a8339c@web.de>
Date:   Tue, 15 Sep 2020 12:10:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q1PcOu+oSzo73KlR10JHwU4DZPm6zwsG9wzPFGol2UjC9PqS7YP
 PVUfiJNrmkAoHZ0YDTdE8OuMsPwCKuHQZFM5HgYoL640C6VGWbH9MEmnvTOdvUs1VTfgX5/
 RxcREQgi/m2yaeEM430y2aSTJlm9kSsU/wJyGV4yXPIIe9wqBm8CP2BbFy9MpQ8vqKIaQ4x
 fuF+/VWm6JjWgUh8YvkBw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:JlVRHei2pwk=:EX3Y/fSRQzFBWWx51DGjOn
 ExUUxDL6tGkjSiuh7N332LRTNnPXtkyfAkxlM0UtUMRJodKTQ937gfNLdDNh2U4TpIut+ffUa
 Ar4J51GD96pdC88I/5UCAj/nwDtjoabDj4bG+WtZjIVfGzHRXeMiwjzc/ag1hEVWbaFilgdea
 7AQfAcxq6l4lrkXBnCTzwg4sP9aQlZLEgYbYpTq00B4Ij0cjgbMjpgvgRevKHMCJy9viS3WdE
 ToML53KYd+ogjkHkMVk5WBZAPZ+5z1E7CMtuA+DiVCCNvxrL9NCH5hrGSX/Lr/wEm4aAkhnKi
 8xAfn2LuuO9Ec068hAeXWfppmDNAUfMHhShVXJmHQndvCUcfA3mztVUZJh/llxMCqVt73rvTv
 AqtqhIuzECac0I8VYSM8PZdC4JFnqOrC3u3NNQ1sL0RPBaEbNxFBmRCXBqZ3PjIPgJudQRAsP
 dk3fdMDfs3vexiU8S86IalnbTssGDHv6Xkf5lsW+FQ+qrMZLY68VSCGG16C0qaWjkLpifq9cI
 KHaFWUg2iw14Fo9j3qmMDNjSyNLV7mtqYKxbHc8yOie+mqy4kzBclzrtNw9GhTnbWzWHc8ZBX
 08tO8WIU0VuDfYR1tOb8o6ooCAsgAFC3U/ZiymcN3AHCQsn/MwXd6ELQOKgNFT8Jm0Fm0If5A
 3gHMQvtmbsl7u9A7wiI937ZmgHquhGHbzkKarW8J/7xyzBLtU1aC/vi4W5CDuxNvattU1NdQS
 7O4HgEsiV3+ZF1LUqT0ox/886IbF/jPsmIT79uEeyFhIm0X8sUUdHi/UxrmcU47C1IOyes2eO
 SV56de1Dx3DzNYqyioYUeiMkGSLI0WnR3CCsUumamwUuPLO5uR6235vjwAlAPXfrSwMYc04i9
 Ex/r2Mq23KNHPmMajldlkVP8BjrBAWrXUUoYtNwStzcOUSNmq292Tr6eO7gXc0dz92F12vK5z
 opMyOmrqFu8QrAY//kgBPZgxJvDA16/yJwAFx7I5Qzp/sR8ygxWzxGXqw5sDvAEexThkjoh1M
 5oC4jNvJHPHqDgyoHdRbyvN8Vk8xVDhB1B/u2E7j/uPtP1ihKnFTj2vtt3ZE1zJwH85MmFeQs
 JcfjKh8jmXISflxR5jt3ZD4sbN7z+GW4hn0azo8i2UGLTsxkvvlJBOQQ3+NmhEmso7Ej78zEn
 HvvgoofQUtFiFvBx8eM0nt7/shO9kiw6oP5gLJCsaY+rdPit8/GQ5uGf/wdRldQQxfT2X3cGm
 D+itlaKc41QT79ouhSI9oaA14ZrjhF13FuQCxsA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David, Chris and lists

I am inquiring about the current status of #2024 [1]

Problem: Kernels 5.7.x , 5.8.x, current 5.9-rcs and drm-tip have a large r=
egression on (some?) Haswell (HSW)

This is verified by _multiple people_ using different methods.
All his is documented in [1]  , Kernel 5.6.19 was fine
Result: no output, no usable desktop due to gpu crashes

Hardware : 2x Acer C720 Chromebooks and potentially others

Methods:
- running mpv with vaapi enabled
- glxgears
- automatic desktop environment start (probably with acceleration)

There is atm no fix in drm-tip integrated (5.9.0_rc5bisect_g30b3e38bd6d5 f=
or example still errors)
 and no activity from Intel in the bug report beside the "working" suggest=
ed patches / hacks there

There should be enough bisection info an there.
Nobody asked there to get more info or different bisects/trees.

So - the ticket is still open.

Because Fedora uses newish Kernels I would like to use it "normally" witho=
ut
going for 5.4 LTS or waiting an unknown amount of time - as 5.9.x currentl=
y seems to have the
same regression.

Affected Hardware at my end:
- C720 with a Intel Celeron 2955U
- UEFI Bios instead of original Bios (mrchromebox.tech) if thats relevant =
for hardware init related bugs;
But the Kernel should take care of the correct initialization anyway

Feel free to comment which trees, branches, tags or patches we should try =
to help
and what _more_ to report for "Report-By" , "Tested-By", "Verified-By"
tagging so that [1] can be closed.

Greetings, Dirk

[1]https://gitlab.freedesktop.org/drm/intel/-/issues/2024


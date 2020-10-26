Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E42429862A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 05:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421380AbgJZE3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 00:29:14 -0400
Received: from sonic303-23.consmr.mail.gq1.yahoo.com ([98.137.64.204]:37460
        "EHLO sonic303-23.consmr.mail.gq1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1421352AbgJZE3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 00:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.ca; s=s2048; t=1603686550; bh=Ec0o3sOEszY2eGhyJjVpQa883vnHjbcvEnzaYM+SLms=; h=Date:From:Subject:To:Cc:References:From:Subject; b=r1sUzoU9X/EqJJSAah3dvDKhyW3qjjE2gSneDsimHmvIgHbL7T8fTZ2W1rZRUJJeIfdE+HgXeYIbybBF9eXVUh59iKdskUT10I28YZk+18DptCqYnFE50lGgytOJHafIUotYEciHgndIQqXV/2QbGZdPAl6weU+WjR+sySGB3yVfhhPe/3vDJL2FXvUi/95cFDXHFHr98Q8bE2cj+vZTP0fehJvguoRruzQ1705EJw9HlZoh0zNmQIcbRAL/33ZuTq+p0MnhjsxRIsbxUDfR9Ly1g4RcpJUZs2l8A8ejTu4M5XAq4aCi9D6AVR8f1E4sXuKdASBeQUwnWI17JUF0tg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603686550; bh=wVqlNBio//oZFVJv3jbjVUrOm5tGZUfYPC1LBOZF/vc=; h=Date:From:Subject:To; b=M2yOKKkfjBtDzIJvrCMmfQH9YSSHVLYoVA8JGkX2FdycYeLN+1yj0D7xgwbBkLsQBz04qNWBE3WLy6w381t9CPwJcHCOG9yxxawyhqlfWAFCalNAOHFAW+2XxsGvQyRm9XKnmqxpNeAh8gxV5Kd1LVDANGjvmacJARqcIFCCobHLn4ZFarRN0A7mB8IxwKja4CWq0TEsClVHYrezf2MO7HSRiqmsHwBZRS/YoYfhZQyw7s6W56bOcxbpQ86n5e4hQWS4rYBBxWWUB0mUC+W3/KZuIVD4GW8AcOdnjif/Ttj+agFHacED/1t/lBF7el16fowXTXu2Dp2rTF5UIcDYEg==
X-YMail-OSG: iLdTl9sVM1nhVlX2udGG.kdDn_5rEVY3GIdINw1ITRwm3glyTJBtgXtLftZQ8pM
 y7s2K8JCAm5KdaQhRYnx2mqc8rK3e6.tx0CglXuv.gtacRU0ocw2lXjqufgLRiHlbfstkrIZ.NgS
 JkKMJp6CSOk1y2sG5BWvyldD3tR4HsinTwl2Uru4R2mrRH2eg46ozT5FurNnWa1YZIL9PimLTo1n
 DBCFBCHklDgDchPorjOaI0rtT6jyZVkHvb3cRI6.NNw8_FVP_X1JBJno_PR8jv5tJDlilkukkVta
 JNDdv36TYVmrZzAMRkqvgldrdBdP.jFhBFPoWgqLYOC0COnSn8hQObMF.ZOLbu_IlMJre90vYO3N
 2Kao28dAZ4UF.MVrKSPvW4AQPwkyTlJdBUm4oQfL1zsU47DlpnHCmP2Ec408bro0hBB70SBpzxzg
 hCDJrMYmieSbOUNyb_tgEE49N5eGKy9iSqfG45xg2CTn.MrmoqelMsGeJU45WsaNDzYIz9TJDpJ9
 Kui6PYkx2K9bDCxugFlcJZo78K44yuRRCvtUZq_WWczKlqXi5djhI5Hakxs_BYMFbdoGFBdH9kDH
 jTqiRO1J_taVb4VoFdjFLPO7mmVVGrtNnSgfSJ0KoC.3t3x1c8RxbbD_9b_6jcuK1htDFGVF8mP6
 ls4aqtknZGSPV0jKvZpkXOcLwOyjIoQ7T2tXHoI_gNI68QOJhO3mAGIkcP1Y8aeCybhgEN_RD7N2
 w4jGexBPrrZ3bAhNzMGOjPLatRDG26Cay1ZWpmfY.5njNSGlSCvRwh08R.m1NyNUASIIx1rBcCYJ
 pHDodjfG2qYlh9yNQ_qMqewrgxOizo1cSa8MgifhwkBh1QUb9R4JPAM72xRa9HNPG6uZ86hNoMQB
 UTFYUKDKZ6kY2uGtcjdUaLdPIJIBfgSBtf6kfb_0_4mwZFyXpGGV8bPZZM4gBgZitNlPefZ8Lyip
 iAXbrRBES8cCmtrebpkP6f0KDmlkV9iLbfEAVeFR1ia.jEXBr1K7coiVky634GDL.UKc4b2URBUU
 bHBiLLlq1JH2TVxuVw51rv9sKTNbScQ2XKoas5KqBUawl.bpfcj8ff6BrAK7gu6RYlDTaC9PyGKC
 gFpn7INmhbt8hFNJefDeNALHGEHYNP.GGNTA968oy7CByWVKkURiU74QwOySXjr4Wa5m04KRyi0N
 vfyxzBXN4bOAkozR7J9O6zmBAXIDc4r9FWeMEo_INHye_0TwqAOP5ngusO3dT9jyXHKH4XT.KeDX
 VDoLwGyrkY7_QWEQmjsY48sogTUfWxTFdR6OE8Dyqf_7qTBbOAf86HM9qhl6c6ImYJGBX2P8ey8b
 Ng_LDVjH0w7YDJgNPXnxQPcpL8kZfrjjpSgBJZKFXVE9tXn07RboXdnMvJc_ZF63bsvN0z0ciIGW
 QZZrWAd0Zb0_YWY7aCEOhYXMnvfwYD8UDZvPvuxhq8LLFlO2JcI9n3Abd3FkcGHzXM3d6Keq97eH
 bKNpPpsYGUZ83Gn9R5cvaAE.q13OwFS75XppUfalT6mY0J9EGdkNoqgBK2qMzxmhZ7sYVYESGFrb
 bSz3GuIyqPlQ2kmZGrj1Bb6JNvgz3_tnGHh84YFNqFdu9VIMR4tI4re8I7PAwFV83_150WleFulA
 qbSkoWssnk7QuNC0KSLAMrR3IDDh5hYsTsH1rwDdlgsSapCQIVKspRXOvWqriCWnrTPc7PID6VYt
 cF.YaHRFg2Ut5vTT9Vw1_ZLt9gTHr2Qvpt0LPrPgtNUsVT07JD9THic.CEXyxNVtFNi3_98GLlGQ
 fKMCY8tkbhpmmHIMD8lwP9xT7bY1AhNA0.drtrpZj0li1Qb9jlVCkGQcR10s.qS6.FQ9lliFuUrh
 fmuS2EiYrQ_pNrsU.sOizo4v81IMnQ64IgVvEfOmKGzGWktfAklLacedwcGoGD2bCQgViRZxABOo
 rsLTpzaBs.YClM..iqE4JTubnXth5qKafdwPkrVZQe3a4wHwC3Jo8WHDKHhtQsRaQVjdr61BEACI
 sU3p.UBUJ6nAvl5K5qkWbVv1OECiurO6zYUPtaI6TzuHkxcluGb0_SwaZzOgOmVLS7zrkH94HeP2
 pPb9xuMRCX8tssCKYbCtFjJWklplShIISlgiVBstddQfItEKig6xwRSxKtAxEBfbHzOLATLKnM28
 Fx5YcLGucZT_skPMyYwD37FtgNA0O8FpHh_ECOaH3DQrkpvnUgwX6KaOMnftPbO.Pf.KSnf205a7
 q8r.K4gGGFk.QnaRq5dhUxl.FR8HhmsM5JUZTXItEr7PSwjxJG5bxBTUWrBMeUgKYOM8OQwWHQH.
 _ECGz8Y.pdOa.3QgOyT7PC13Aq0ICZ3RKIivyUbycQjOdtLN2ybwV1MFemgHe0YnsGKcARIkGJR6
 iUnwQxtFQfVuqqRjxVLPFO.ql6pKCdW9YsNNhL9QsrlLX.HgXIjiaCPKFbvrPiZM3E87U9CEfxJl
 im4iinkhhE0S6.nioTzmGillMU0oy.6hqFGEhLhUkhLH3N1xQCV4.Ok6PYiNMmOtLrcf4naW0pKn
 RlNPu4PfIs4uqGqztVENpPemBK28ctHpl8VH6wYs9jzoILtgaI5AkQDaLLs10_b0f8h8WbTwT1JM
 qJTKgJ_immptCM3fx1r8.O_YfqPU8VPJD.StLGO5j1iiYDwLwNEb4yAPuP0ZO3GvMJwH9xDdNYQX
 IuSIkdGaRkodSS7Ht6TkTTC4feF.Azuz_RQf_dl734WcMh.eDgBTQF5wApZFxRm5t1ejujC7CX3k
 ToU7xqfYNVkqxm4LgbQ5ho2NBOBCRN8Zj
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.gq1.yahoo.com with HTTP; Mon, 26 Oct 2020 04:29:10 +0000
Received: by smtp401.mail.ne1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 6a7b32f6e8bbe21d3dc245690167a96c;
          Mon, 26 Oct 2020 04:29:05 +0000 (UTC)
Date:   Mon, 26 Oct 2020 00:29:00 -0400
From:   "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Subject: amdgpu crashes on OOM
To:     Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        alexander.deucher@amd.com, Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, amd-gfx@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <1603684905.h43s1t0y05.none@localhost>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
References: <1603684905.h43s1t0y05.none.ref@localhost>
X-Mailer: WebService/1.1.16868 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo Apache-HttpAsyncClient/4.1.4 (Java/11.0.7)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I frequently encounter OOM on my system, mostly due to my own fault.=20
Recently, I noticed that not only does a swap storm happen and OOM=20
killer gets invoked, but the graphics output freezes permanently.=20
Checking the kernel messages, I see:

kworker/u24:4: page allocation failure: order:5, mode:0x40dc0(GFP_KERNEL|__=
GFP_COMP|__GFP_ZERO), nodemask=3D(null)
CPU: 6 PID: 279469 Comm: kworker/u24:4 Tainted: G        W         5.9.0-14=
732-g20b1adb60cf6 #2
Hardware name: To Be Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4, BIO=
S P4.20 06/18/2020
Workqueue: events_unbound commit_work
Call Trace:
 ? dump_stack+0x57/0x6a
 ? warn_alloc.cold+0x69/0xcd
 ? __alloc_pages_direct_compact+0xfb/0x116
 ? __alloc_pages_slowpath.constprop.0+0x9c2/0xc14
 ? __alloc_pages_nodemask+0x143/0x167
 ? kmalloc_order+0x24/0x64
 ? dc_create_state+0x1a/0x4d
 ? amdgpu_dm_atomic_commit_tail+0x1b19/0x227d

followed by:

WARNING: CPU: 6 PID: 279469 at drivers/gpu/drm/amd/amdgpu/../display/amdgpu=
_dm/amdgpu_dm.c:7511 amdgpu_dm_atomic_commit_tail+0x217c/0x227d

followed by:

BUG: unable to handle page fault for address: 0000000000012480
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
[ ... ]
RIP: 0010:dc_resource_state_copy_construct+0x10/0x455
[ ... ]
Call Trace:
 ? amdgpu_dm_atomic_commit_tail+0x2193/0x227

This area of code is quite odd:

dc_state_temp =3D dc_create_state(dm->dc);
ASSERT(dc_state_temp);
dc_state =3D dc_state_temp;
dc_resource_state_copy_construct_current(dm->dc, dc_state);

This ASSERT macro is misleading: unless CONFIG_DEBUG_KERNEL_DC is set,=20
it is actually WARN_ON_ONCE(!(expr)). Therefore, this code fails to=20
allocate memory (causing a warning to be printed), prints another=20
warning that it failed, then proceeds to immediately dereference it,=20
crashing the thread (and the kernel if panic_on_oops is set).

While I am not by any means a graphics or kernel expert, it seems to me=20
like there should be a better solution than crashing. If nothing else,=20
the OOM killer should be invoked and the operation retried. We may lose=20
some frames or see some corruption, but that's far better than totally=20
breaking.

Thanks,
Alex.

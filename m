Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7B01BDDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Apr 2020 15:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD2Naj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Apr 2020 09:30:39 -0400
Received: from mout.web.de ([212.227.17.11]:54393 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726780AbgD2Naj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:30:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1588167022;
        bh=/MTQc9gAsJAPP4H8/tzw9TM1Qf8zudFOc4Xfmf7+dYw=;
        h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
        b=fsdbxE9Y9QjcpcTNcDW5A6vLho0tdp1NHLllHlKKk9jr3duMgpRDz1MwAwEyZGFbC
         Cs96J68+R+oAjGMOTeIgy9hjJM8TUQ+9ER2LltZmtxP+aEw624v7hKV6uXR3uWIHVZ
         OBA5rNeNnFXPYggFnDvAm/R+2LuRb2bES+xQU76U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.72.72]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFL2m-1jQXf73GXE-00EJ4M; Wed, 29
 Apr 2020 15:30:21 +0200
To:     Bernard Zhao <bernard@vivo.com>, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        opensource.kernel@vivo.com, Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH] clk/meson: Complete exception handling in
 meson8b_clkc_init_common()
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <ceba9706-0819-54cf-c3d3-9ceb93d31c5e@web.de>
Date:   Wed, 29 Apr 2020 15:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VbtUozrdnS3f3mFsMO90WUGM4iLjjRhtjaQ2tdiDGbLTbeM8kps
 oeBHZw3l4M5oaDrHpnAZ/tz2cVpUMocce20jjzTJHfDqQgg3QoHS7AQLt8Wfug2chbbxkY9
 sAsH2sUA+2LKOHNghLioNcBvzcVZq9SEmjalf6ke6Elv4s4hIdn17v3OGEYXSe06mNz1bxw
 0PhXOUbwuExEI8rxgOE4A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0WnMMYIuquU=:xwc98jCk5A95enBKww7nVB
 41Mb80XNIKMDDVGiYbtQl3csVIr1rP4fi1XSzOqV886C29z9WOeeVO8k8GfD08qeKCiUut/kH
 k9SUFuVV80TRCrUB8vSfvkxxWz3YqrA2bMEnankibACtpfy/BWvNSmHjQRxhtoyDFUHVjALsS
 IyClxlWKjMEQE05hzLGPfu2fDWx0NM97kilJvqjC5ciPm9fb7Qk/TX80mrLoBfCt4yE4xq9og
 82d4gviF0yc365ZSaMaWAsE5GakAXNoZGSV8xR9Ay2Epz+hbqc/KbYRm6mA5rz/IXgmRSLNIh
 LEmMfrUZCHzWWobj/ZDT1J0Kor04yHtZovxZTo2YlJzOIhfZLATe/tsM6N9zBqw4yqhCXRFXf
 Wr9lCj2xgEEu8XaDs0XuaaNBVkdscac6v+4f41cEDYjwJp1ZdEq1S0O5G29/dux+4H6WC/ZYe
 BJMAFMio9GhIwGChikz1WXrbn+avS7ag93XzsijRMscO5LVUfHkc35jUqP7tQcDIBLGgHd4MM
 Wqu9tAxSPxyl6DiHSLEPIPDOkn8DjS+pr87pt443ceGTCkCBiZkIA5NQcMGOxJ7E0wTr/Udid
 pwN7zpIrIr6110Mnj6KVk1kgHSqRIL15VUJ5eC7GyFd8YVE2ggtLcSi0ZUf1zEEY8C3AlISr0
 8m0a8Ozn3p5ksDQjbtv7Y584YOe/hUHFRWp48bSsYQm3w5M8VRDI+f6khvHQbjmhvuOhtD+F+
 FTijKRWaa7Eu1y4PcYEYKuopYWHhDYMSQjlYX4bqcrqX6xXXNjMRiXwaq1Csc8oPNsTiLP8M0
 KhDIf/BueyMp8ub1ViGAyziIUp0KU+77mM4MQRBotbHjT6HynhO/QsKO2WxWzMBtWSX4wIVQi
 jJzgF2R/pnVJOk+fZaRwXEQfENk3FGoEsnovr3oNW0vkzoKN10wYtlPWYX9hP9Kp6DgpKx6O2
 7axOJlSmZm0YdaNyGMLEszF6KfDOdD3AkjpvGDv44REMrKIweQigIDwV2n2tToEMPyIHNHZKd
 dnX6/PCYV3ddFcmdWwBqUJxeMlS0eYqDdGOjjabNtos7a+9GfdzsyIZtZYxDXNF0EPDPWsGZJ
 eWjZwJfx2aEAXFQAmdbhj46pW0FsWHoA6r/QGkTFbo72H8C7twyc3sL5q9/FFDQcXp6J+3+r3
 MB3373nLxjh+kQBJf3MQK+08N1nn+ZeKHyhaDzwg+4AaXGGSP3TDV18E42dtnU9jpd0nkYhaF
 ihYRX8HFXjgOYD5ii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> In common init function, when run into err branch, we didn`t
> use kfree to release kzmalloc area, this may bring in memleak

* I suggest to improve also this change description.

* Please move the resource release functions to end of
  the function =E2=80=9Cmeson8b_clkc_init_common=E2=80=9D here.
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/coding-style.rst?id=3D96c9a7802af7d500a582d89a8b8645=
84fe878c1b#n450

* Will the tag =E2=80=9CFixes=E2=80=9D be relevant then for the completed =
exception handling?
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/=
Documentation/process/submitting-patches.rst?id=3D96c9a7802af7d500a582d89a=
8b864584fe878c1b#n183

Regards,
Markus

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBE0269443
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgINR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 13:57:25 -0400
Received: from mout.gmx.net ([212.227.17.21]:43193 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgINR5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 13:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1600106229;
        bh=VkR3sLNEHGB7vqOFeucWnF1Cpiwm6NMeodVD3aUq3rs=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=VPHvLGE3P6Gj313ovpVLFc3MLvGx64PDo1cCrgTUvJQzAf/NiUf3lOYsc997e2zAx
         6XczVY6GMBIJ2gQUuJ7+PDmIFq28cXcyXNMGtRLC6NdHD2sVZaQPilf5PAsMOKePbI
         m2VCEhTqLfoikqSvTZgRvMxqTeSS9pbb8akrKg08=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [80.208.209.101] ([80.208.209.101]) by web-mail.gmx.net
 (3c-app-gmx-bs03.server.lan [172.19.170.52]) (via HTTP); Mon, 14 Sep 2020
 19:57:09 +0200
MIME-Version: 1.0
Message-ID: <trinity-9cd01270-7c54-4bf5-810d-e1b7de352e11-1600106229398@3c-app-gmx-bs03>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kernel@vger.kernel.org
Subject: [question] KBUILD_OUTPUT and modules install (with
 INSTALL_MOD_PATH)
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Sep 2020 19:57:09 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:ALlgZSKA62hoClrvvBfPSX3yC7O1YXEi6blZpgY6jvYhAYMlyeV+1EZJrcfhxcD9+HoVX
 bc3bTLKEKABBaVqDgLwSpxGGXGQuaWKbYaNPvqhEGgwabfS1n0sXSByoVnLjZky7V1OOk3qDxQU5
 MAgkdEZ+APoolnl62ZuoTPmtEgOKG0S6DWpG/6PpgsaWLhjG06/L4ag4bjd7dRtSXb8AjGdl1/sn
 2nbLq/wr9WlNylr3yWsue5GgYsW7PQ09HpCfsp3RSgP4cV/qYdsuaJE6ZIVnzmCvv5yRTAB8Vp27
 F8=
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:SD2Cj1CuugM=:7FueitUXOoE++PIaOLEejH
 wJ1HdukpUWpxCUgLqYLJx2ldDFUOwF/gaeE+YnGujhGsw+KX8INrsUeC2GKbnkCL4s82P1p1J
 UWRCwKejSZ3KmrIaLyvskFAU7gHTnUsIYxGOrzWpr9uqa0pTobrt3Dxk/qyBA/T0gqA2FG91D
 a82Zwwjxx9H8Af8WWqWSy8Nz9mYHkTNHOJwoOPh2kLshitRPe/6Fn5kun0/wDaQ6Zi2OHT2L8
 P9HJVzDtXvd1x+Y1y119o3yiW/lKyO1FUU4iOkaBrP1zjdtxaUTUjKNlDvfyOyVYpAZPLxdzh
 v+a4/683rwUGvs2K6o0WYlTqQj/oWK5t1IGHHzO6XHU9DGDnGukMrrtxU8DCDFPgizIQViM+K
 wRb/F7uVxXLfo5s+yvbOCWL8hh+tCAqZAdkFDoIhsPLUhBn2rjHZP1ULN7BspEEKIzB4Ya6yS
 SzWTvyf9sD8/Fkc/dbfqNfFnmyQCKFBSRex6WroCbxWbhZ0GhVSsTcBy9RbQLmh0jUJxiXj3O
 PXWewb9kANY2Ryc9XHAQd6SFPp+2dncrzkyVk+jsaNkpHqKx3bSI8uyNF7CiHZ05A5bAhaPjf
 vlL9th/gimp2SpobGHbav5wPsDXaUf38zNyLrC85PI6KW75HeK+v+AHUu1YhD8tnJ43oe/xet
 zsXOZKQnDd0D85yz9a9/mTDBhBeZV+2CAAWypQoktlZMSiXUVglChUAoMp1YLPsVmeTk=
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i try to use modules_install target after building kernel with KBUILD_OUTP=
UT set

KBUILD_OUTPUT: /media/data_nvme/git/kernel/build #kernel source is in /med=
ia/data_nvme/git/kernel/BPI-R2-4.14

kernel is build successfully, but i fail on running the make modules_insta=
ll target

  ERROR: Kernel configuration is invalid.
         include/generated/autoconf.h or include/config/auto.conf are miss=
ing.
         Run 'make oldconfig && make prepare' on kernel src to fix it.

Makefile:648: include/config/auto.conf: No such file or directory
make: *** [Makefile:719: include/config/auto.conf] Error 1

it looks it is ignoring the KBUILD_OUTPUT variable, as both files are pres=
ent

$ ls /media/data_nvme/git/kernel/build/include/config/auto.conf
/media/data_nvme/git/kernel/build/include/config/auto.conf
$ ls /media/data_nvme/git/kernel/build/include/generated/autoconf.h
/media/data_nvme/git/kernel/build/include/generated/autoconf.h

i also tried adding KERNEL_DIR var, but also without success

sudo make ARCH=3D$ARCH KERNEL_DIR=3D$KBUILD_OUTPUT INSTALL_MOD_PATH=3D/med=
ia/$USER/BPI-ROOT/ modules_install

$KBUILD_OUTPUT is definitely set to right directory (checked on beginning =
of my function)

this message seems to be triggered by Makefile in root (here i tried to ad=
d the KBUILD_OUTPUT in the test before include without success)

 718 include/config/auto.conf:
 719     $(Q)test -e include/generated/autoconf.h -a -e $@ || (      \
 720     echo >&2;                           \
 721     echo >&2 "  ERROR: Kernel configuration is invalid.";       \
 722     echo >&2 "         include/generated/autoconf.h or $@ are missing=
.";\

any idea?

regards Frank


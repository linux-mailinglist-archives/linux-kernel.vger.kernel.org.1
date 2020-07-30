Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F49233612
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jul 2020 17:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729805AbgG3PyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jul 2020 11:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729724AbgG3PyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 11:54:06 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771E8C061575
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:54:06 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id z26so2668444uaa.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=DEEkv/VGEQSgB+RIrNLIfzumf5ncvbrN3bYAAiQ9koI=;
        b=TQUxTpCH9WMiZ0LvB0esLbFDno9ZN5TJGNNwtBmaZVtqWX/QEnxWHWV3VPePlQEMWn
         UCkAyQOoXRnlLbGZ++LsEznAdvAXnAKjHzSDMsaPB36mi4T4j+B67PhQEwllUNIANj+W
         DUSUG7I4zRtBiUO3P6QDe4fph/piNPxrcMjZ9vLngZmNRycwaGDEXaqPizyflTJtfEim
         iBwjqGNPdyodaqszJpW2XBIpM/fL6TlQlXKjgu3MFX0U+iwGO33wv+N3eTPSdM2YkTfV
         35sfSR6xwRFvQpvvOlwQMGL8lbIMohGNC4tpT6qgwpmamVGeDWMqX0XPP1jVcmhdjXol
         gOJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=DEEkv/VGEQSgB+RIrNLIfzumf5ncvbrN3bYAAiQ9koI=;
        b=ZomZ7nK2wQW6Zq72/Ksn6YU4zSKj5wMm0DSykXURacNf34zjkNuleRKcaGsaF22W9q
         c+pVgdy2S55xKES76UbnhNXd2qt0LCqKncj77bYtxy85nni8ALmDnSq3SZwCKdYgCsqk
         Z2tUzPv7DLfCmY1//7x+U47Fcwqk+ac20+8Sy6s1hfStSY47fR4cnTFL9EJ/8xPnkNvE
         C4MD9j27rXn/Dp24frGigOrJ/F15QOwEehK/J12jrESr3qRe4Lv1nbmgqvhE+MGuwC09
         jJkNbJLr6zqA97SoQIlPzZydFP7xMide1Q18cVLTShNwypL2o1rtQfIrTMC+W4uDMo6N
         KMag==
X-Gm-Message-State: AOAM531n1N5Bcw82/Big/LfuceHLS0QpKycvNcWlTA3w44DciK3Y1SkN
        7wl7rVryHnfB+iG9fhbuG+Yl3MyM6xIYn4uUPOHrlMw0kiCUMQ==
X-Google-Smtp-Source: ABdhPJzAi9z03C1PKWYToI3ONL8zHEh+0Gn3h/t4WmPwCQvUyAgk0rLVRJG2ECJZvBQiz8uaRrxGsRaGOukRnFBingY=
X-Received: by 2002:ab0:5963:: with SMTP id o32mr2587457uad.142.1596124444916;
 Thu, 30 Jul 2020 08:54:04 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 30 Jul 2020 21:23:53 +0530
Message-ID: <CA+G9fYsomRiVYyFCbSo3UvzcROOij7Xq73-crk+2nNOoq8AY3Q@mail.gmail.com>
Subject: scripts/mod/empty.o failed on i386 on linux next 20200729 tag
To:     open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, corbet@lwn.net,
        masahiroy@kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>, jpoimboe@redhat.com,
        elver@google.com, Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have noticed this build error on i386 on linux next 20200729 tag
this is building with gcc-7.3.0

make -j 8 -j 8 bzImage CC=i686-linaro-linux-gcc
  -fuse-ld=bfd
  -fdebug-prefix-map=/srv/oe/build/tmp-lkft-glibc/work/intel_core2_32-linaro-linux/linux-generic-next/5.7+gitAUTOINC+04b4571786-r0=/usr/src/debug/linux-generic-next/5.7+gitAUTOINC+04b4571786-r0
  -fdebug-prefix-map=/srv/oe/build/tmp-lkft-glibc/work/intel_core2_32-linaro-linux/linux-generic-next/5.7+gitAUTOINC+04b4571786-r0/recipe-sysroot=
  -fdebug-prefix-map=/srv/oe/build/tmp-lkft-glibc/work/intel_core2_32-linaro-linux/linux-generic-next/5.7+gitAUTOINC+04b4571786-r0/recipe-sysroot-native=
  -fdebug-prefix-map=/srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source=/usr/src/kernel
  -ffile-prefix-map=/srv/oe/build/tmp-lkft-glibc/work/intel_core2_32-linaro-linux/linux-generic-next/5.7+gitAUTOINC+04b4571786-r0/git=/kernel-source/
  LD=i686-linaro-linux-ld.bfd

<trim>
|   AR      tools/objtool/libsubcmd.a
|   CC      scripts/mod/empty.o
|   HOSTCC  scripts/mod/mk_elfconfig
|   CC      scripts/mod/devicetable-offsets.s
| cc1: error: code model 'kernel' not supported in the 32 bit mode
| cc1: sorry, unimplemented: 64-bit mode not compiled in
| cc1: error: code model 'kernel' not supported in the 32 bit mode
| cc1: sorry, unimplemented: 64-bit mode not compiled in
| /srv/oe/build/tmp-lkft-glibc/work-shared/intel-core2-32/kernel-source/scripts/Makefile.build:280:
recipe for target 'scripts/mod/empty.o' failed
| make[2]: *** [scripts/mod/empty.o] Error 1

Full build log link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/824/consoleText

- Naresh

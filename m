Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CAB91EE693
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jun 2020 16:24:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgFDOYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Jun 2020 10:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728663AbgFDOYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 10:24:43 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B754C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 07:24:43 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id t8so6224892ilm.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 07:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JS6HyeVvkiCeDemuhmHzEunRqmqArfkWc2lfz975jaM=;
        b=GJkFARNUDltUhSI4g77UUJqkqXhQ4Sljzq2oabPOKKvdlLn4cSjYcrMZuZKO3+v7zE
         WTcbBBgnGlQZM2ulOQ3wCDrzSBbmw3LJHI8H0Z1YRdz+NuVAmV44585FkTS09ufVMBY1
         d7mSwWz5dgftw+kaQ8nMYAzNCFkWDrxuyh8vVYWBHB8XOOzyiY4vJe7RyHNYjSI2l59Q
         Kn/PWbO2lW69j0Z5xlAuyNtERmkI1p7YEzbSJRYoDFGmjvSTMQwPFfLvuRpd4z8DeFUX
         xfavYTMO9JGZTGIIotzJN1ZDGGWObzYhzudTQryVJSt2Bkf8PFoEoMX8icC1siFGWkFw
         MG7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JS6HyeVvkiCeDemuhmHzEunRqmqArfkWc2lfz975jaM=;
        b=bi6WLTjzDxm6EB0aSk9JwL7TaLJqLLbATEMAEUK+3xLWdB3NrkCr/1FJlO1UinAgyN
         xPyGDXgrCo0fpCozhc2Owq2jllAJl3+I0t/dPUPUeq/lemx8dRd7ymFeit+qwt+mOcfr
         hWe0NNsDyr7UejfbEVusxoq2RP2H2IjN1OtNk1P+mr38AwLsI2zY+RChy2MaNaNQdY96
         25niwoKzIt9yjcRhOC4eTtAcJd3C9XC5DdjJaFzmISEhXGtf/CfDlUVueomXVgNo0mQf
         UTiM8gbKUzNENfGMT+GUGbItzHKFWbFtJeT43dhDd1V6mLMbE4M8m3P14mKpkSwocziq
         XoRQ==
X-Gm-Message-State: AOAM533jNkqL7osP8OB229cVXy4duZaf1ujGWFcpFyD1H8p+Pxb+cNpv
        K9kfN0mccnda90AXSM37FhBDph5TFvdsG8RLu6gAnfSrCI0=
X-Google-Smtp-Source: ABdhPJy2fM6Chl0A3+CRZB14CZUFCbwsNW4wh+kid99szc1vK1MLRFrJmJpID9X9N+BTR0IjCtDl1Xzila4UI6GHaOs=
X-Received: by 2002:a92:af44:: with SMTP id n65mr3944790ili.61.1591280682508;
 Thu, 04 Jun 2020 07:24:42 -0700 (PDT)
MIME-Version: 1.0
From:   Zeno Davatz <zdavatz@gmail.com>
Date:   Thu, 4 Jun 2020 16:24:31 +0200
Message-ID: <CAOkhzLUrNYk6JKTbTQuFkfuGKxGvW9XVq6+p9igsBgX1-e9Cxg@mail.gmail.com>
Subject: NVIDIA GP107 (137000a1) - acr: failed to load firmware
To:     nouveau <nouveau@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

With Kernel 5.7 I am still getting this, while booting:

~> uname -a
Linux zenogentoo 5.7.0 #80 SMP Thu Jun 4 16:10:03 CEST 2020 x86_64
Intel(R) Core(TM) i7 CPU 960 @ 3.20GHz GenuineIntel GNU/Linux
~> dmesg |grep nouveau
[    0.762872] nouveau 0000:05:00.0: NVIDIA GP107 (137000a1)
[    0.875311] nouveau 0000:05:00.0: bios: version 86.07.42.00.4a
[    0.875681] nouveau 0000:05:00.0: acr: failed to load firmware
[    0.875780] nouveau 0000:05:00.0: acr: failed to load firmware
[    0.875881] nouveau 0000:05:00.0: acr ctor failed, -2
[    0.875980] nouveau: probe of 0000:05:00.0 failed with error -2

Old thread is here: https://lkml.org/lkml/2020/4/3/775

My Linxu-Firmware is: linux-firmware-20200421

This used to work fine with Kernel 5.5.

Please CC me for replies.

best
Zeno

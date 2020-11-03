Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8902A407D
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 10:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgKCJnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 04:43:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgKCJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 04:43:22 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F28E0C0617A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Nov 2020 01:43:21 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a10so343809edt.12
        for <linux-kernel@vger.kernel.org>; Tue, 03 Nov 2020 01:43:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=FFd3mvhuQMY/+bsfnVKNY7hNDVTrPNGeeWvSKBTt/6w=;
        b=arYDKw0T/wCpqExPGZaCoxeicaXqBaBLG/rtsFLovNIGxliIWwpjvyoeoIX4sLmmQ/
         XcJeYYzamHLxiqIZVvh8ECoqpzi6zQuhnT8yHA2NI4i7Oj12Nu7NPW3/H2HRuAhxFS/f
         m8UHRQjc5aVaOzzjo+9URvrphNdC8NtQCUjiXVPj6vXBJqVu1/u8sVFtS6Q6Rn/Eut9A
         Pp6AzIsTVAnc421Fw+Jp0wXnOGkkUmdSdfGpfinV+YTNaPaJMglfAna460V9XmlJXzFC
         sjzB/+B2mjgarsY/89FEJRgGoZGkfPCrRzBJOiTRwo3XgCpBvb9gI3Fo1VPEOR7o4jBF
         5ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=FFd3mvhuQMY/+bsfnVKNY7hNDVTrPNGeeWvSKBTt/6w=;
        b=CuEbFsr9mXdAdK01cAhjVXNPZdDxkJxO45D7hw4Rq4NABNh97PDg+b0iYRUpbgUtJT
         ysdqviQTOuLSqXQZImAoMdyiTK/hHU4UJhXXimbfzFFcL+PCj7U6CnzE9MbLkb+lRzSn
         9u9vrjw3dlEaZX2Qdq8hN6UKtJvkMTy44v4ZIv+2W93k7/lsS+B7ILBlk5c3pAPwOlqT
         kqrb2xf5j0d7wTfokvn7v1/c6xeaUwtktMR71TU8MeJ9fDP5145RVvOqe13CZpEK3MHe
         p455YAu0J0dRUBx0IsijuAdlzOEJ1o8Wt9kx4aJolcSgM7xVhy0SD9mKLI7KmLf42qvF
         yOpA==
X-Gm-Message-State: AOAM533/wZKUWJAnPslcf4lPyIy3vQnl/TywtWgkDTkMaQ4BWtYWDUSr
        PaqAEVRKv6dIzZwn3oajEPVCxIGswBvhaFXAu0aUbA==
X-Google-Smtp-Source: ABdhPJwGZRXstRG2NgMYG0hFSTe89LWHITcBb74FWuHjiKJrodeo1tE1qaHQHTez8XVyFSt3zX7Yx29h1pErpyUZhEc=
X-Received: by 2002:a50:cc86:: with SMTP id q6mr21740872edi.78.1604396599677;
 Tue, 03 Nov 2020 01:43:19 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Nov 2020 15:13:08 +0530
Message-ID: <CA+G9fYsqbbtYXaw3=upAMnhccjLezaN7RUjysEF4QhS6TfRr-A@mail.gmail.com>
Subject: ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, linux-btrfs@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linux next 20201103 tag make modules failed for i386 and arm
architecture builds.

Error log:
  LD [M]  fs/btrfs/btrfs.o
  MODPOST Module.symvers
ERROR: modpost: "__udivdi3" [fs/btrfs/btrfs.ko] undefined!
scripts/Makefile.modpost:111: recipe for target 'Module.symvers' failed
make[2]: *** [Module.symvers] Error 1

Full build log,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-core2-32,label=docker-lkft/891/consoleText
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=am57xx-evm,label=docker-lkft/891/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org

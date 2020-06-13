Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBACE1F8430
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jun 2020 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgFMQCX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Jun 2020 12:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgFMQCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:02:22 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF1AC03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:02:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so14362008ljb.12
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 09:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=TcOTBtDqIOvW53qGgbVIKmtl2sjId6eSG9+9X/In+Buh646Nyu+AbSmt5zCbZYiS6Z
         zs7LTNKRsSHM5UNAGRJWX+7bEk2QHRX7S0/sh5vXeA4onZXm5ShmZt92/pnpx7CgTCUq
         95ZRvhbVaHCsuXxKnNyIA7pvF/DwucXEu1oOptUp95/2kfmchSan7UznB10PqgoxqRhO
         0sZeG05hJCNzVIuJqfKmxiGVTxHXBopHRMwo72QRBzZVEgnCHzoaCaP0cIcWwowq2QCB
         NhwoPQ52Pp3OqPokHjSr+03sO8CUIUhR/7RA2z7jDgVM9MHzAbCy8gl+2itTzDsa8Uz9
         9BBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=gt10UL8ppRWmEUMDLppHSyEqHbDEHGW+8w2n1j2KuOp2nj47egY3TnXIK8U+bsgsoi
         bcaGnIkCDP3DyWuuVSyF8HkNMj94hJiBFhbyvqBt7T/6XNOOecv4y5O5buZ2YtPagjuY
         qU0nlbS+7fV8ylM/nIcIdkKwWxPE8RkXjUrwBCffMBK1s5LLrTPVkgVDxGnCNvgPdFiC
         h9pyVJYG8DZcSEe9NsoiHL9XgLI/BOdxeOVo25Ie7baoTy64GTP0SZLokm6n3gWWw+tR
         nv54pf0gg8WteRWiYphzuu4sLLCkwrVuHp67+eVmfVSzPrxDRtd+JKKUVR4InvEyIW6b
         ekzA==
X-Gm-Message-State: AOAM531z0976Dg/uve1/7lmwM55v6nLmHCajNOCfhlgba38CnuweNqZC
        ni1LPyuBE9uu0SrKQ5lM22T8zrVKgnxdwDGNklI=
X-Google-Smtp-Source: ABdhPJxY/L0/G2OiwB9o/YsdwlKqXO2KcHMlsiSvKFQCUZl4TpfhJ5OTcmqO7VCqdDun4SrOacfSMbHB34T4dpwqQD4=
X-Received: by 2002:a2e:b0e9:: with SMTP id h9mr9477446ljl.460.1592064138955;
 Sat, 13 Jun 2020 09:02:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:804e:0:0:0:0:0 with HTTP; Sat, 13 Jun 2020 09:02:17
 -0700 (PDT)
Reply-To: robertandersonhappy1@gmail.com
From:   robert <nnadinawafo11@gmail.com>
Date:   Sat, 13 Jun 2020 09:02:17 -0700
Message-ID: <CAPhDfr3wY-cwQU8nE-KU43p=yFT8vFXJ1QUncrhe2fLncrbG=g@mail.gmail.com>
Subject: =?UTF-8?B?0JTQvtGA0L7Qs9C+0Lkg0LTRgNGD0LMsINCc0LXQvdGPINC30L7QstGD0YIg0JHQsNGA?=
        =?UTF-8?B?0YDQvtCx0LXRgNGCINCQ0L3QtNC10YDRgdC+0L0uINCvINCw0LTQstC+0LrQsNGCINC4INGH0LDRgdGC?=
        =?UTF-8?B?0L3Ri9C5INC80LXQvdC10LTQttC10YAg0L/QviDRgNCw0LHQvtGC0LUg0YEg0LrQu9C40LXQvdGC0LA=?=
        =?UTF-8?B?0LzQuCDQv9C+0LrQvtC50L3QvtC80YMg0LrQu9C40LXQvdGC0YMuINCSIDIwMTUg0LPQvtC00YMg0Jw=?=
        =?UTF-8?B?0LjRgdGC0LXRgCDQmtCw0YDQu9C+0YEsINGB0LrQvtC90YfQsNC70YHRjywg0L/RgNC40YfQuNC90LAs?=
        =?UTF-8?B?INC/0L4g0LrQvtGC0L7RgNC+0Lkg0Y8g0YHQstGP0LfQsNC70YHRjyDRgSDQstCw0LzQuC4g0Y8g0Lw=?=
        =?UTF-8?B?0L7Qs9GDINC/0YDQtdC00YHRgtCw0LLQuNGC0Ywg0LLQsNGBINC60LDQuiDQkdC10L3QtdGE0LjRhtC4?=
        =?UTF-8?B?0LDRgNCwINC4INCx0LvQuNC20LDQudGI0LjQtSDRgNC+0LTRgdGC0LLQtdC90L3QuNC60Lgg0LIg0Lw=?=
        =?UTF-8?B?0L7QuNGFINGB0YDQtdC00YHRgtCy0LDRhSDQv9C+0LrQvtC50L3QvtCz0L4g0LrQu9C40LXQvdGC0LAu?=
        =?UTF-8?B?INGB0YLQvtGP0YLRjCDQutCw0Log0LXQs9C+INCx0LvQuNC20LDQudGI0LjQtSDRgNC+0LTRgdGC0LI=?=
        =?UTF-8?B?0LXQvdC90LjQutC4INC4INGC0YDQtdCx0L7QstCw0YLRjCDRgdGA0LXQtNGB0YLQstCwLiDQvtGB0YI=?=
        =?UTF-8?B?0LDQstC40LIg0LTQtdC90YzQs9C4INC90LDRgdC70LXQtNGB0YLQstC+INGB0LXQvNC4INC80LjQu9C7?=
        =?UTF-8?B?0LjQvtC90L7QsiDQv9GP0YLQuNGB0L7RgiDRgtGL0YHRj9GHINC00L7Qu9C70LDRgNC+0LIg0KHQqNCQ?=
        =?UTF-8?B?INCU0L7Qu9C70LDRgNGLICg3IDUwMCAwMDAsMDAg0LTQvtC70LvQsNGA0L7QsiDQodCo0JApLiDQnNC+?=
        =?UTF-8?B?0Lkg0L/QvtC60L7QudC90YvQuSDQutC70LjQtdC90YIg0Lgg0LfQsNC60LDQtNGL0YfQvdGL0Lkg0LQ=?=
        =?UTF-8?B?0YDRg9CzINCy0YvRgNC+0YHQu9C4INCyICLQlNC+0Lwg0LHQtdC30LTQtdGC0L3Ri9GFINC00LXRgtC1?=
        =?UTF-8?B?0LkiLiDQoyDQvdC10LPQviDQvdC1INCx0YvQu9C+INC90Lgg0YHQtdC80YzQuCwg0L3QuCDvv70=?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



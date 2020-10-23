Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F1D729793D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757072AbgJWWPv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:15:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757065AbgJWWPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:15:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD11C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:15:50 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id x13so2425309pgp.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=gvcpOYVNoSdIulRrMy67TySZurny5+X8+hqm+qjo1EE=;
        b=XPojyT1soGYGA3mm8Dte/lMaSHlqgZt6TiZNuQre554b/c2837SVr4yZhUOqnqqGde
         XEkic7nunFSTm7q4Eqi9El2KWog1DMa3rzuzy8pu9eDzFq7Pme6f4YlMi+TCDzGLyWxf
         2t7+KZ3vPHfvOX3wiUtyInDv3obc5iYOSbbLEnjOq77rUY+eppCzzM+1G4eAEMAHmfKf
         zg27p6Ge2HXNKAOJB0PCz54qAeTBmQIBdQYo3Nnig1xmIEQEGLlsdZbE6iDw320XiYIu
         Xak/p7zlaiCiPxmOdIwtF5WjtOVhtF4O/FRz7s30SXo+C1I5gCz3s/7kFCByepnibgiK
         BvkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=gvcpOYVNoSdIulRrMy67TySZurny5+X8+hqm+qjo1EE=;
        b=BImlkn550abnrjC+sTWrLJnWntB0MabtApWKJ78fQgTndcXaoFf7Z5UMu/WFnMKZ+u
         W7xIlI13F/KBXVnFmQC4xEHjpN1oIvzUWQL+95p9oAWe0vcRX33HMaDpgPbcKh0B7I7D
         w+L2aF/3KgdENyBmIRqXkKFL1aznOqijetqGraWWpPWQ1Ja1udecTQhhtEOwhY55PVCO
         hTJ15YvGdVVKawJXD7QGvtXAO6Ct0L6wNEZ9S5/ST3Sb8dG08YiocIJTLGHNKM/K7rvV
         hz2Wwng17NRlVDsq8tQEHcKfWPK8mriz4uxbtUeApV7FU2UXtBMqaPrsl0d4FqC6PBVr
         67Dw==
X-Gm-Message-State: AOAM533GhjI/3HI0l4J+ZMh1MXuPizkUqx6Jdl99X3zWOHoPShFFdNKd
        W2U7AYX+CR9eegiHFMGM4eHDD/ZZ5rihaw==
X-Google-Smtp-Source: ABdhPJzmhpFPSu/h0c9pDy21scVCncXvLU3OuaFiTVXAwisL7uB0/WX2uUXcRdONyQsy35KhxlIyrA==
X-Received: by 2002:a17:90a:1596:: with SMTP id m22mr4899132pja.189.1603491349613;
        Fri, 23 Oct 2020 15:15:49 -0700 (PDT)
Received: from [192.168.1.134] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id 92sm3737975pjv.32.2020.10.23.15.15.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Oct 2020 15:15:48 -0700 (PDT)
To:     xiaoyao.li@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: allyesconfig broken in -git
Message-ID: <ef29daba-7c77-4e6e-ab31-a0bd126b71fb@kernel.dk>
Date:   Fri, 23 Oct 2020 16:15:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Trying to do the above results in:

ld: drivers/block/paride/paride.o: in function `pi_init':
(.text+0x1340): multiple definition of `pi_init'; arch/x86/kvm/vmx/posted_intr.o:posted_intr.c:(.init.text+0x0): first defined here
make: *** [Makefile:1164: vmlinux] Error 1

because commit:

commit 8888cdd0996c2d51cd417f9a60a282c034f3fa28
Author: Xiaoyao Li <xiaoyao.li@intel.com>
Date:   Wed Sep 23 11:31:11 2020 -0700

    KVM: VMX: Extract posted interrupt support to separate files

added another pi_init(), though one already existed in the paride code.

-- 
Jens Axboe


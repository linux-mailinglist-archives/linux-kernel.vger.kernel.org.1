Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20742CA7FE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 17:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404089AbgLAQRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 11:17:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388364AbgLAQRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 11:17:24 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6CCC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 08:16:38 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id p6so1390688plr.7
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 08:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keKgMbCkoGOXeTFvWr8odCNv42gYD1NHpH65Gpi3cCA=;
        b=pOQ4NjzPVp6iisrE9P9gGQG6wNSldY4e18fm6iUbeVrUS7EJ37dp6TsrrKURZ/aNde
         ry5rJrSim0HZoWiOXMWIRmBirNoa7cEORhW5l6j4dxpbpUJT/lQTnPtzP68AnJGbBJU9
         kFxi3hT3dbZM32tJteH0PEpmZ3owWh7NtAIf8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keKgMbCkoGOXeTFvWr8odCNv42gYD1NHpH65Gpi3cCA=;
        b=GOrf4RRQpvwTpk7goClQ5vr505QlIzQxI59jss6zpNPmxaPi0v757kkaxb9aKTRZzX
         1RTSegZ7k6X9PnZ36LOWD4Sa0bm4JS/kXFyei5g3AJcCrAo87lPFQCnnQoVoDg2ZyPSH
         S17TBCHINJ3F7cComNg2KVtqOuya7n9LtvD1gzNrv9n8mvWsgYQkOTx6dJDjUUGkMo6D
         wlnvE7AT1AWteQA9LeYZ7UiKFCD+6cxP/BuGmouDk/8YdOFzfXjiT6/TMPGXRHsDKseO
         TS2K4tTS0QsfZ+3XeHlrcBcJ93eacTRNAuA9WA1ViZLIEmtE40OVE4QMTYUzS56egb3k
         aOGw==
X-Gm-Message-State: AOAM533yDlrD0wH+G6C6y0yk0LFPFWiWS82w/1/8jMPS+YPyIhRVJ1UV
        19yTw/ueA2/fFmMaNUq0iL+ZGPEcdeyAdA==
X-Google-Smtp-Source: ABdhPJw8p/fYmmJr1JIB/2o9aL9RGNVV5xtAOwCWgAXwUflXsCj28scQTc16C3z6SmRwv4gaC0Apuw==
X-Received: by 2002:a17:90b:a14:: with SMTP id gg20mr3560478pjb.46.1606839397634;
        Tue, 01 Dec 2020 08:16:37 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-f932-2db6-916f-25e2.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:f932:2db6:916f:25e2])
        by smtp.gmail.com with ESMTPSA id r11sm82914pgn.26.2020.12.01.08.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 08:16:37 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        christophe.leroy@c-s.fr, aneesh.kumar@linux.ibm.com,
        bsingharora@gmail.com
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [PATCH v9 0/6] KASAN for powerpc64 radix
Date:   Wed,  2 Dec 2020 03:16:26 +1100
Message-Id: <20201201161632.1234753-1-dja@axtens.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building on the work of Christophe, Aneesh and Balbir, I've ported
KASAN to 64-bit Book3S kernels running on the Radix MMU.

This is a significant reworking of the previous versions. Instead of
the previous approach which supported inline instrumentation, this
series provides only outline instrumentation.

To get around the problem of accessing the shadow region inside code we run
with translations off (in 'real mode'), we we restrict checking to when
translations are enabled. This is done via a new hook in the kasan core and
by excluding larger quantites of arch code from instrumentation. The upside
is that we no longer require that you be able to specify the amount of
physically contiguous memory on the system at compile time. Hopefully this
is a better trade-off. More details in patch 6.

kexec works. Both 64k and 4k pages work. Running as a KVM host works, but
nothing in arch/powerpc/kvm is instrumented. It's also potentially a bit
fragile - if any real mode code paths call out to instrumented code, things
will go boom.

There are 4 failing KUnit tests:

kasan_stack_oob, kasan_alloca_oob_left & kasan_alloca_oob_right - these are
due to not supporting inline instrumentation.

kasan_global_oob - gcc puts the ASAN init code in a section called
'.init_array'. Powerpc64 module loading code goes through and _renames_ any
section beginning with '.init' to begin with '_init' in order to avoid some
complexities around our 24-bit indirect jumps. This means it renames
'.init_array' to '_init_array', and the generic module loading code then
fails to recognise the section as a constructor and thus doesn't run
it. This hack dates back to 2003 and so I'm not going to try to unpick it
in this series. (I suspect this may have previously worked if the code
ended up in .ctors rather than .init_array but I don't keep my old binaries
around so I have no real way of checking.)


Daniel Axtens (6):
  kasan: allow an architecture to disable inline instrumentation
  kasan: allow architectures to provide an outline readiness check
  kasan: define and use MAX_PTRS_PER_* for early shadow tables
  kasan: Document support on 32-bit powerpc
  powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
  powerpc: Book3S 64-bit outline-only KASAN support



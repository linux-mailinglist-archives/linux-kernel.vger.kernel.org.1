Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCD72D4D84
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 23:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388621AbgLIWYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 17:24:03 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:40916 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388604AbgLIWXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 17:23:51 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kn7rW-0008DE-P6
        for linux-kernel@vger.kernel.org; Wed, 09 Dec 2020 22:23:06 +0000
Received: by mail-io1-f72.google.com with SMTP id t23so2495266ioh.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Dec 2020 14:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=nCPT21aBYHK+VmSNH6RsExkU8pXC3B3JSnVf9A2XUAw=;
        b=VlCchNEpxb0RiLFZymnTstdml18zKCl9c26T53Z0qzsBYLB4DjE+ls5mwlv+iwYAZ0
         QC8S1fuVknyB1kK8rkjvZXkFH6QLtQW049Ep0YkPgbbF7h/CFb+BoUS0ZUSzsCiUB2fO
         renvyjq47oSQWGUDYduu4Cqt2O7fEFaz8rw41D6asZ/adoBlo3jceF0IOPRtw+iDITPD
         LDfbnKL5asvUsFvIrjElAbbm3RzzZ5YM051fidTplIvS7SFn5/V89Ns5pkB8I2lO7YrA
         m+hlNdNxL662eHcxxK+M6BYKCCM2aMHTkx9/WMEizkTwbDPASXOKVAiUOUBVNTy6ceq7
         S15A==
X-Gm-Message-State: AOAM530ep3Ip5R1YsUg2GHftE5GKupDhiIASdvUMdpGUEjXXcbw8RQC1
        pigHLE0j8tT4dWcoPq4Jwoh0En2c4fUTB4IpECY9jBrK+VYmo+sDUnWs4kWvp2jhBfLe2/hjHBX
        vuB42vEXJWYwjLpE8Cqcq+A6QysYY0xuagbFdfFLbWg==
X-Received: by 2002:a5d:9507:: with SMTP id d7mr5636562iom.32.1607552585835;
        Wed, 09 Dec 2020 14:23:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPHEVz4M/SVZNUt1nS2IcUlOCb7v1fywa1vG7vTZjQwq6m0YhMMXsMPX3MpNt78iFWUndNBA==
X-Received: by 2002:a5d:9507:: with SMTP id d7mr5636527iom.32.1607552585581;
        Wed, 09 Dec 2020 14:23:05 -0800 (PST)
Received: from localhost ([2605:a601:ac0f:820:f6e7:e083:7e01:5905])
        by smtp.gmail.com with ESMTPSA id e1sm1528753iod.17.2020.12.09.14.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 14:23:05 -0800 (PST)
Date:   Wed, 9 Dec 2020 16:23:04 -0600
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: BPF selftests build failure in 5.10-rc
Message-ID: <X9FOSImMbu0/SV5B@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building the BPF selftests with clang 11, I'm getting the following
error:

   CLNG-LLC [test_maps] profiler1.o
 In file included from progs/profiler1.c:6:
 progs/profiler.inc.h:260:17: error: use of unknown builtin '__builtin_preserve_enum_value' [-Wimplicit-function-declaration]
                 int cgrp_id = bpf_core_enum_value(enum cgroup_subsys_id___local,
                               ^
 /home/ubuntu/unstable/tools/testing/selftests/bpf/tools/include/bpf/bpf_core_read.h:179:2: note: expanded from macro 'bpf_core_enum_value'
         __builtin_preserve_enum_value(*(typeof(enum_type) *)enum_value, BPF_ENUMVAL_VALUE)
         ^
 1 error generated.
 llc: error: llc: <stdin>:1:1: error: expected top-level entity
 BPF obj compilation failed

I see that test_core_reloc_enumval.c takes precautions around the use of
__builtin_preserve_enum_value as it is currently only available in clang
12 nightlies. Is it possible to do something similar here? Though I see
that the use of the builtin is not nearly so neatly localized as it is
in test_core_reloc_enumval.c.

Thanks,
Seth

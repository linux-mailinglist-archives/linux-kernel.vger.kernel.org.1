Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDE9026CA2F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgIPTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 15:50:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:35037 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgIPTro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:47:44 -0400
Received: from mail-oo1-f70.google.com ([209.85.161.70])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <seth.forshee@canonical.com>)
        id 1kIdOy-0002qF-7a
        for linux-kernel@vger.kernel.org; Wed, 16 Sep 2020 19:47:36 +0000
Received: by mail-oo1-f70.google.com with SMTP id n6so3476239oos.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 12:47:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=9DTlUMQXUmYJrnQP6eQ/0rjf2Cvpn5CNN8DUo3rzLVw=;
        b=fZxkCvNcldN6miR4C2S5GBI5seXaAQ+ZlnxGgsoj+M/SWDYgj3RQFLp7sMgh/o21BT
         6exKeNyv72FaoPIlrAtqwuGxiTp9vju/OraRHJ9/j8WCUMJvv2mDmS4VqSSe3edNwmFi
         u0Et882m3c2QCE6qOGcA/zD1xvZTHL1lpshWvBwteJh8tTgU9mcX9+VS3zlioc5jzvDi
         +lwUs7+ZaahtBWeVyRE87XJSE+Ju8ZL8ou6P4Pu+35wThV/MaQC93nZDjlb41dRCTjVa
         jkxeGsh12sqikZZYbJL4JRb2YoTXB+cQNgXBtwlfRDkS4i0iyYPFBVD9ksAAJlaAIVXM
         NX+g==
X-Gm-Message-State: AOAM532WpGWRyHYWmfTP8s9Urt3HvlfFKICi79/B8lmIX3NQMpdQM254
        TJA0s5jqmuopLFkGfCxae2/0/6/JJcu472vXTOMKddeTCxc1Dy9PM6cYX+IjjTrpiaNEmenPBjk
        EaPBeqeWCVyAo7zY4l7KzukOAl5n1pAHYZ39fKh4Jtg==
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr4373479oij.92.1600285655136;
        Wed, 16 Sep 2020 12:47:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKw+wXmBG1oNv0ozyloHVqvmTAv80Lf/litTjvvMwgITJt/qOwX4GwXGPYo9+4OovuahX0Gw==
X-Received: by 2002:a05:6808:8c1:: with SMTP id k1mr4373469oij.92.1600285654807;
        Wed, 16 Sep 2020 12:47:34 -0700 (PDT)
Received: from localhost ([2605:a601:ac0f:820:2228:e36:da90:6c9])
        by smtp.gmail.com with ESMTPSA id x21sm8777870oie.49.2020.09.16.12.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:47:34 -0700 (PDT)
Date:   Wed, 16 Sep 2020 14:47:33 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: resolve_btfids breaks kernel cross-compilation
Message-ID: <20200916194733.GA4820@ubuntu-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The requirement to build resolve_btfids whenever CONFIG_DEBUG_INFO_BTF
is enabled breaks some cross builds. For example, when building a 64-bit
powerpc kernel on amd64 I get:

 Auto-detecting system features:
 ...                        libelf: [ [32mon[m  ]
 ...                          zlib: [ [32mon[m  ]
 ...                           bpf: [ [31mOFF[m ]
 
 BPF API too old
 make[6]: *** [Makefile:295: bpfdep] Error 1

The contents of tools/bpf/resolve_btfids/feature/test-bpf.make.output:

 In file included from /home/sforshee/src/u-k/unstable/tools/arch/powerpc/include/uapi/asm/bitsperlong.h:11,
                  from /usr/include/asm-generic/int-ll64.h:12,
                  from /usr/include/asm-generic/types.h:7,
                  from /usr/include/x86_64-linux-gnu/asm/types.h:1,
                  from /home/sforshee/src/u-k/unstable/tools/include/linux/types.h:10,
                  from /home/sforshee/src/u-k/unstable/tools/include/uapi/linux/bpf.h:11,
                  from test-bpf.c:3:
 /home/sforshee/src/u-k/unstable/tools/include/asm-generic/bitsperlong.h:14:2: error: #error Inconsistent word size. Check asm/bitsperlong.h
    14 | #error Inconsistent word size. Check asm/bitsperlong.h
       |  ^~~~~

This is because tools/arch/powerpc/include/uapi/asm/bitsperlong.h sets
__BITS_PER_LONG based on the predefinied compiler macro __powerpc64__,
which is not defined by the host compiler. What can we do to get cross
builds working again?

Thanks,
Seth

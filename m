Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2FF273249
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 20:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgIUS4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 14:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47539 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726395AbgIUS4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 14:56:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600714607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=pWkNANwFp8KVnuJc5tgcb5hxDfStvMJRcSA/c6Kt/yw=;
        b=HTiguvWWnr7HIylND5tUTgt/4QB8xcaEVbomiKXTVKpJB9MmIarjyR7ef9FzrzIsDhCCH2
        wt2eKWY7+XASsXjtWiLYzFPXAhluiTpFu5bBC+/7Fd0pI3MEmI32xlmtUUdP7xSWUHqicm
        9aJd1gXhjlEq2U5qOKgRajhs9E5SmAA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-cKEdUrCwPQOi5uNt57d9hA-1; Mon, 21 Sep 2020 14:56:45 -0400
X-MC-Unique: cKEdUrCwPQOi5uNt57d9hA-1
Received: by mail-pj1-f69.google.com with SMTP id gc24so425781pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 11:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:date:message-id
         :mime-version;
        bh=pWkNANwFp8KVnuJc5tgcb5hxDfStvMJRcSA/c6Kt/yw=;
        b=svSbgvcae70Remr0CV11YdDDpXezwkbWkOM2xRTb8NKR7lupvrEv5XVy3FUKxF/ZvK
         vvdCzFh1f+y0g1Sz//OlnZRZQFjOcNDpnHoreHy2j/N72y5MiQ2ARXxhLBjGItPS6zNG
         dbErxaOjx6VIL2ma62jRR/VvvOAngOD4kyo8It6ZkJJBuFBKnQFQCZ06ZHJM08dBflBZ
         RCpnpTlafIQTCstT6S3hOzOq96Ktd46rDKPuRdUvqhaAVHNhvfqx2gL7hZ7i4jdgB5Cg
         Gmb583jrZKiWSx5agkuie5VRxIUeZHjuHae02VAg/566/UafaC5+LMwmHmeO8C1aE4Jz
         kdNA==
X-Gm-Message-State: AOAM5326C4rL0CShDVluXxm1EICf4OUm5zxwixYIPw/bkJFC4kNjfSGZ
        ZYHOMkXr79I9WDLf5ZgqJa8AUqlvqHIr60Z3f6uyTkuvFi7QSDGCupJbNlMpz0u2VVQhbg11Xy5
        DVG8SqyQ0EmLlH6JuJCRteoqx
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id v7-20020aa799c70000b029013ed13da056mr1065261pfi.28.1600714604909;
        Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzGtS9wJP1qEjTL2vZQLuVGFgxGjE7bi7YLAPHtKyeJGP8o7s+XsIA0TtINV5U5VfRwMCqwGw==
X-Received: by 2002:aa7:99c7:0:b029:13e:d13d:a056 with SMTP id v7-20020aa799c70000b029013ed13da056mr1065245pfi.28.1600714604684;
        Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id j9sm12285498pfc.175.2020.09.21.11.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 11:56:44 -0700 (PDT)
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>,
        Adrian Huang <adrianhuang0701@gmail.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: kdump boot failing with IVRS checksum failure
Date:   Mon, 21 Sep 2020 11:56:42 -0700
Message-ID: <87o8lzvtzp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Joerg,

We are seeing a kdump kernel boot failure in test on an HP DL325 Gen10
and it was tracked down to 387caf0b759a ("iommu/amd: Treat per-device
exclusion ranges as r/w unity-mapped regions"). Reproduced on 5.9-rc5
and goes away with revert of the commit. There is a follow on commit
that depends on this that was reverted as well 2ca6b6dc8512 ("iommu/amd:
Remove unused variable"). I'm working on getting system access and want
to see what the IVRS table looks like, but thought I'd give you heads
up.

Regards,
Jerry


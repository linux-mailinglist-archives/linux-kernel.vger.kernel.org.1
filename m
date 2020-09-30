Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A40627DD6A
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 02:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbgI3Afr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 20:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgI3Afq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 20:35:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 581E1C061755;
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m34so5381120pgl.9;
        Tue, 29 Sep 2020 17:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LQdI0KJeifkWmziJ1KKn/3OkC7DNIF2gUIHKqRdQ2No=;
        b=COpFGQAUJ3szg36uk+5qopcDl+hjq6PhY+7+jCoz1ihc2jigTeQyhRxgHGeL5BcDhg
         2kEKVntCA3nl+RMU046/O/2qBso/6JJua47NOu9yi/gI3TUhG8CE4mCD+MLABEV6gXho
         8EtBVmpUc0EOmjeoOjg2SM7z95mdP2zz8gi/5wQZPRDwSNE5/eNLb88zg8OHqo1N0oO4
         XHN0XTpjxG/Rfe6mEDX43ti5n5+e+Zsf/4qbVysWUXnQPT8uLj/QiLgW3xZbSiU/9bTF
         G8ouAw0zzuiN/jrH7n41AFC4Z1X1btFsUNZZvmI82Zxu0dTTorjFmCOTyWJar5krdem3
         lxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LQdI0KJeifkWmziJ1KKn/3OkC7DNIF2gUIHKqRdQ2No=;
        b=emoeJ1jg0bbXyb+tY8UGgboc7jlFt8dOPYZK6wl4hDFeIbJP9kMgRMCqs9kI8CpqIx
         UG2p4HmvzAj6vXxF90SUYi3oK8Ah+4w4p84sGXvrQ4ulNb5lwAzNqtxWgMZb/dYOTINE
         Ght6o4LmKYqv1BYu4uaRT0tMsKhV8tb9oyn66CxbUKNHQLh/91v+PejSFI3ZnhFDvDoS
         3E0y3S0ZHqMA4lr/cVrrM4ambj4Qqt6RbENyahuMMekSm8urAJ8U6kfIahtd4vraeEnN
         zh0Ket17Alf3yL6sfRCSRLlno9GW1dWV2C3MuMuu0SXbGfnghkFmCisv/jit08W8dIkF
         J0sA==
X-Gm-Message-State: AOAM530bDpPOtDAcdW3f8gYwlkx5EDBQxVVOwJElZenVdsvmFtUjRZsC
        Chx7DaNbESw2RYMv9WVhRi6EiY++Npc=
X-Google-Smtp-Source: ABdhPJwUklEQdqfwvZZtfMtagP7cPb6ScYPheOd9v+vPXqgLW6Q0BFn78D4uerB2Nem22xypmGh3GQ==
X-Received: by 2002:a63:8f18:: with SMTP id n24mr125903pgd.209.1601426144665;
        Tue, 29 Sep 2020 17:35:44 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id x185sm6904738pfc.188.2020.09.29.17.35.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 17:35:44 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org,
        digetx@gmail.com
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] iommu/tegra-smmu: Add PCI support
Date:   Tue, 29 Sep 2020 17:30:10 -0700
Message-Id: <20200930003013.31289-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series is to add PCI support with three changes:
PATCH-1 adds a helper function to get mc pointer
PATCH-2 adds support for clients that don't exist in DTB
PATCH-3 adds PCI support accordingly

Changelog
v1->v2
 * Added PATCH-1 suggested by Dmitry
 * Reworked PATCH-2 to unify certain code

Prvious versions
v1: https://lkml.org/lkml/2020/9/26/66

Nicolin Chen (3):
  memory: tegra: Add helper function tegra_get_memory_controller
  iommu/tegra-smmu: Rework .probe_device and .attach_dev
  iommu/tegra-smmu: Add PCI support

 drivers/iommu/tegra-smmu.c | 177 +++++++++++++------------------------
 drivers/memory/tegra/mc.c  |  23 +++++
 include/soc/tegra/mc.h     |   1 +
 3 files changed, 84 insertions(+), 117 deletions(-)

-- 
2.17.1


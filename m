Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB7B2797C6
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 10:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbgIZIMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725208AbgIZIM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 04:12:29 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94698C0613CE;
        Sat, 26 Sep 2020 01:12:29 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x22so5260990pfo.12;
        Sat, 26 Sep 2020 01:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=RqGonHimm7XKXd4Ikem1uzvHdZOfGO32j99S5gvNitA=;
        b=j7IRl9KG/Se58SYA6QuKBw/YmiREdDFLHKttC0OcR475GvqIUmNwYl4EH6zKZRjWl4
         UQwJt9nQm2pxOy/cEOr3j3PKZn+0ERaK79LiLsWCHjm304oGXxjYEEcsDN56k2eKixfa
         hscI3xgUxuMp+t4T8gCXGGJvGmOPX2361HMj428IIAj83DHM1sXEuQCHZva8YCBaun89
         6KRJ9Pbqp8czbZzATMwH0ToUTTkrUfvfyJrEWMq7k7lUTuneSPuS8oFfoxmGSwABPngq
         ViS9j5mnTvkWndOh2eSLtjE26QFp35ccwIZh6u44Lz7Mo4g0X7aKAJW0CC9p96YclRt+
         ftCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=RqGonHimm7XKXd4Ikem1uzvHdZOfGO32j99S5gvNitA=;
        b=CqP9lK0KuFevaZhtbtQgEQETvg6aeCCtPTT6cy+2ZglrQF/NadYQHUviwbhmTKmG0U
         7L/t1sN4hJl7H9PRJV/l2rgNWg8N8viaIe7rJeUUJ4uoJtnS5CNreVcbmogXpaj/ak0T
         8oon9CS4hZ+EvQOrwlIG9bCGFFCGGafDJdrxLOCK3Y8L8JV4Bo7IFLpKp7qHAbqwmkss
         FeztjF+j+IixRnWCHvzWY3yXg53OrD1XTq5FHf8hu/SQ2hSnXn/5kpLIaC9SeMM6hb7r
         y1/1/nCng9rt0zUW5YDOn9x5lByk4Va7xdXkr819wn/z7n6oRMkIW9sTlRSoPCAOWZNU
         ygqg==
X-Gm-Message-State: AOAM532R48yfzwUxTZX5imkZHNw8QHb28ewl0XEn/T8fUTzlIOdnhuAU
        MdM7Kypy+9RRFVefOBnHC0U=
X-Google-Smtp-Source: ABdhPJy9a1WcIQBjVdYr5QAtqHP0TJd+SJ/l8Mqb8n6WGtKnDdwx1qDk93Bdrq7G0FwZSdF8jpKI0g==
X-Received: by 2002:aa7:97a8:0:b029:13e:d13d:a105 with SMTP id d8-20020aa797a80000b029013ed13da105mr2189367pfq.33.1601107949029;
        Sat, 26 Sep 2020 01:12:29 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id i1sm4833497pfk.21.2020.09.26.01.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 01:12:28 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     thierry.reding@gmail.com, joro@8bytes.org, krzk@kernel.org
Cc:     vdumpa@nvidia.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] iommu/tegra-smmu: Adding PCI support and mappings debugfs node
Date:   Sat, 26 Sep 2020 01:07:14 -0700
Message-Id: <20200926080719.6822-1-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of patches are some followup patches for tegra-smmu.

There are four parts:
1, PATCH-1 is a clean-up patch for the recently applied SWGROUP change.
2, PATCH-2 fixes a potential race condition
3, PATCH-3/4 adds PCI device support
4, PATCH-5 adds a debugfs node for phys<=>iova mappings

Each of the four parts is sort of functional independent, so we may
apply them separately or incrementally depending on the reviews.

Nicolin Chen (5):
  iommu/tegra-smmu: Unwrap tegra_smmu_group_get
  iommu/tegra-smmu: Expend mutex protection range
  iommu/tegra-smmu: Use iommu_fwspec in .probe_/.attach_device()
  iommu/tegra-smmu: Add PCI support
  iommu/tegra-smmu: Add pagetable mappings to debugfs

 drivers/iommu/tegra-smmu.c | 287 ++++++++++++++++++++++++++++---------
 drivers/memory/tegra/mc.c  |   2 +-
 include/soc/tegra/mc.h     |   2 +
 3 files changed, 221 insertions(+), 70 deletions(-)

-- 
2.17.1


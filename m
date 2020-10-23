Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA0D29794D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 00:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757129AbgJWWbn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 18:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757073AbgJWWbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 18:31:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B832C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id b26so2633247pff.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 15:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tsS1mku/LR8P3kDZQ8K26xZUVXqaC4M+JqGGn6cxsw=;
        b=hNr7DfDPm3FbEu1yIgQZkf3bFuKa6gtreN5RlPpg2kzI+QKy9r4NfCWnOLrrQce8LA
         h+kcNovbHvN2pZHFy8lspCkt5FcemVE6Zu5udT/i8wZmT+cpJ16Crz9IaIzyMcJp3JW+
         ztf0H/HGdLU8er13BJAt++AYRvdVH/zFyg21i97pODOdDPMcTHZxCqZBCBS+WOB+4uwa
         JQImIrC8ua3tKg0s97WLNuxOcmEBBDb2uEq/KUULt+IPzEFJzNq7j9Tm628dX1RLJcW1
         /GtoQLPcuET0lwY0+N7+LgT6AztJnY+DfsjRBEeF/UtfOL9aWLwAQsnOIjNNpgTCXmlQ
         1L/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7tsS1mku/LR8P3kDZQ8K26xZUVXqaC4M+JqGGn6cxsw=;
        b=HWtjhfkgbCgAzIc69ZMzdAXGqNdNg+509QFD8ZrROujj6Kxtlr+A+e5y7MHfF4EDAt
         icYjg02whWrx5OhzVaOz0fML+3r/MXXQ/UHKJCPMj1SWFW2aO8gkxq/2sbNcuTWuGOmW
         EqGvwh73OcZxu8VpBFauGK1d/3LN00yBzLAiecD/d50opCfXXrd65Je8WTWv3HW1Dpvk
         yo83xEs/jt40lp6c3xU8YxiS7f+GDmSld2f3weiBlYbK2NpHrta7NH71qwIZ5i2CRT9B
         e7P/RnqbqmLK6IHTCu/NHfKXsNhtIACGreKFiFZ1OcmTQtlVCSdgrfI/XES2O67KeTpn
         KTmw==
X-Gm-Message-State: AOAM531hccBZIzXTT5bXf4DXtymKWswnd34zO4FDyQbcC/Cz5ysJEN/b
        qiYGYPPElRbsBVcJnZWBFvnQvg==
X-Google-Smtp-Source: ABdhPJzw48SqDGSgf8X/LqZqgxV70GwjoeMi8T4zSkY1xxqYaZnhdAJ7z9hHRwshLWzqmmG2yDDZIA==
X-Received: by 2002:a17:90a:f994:: with SMTP id cq20mr5367308pjb.173.1603492302316;
        Fri, 23 Oct 2020 15:31:42 -0700 (PDT)
Received: from lx2k.lixom.net (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id o15sm3406457pfp.91.2020.10.23.15.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2020 15:31:38 -0700 (PDT)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-arm-kernel@lists.infradead.org, arm@kernel.org,
        soc@kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL 0/5] ARM: SoC contents for 5.10
Date:   Fri, 23 Oct 2020 15:31:17 -0700
Message-Id: <20201023223122.19189-1-olof@lixom.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is the batch of pull requests for ARM SoCs this release cycle. It's
arriving late; I've been too busy the last few weeks -- I'll need to hand
over the lead to Arnd for a bit. As a result of that, the last batch of
fixes before last release are here as well, as the first branch.

Contents is about the same as usual, described in each pull request. There's
support for a handful of new SoCs this release, and some new boards, etc --
described in the DT tag.

There are also larger sets of cleanups for Samsung and TI platforms,
as well as removal of some non-DT platforms for i.MX. As a result,
the net add of lines isn't as large as it would otherwise have been.

Two minor merge conflicts in the soc and drivers branches, due to surrounding
changes. I've described the resolution in the corresponding pull request, but
they're straightforward.


Please merge, thanks!


-Olof




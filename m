Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FD92113BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 21:43:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGATnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 15:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbgGATnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 15:43:05 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F3EEC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 12:43:05 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id 59so16820400qvb.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 12:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IcM1DMlGqfWlbK8UuCKCj+3RGvppZHjO0rvw3+FNYz8=;
        b=n7SrIDjkqzJQ/t1cFkYddSp8OSB/MB3WbnI1/+6CRIR3pWGcsNXvXORcR36KT3meLf
         jVTSIWCAOvZDd0Rn8l+Ztb+VD28bDPqWWH0iBhfjF29jlr4xTfNSwSjJgZSntdcb3BhV
         +4YKDbfYJl7CAxeM79pdbjNzFhfLgsUqQeWsA/VVzGPkSRo4HsngQ/6ACmC9KuPcOL42
         XxVp1VQ+Zoe8BPvnmOeus6zOzC+Pv0wcPocf5nzmchP353OMkK4X9CGjlut9ey58krQW
         LKoQ+SONHvZap3NpnJP0TROXpg9IPnzS8tP+2j/kOdSt3VHz6OVkmqAyc+lFjUEpLlwm
         u1dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IcM1DMlGqfWlbK8UuCKCj+3RGvppZHjO0rvw3+FNYz8=;
        b=SjhMS8//UuwwpTTHPflLaVbRqxmFUiktSRnzO8cdLcUPWta1RJl9chwWL3/oB6tDMX
         dFmtFMogfthsmSqhO+vX8px78A0ktY+1Bp1qLTRnvRetQZGUqDlXerUCj/SOKchTGBmv
         +XXl/BvS1KsMMJj/lyVnRrAmxvCB4dwlljcq3j1Aray14GW6hePXxz1Hovt8vCS5WsaZ
         Chz69nPofjZ8PxsaU55V8wv1pKpb0GDwjNOJLrMPDl5JT7iIo5Y0dx4iEVqQcjQVFqDP
         6QvfLPEGqQdATt5CiXRoU9HNtLNOmxgFm/oioDXHSf2zmrXOB5xsIz1VVP87+rTYnuiU
         S0+w==
X-Gm-Message-State: AOAM532sgcAK9ar+1amLCKQ5B0cBxGpRLz4UDz3+5L/vPMi2eGcpTONL
        a7gfs5BIFQFyN3zglWb72vC/blMGADzG3Zk=
X-Google-Smtp-Source: ABdhPJzPalutlqWYI3wmwJAuvz1yfGGMg2yt0bni7xGT3ekm+eS/fzhY3dImgXXWx2aZwNW5Q+rQvQ4iBy6i7tM=
X-Received: by 2002:a0c:ea8f:: with SMTP id d15mr3737863qvp.95.1593632584303;
 Wed, 01 Jul 2020 12:43:04 -0700 (PDT)
Date:   Wed,  1 Jul 2020 12:42:56 -0700
Message-Id: <20200701194259.3337652-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v1 0/3] Fix dpm_list ordering issue due to fw_devlink optimization
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When commit 93d2e4322aa7 ("of: platform: Batch fwnode parsing when
adding all top level devices") enabled batch processing of fw_devlink to
optimize the parsing time, it caused a suspend/resume regression due to
the use of deferred probing early on at boot.

This series fixes the regression by avoiding the use of deferred probing
when optimizing fw_devlink parsing.

Saravana Kannan (3):
  driver core: Don't do deferred probe in parallel with kernel_init
    thread
  driver core: Rename dev_links_info.defer_sync to defer_hook
  driver core: Avoid deferred probe due to fw_devlink_pause/resume()

 drivers/base/base.h    |  1 -
 drivers/base/core.c    | 44 ++++++++++++++++++++++++++++++------------
 drivers/base/dd.c      |  5 -----
 include/linux/device.h |  5 +++--
 4 files changed, 35 insertions(+), 20 deletions(-)

-- 
2.27.0.212.ge8ba1cc988-goog


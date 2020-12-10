Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB3C2D588D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 11:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389061AbgLJKse (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 05:48:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388872AbgLJKsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 05:48:33 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B18EC0613D6
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:47:53 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id p4so3690049pfg.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 02:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1CLF3jhgzuG8CXsCmdXZEYaITzNoEWk6wc5CrYfURY=;
        b=MYtZnMZka/yCtbeqjEtHPQMPRp1pS+LV5yBBJOSv5CxwHvamurnZGghYtmeuTU8F61
         sDFbaTQ5Vh11gbpI41KxB+fM6OZ66qRVUMM00yzvye7KdgyP9tov+Pi9eAdXP0k5Qz7R
         uSrEc6Xw6liW70X0OkD8dzvMZDS8DkyvuyhmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/1CLF3jhgzuG8CXsCmdXZEYaITzNoEWk6wc5CrYfURY=;
        b=qdrILttu5HFcHl5HcAFpKifAjUxoOCqCi0TJa87b6Hvp5mJNIpbjE8QDU7oq7u+Eu5
         v2ziN80Yn1yZRcCpriNN8VceU7pP2sMe55lGy2byZNJvYKCQ0dEOehdYqIzQ6BsU8f0z
         KWyAq4V0sGePmm7uDYcWIjIvuduCLqByi6vmxHpEE3hx3WRGxkaQ899mJusefBvJm4z+
         J+ao4plkdyXFV3FJI40FIOnT0C2DicrCiFCE5J60YGnWzZ6Eeup6kI4nPr6ftLh2+OSt
         R6NIIbP/5if4P9Y3uuMOZQINItfUlEzPYEQKC/NEn5x23lBsoZfh3hNqdKZ8XF8gWV4H
         +tkQ==
X-Gm-Message-State: AOAM532EGefhhOv82vXG2sRdCTNJJDBOgpL5/F0+043O6dbtiw31Rd5I
        riFz4mpZJkk5OZPe4Ftx3IaykQ==
X-Google-Smtp-Source: ABdhPJz1UOPyHnOnpgetFP3LmdV2keXwZM75/Y/XQxXs0IUr220E0wzUZTDhvJvtJum/Y71jRrXerg==
X-Received: by 2002:a62:d142:0:b029:19e:6b61:7f80 with SMTP id t2-20020a62d1420000b029019e6b617f80mr6244596pfl.9.1607597272744;
        Thu, 10 Dec 2020 02:47:52 -0800 (PST)
Received: from ikjn-p920.tpe.corp.google.com ([2401:fa00:1:b:f693:9fff:fef4:a8fc])
        by smtp.gmail.com with ESMTPSA id y1sm6386658pff.17.2020.12.10.02.47.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 02:47:52 -0800 (PST)
From:   Ikjoon Jang <ikjn@chromium.org>
To:     linux-mediatek@lists.infradead.org, linux-usb@vger.kernel.org
Cc:     Zhanyong Wang <zhanyong.wang@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Ikjoon Jang <ikjn@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] Release allocated periodic bandwidth data from reset_bandwidth()
Date:   Thu, 10 Dec 2020 18:47:44 +0800
Message-Id: <20201210104747.3416781-1-ikjn@chromium.org>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


xhci-mtk releases allocated TT bandwidth data only when whole
endpoints of a device are dropped as there're only {add|drop}_endpoint()
hooks are defined. This patchset adds more hooks and releases all
bandwidth data from reset_bandwidth() path, not drop_endpoint().


Changes in v2:
- fix a 0-day warning from unused variable
- split one big patch into three patches
- bugfix in hw flags

Ikjoon Jang (3):
  usb: xhci-mtk: code cleanups in getting bandwidth table
  usb: xhci-mtk: delay association of tt and ep
  usb: xhci-mtk: fix unreleased bandwidth data

 drivers/usb/host/xhci-mtk-sch.c | 180 ++++++++++++++++++++------------
 drivers/usb/host/xhci-mtk.h     |  13 +++
 drivers/usb/host/xhci.c         |   9 ++
 3 files changed, 133 insertions(+), 69 deletions(-)

-- 
2.29.2.576.ga3fc446d84-goog


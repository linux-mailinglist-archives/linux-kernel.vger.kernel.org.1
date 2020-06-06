Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614C1F03FE
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jun 2020 02:35:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgFFAf6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Jun 2020 20:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbgFFAf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 20:35:58 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D306CC08C5C3
        for <linux-kernel@vger.kernel.org>; Fri,  5 Jun 2020 17:35:56 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id w14so9138963qkb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 17:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=eyZV87qhT8z+fcURL4hitHQnk0t0GkFKS/VqMAdkgqw=;
        b=WXYPfU+ixMBneVGXrA0oLJlYKz8PEbm8PCIMMTP6dwZMJZxm1O7zjq3BbCfu6NlqLC
         +TPuyvEqgvC9j0l8Pn5b658Eilu69ImBGHV34lPvD26ZohzDtEkrY62ImLklCUjcBaDA
         83aHhJxhm8gCXmPl289T/S1bA14tI1/IN5EcmOT5TeATLo6NNXkdaONs/bVj55s1O6Tf
         2N4Htz5tsRHBzBI/iOGAOJnavySrzRka8wX14Bu6IEwmmbePnX9FrhlyPhvWAA/uAGZw
         bP0tmHilekmfF1ZJmeAxArw/4E8m7vObhOitnlXm2aOyQDSromZVBZAx/gHsnq4UmkJq
         iVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=eyZV87qhT8z+fcURL4hitHQnk0t0GkFKS/VqMAdkgqw=;
        b=AWiq2uYwtjcZs/HpoHc9FnhIJGGQpXWpm6x7gT9xyhGqRETrfBGSDGivHOItTK6c5D
         75RppuO4Q9ly2zFr0qodi4qXioI+MBvWa539vCO0A/hUxXaDzh+nniqMw6g8C34K+EVK
         MePD0ib4D+5gvJkwcIB2OM9QOdVCer6LBNtYn38x5jUCdqJ9HOAo7LICuLzSjuH9o5VP
         kZd4iQOotVhHfv28XllFM0b6OTsdcyz5QWcL1pyZBu7tAeyodk+IOQRPYj8K7zx703Qb
         S6THfcBXrCEhvUGW22BjPXpcfpAKbH/cvEweOlkCbc1rYU1evaF8G6zX0Y9GNJnA0kSn
         FvAg==
X-Gm-Message-State: AOAM531OcDX0HYRl/FcqeMyc+kG/hkp+BiFb3PLYIwvFUxDb7Ny7hRvJ
        Waa0DR08cLV1ta5ed7DlNTvt9luWsTypvhY=
X-Google-Smtp-Source: ABdhPJwKNqLsko/t6NsDu6tdE8gWsgm6szCWMHdghVz6g2I480JWOCiRCDe3AesWpmQUT5L1VHe+Wxw7yYsoIp0=
X-Received: by 2002:a0c:ed31:: with SMTP id u17mr11700535qvq.117.1591403755888;
 Fri, 05 Jun 2020 17:35:55 -0700 (PDT)
Date:   Fri,  5 Jun 2020 17:35:50 -0700
Message-Id: <20200606003552.247693-1-saravanak@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.278.ge193c7cf3a9-goog
Subject: [PATCH v1 0/2] fw_devlink: Improve cycle detection in DT
From:   Saravana Kannan <saravanak@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Saravana Kannan <saravanak@google.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        John Stultz <john.stultz@linaro.org>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2/2 explain the series. Just using a cover letter to thread the
series and add CC's.

-Saravana

Saravana Kannan (2):
  driver core: Add device_is_dependent() to linux/device.h
  of: property: Improve cycle detection when one of the devices is never
    added

 drivers/base/core.c    |  2 +-
 drivers/of/property.c  | 44 ++++++++++++++++++++++++++++++++++++------
 include/linux/device.h |  1 +
 3 files changed, 40 insertions(+), 7 deletions(-)

-- 
2.27.0.278.ge193c7cf3a9-goog


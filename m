Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C74E2230D2E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 17:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730689AbgG1PNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jul 2020 11:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730612AbgG1PNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 11:13:04 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 980DEC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:03 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id v6so5869278iow.11
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 08:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WI3fumWYUK+x328Qo7vj3Eg0qcEK6KoFgm7ErCr4104=;
        b=h7elNg17cYKsZqrZyaL2ZdS9YLt+W+ZWu55JLROmCbh1O95nsJ/+NZlCy0qQ4UL2Mr
         qW3EZC2DlmQ0QGl21rf5q4DJPRlUfBiphwDy69CfIt02HtxvnRUNv/FYZO3cNo+ysuOq
         9qbmC1nesGgKDu5RmF9LfZzbIxIVRt318tjZk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WI3fumWYUK+x328Qo7vj3Eg0qcEK6KoFgm7ErCr4104=;
        b=o3Jh7rElhuy+oVpeSEd2CtqURaScc47eqOxliTEkkaMlGZFH1gHe+Tiprd5nsyM0AC
         4j41+0vWE3HriAeMZR7hCCh+2jCzAw9hmKvUynImaueatr/5zZUk3aZg1kOpcZKRZgDG
         JVo/XD6XnbOc2J0TP2Zb/2kf+L2SaVz/aUQDL/AUMOI4TvWeQ4FD5Dl24abK0uRo4XKf
         0f0ycPVrCq23Zll8wOCChg3ISw96byOwTg9u9hocDsLpIIxaiF1OfgYimhdamCyoaV+U
         ffvEyKCSJHwPanvfe5UUcGKDCwMDfsPNT/9s6zcnW2IZf16Pr44ld1RWr96nROHZfKct
         Po/w==
X-Gm-Message-State: AOAM531Ej5ZUU+CDGfjTwPilni3uQLXp68egG0OmkIazjRwO9uZzj4Ce
        GXyWbODqg6A/gGnTQx1uLPotjA==
X-Google-Smtp-Source: ABdhPJz16mmv05HpXxjY6ax+58ko05ihbP6i/A3DYP1AdvM9yMATQllxrAzERVsTsaADDG8IlFk9oA==
X-Received: by 2002:a05:6602:2c83:: with SMTP id i3mr28854532iow.144.1595949182954;
        Tue, 28 Jul 2020 08:13:02 -0700 (PDT)
Received: from derch.Home (97-122-92-59.hlrn.qwest.net. [97.122.92.59])
        by smtp.gmail.com with ESMTPSA id q70sm6399781ili.49.2020.07.28.08.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 08:13:02 -0700 (PDT)
From:   Daniel Campello <campello@chromium.org>
To:     LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-iio@vger.kernel.org
Subject: [PATCH 00/15] sx9310 iio driver updates
Date:   Tue, 28 Jul 2020 09:12:43 -0600
Message-Id: <20200728151258.1222876-1-campello@chromium.org>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
In-Reply-To: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch resends the DT binding for the driver that was merged in
v5.8-rc1 with a small change to update for proper regulators. The second
through the eleventh patch fixes several issues dropped from v8 to v9
when the initial patch was merged. The twelveth patch fixes a few
printks that are missing newlines and should be totally non-trivial to
apply. The thirteenth patch drops channel_users because it's unused. The
final patch adds support to enable the svdd and vdd supplies so that
this driver can work on a board where the svdd supply isn't enabled at
boot and needs to be turned on before this driver starts to communicate
with the chip.


Daniel Campello (12):
  dt-bindings: iio: Add bindings for sx9310 sensor
  iio: sx9310: Update macros declarations
  iio: sx9310: Fix irq handling
  iio: sx9310: Remove acpi and of table macros
  iio: sx9310: Change from .probe to .probe_new
  iio: sx9310: Align memory
  iio: sx9310: Use long instead of int for channel bitmaps
  iio: sx9310: Use regmap_read_poll_timeout() for compensation
  iio: sx9310: Update copyright
  iio: sx9310: Simplify error return handling
  iio: sx9310: Use variable to hold &client->dev
  iio: sx9310: Miscellaneous format fixes

Stephen Boyd (3):
  iio: sx9310: Add newlines to printks
  iio: sx9310: Drop channel_users[]
  iio: sx9310: Enable vdd and svdd regulators at probe

 .../iio/proximity/semtech,sx9310.yaml         |  60 +++
 drivers/iio/proximity/sx9310.c                | 407 +++++++++---------
 2 files changed, 263 insertions(+), 204 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/semtech,sx9310.yaml

--
2.28.0.rc0.142.g3c755180ce-goog


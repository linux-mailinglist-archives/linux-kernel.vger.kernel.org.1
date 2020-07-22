Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFF2296CD
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729744AbgGVLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgGVLBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:01:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316E6C0619DE
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:01:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id r12so1442335wrj.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 04:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sISKqG3zytnruvPe3/sMoutNe9YJtA5YhpTs8Hs22Q=;
        b=GfK17w9A7urar0bbCno8XvDiWdKYtCn/FkvPPArA+GEu1ZXhnvZ9bAoakVcJhb1LwB
         lJAYp1XvgXaOSu3TD6gMvEwpokTWVzY+8o/e4yDWUWImmsTeZ5eBCvp3ffROdkEXsCOC
         O7wNzG5tJKLjVlkL0IhrVBD26gbfXwfvzDXO9UkMBoeOwJPervPItYGXbfzI4yQHGSc8
         c9kaNVZ2W8Q4AErxprcIx01PSnUQXWkcUQk7+f6VfHZMNAn1tSSoVqT0JzlHEKRALQ6x
         MuNIEfo7OLSYXpX/IJQKjmn+I1MtwyxTRCGxaSjFHCWwyoHfJbOFfTCZU6fvmms10wG/
         lhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1sISKqG3zytnruvPe3/sMoutNe9YJtA5YhpTs8Hs22Q=;
        b=HezTSMCpB/yBii+vCfEntYY4KpIKow2Wq+bzLw9LSw4Z0f2k0Bzlis2Cs7LoBbkfyu
         JgeYCy8HtJP+J9MK7F3kA346JA7riaKmDIFpXYIYoi6TsIxXuD3hz0Fd8JgDArPhxWlk
         qpUJrqHSDdRtJ6bHXW7G/JOwomUF9Ds7KFccQWe8zkFHd1HqCoGdSp/liuC0hyaj+ddJ
         OttOUFifdidzVIMYU1ytFLYEgJh8OAopBZ8W5xlPhAyxHrVox4MUsWHKmpTSvKNdX3qS
         rWtfn7MNCpn/JHxjYx4rT0VjDv6NUBr4ZXMb1ZvUEjTOTrlVuTCu4cFXOnEZXH1xEfrH
         GLiQ==
X-Gm-Message-State: AOAM533RQIDbCetywgarTvIcI1R1/HiOiFLytE2GKR/vY43zss3f/rFE
        HwFt3G4DAv2BNTOt50NJaoGFfA==
X-Google-Smtp-Source: ABdhPJzvbJiEbZhTK9KtS+CuXvFxkQ841o0YWwDshK+1uhQj4fRq4YoTcgct5xjCsALL1vxZi3oyjw==
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr14176435wrn.110.1595415699849;
        Wed, 22 Jul 2020 04:01:39 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id y6sm41256164wrr.74.2020.07.22.04.01.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Jul 2020 04:01:39 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     saravanak@google.com, mdtipton@codeaurora.org,
        okukatla@codeaurora.org, bjorn.andersson@linaro.org,
        vincent.guittot@linaro.org, georgi.djakov@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] Add interconnect sync state support
Date:   Wed, 22 Jul 2020 14:01:37 +0300
Message-Id: <20200722110139.24778-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bootloaders often leave some system resources enabled such as clocks,
regulators, interconnects etc. We want to keep these resources enabled
until all their consumers are probed. These resources are often shared,
so we must wait for all the consumers to come up, before deciding
whether to turn them off or change the configuration. This patchset is
trying to solve the above problem just for the on-chip interconnects.

The problem is solved by allowing the interconnect providers to specify
an initial bandwidth values, which are enforced during boot as floor
values, while the requests from all consumers are being collected.
Then the sync_state() callback is used to signal when all consumers have
been probed, meaning that the floor bandwidth is not needed anymore and
the framework is ready to re-aggregate and process all requests.

v2:
* Support initial values for both average and peak bandwidth (Mike)
* Skip aggregating/setting for nodes that don't specify initial bw (Mike)
* Drop patch 2/4: Add get_bw() callback (Mike)
* Squash patches 3 and 4.

v1: https://lore.kernel.org/lkml/20200709110705.30359-1-georgi.djakov@linaro.org/

Georgi Djakov (2):
  interconnect: Add sync state support
  interconnect: qcom: Use icc_sync_state in sdm845 and osm-3l drivers

 drivers/interconnect/core.c           | 61 +++++++++++++++++++++++++++
 drivers/interconnect/qcom/osm-l3.c    |  3 ++
 drivers/interconnect/qcom/sdm845.c    |  3 ++
 include/linux/interconnect-provider.h |  5 +++
 4 files changed, 72 insertions(+)


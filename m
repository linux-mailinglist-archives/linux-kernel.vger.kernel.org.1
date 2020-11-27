Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794BF2C6306
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 11:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgK0KZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 05:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725616AbgK0KZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 05:25:11 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D093C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:10 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id 23so5014104wrc.8
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 02:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY/9AzNvLjBeNPkcmQucef8Xz2kwdVf6AcgLBxqKhiY=;
        b=QaTJM0SvRyVz1yHldqY++eki5EqL5gcfEajhCHMtawzJhH/xRcymfQQhOZcUcOE9Ue
         mTolI6tctVdnOfyhCJfrqV5EhGSj9bn2EMfD+FIYP+IwFSUneadyWODSE5VnHkm+2BBA
         t3krEhrpyh9bGrDpDEzMktN0hK0JqspVbBnqNBT9dl/QbNPSJlqtY3JM55Mkm1ITuvyi
         mqSdLkcT/FWmARIxuS+BUasGvIlaeA4k1ON9KeKCKPhsw2353BdSuUU+ySQ+DerhK6Z2
         X5xKtQeYt61tp8PM7RamfkLXpGo0tAJAqcm+UPHYhNcj62S3ybPwhZohOtVaVjcnI797
         eREg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY/9AzNvLjBeNPkcmQucef8Xz2kwdVf6AcgLBxqKhiY=;
        b=hroB28/j51rkZsA47bNchOeoLmDLPFZxOVSybNs3FmXigdOdlyI72iUwROMirc7kcM
         QNPKSXcLvJFUjaiq6mtSzCYQIyl0OxQOuc+vin+ATZPYrLYno6BzPlmP+9nTeuPYdA5a
         HlOP510au3Z+fWtZ1lerlxGI/xVrLYFM9Amva1bRTrEFqNjUBf7WAsgEdtK3hvntpsPZ
         YQKjz2uFlUf5H918w4tHyGZ5dyRgDp3Ost+KKjB/lkH+LXTg4Osca36r37TGB5CODwMA
         QpojVd0SR216xRzfK4wkF8jaAUbT7cLM1EUHyTX0HAgUzeDsp92rUIqVA861RXhsie8g
         e0tw==
X-Gm-Message-State: AOAM531+ke0LbF6dDzavli1vSQT4tkxoBTSR18BlOJvdsDn0Q3k85gnw
        fPrwTATzVAtPrOrDwnBym8mDYA==
X-Google-Smtp-Source: ABdhPJz06fPUB7ORova+v0J4ZICjciwoWqWvh2PRYYEouRLmOtNL2pkhpt+o0bN724MEDnIwuvn8TA==
X-Received: by 2002:a5d:634b:: with SMTP id b11mr9663425wrw.97.1606472709386;
        Fri, 27 Nov 2020 02:25:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id x4sm13942024wrv.81.2020.11.27.02.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 02:25:08 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/7] slimbus: patches for 5.11
Date:   Fri, 27 Nov 2020 10:24:44 +0000
Message-Id: <20201127102451.17114-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Here are some slimbus patches for 5.11 which includes
- ngd controller has added PDR and SSR support along with a trival fixes.
- few doc and clang warning fixes in slimbus

Can you please queue them up for 5.11.

thanks for you help,
srini

Bjorn Andersson (1):
  slimbus: qcom-ngd-ctrl: Avoid sending power requests without QMI

Gustavo A. R. Silva (1):
  slimbus: messaging: Fix fall-through warnings for Clang

Mauro Carvalho Chehab (1):
  slimbus: fix a kernel-doc markup

Rikard Falkeborn (1):
  slimbus: qcom-ngd-ctrl: Constify static structs

Srinivas Kandagatla (3):
  slimbus: qcom-ngd-ctrl: add Sub System Restart support
  slimbus: qcom-ngd-ctrl: add Protection Domain Restart Support
  slimbus: qcom-ngd-ctrl: remove redundant out of memory messages

 drivers/slimbus/Kconfig         |   4 +-
 drivers/slimbus/messaging.c     |   1 +
 drivers/slimbus/qcom-ngd-ctrl.c | 133 ++++++++++++++++++++++++++++++--
 drivers/slimbus/slimbus.h       |   2 +-
 4 files changed, 130 insertions(+), 10 deletions(-)

-- 
2.21.0


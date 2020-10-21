Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 542F22953A9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 22:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505558AbgJUUxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 16:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2505512AbgJUUxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 16:53:31 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F724C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:31 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id lw2so1774515pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 13:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NAPX8jIgb+PzaCcJ6Ca8FCBjRX5Gtd81LQpD/A3Zyc=;
        b=ftRWqytil+d61ywUdpNfKAharhMRv6i81bxlnqdoP8jgYyJiq+rGb+3kSVLxsIMfwO
         zO1QopRsM1qkS1ZOEYA6U7gla4qrOsQr4OiOTjp8ZUvStup0BglNZvd9H5q9OffpObyM
         7hgjX6vYmg8nhrRBycEDW5YqQxUsPN3HiOtmA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/NAPX8jIgb+PzaCcJ6Ca8FCBjRX5Gtd81LQpD/A3Zyc=;
        b=uRRsbNrNi5XN3TSOz+S6OP/9M+LJZgmMgvE2DrSHOeU6fEmpfowTHghek+hyFwbQ9k
         IU6zGjg9pKEiwscQ+DlgSodzjZW9pybWw04jNGFvPi4bJRSNv57UTeErS96UE8bYsv/E
         L9EsYkut7plhbe11jkPn6M3bwmCtT9tgABR4MTfDsGtUyIXexHg0M2xaT/kv5nVNZr8o
         zLKGY9Iqj91SfI52voEnQHipaF+53mP+4TT/YzPuCNxuDiIgSiH3QsEwj3XiRC24HjvP
         olF4CgOFEOnEf3KsdtlT2pJ3lvzAWFTJSC+WCZ2O7UqjocFi5qw6pSy/gMLxMgkWXJbF
         3rWQ==
X-Gm-Message-State: AOAM533p1r88aSpFiVazL88xU/FFXnLLsJqRdQO1D3zoWIw021Wop13C
        9sIXwolrUpLpwWuzpVVpsQ28H6OP2cAniA==
X-Google-Smtp-Source: ABdhPJxACGSm4NH9Y6ocSP7W5KBPqh81+f97uCbHv88OYRKKDFTKl5gNH6DQ3mzrSvmX8qeI2qktMw==
X-Received: by 2002:a17:90a:9f8c:: with SMTP id o12mr5199057pjp.67.1603313609001;
        Wed, 21 Oct 2020 13:53:29 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:a28c:fdff:fef0:49dd])
        by smtp.gmail.com with ESMTPSA id q8sm3178087pfg.118.2020.10.21.13.53.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2020 13:53:28 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Pi-Hsun Shih <pihsun@chromium.org>
Subject: [PATCH 0/7] platform/chrome: cros_ec_typec: Register partner PD information
Date:   Wed, 21 Oct 2020 13:53:08 -0700
Message-Id: <20201021205317.708008-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support to retrieve Type C PD(Power Delivery) Discovery
information from the Chrome OS EC, and register this information with
the Type C connector class framework.

There are also a couple of patches which fix minor bugs with the
existing cros-ec-typec driver.

Prashant Malani (7):
  platform/chrome: cros_ec_typec: Relocate set_port_params_v*()
    functions
  platform/chrome: cros_ec_typec: Fix remove partner logic
  platform/chrome: cros_ec_typec: Clear partner identity on device
    removal
  platform/chrome: cros_ec: Import Type C host commands
  platform/chrome: cros_ec_typec: Introduce TYPEC_STATUS
  platform/chrome: cros_ec_typec: Parse partner PD ID VDOs
  platform/chrome: cros_ec_typec: Register partner altmodes

 drivers/platform/chrome/cros_ec_typec.c       | 331 ++++++++++++++----
 .../linux/platform_data/cros_ec_commands.h    | 155 ++++++++
 2 files changed, 417 insertions(+), 69 deletions(-)

-- 
2.29.0.rc1.297.gfa9743e501-goog


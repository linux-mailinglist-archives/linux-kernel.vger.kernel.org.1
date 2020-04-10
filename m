Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8C911A3D47
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 02:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgDJAXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 20:23:35 -0400
Received: from mail-pl1-f177.google.com ([209.85.214.177]:36101 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgDJAXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 20:23:35 -0400
Received: by mail-pl1-f177.google.com with SMTP id g2so122249plo.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 17:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKVl6BcBoowwdtw9O7SBGiEP6TqcKMwxzz7fLolApck=;
        b=oVROvY/zAuNrLdlXBdwdRC/R7lAMUfc/uppMU2pgm6sNGpA/Ft5xMxZSIklKgZqYQj
         dTytluExWWu5rrTAPhCoqzOyeWcciW1hQLqvSahBufzxa7qaH5wnqrO++H+R+uo1LWQf
         SsAKbqvB48c8S5PH7YxGRxaDjtJzQ2YVOHh9w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wKVl6BcBoowwdtw9O7SBGiEP6TqcKMwxzz7fLolApck=;
        b=f3BQFYYhPsiOF2Pa4HBj6J6fwZgGOcxejm3jmk6y11/3KNlUKOrp5VRfh6gfBd/tzo
         aayO0NmB2JHMHcAd/rlmsP1gGjNy9rTBTVC+sRXFbaAALVz5Mxf9g1T7KaS/6ipK2S8P
         jL/AfFl+Cr5cfUCtFwG8ndhu8ZNiRZsrif2P6orz8LvbUKRiHS4HFiG5p8dEf0AuMUTy
         tIVyf+dQO7EcSN7MWM35SEkk1VtJkNQnHgNzaXnwuzWygU053K2QrQ3cj7snigOpnj8N
         9hhOpjPHO+JmibX12FDw2Y0LuQXUTWHFFLN3v83PLAub+MR2qVDKQDcE5grBA1l+zsgN
         ICzw==
X-Gm-Message-State: AGi0PuaWZQ9bRtnwompkGky70+odBMiZE0mESQ1IgSwK3gF8jIYi/x9/
        grNsK3ihox+pdEy1SfdlMzoPkN4iY/I=
X-Google-Smtp-Source: APiQypJYKx/2iU/LWKPIMAOLBQBUdCzo529yb50OORiNr8mehbkbYc3/nP0Bszx+s5Eswt7arCe1EQ==
X-Received: by 2002:a17:90a:9318:: with SMTP id p24mr2251160pjo.163.1586478214262;
        Thu, 09 Apr 2020 17:23:34 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id z7sm286952pju.37.2020.04.09.17.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 17:23:33 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v3 0/3] platform/chrome: typec: Add port partner registration
Date:   Thu,  9 Apr 2020 17:23:13 -0700
Message-Id: <20200410002316.202107-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.110.g2183baf09c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series adds port-partner registration when
connects/disconnects are detected. In order to do that, we also register
a listener for the cros-usbpd-notifier, which will inform the driver of
EC PD events. While we are here, separate out the Type C port data
objects into a separate struct.

v2: https://lkml.org/lkml/2020/4/9/861
v1: https://lkml.org/lkml/2020/4/6/1155

Changes in v3:
- Fixed trivial Kconfig dependency ordering error.

Prashant Malani (3):
  platform/chrome: typec: Use notifier for updates
  platform/chrome: typec: Add struct for port data
  platform/chrome: typec: Register port partner

 drivers/platform/chrome/Kconfig         |   1 +
 drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
 2 files changed, 103 insertions(+), 17 deletions(-)

-- 
2.26.0.110.g2183baf09c-goog


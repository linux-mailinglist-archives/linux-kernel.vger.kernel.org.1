Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDFD71A0423
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 03:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgDGBJ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Apr 2020 21:09:56 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:44459 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:09:56 -0400
Received: by mail-pg1-f171.google.com with SMTP id 142so899484pgf.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hxs/afcb0MhjFFfWYcFauB3HH6jjoFqq7M9/7Awekes=;
        b=XbsiHs0kPiXh+KouUNZMERmrL06fLoNH3qeAhFjSsbF677ozzS+MsBznMHrqAEVvlH
         YvKbM4BSBuS0KwJS1YD91zEv+as8Eehgwh/0M64ImGC14gFXo6azk/UCISZ7faZ5HSYr
         PsevY+xJ5YURV1M1bAEvE1MbKR3edaydTjPe4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hxs/afcb0MhjFFfWYcFauB3HH6jjoFqq7M9/7Awekes=;
        b=Swm49AxGJrlczjgz2R1yXQzbRM1ufSsLNx2SYW7JtjusLM81MN97dWmZxtPT28lqK/
         U47Usg6WR46yxj+Mdb8MtyMHlwTroHUFcrcTqeqHUtBvzPVe0DkFsVfRy7Ec66liJRs+
         gIYyqexi201kDsxwXJViEsj6LIG4dITizWvfQkYTlrZyEyut3pR0qxXWKWVriCI4J7E8
         2A4INwrmezmgFGRFVkYoA1wzxLVUXLeQ/2YhsFHPMvrycqtH4+39vZTPSgIYCQJRlxAS
         v4uK6ZRlEaT0KrZp7t249j9uMga2avzzE1RYtAKacy983FX4WCuTlvmpTS2a2OfF9X/2
         J6hQ==
X-Gm-Message-State: AGi0PubkYNBX8Z6F4ElHPA8bwZWv5guFFGJ5ocEfn1s/Pdag1HpfmnRe
        NSZOb4eADKGtkL9uNQMfKhE8JSY5HvQ=
X-Google-Smtp-Source: APiQypLOn6SjQqUwMDdvustCjzzD3AW1DQSx+dpCelcy6Ptdb7cAm/AABk1hV6c0vDmLNwuVfIHT+g==
X-Received: by 2002:a63:a55d:: with SMTP id r29mr1888282pgu.248.1586221794481;
        Mon, 06 Apr 2020 18:09:54 -0700 (PDT)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:476b:691:abc3:38db])
        by smtp.gmail.com with ESMTPSA id s27sm12086500pgn.90.2020.04.06.18.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 18:09:53 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/3] platform/chrome: typec: Add port partner registration
Date:   Mon,  6 Apr 2020 18:09:36 -0700
Message-Id: <20200407010940.155490-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
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

Prashant Malani (3):
  platform/chrome: typec: Use notifier for updates
  platform/chrome: typec: Add struct for port data
  platform/chrome: typec: Register port partner

 drivers/platform/chrome/cros_ec_typec.c | 121 ++++++++++++++++++++----
 1 file changed, 104 insertions(+), 17 deletions(-)

-- 
2.26.0.292.g33ef6b2f38-goog


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6956E273F63
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Sep 2020 12:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIVKQl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Sep 2020 06:16:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbgIVKQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Sep 2020 06:16:41 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B086C061755
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:16:40 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id lo4so22003700ejb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Sep 2020 03:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHn6KqIxxvvocNW+viYY6TMSUZ4OonfYTtb2R3HGCtc=;
        b=pxOf+TpxR7/efT6GRHTUj0vaAe6+MucbjpTKmAq1m9ZgGIuM5e+LI4t23V0ENZemdp
         an73Fp9ojHnC34eTTTQNVJIqgystqZPihrCIiB6+77luvJGPNfn3pcdaryrY/hpzuspd
         Omm4HFTdNCs11OV8LGP9XoRBgYW95RV6e5BZKhhPx5yT/sv3X8R0tYpEH7zR+zmQjS0S
         PifdSGxgT5UniSnZNGdfSSM/EwENvqNgiXd9BCFYHYXnT+rf5wGRZ8XJPffXmpJL1pC3
         r3bx1qztnWPsYXxA3xopXuWpgrXxf/+E3ewjjZs+afwz8TTUlnR2y1gBDjxc+rrRma5Y
         q7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UHn6KqIxxvvocNW+viYY6TMSUZ4OonfYTtb2R3HGCtc=;
        b=QP3IV+o/Q0fNP2gexrxs0lZHUzK/rzLC+xnO2wcmE29Ok7Ncdsbb4g/DaKqpfPCqKy
         +HQIjA1hXJwUSnhu22fXF82H0LSmk/Q9HBfScOatazZ4iEr9Jmot46VIB/k8DxcmMPAw
         ETSu1vRnkAlGIudbUqF0cECyaysHpOym1r/ifaS8z9WtnR2m4+vDxjDQTuEMkhA6AKdj
         f3lV5ITBc5mepTLnANOQLN3S5qAMaJZ0Nd5UV9eAuPChT71+Jf2Grour9mDfZ3DDjGaj
         EHzcNnzAxYEJivEVQX3e9Q6bAHHFeYOxheRAPH8QnQSFOdQ2nSPCR7RnMHNei8h6qB9Q
         sfOg==
X-Gm-Message-State: AOAM530mDWf8A4LG9ocU3m9Zu9cLzwNFZKzCWACr0fW0t69sYKV5v7KK
        o0uXg0h9H6wbjxJmLKmEb+yX2A==
X-Google-Smtp-Source: ABdhPJyk2xr8PI637OfNElC/sHAG6JCn26dSoXKlnx7RAZOFliRC+zCZ+J0/JqxrdKt+dSnVQT8Q9A==
X-Received: by 2002:a17:906:a88a:: with SMTP id ha10mr4298833ejb.532.1600769799217;
        Tue, 22 Sep 2020 03:16:39 -0700 (PDT)
Received: from localhost.localdomain ([88.207.4.22])
        by smtp.googlemail.com with ESMTPSA id p3sm10595368edp.28.2020.09.22.03.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 03:16:38 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 0/2] net: mdio-ipq4019: add Clause 45 support
Date:   Tue, 22 Sep 2020 12:16:30 +0200
Message-Id: <20200922101632.54896-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for Clause 45 to the driver.

While at it also change some defines to upper case to match rest of the driver.

Changes since v4:
* Rebase onto net-next.git

Changes since v1:
* Drop clock patches, these need further investigation and
no user for non default configuration has been found

Robert Marko (2):
  net: mdio-ipq4019: change defines to upper case
  net: mdio-ipq4019: add Clause 45 support

 drivers/net/mdio/mdio-ipq4019.c | 109 +++++++++++++++++++++++++++-----
 1 file changed, 92 insertions(+), 17 deletions(-)

-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8890F1F7487
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 09:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726441AbgFLHWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 03:22:43 -0400
Received: from mx1.tq-group.com ([62.157.118.193]:36108 "EHLO mx1.tq-group.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbgFLHWm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 03:22:42 -0400
IronPort-SDR: Nc4pdbAZB7Zb0hSTufC5aDJENs09uJDjijKEi0rckHuJmUZMc+HbtyJh44aHWQ2kZ4iJDz+TNd
 tpgoJbf9+0pVzVWtEkzsUGSdLRz/DFg21/mhW559NZ5gZi+XVf3C5iiU796IVQPiS+EqVO5Q7w
 JWQswwSTiTNJDAV/qSUj/AySZ5HHG1tHcu14mnUKK2WryPbNzC1mU/i70iVUFcze3+7EmkJmgJ
 /w1wMzyQu4+x5o+XxqfdVLp6lTJPJePWpJeD0rg/YB3Vos5nBa5cmD7J3H/B8sjbqmvzNTskfe
 glg=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657240"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Fri, 12 Jun 2020 09:22:40 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Fri, 12 Jun 2020 09:22:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1591946560; x=1623482560;
  h=from:to:cc:subject:date:message-id;
  bh=fswM+upoobDK3SZQ3Lk7Spn5j3s1LgDDzID4tgIKQKo=;
  b=FYGfNpDfbnfVciJy+omDaBP1tNYcvmPk4Y3Ox+JKFbge+ElspVWN/fGt
   uvajo3m4KtyaMMp7VZb43dreiMHsPF3Iu0WDaSVFkPeal1bmLTJlW1lZ1
   aN9wo6SkSpc9P/aPf5Gk8vGOcJc+rqPJOd9Lgw2W9g9GT9A9wU3OOS4Ku
   JNIASh5ZjqYAY9+2L5PKskm1njIkIQSDlhAnAXNKs3P7m4SY3UFBrks9A
   6u0t/r6vP7jbw1iwfCumN3McGlmGp+trNV7MMMUJhV+LjYe9sdgCh5gzM
   3vutsvSIDNYL5Xh/JMj92gRTTHE3Lkvyyog8FJ+lfKJQlOM6PwNmwzO8C
   A==;
IronPort-SDR: CxZdULvQnOKEWtol3vQScgJl3EvnJ73XMA8LIpbeTsS9IBbHUbNd6tHEbY+LhiXURpZlX2zeK1
 hqnyEbiSTMUjD43m7Kntuk27wI7HFRnGFTqEk94k5xzxXND/DJrE1fYDniXhrlcm7S0diK8Wib
 pf/BfO9bc+AqPpiZT7YvGtmVtq23dzG1lXelE/6czYrfh5G4l5e2Ins7u7Lhv0JQ3bCA8rB8IQ
 TOW7qrelmvOfYUzLFOY4dQCU5te2RnkKHcBfegqS0Nk7rwojzsPWn0Qr2O41JVIGbxwObH7w5g
 x4U=
X-IronPort-AV: E=Sophos;i="5.73,502,1583190000"; 
   d="scan'208";a="12657239"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 12 Jun 2020 09:22:40 +0200
Received: from schifferm-ubuntu4.tq-net.de (schifferm-ubuntu4.tq-net.de [10.117.49.26])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 3C73B280065;
        Fri, 12 Jun 2020 09:22:40 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH RESEND v2 0/4] panel-simple: CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44, Tianma TM070JVHG33
Date:   Fri, 12 Jun 2020 09:22:15 +0200
Message-Id: <20200612072219.13669-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthias Schiffer <matthias.schiffer@tq-group.com>

This adds a few panels TQ-Systems uses with various starterkit
mainboards. Device trees actually using these panels will be added with
a later submission.


Matthias Schiffer (2):
  dt-bindings: display: simple: add CDTech S070PWS19HP-FC21 and
    S070SWV29HG-DC44
  dt-bindings: display: simple: add Tianma TM070JVHG33

Max Merchel (1):
  drm/panel: simple: add Tianma TM070JVHG33

Michael Krummsdorf (1):
  drm/panel: simple: add CDTech S070PWS19HP-FC21 and S070SWV29HG-DC44

 .../bindings/display/panel/panel-simple.yaml  |  6 ++
 drivers/gpu/drm/panel/panel-simple.c          | 75 +++++++++++++++++++
 2 files changed, 81 insertions(+)

-- 
2.17.1


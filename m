Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8832D20AAD2
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jun 2020 05:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgFZDkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jun 2020 23:40:40 -0400
Received: from alpha.anastas.io ([104.248.188.109]:57779 "EHLO
        alpha.anastas.io" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgFZDkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 23:40:40 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jun 2020 23:40:40 EDT
Received: from authenticated-user (alpha.anastas.io [104.248.188.109])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by alpha.anastas.io (Postfix) with ESMTPSA id 4C59C7EC0E;
        Thu, 25 Jun 2020 22:30:35 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anastas.io; s=mail;
        t=1593142235; bh=Hy3qKfXHwG5eYAJuCpaXK7TCeMP269A9UoaRSa1A4+Y=;
        h=From:To:Cc:Subject:Date:From;
        b=J+yD5JTrAhhUHcuP4Umd8+0REVO9aX6zmjExV4ypWwr2/THFo1WGVLOv80v/jC3CW
         FtvPg2HK4mqtKHxV7alHkAskEvfIkjL8L3viNb/T+Xd1HweEETvLU2p8zw/5k0Nuwd
         Q3+rdcBOp6dzB2nnNvKNcRt+Q5gKFB9uA4sMD/Vffs3NfEXNapYcH3jo6WxsoDebCU
         uU7e/D/4fCC6MMAvugK/DDjPxtjR94jnc845+E+7lVVaVixpncKsv/vSYcNEVvdet/
         UKxgCqBCGYGpvCtHDF5dj9biAZM+EP2A+dLP4aVxC2dA/gzoj6Ifbn0ncetgokWNgN
         jBd3XeWd3D1yQ==
From:   Shawn Anastasio <shawn@anastas.io>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, a.hajda@samsung.com,
        narmstrong@baylibre.com, airlied@linux.ie, daniel@ffwll.ch
Subject: [PATCH 0/1] drm/bridge: analogix_dp: Add PSR toggle
Date:   Thu, 25 Jun 2020 22:30:22 -0500
Message-Id: <20200626033023.24214-1-shawn@anastas.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a commandline toggle for the Panel Self-Refresh feature
to the analogix_dp bridge driver, much like the one in i915.

This is required to work around a hardware fault in some Pinebook Pro units
from the May 2020 batch whose display panels seem to behave sporadically
when PSR is enabled.

Shawn Anastasio (1):
  drm/bridge: analogix_dp: Add enable_psr param

 drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.26.2


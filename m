Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FC82ED197
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 15:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728866AbhAGOQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 09:16:51 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:63835 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728817AbhAGOQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 09:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1610029009; x=1641565009;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=Om7iQCxx9wVMG8JVsd+08yHKHLeYRYCvOCLDk6xzc+0=;
  b=VjyxmzSELKwXPqFYt3byoF8W0Bl39ZGHn2EV9vnDvs70cUDmikxyaHjw
   eJ/63N4ugPDOFrDw3RMElHEjuaIDQosHbfp84Yf5cSmw1mMtWQwHpzH/b
   GkfoNl0InP9hbvHYfF37Y2bAnQMKQQvrTgztwT4cxJ3G4S6WWK0ti1rhK
   aPl93nHi9VtVaXvtYK0AlJ4l1ALvAtoxHyUevw4Ai3NKc2Y4R7egIykOE
   hQc7on0NVChiCTGjCzOQqtiaGLBBAoR4Q1NLYpcA4Fpy3x7goal1jiGB2
   9DAVeFDdqN59Bx+RJwuwOnVi5FBs22LuRLnQ4HqYm6KLDTzCJ4EyEQ72c
   w==;
IronPort-SDR: ihkp1LwqMTMMsYI+ca6s9lEvmQzUnlBB4/6/vjX9Waa3/mfggzs9UuJnoF2Y8L/EyIDegSI4CW
 YFKCU8b0/ja5MbUGyqbLd07YEdwbKwHwkf+behuJAodJOEYIW/B0VewOGe6ZaEmoj5Aw6sI45N
 HGWOIYsymTtoXAhA58K/O7leymtre0VKELmp8JodfmYKKG77jvN4kzOT56VfcZh/I5+xnVaegv
 C11z7hz0HgmXhYJyoLyD7CZU518DtIQnVKu+cPQUtaDbZJlwotVJdkv3ZLheSpTD2MRmIMGNN4
 Ok0=
X-IronPort-AV: E=Sophos;i="5.79,329,1602572400"; 
   d="scan'208";a="102091548"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jan 2021 07:15:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 7 Jan 2021 07:15:33 -0700
Received: from m18063-ThinkPad-T460p.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 7 Jan 2021 07:15:29 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/3] regulator: mcp16502: make lpm pin optional
Date:   Thu, 7 Jan 2021 16:15:24 +0200
Message-ID: <1610028927-9842-1-git-send-email-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch makes the LPM pin as optional as this may be controlled
in the last phase of suspend procedure to decrease the power consumption
while suspended. Along w/ this update the MAINTAINERS entry for this
driver.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  dt-bindings: regulator: mcp16502: document lpm as optional
  regulator: mcp16502: lpm pin can be optional on some platforms
  MAINTAINERS: add myself as maintainer for mcp16502

 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt | 3 ++-
 MAINTAINERS                                                        | 4 ++--
 drivers/regulator/mcp16502.c                                       | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
2.7.4


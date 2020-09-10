Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFD4263F24
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Sep 2020 09:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730315AbgIJHzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Sep 2020 03:55:00 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34074 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729529AbgIJHyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:54:47 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08A7saLh078055;
        Thu, 10 Sep 2020 02:54:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599724476;
        bh=d8aaEEEqhdAcIGs3M4AAwCP4B/RKpo4KytEfLks0u/o=;
        h=From:To:CC:Subject:Date;
        b=n/jZExQUK4HfNhmsPpOXJgQQ8M5ykyLZ8FsnXi83OqPkooYHCFZnO/DU2vso2jvbC
         KCTqFI06S+ns857rgoRoz6SCZdki8CYum6gqvixoFQaGw/69+oIs2ir7cbnpCquj12
         5WwO216dqsfdSL3hmiswKCMUT53OQ2z/e84fAQ8E=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7saDo110099;
        Thu, 10 Sep 2020 02:54:36 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Sep 2020 02:54:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Sep 2020 02:54:35 -0500
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08A7sXCS123142;
        Thu, 10 Sep 2020 02:54:34 -0500
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/2] ASoC: ti: j721e-evm: Support for j7200 variant
Date:   Thu, 10 Sep 2020 10:54:31 +0300
Message-ID: <20200910075433.26718-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

When j7200 SOM is connected to the CPB, the audio setup is a bit different:
Only 48KHz family have clock path, 44.1KHz is not supported.

Update the binding documentation and add support for the j7200 version of CPB
to the driver.

Regards,
Peter
---
Peter Ujfalusi (2):
  ASoC: dt-bindings: ti,j721e-cpb-audio: Document support for j7200-cpb
  ASoC: ti: j721e-evm: Add support for j7200-cpb audio

 .../bindings/sound/ti,j721e-cpb-audio.yaml    | 92 ++++++++++++++-----
 sound/soc/ti/j721e-evm.c                      | 11 +++
 2 files changed, 81 insertions(+), 22 deletions(-)

-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki


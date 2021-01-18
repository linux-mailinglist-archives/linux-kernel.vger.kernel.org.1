Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227182F997D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:47:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732275AbhARFpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:45:54 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:13022 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732021AbhARFnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:43:52 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B60051fef0000>; Sun, 17 Jan 2021 21:43:11 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 18 Jan
 2021 05:43:11 +0000
Received: from audio.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 18 Jan 2021 05:43:08 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <robh+dt@kernel.org>, <broonie@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <jonathanh@nvidia.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Sameer Pujar <spujar@nvidia.com>,
        Rob Herring <robh@kernel.org>
Subject: [RESEND PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required property
Date:   Mon, 18 Jan 2021 11:13:05 +0530
Message-ID: <1610948585-16286-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610948591; bh=z5xavFenRoKMKPK0qwGJtQP0fdSh62QlRJgN6qV4K8w=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=Y7fcaI/VN5m+uJOx/l6EHovzNU+Geqx+7pa7ROXrfbtlnKN9zDaY5iGjMOoJuzdx5
         7lTghFQNTzwPuLbS1jPPX1WCiFI6anNPTI8Eau+6L3opb2+M0EkJUsPZw1UUG//PKC
         +gdyQ0FwNtlxz+oD1W1NYtNH2r/u4oy9LbT3SCDG3Eynhx67/2Sc0FvGxQXeodMv5s
         fC2aIoQkFAheuRdd/39lwAYTxTttkjPuoxRsoqUsivLZhpr9xg+ehOehXq2CmKCuDr
         C0RFmndOnX+Dkc/BBHXUSPQSe2g3INSKCld9pQgMoP0lkJnBJ4LeaZQ972HvdpgtXw
         Vof/9xALgHULQ==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The remote-endpoint may not be available if it is part of some
pluggable module. One such example would be an audio card, the
Codec endpoint will not be available until it is plugged in.
Hence drop 'remote-endpoint' as a required property.

Cc: Rob Herring <robh@kernel.org>
Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Sameer Pujar <spujar@nvidia.com>
---
 Documentation/devicetree/bindings/sound/audio-graph-port.yaml | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
index 2005014..766e910 100644
--- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
+++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
@@ -71,9 +71,6 @@ properties:
             description: CPU to Codec rate channels.
             $ref: /schemas/types.yaml#/definitions/uint32
 
-        required:
-          - remote-endpoint
-
   ports:
     description: multi OF-Graph subnode
     type: object
-- 
2.7.4


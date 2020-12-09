Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8B22D3C1D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 08:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727558AbgLIHXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 02:23:11 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:15356 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgLIHXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 02:23:10 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd07b360001>; Tue, 08 Dec 2020 23:22:30 -0800
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 07:22:30 +0000
Received: from audio.nvidia.com (10.124.1.5) by mail.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Dec 2020 07:22:28 +0000
From:   Sameer Pujar <spujar@nvidia.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>
CC:     <kuninori.morimoto.gx@renesas.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Sameer Pujar <spujar@nvidia.com>, Rob Herring <robh@kernel.org>
Subject: [PATCH] ASoC: audio-graph-card: Drop remote-endpoint as required property
Date:   Wed, 9 Dec 2020 12:52:12 +0530
Message-ID: <1607498532-19518-1-git-send-email-spujar@nvidia.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607498550; bh=z5xavFenRoKMKPK0qwGJtQP0fdSh62QlRJgN6qV4K8w=;
        h=From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
         Content-Type;
        b=dHQv48V+NDFdUQCPpJYA3492Zpdrgew/uYiPtGufbR33O8hJJ5R+clelWILhsyJW3
         yD5u20s1TWNQvqTJ1IT+gO9LsPDxXSRHIJLiodd5HJ5vdoLaB3WLhYzOHqgCMGcxq0
         9aajja2pBwhPHfPxN+eqOpfmB0OXMDd266rLpTc8L2FgxqdLFjhkpe8IcYLHEA4JKU
         BYZQHNhjYxct8+K0/Wou/M3kmWEbrsugJjI5zv5WQBbvT9E8lZvaDZpBnufVYN1P8S
         R+mUin8zt+P15EfesoP/PFzf2h4ECa7dHZa3RqgAHM2Hro/gsCdim2/R+aQtV7Z8KV
         m2FC2TEPfXFWw==
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


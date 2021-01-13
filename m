Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70FE02F4967
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbhAMLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbhAMLBd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:01:33 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 383A023441;
        Wed, 13 Jan 2021 10:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610535570;
        bh=YW4QjGYFsbAuui1Vift+SPuhkkmUUaZythToMJo1+vw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OyRNuc2fpe0Hj3u2FvUgrww9G6rTIjDEsi0ww87FsoxfQMGZ0M3HZSlEM0J73t73Q
         J/fYjXEZdqw1dVE0T0O2ethPSuAg8raN6fmokKnAMpoRhiwfvrmrV8/kvWCi5NpLN3
         GpXR1aJ2DC/BEykKU6+8pM2W7Sm/sXjlwZctGJ0LU0tjxZ3MrBvRCZwy+hmRMhCL4l
         lr0lebDfK1kVO6cM+Omx1g8PQ3/EUm2oa/R3vYENYDe3gKvzmm+tL5FQMd0cKYOg7y
         8DqNep3l1QmHAJ/vw5rrUhaH17PCGPG5mujVaKfEGdUscb7a/TgjAD/viwLxu1nEez
         DsXtqSUj1jlCA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kzds7-00DpGl-QQ; Wed, 13 Jan 2021 11:59:27 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 20/24] ASoC: audio-graph-card: update audio-graph-card.yaml reference
Date:   Wed, 13 Jan 2021 11:59:21 +0100
Message-Id: <8a779e6b9644d19c5d77b382059f6ccf9781434d.1610535350.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610535349.git.mchehab+huawei@kernel.org>
References: <cover.1610535349.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changeset 97198614f6c3 ("ASoC: audio-graph-card: switch to yaml base Documentation")
renamed: Documentation/devicetree/bindings/sound/audio-graph-card.txt
to: Documentation/devicetree/bindings/sound/audio-graph-card.yaml.

Update its cross-reference accordingly.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/bindings/display/bridge/sii902x.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/display/bridge/sii902x.txt b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
index 02c21b584741..3bc760cc31cb 100644
--- a/Documentation/devicetree/bindings/display/bridge/sii902x.txt
+++ b/Documentation/devicetree/bindings/display/bridge/sii902x.txt
@@ -40,7 +40,7 @@ Optional properties:
 	documents on how to describe the way the sii902x device is
 	connected to the rest of the audio system:
 	Documentation/devicetree/bindings/sound/simple-card.yaml
-	Documentation/devicetree/bindings/sound/audio-graph-card.txt
+	Documentation/devicetree/bindings/sound/audio-graph-card.yaml
 	Note: In case of the audio-graph-card binding the used port
 	index should be 3.
 
-- 
2.29.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F840281527
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 16:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388129AbgJBObs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 10:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387777AbgJBObr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 10:31:47 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EAEFC0613D0;
        Fri,  2 Oct 2020 07:31:47 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id e2so1987542wme.1;
        Fri, 02 Oct 2020 07:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6o5jHfcjbw5X3IGqgGWdir89nONyuyUEchA4DUJix40=;
        b=UWIB0bev3xg2tOPk3cOSDdcEz35DItpIA/02YLXLns/QR3nPDr+Tn39FOEQPVdbFd+
         H6phd+DbKxi9Og6/8DlAVr/cJINOAME/KlKKEOiHlEw8ZMe9blKOKcH3Je8ctPioXUtG
         aWoGwPCw9B2YqX5g3aIFpwZ01R4An0lCCQcYwqIkAdsBPzDgkD/dV+SEHIXFkB2y5XIp
         rEKqcjohlxMfwkCtJ9GgRCaWxsqURiAg1R/vXCdwIJqcxBoEEFGbdsrRxrZH+z4ackeI
         KGqfwru1urBy2/3llsa0sq3L4Jyvz9RuyGB9pgwKjMDVIWCvXhp52JvzF6vz4p5QwOEk
         Yz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6o5jHfcjbw5X3IGqgGWdir89nONyuyUEchA4DUJix40=;
        b=PqbxtwUcYCqE2VuBTC2XGwLa3ZcFfsxb25hiN8D8oNlfANVQwgEpkM4D7sLvW7TC5T
         E282V2yAlgldhF2Cy+ShZShEeeugqjysJt8+ZmsFYprYoGHctzzsjZltMftZV0U+ugE2
         dXUXq5jvNankgrmnB8nybEX84Eb96hiWVxuzMWu7I34Qrg1wmyVShHhs31lQ+mW/tDrB
         n6fxpxdAu027h3+99WOYyf30lHmS9ArFl0BtEZwfcAljVQ81dHpY+5a9odI//XakrraT
         miKK80PDYsWPAEI/JnbuSeoj03HW6OgXvC6FYUMiy1zLv/Jn5iT69Hzrzx4NrLfiA21Q
         UdfA==
X-Gm-Message-State: AOAM533CFitgq1p4jvEX/Be1jr98bZRNhZg/BbPda5sZa7wQ6zC0rig1
        MtMIMuHWJprO4idlnEhrA5k=
X-Google-Smtp-Source: ABdhPJwcBhx8MfW10XshdbWBrBec7TjBSbx9dXWZePPSkzyIMzN21tQ8bYJtJsv7m27t0JkHLjwlUw==
X-Received: by 2002:a7b:cf27:: with SMTP id m7mr3234029wmg.74.1601649105740;
        Fri, 02 Oct 2020 07:31:45 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id w7sm1907392wrm.92.2020.10.02.07.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 07:31:45 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v2 00/10] arm64: dts: meson: add more GX soundcards
Date:   Fri,  2 Oct 2020 14:31:31 +0000
Message-Id: <20201002143141.14870-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for LPCM audio over HDMI and S/PDIF
interfaces to GXBB/GXL/GXM devices without support. I'm sure audio
support can be extended in places (some devices have internal DACs
and headphone hardware) but this gets the basics working.

I have personally tested with the khadas-vim2, odroid-c2, and both
wetek devices as I have them, and there are positive forum reports
from users with vega-s95 and some no-name P20X box devices.

Changes from v1
- Drop nexbox-a1 and rbox-pro changes - the regulator changes are
needed to get the dts to compile, but I do not have schematics to
validate the changes or the hardware to test with.

Christian Hewitt (10):
  arm64: dts: meson: add audio playback to a95x
  arm64: dts: meson: add audio playback to khadas-vim2
  arm64: dts: meson: add audio playback to nanopi-k2
  arm64: dts: meson: add audio playback to odroid-c2
  arm64: dts: meson: add audio playback to p201
  arm64: dts: meson: add audio playback to p200
  arm64: dts: meson: add audio playback to p212-s905x dtsi
  arm64: dts: meson: add audio playback to vega-s95 dtsi
  arm64: dts: meson: add audio playback to wetek-hub
  arm64: dts: meson: add audio playback to wetek-play2

 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++++
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gxbb-p200.dts      | 61 +++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-p201.dts      | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gxbb-vega-s95.dtsi | 61 +++++++++++++++++++
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++++
 .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 +++++++++++++++++++
 .../dts/amlogic/meson-gxl-s905x-p212.dtsi     | 40 ++++++++++++
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 ++++++++++++-
 10 files changed, 464 insertions(+), 3 deletions(-)

-- 
2.17.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99B3A2B3CF6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 07:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKPGUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 01:20:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgKPGUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 01:20:38 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77323C0613CF;
        Sun, 15 Nov 2020 22:20:36 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k2so17418990wrx.2;
        Sun, 15 Nov 2020 22:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=PRE33PyX0DgQV+nPjucF/BuaE/3yxdmGeh7qvmvEzro=;
        b=TI6RaHtEPsDA2gqYraJ1fkUSJhdCI6IMKeSAjnX8tAupeoT+MgZnMJytGNyIeJZb8E
         tejpSnUoo2UJl1gYC6y9klVRPRhiTrakvO4ZCFqcry7L52wJBCNEoN1riuc7MWnkSfED
         i4AWh/1K0qK32fKaLtQECbwi89jKWtlg/hKWREor0cWTAcRgg2mqbtr/DL9tT9YVO96t
         cIudPEJKp45VpY01drRruOxH/iZRoCFtBuCqIevGTc8yQMJZYXMwLiZ/sELtds2iy0M/
         ZDRiBx3yvk+9u2V0DNPPyTqspOCcXxm4FE6cMZ2fhtaa+wOq3UY5+hlJoMQHDSnGqeA1
         wHWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=PRE33PyX0DgQV+nPjucF/BuaE/3yxdmGeh7qvmvEzro=;
        b=WTCPfzWI6duv8S3jMbf3IR9KQnzCYVEDAYTXptR0vaoHZDhzbzpUXObJ9zUZlPLm/U
         51yOMxSXKgfdJeZaTgCXncVSrrAoCohNdcxsg7HPnoW0Sl4XgQDIaklq/4Ca3207deiV
         Nh2Xdbx+KyBGMNDuFYArQcsFro7BwXwp860gGKjtJnmoSkOTeGlhEeOIvPgo9Xxpz5W1
         mBWhE9olEmWXMpWAf2MiOR91ysPXEq0px89wSlPBNtptl1OmWiHn5crJOpNVanfMAGtO
         jcoxiAZV21E22RitSFaLaF1vgiUJJsl1Gjms4l+2RAzKMjSvK31gPmR+ZlAyOWHw8Z0/
         FxPQ==
X-Gm-Message-State: AOAM530jQ3hZaAOedB0e3X37ZWcyBZU+R+H5tTxrBc2EPPCI+6bkh19f
        AsrqTgprZ8Tc/h1qwPY17pI=
X-Google-Smtp-Source: ABdhPJzKlFtq6d42gqMkJc5oVxVrMJJ1WBeET4rSm0rF+ADL8gJZL3ZhaIZJBUubub86R0pfcSCdDw==
X-Received: by 2002:a5d:4d02:: with SMTP id z2mr9475903wrt.109.1605507635254;
        Sun, 15 Nov 2020 22:20:35 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id m3sm17065985wrv.6.2020.11.15.22.20.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2020 22:20:34 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v3 0/7] arm64: dts: meson: add more GX soundcards
Date:   Mon, 16 Nov 2020 06:20:24 +0000
Message-Id: <20201116062031.11233-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for LPCM audio over HDMI and S/PDIF
to GXBB/GXL/GXM devices that I own and have tested with. Audio can
be extended in the future (some devices have DACs and headphone
hardware to connect) but this gets the basics working.

Changes from v2
- Drop p200/p201/p212-s905x/vega-s95 changes
- Add khadas-vim(1)

Changes from v1
- Drop nexbox-a1 and rbox-pro 

Christian Hewitt (7):
  arm64: dts: meson: add audio playback to a95x
  arm64: dts: meson: add audio playback to khadas-vim
  arm64: dts: meson: add audio playback to khadas-vim2
  arm64: dts: meson: add audio playback to nanopi-k2
  arm64: dts: meson: add audio playback to odroid-c2
  arm64: dts: meson: add audio playback to wetek-hub
  arm64: dts: meson: add audio playback to wetek-play2

 .../boot/dts/amlogic/meson-gxbb-nanopi-k2.dts | 40 ++++++++++++
 .../dts/amlogic/meson-gxbb-nexbox-a95x.dts    | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gxbb-odroidc2.dts  | 40 ++++++++++++
 .../boot/dts/amlogic/meson-gxbb-wetek-hub.dts | 40 ++++++++++++
 .../dts/amlogic/meson-gxbb-wetek-play2.dts    | 61 +++++++++++++++++++
 .../amlogic/meson-gxl-s905x-khadas-vim.dts    | 43 ++++++++++++-
 .../dts/amlogic/meson-gxm-khadas-vim2.dts     | 44 ++++++++++++-
 7 files changed, 303 insertions(+), 5 deletions(-)

-- 
2.17.1

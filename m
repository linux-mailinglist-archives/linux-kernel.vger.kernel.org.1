Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3042CCEEC
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgLCGBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:01:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgLCGBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:01:15 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45EB4C061A4D;
        Wed,  2 Dec 2020 22:00:29 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id u12so638262wrt.0;
        Wed, 02 Dec 2020 22:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FgP7aBE8aKGLuFedysVwA7KL29Dq1oiQSpDqT6u+4VI=;
        b=h4Lb0tD7YcJ2v1bsPqUsKQ9RPQ2a1WMayCpc0Pt95GMhoEPUs5a4G7VOQpBnNkwWJE
         Eo5ELadpnQjo2ML7qWxuKTuyVUTHLEztQBKT859ug+MGuGxBDSANnVQ3puvlVAMsBHjM
         GDcqU9OCjAqGRUvw/MTpzzJ5D5NI9lv79yVGB6Ro00wPCKonxCxSGQJz2yqB0CCp4WCl
         P4GnlZxVqNe4bjhPLZpv0JpySazPmdM6sm/m1iZn2kXy1cggTJAd70ChA2Effh1gQSKt
         9cre7qLUWL+PChhZSyL6k/PJ7tVIvK+FjVS0OssJNnTn5sGtR6413MU4NDYsTocPAFM6
         IDOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FgP7aBE8aKGLuFedysVwA7KL29Dq1oiQSpDqT6u+4VI=;
        b=ji8GKIQpNT2rdEqOKud8efe0H3eUx/yHpXE4rQLoLWsIsV+nCMBula5+wru686l0A0
         /E3Gz9Q9z/jZOMpZDNLza5Mqh2YJQNSREcWK3PLE/Hz2E8EgPBtvb8shlTXl37dZXEW6
         W/WYZ9WoYSQmcxIq+eh5lWSfr7LI4Udl+pTdLJezNMdGSqCREuJyg/0Rmphupag+MPjx
         esCPXJ56uIwpAKVXFRXU+vWuNTD1KSZoBzhjslYFC4Lq+VgarkiuRX2w6rhYEqO65Gp2
         dn1YWFVuvQ8BwCZ1n4RBW0i8ytx1P2YgsfE7aT1ksOcfy6Lv/u6KFPb4jx7CIjBZNI6q
         lqew==
X-Gm-Message-State: AOAM531KZyRdtwAVzj6l1+wnV7YwNouSzsgJwpJw6H7rvim6mlFlk6mJ
        TTift9CuzgNQJXHtZiRo1MM=
X-Google-Smtp-Source: ABdhPJzGCGuP5kscbpV5BX+E0FsFhFfbzFF/ey1HKAGsMH6YD4c+lt9NmwX6UPoMLk2rDqA6RcjbVg==
X-Received: by 2002:adf:bc13:: with SMTP id s19mr1662859wrg.397.1606975227952;
        Wed, 02 Dec 2020 22:00:27 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id i11sm218439wro.85.2020.12.02.22.00.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 22:00:27 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH v4 0/7] arm64: dts: meson: add more GX soundcards
Date:   Thu,  3 Dec 2020 06:00:16 +0000
Message-Id: <20201203060023.9454-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds basic support for LPCM audio over HDMI and S/PDIF
to GXBB/GXL/GXM devices that I own and have tested with. Audio can
be extended in the future (some devices have DACs and headphone
hardware to connect) but this gets the basics working.

Changes from v3
- Drop includes tidying in patches 2,3
- Add Jerome's acks

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


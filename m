Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0A52D0D77
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 10:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLGJyr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 04:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726637AbgLGJyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 04:54:46 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C7CC0613D1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 01:54:00 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id l9so2971183wrt.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 01:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDl1SiUqs+tVTq7p6TpRFwWPM2gXn3fAWwGDnQ0ZJLU=;
        b=WU4qUfu46oPI3fbmoBdkehsFavNQIcLZ6Z8f9WKZh8y7/XyV6R5XFUsTZtE8tzBdpX
         /MmV7hdj4l6FNZCQuIDrPCIb0s26w1/M8K1iHtVqVDOhLk1hwL8rrsmCpk/6Vp84Jgro
         JIzhlt47WU53MK7Hr3+VvptTIJzHawkrRDL3UW93QhMdc8qBJOAVn2au0KRb6fa1L/RK
         inZC37yfXxtHHNcdDwlwhIfQ09JI9r9cAqe/yA1SAeA7KisLbQwiZQ1H7e7XSSgJDfwp
         tk02uk5LhGyG70Dqtte5GhLowAqMwr7W+DQiFEwIK1NvR9U529p8ixx8RTKZKw7ZJMls
         Ghbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NDl1SiUqs+tVTq7p6TpRFwWPM2gXn3fAWwGDnQ0ZJLU=;
        b=Q5z3KngyloVBE/F/fsmgbyK17+yF2xdybJWTy3oLyyVqcXrBZLuLdMe1NcaB3bVTOj
         /95xpN6h5MVs4dh/Q3LMLJqzGL8Mzk6aSgCD3ixiApgeW+oxyzVCRlXD0/4XXBcObmta
         2U3A/+o4iZ4GcksMg7K902fKKM2tH9w8iGmCUcdw7hJsxohmgHDRfazeZDkm6P3JjLUD
         V2riIYZGz5jNO64VZHnXeMNcFVLMDSyr3nEWOb/Msaj1MIx8/4p4Grl+tKDkojWVLEdv
         I72xW5rERsJOwv04ss1cf7qtiOEBYzP+orghYPEkyodPtkvDnhnbKK6liKMjV8FVpUF3
         LOVA==
X-Gm-Message-State: AOAM533IsfhD0e/84DQ4aDXnc85ICbUtn40R8yV8jCpyQeRVBJn2KyA3
        pt6PLc40ZkloDpHDPBJZVlnn+g==
X-Google-Smtp-Source: ABdhPJzwba7QWJxQRgsk6T64b2mRfYcmawrDO8+x1mYbwtOsc9yi5zyvuvGhVirCO3gg+GM7xSgSRg==
X-Received: by 2002:adf:e490:: with SMTP id i16mr18527870wrm.337.1607334838975;
        Mon, 07 Dec 2020 01:53:58 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id t188sm13558066wmf.9.2020.12.07.01.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 01:53:58 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] arm64: dts: meson: vim3: enable hdmi audio loopback
Date:   Mon,  7 Dec 2020 10:53:44 +0100
Message-Id: <20201207095346.26297-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset enable the hdmi audio loopback on the vim3 and vim3l.
I found a few whitespace errors while doing it. This is sent along to
avoid annoying conflicts.

Jerome Brunet (2):
  arm64: dts: meson: vim3: whitespace fixups
  arm64: dts: meson: vim3: enable hdmi audio loopback

 .../boot/dts/amlogic/meson-khadas-vim3.dtsi   | 60 ++++++++++++++-----
 1 file changed, 46 insertions(+), 14 deletions(-)

-- 
2.28.0


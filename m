Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336D21A0C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 12:38:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgDGKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 06:36:44 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55062 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725883AbgDGKgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 06:36:43 -0400
Received: by mail-wm1-f67.google.com with SMTP id h2so1213243wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7QGET4RGE/b2notuLD7So4S9wMFDLvNgiDRB/hMgYo=;
        b=i6GRznCp0m+F1v9sZJgiU4a5ku5MFHh4xOrCVR4GY6/4aX8jhDBZpYoy+E0wKfw3KP
         mXqeoWR3jZfePMnr5sgqE10h9MY/GQKkDPvAQir1N4js9OFWBQb0YDENytyHeDnUdfz8
         C6TBQsSSnVBcoBD2xlb1H4mxHxQEu7gg83VTLRjOOFzuq4MpYTDrFiYqt5xGSRnaK2Lh
         gukRJ6D88qHEldWzg7dP2dQj3K3V45l59Q969LyYKktjyiqHTDiPBXJ0W3RIeEiSMrpO
         y6S5cU41+hpyTfB3t/71ZqekGEqC0/60DeyUKH3qIf1K9wEx7p//vVTjEdCKT5oYRs1A
         st5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=q7QGET4RGE/b2notuLD7So4S9wMFDLvNgiDRB/hMgYo=;
        b=C0rCqryJLx01knnG6rzTKJDukXI4fnJccx8orSYXh63Vmrg6dUaTdZRpWD0DpPUHiU
         DCAu18lDKkjUwFrHpcpnHpYV4dFs9wT9oQwf7iCk2mX7rpxWq3X0pvzHSdxZGDuOqt49
         1yO4t2JJ4F0vw5Mw4u7N4J6UMca5efdewbtCup/kmxRiXPpKH3HOIpkkfmJdL22FPj4l
         /dSwMGWoC3mNFEdkIkIgOs1YMRWiJNnVfKwGpjhPDnjQji38W/lqZoYBAbjpnb3RGp/S
         iySEF01hNSuBBo6Hym7j9+az0OFdFz4BZxaaF7klvgKiJh0rwG52PsaNqpxDwld5ZV4H
         vzJA==
X-Gm-Message-State: AGi0PuYDmY4aTnnDjXlTQtqxhB7idE4qr4zAJRdJj970DTtBpToAqf0D
        VzwGaJTinKy0V4LEMq9XX/3YZHRcmcI=
X-Google-Smtp-Source: APiQypJwScHUCMB89rigfHI1XkeApoit4SWFTemp3glBSOOUL3Sp+gKSO3b2Y60Y/3hijRMfGQhylg==
X-Received: by 2002:a05:600c:2245:: with SMTP id a5mr1762018wmm.171.1586255801026;
        Tue, 07 Apr 2020 03:36:41 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-124.static.upc.ch. [31.10.206.124])
        by smtp.gmail.com with ESMTPSA id c17sm25016722wrp.28.2020.04.07.03.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 03:36:40 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
X-Google-Original-From: Max Krummenacher <max.krummenacher@toradex.com>
To:     Max Krummenacher <max.krummenacher@toradex.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Will Deacon <will@kernel.org>, Vidya Sagar <vidyas@nvidia.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Olof Johansson <olof@lixom.net>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH 0/4] defconfig: fix changed configs and refresh
Date:   Tue,  7 Apr 2020 12:35:33 +0200
Message-Id: <20200407103537.4138-1-max.krummenacher@toradex.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Three configs have been renamed and/or changed behaviour.
Clean that by using the new config name.
Then refresh the defconfig with make defconfig savedefconfig.

The refreshed defconfig does result in a not changed .config.

Applies on linux-next/master tag: next-20200407



Max Krummenacher (4):
  arm64: defconfig: DRM_DUMB_VGA_DAC: follow changed config symbol name
  arm64: defconfig: PCIE_TEGRA194: follow changed config symbol name
  arm64: defconfig: ARCH_R8A7795: follow changed config symbol name
  arm64: defconfig: refresh

 arch/arm64/configs/defconfig | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

-- 
2.20.1


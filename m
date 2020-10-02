Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AED4281B28
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 20:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388139AbgJBSvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 14:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBSvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 14:51:39 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE743C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 11:51:37 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i3so1340292pjz.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 11:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tUSYbGADt5zWhR4KyAct6QpTK0aisoUtA8b6yIqd5d8=;
        b=PVw+/hJhJzDBxSG+wde89r2aB1QxeJFWovzl5+HCfyu5Fbvf0dGxyoEtDBeG0kNMKP
         ljpsPY0KyCH83vK5RhmvWY59XTM3YGaUX2AfcdMWpbA4Qny3qaYt3TPdawmC7Dzn9M6c
         NzcUbBVfoxXJfsP1/vrjbM0VvtTz6AaLiFwkaQS5GDMG7uZzb+DNmcycEmBVJfIzR8f5
         Stt5mT41A6622bWseMJtVyPmrY1dKRUy3djJLRcjao8VvM8lAEpqnkHFV/+Mv73FTVMU
         5E0Jv3ilY+9PSZiNfNcgw5GISeyKStAO5STNwu1LCt1hkV5uBgA0HPl4+1ClrztOkwsV
         Vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tUSYbGADt5zWhR4KyAct6QpTK0aisoUtA8b6yIqd5d8=;
        b=RsUDDTqtsneT4KHjgjOXqZtjoO8THnSnUW730jevAblAf0+8Ir+KMRmf2+DrapeSoT
         QZ9FKKTtyUf3G1OS0bPR981Py0fAs7qh1zmK4hkbAX/CXvvCuvt/GrpUjepaFQUb9bdQ
         2tyy4l6JPRPkCOxwCEQA5fg0eyOd1CdeFG5OJymVMW7oM/w87pCKqypwbt0Mgf1Fbzgn
         OClOoJRUwgSRbwKTZ4rKarUKyfg3kT8y6srYKjpbuhBaBMtKg8dbrmRbYd4EEiJtRuC5
         nZKuOESVHcIHF4LISJX02q0x7FVXpYuw8mHQv9jW7FFU+eNPZHcBJaWvHqRY1sPE9uQ5
         y8sw==
X-Gm-Message-State: AOAM532sMg80Jr2Grn/lLiYJpFT0XUSujMxvZtCasADragHK729WJ8mf
        jsS9xyKRaoupDx8pEhVGEdLXWRMW1/qiEoEm
X-Google-Smtp-Source: ABdhPJzUoHAc8JF6EJT4u/l5KCL4oF1JeRj5BESUn4xpNOLVZmmAS6ACGMC7bCzaWlMLkRwbEgf34Q==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr4166212pjb.125.1601664697165;
        Fri, 02 Oct 2020 11:51:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id r4sm2261674pjf.4.2020.10.02.11.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 11:51:36 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: meson: add SM1 soundcard name to VIM3L
Date:   Fri,  2 Oct 2020 11:51:34 -0700
Message-Id: <160166469102.35184.15775273206707708270.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002141619.14387-1-christianshewitt@gmail.com>
References: <20201002141619.14387-1-christianshewitt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Oct 2020 14:16:19 +0000, Christian Hewitt wrote:
> VIM3L now inherits the sound node from the VIM3 common dtsi but is
> an SM1 device, so label it as such, and stop users blaming future
> support issues on the distro/app "wrongly detecting" their device.

Applied, thanks!

[1/1] arm64: dts: meson: add SM1 soundcard name to VIM3L
      commit: 0fe4c285ef8bd0475da7e288c844cb55fc850970

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

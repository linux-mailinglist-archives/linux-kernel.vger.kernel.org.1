Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4714285A17
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 10:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgJGIIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 04:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgJGIIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 04:08:10 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71F17C0613D2
        for <linux-kernel@vger.kernel.org>; Wed,  7 Oct 2020 01:08:09 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id dn5so1180657edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Oct 2020 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGSaUBpUa7h3fJNtYObjMDqGR9Ro46H8/LDVOVOxdpA=;
        b=bSN8spIR9xUdSRkZ32gyacqTUcBVqvjgg+fTC1ekYl0AokfdWqIn8LFypvOYpbo38i
         cMTvixuZ/BStwWXTskgekW/5ucWRgKrX86vmjkGne7IqqShgah/SJRgB+CVrmTDvTfpz
         MnN4Jbgs9uvd6rnOErAqgY6cu/xXcld8dzrEubFtqqzlJ4SYJ6pOs9sTKrDCET55sgGF
         driJcWaouxN8vLSnxF4T0p5EUExeyhnVmGI+JH5D1OJ0zqECV+7uv20hREo2JVEuDclB
         ubVry93jRm7PVxX4vVmtawhppul8FdyFe1TOQXm928FO1UK1Rfo5fafKxZ4omdilI00I
         5CaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bGSaUBpUa7h3fJNtYObjMDqGR9Ro46H8/LDVOVOxdpA=;
        b=Mgmth28JM4h2VJst6/W2vj2Lsz0Zc8n1kHN9wJbF/zglC3QskBeFmm5cvNV5VN9hzY
         PDYXsRma4gT9pyliYIMKvuZoe31vx6YHAUijXlKjV8EGUY0CyEYypKhkc0PNwgQepgO5
         O7ANoVF2t95O1PMI9XxQj3aGLavcgFQMicOxvatXKmEBFnFaAsDClrZDIOPnxWYYYlgM
         Yh0wf7Rle7EkdX44FcrrN6irZXgH974c9PbMS5Kgm5OcD5dnRJZeF+StcBIaI44LDvnw
         rQ5/wO6qPtmCot6LqMxhC4lm1wQ+lzM4pKmboqACBdEG1o6C5M3h+Kt99Hp5q3ZuLM9r
         v/3w==
X-Gm-Message-State: AOAM530OjYyJvhw3Xt5Limz8y3s4ZRKLGOWWWdzJ3kWoG1YF3LuSNiMt
        fYAXziPHIuxvNvkqOAh9JN5ByQ==
X-Google-Smtp-Source: ABdhPJwq4DM7Wcl63R3341ewtPx1CDtsyrwGljNdz6qXSDJ5K2AqSjcd8k6iCCwk/nBKKBLAmDFYLQ==
X-Received: by 2002:aa7:cb05:: with SMTP id s5mr2224828edt.363.1602058088071;
        Wed, 07 Oct 2020 01:08:08 -0700 (PDT)
Received: from starbuck.lan (cag06-3-82-243-161-21.fbx.proxad.net. [82.243.161.21])
        by smtp.googlemail.com with ESMTPSA id p11sm888645edu.93.2020.10.07.01.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 01:08:07 -0700 (PDT)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Wolfram Sang <wsa@kernel.org>, Kevin Hilman <khilman@baylibre.com>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Nicolas Belin <nbelin@baylibre.com>, linux-i2c@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] i2c: meson: scl rate fixups
Date:   Wed,  7 Oct 2020 10:07:48 +0200
Message-Id: <20201007080751.1259442-1-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fixes various issues related to SCL rate on AML SoCs.
We retain the method which was used so far to set the SCL rate.
This method does not provide manual control of the clock duty cycle
but so far it does seems to be a problem for anyone.

Amlogic vendor kernel source uses "HIGH/LOW" method which allows to set
the rate and the duty cycle of the clock. However the documentation
around this method could be better and the result on actual HW is not
perfectly aligned with the comments in AML code. In case the current
method ever becomes a problem, we might consider switching to this
HIGH/LOW method.

Jerome Brunet (2):
  i2c: meson: fix clock setting overwrite
  i2c: meson: keep peripheral clock enabled

Nicolas Belin (1):
  i2c: meson: fixup rate calculation with filter delay

 drivers/i2c/busses/i2c-meson.c | 52 +++++++++++++++++++++-------------
 1 file changed, 33 insertions(+), 19 deletions(-)

-- 
2.25.4


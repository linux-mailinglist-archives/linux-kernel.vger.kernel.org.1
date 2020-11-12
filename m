Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1229E2B0258
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 10:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgKLJ5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 04:57:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbgKLJ5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 04:57:19 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72A7AC0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:19 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 23so5801872wmg.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 01:57:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJdlB8xXslxrXWz+83yO6rq8sfEN0xtnjkNe/5k6q8o=;
        b=xC0FljWqdDp0JYyC2N6sRxyC4M5oR8YfJDzzWjOcUUI2nmbP1cPJsYPk+zSNsuZl91
         I2y+3FjkSM/lnfwZcAbKvd4jRftxtMK66fC2xdbI14LiJtQl2H83DDZOATO4jAtyEz1K
         CEr728uOPMjJeqsa239TbdxYsFO6ufLh9/bPVnMS+etRZ5NA6kQBhBbrbESm5lkO1q/S
         xMQjty3iW7tgKcYqnKYaU5RnAcGeNs838Z9B5bRVoVjrZYv3hJeuZzLeFB06ZW+msqOQ
         m1/0uQsgIPTLp6+nN0v/N82+WrU7N66Kfk4TRwhLvXwgZGcLpyjmSoSzoybIjwE5u9Tv
         QKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SJdlB8xXslxrXWz+83yO6rq8sfEN0xtnjkNe/5k6q8o=;
        b=JlGw08ifKeGmmHq9r/2d80bFkliLLk39ZeLK7OftzP2BeNFYwwq0T853h/VLidL0H5
         bscC0TN1anpIGkmjmU/54ywvcPON3iifuGatogmdqtorcIhhqXST7T58twplXHmbwwJE
         gWkny6osvxe+VR0puaFgY3pPi9LLyqVNGBj9xGpA+UkazsvbhMDTLEB0tfKzisJuwYha
         BtCXf7gdsbbdw9iS9MsvQvNhzHVcmEYhfTbmpBEPUK1I2QjBSh155+CDLpnM3o3h5EWx
         BPuqR02/y9KYhf09erOg4DGDUWftnKoImzvmKRRiR2JuCW8tP+ZtlP7H6d7jjaXrIk7z
         6dvQ==
X-Gm-Message-State: AOAM5312rdxVg5gSoFilsiJ7rQeP+gvGtGqF/hTikSwyEXYZvMDXE4IX
        eSyCri0V442AdPbk7v6Bf0UnnQ==
X-Google-Smtp-Source: ABdhPJxg3Ef2Soll0LH/c+2LR15Uk1TaaSB8m0drUb+pvQ4sDVM8xS9tns/UgMX2m4xG1FCkRr4LAQ==
X-Received: by 2002:a7b:c2f7:: with SMTP id e23mr8872342wmk.100.1605175038192;
        Thu, 12 Nov 2020 01:57:18 -0800 (PST)
Received: from dell.default ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id n15sm6138792wrq.48.2020.11.12.01.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 01:57:17 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     jdelvare@suse.com, linux@roeck-us.net
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Lee Jones <lee.jones@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Neelesh Gupta <neelegup@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] Rid W=1 warnings from HWMON
Date:   Thu, 12 Nov 2020 09:57:12 +0000
Message-Id: <20201112095715.1993117-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This set is part of a larger effort attempting to clean-up W=1
kernel builds, which are currently overwhelmingly riddled with
niggly little warnings.

Lee Jones (3):
  hwmon: adm1177: Fix kerneldoc attribute formatting
  hwmon: ina3221: Demote seemingly unintentional kerneldoc header
  hwmon: ibmpowernv: Silence strncpy() warning

 drivers/hwmon/adm1177.c    | 10 +++++-----
 drivers/hwmon/ibmpowernv.c |  2 +-
 drivers/hwmon/ina3221.c    |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

Cc: "Andrew F. Davis" <afd@ti.com>
Cc: Beniamin Bia <beniamin.bia@analog.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.com>
Cc: linux-hwmon@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>
-- 
2.25.1


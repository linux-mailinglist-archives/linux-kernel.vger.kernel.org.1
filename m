Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0F0C2C939A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 01:05:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388812AbgLAAEe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 19:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388031AbgLAAEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 19:04:34 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74157C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:03:48 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id hk16so103467pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 16:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yNlEFUw3WIu5X/RkuCRlgAtwXJZvDq05hfWplllmYns=;
        b=MqW7DpSBs3wPvTtDCSmbu7MBS8C9KIXpa3Uv7uXkdsMxQRs2zx9NCmd5z9XcYAY85+
         QdHYaegfiMjhCDQrZk70++0SmfawfyXT2A4rSZ8WfYwg+nLE47ossll3HWZ6/+zXUoqb
         EL1zXa6JnOfmS15SOBLHaf6nxKYhMc0Th/CLTzEy0rXlROnwrSU/ddP7Ua2RATlQsUVi
         0z4GxdYxZCfap2+KjaygLvnIY6cXhdoKzOmjdpTRTLEO30IEiFPjwj7MY1dgwHebOdhy
         bKCmty6lwdT8mW6WSfsbNBdeJOTpHEqihmp6bi1H3OdsAzjHJVkE0oIFwhB5PWfNs1Xn
         t4fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yNlEFUw3WIu5X/RkuCRlgAtwXJZvDq05hfWplllmYns=;
        b=A2vXYqpfL+ORMnQPFROfZinRrV5hPaHJFP+INrwrnf4h5J50eawXqPUvnXeCEagA4g
         FdDx1A07YLpVAHKiHsda5emNRtD2tOHK8Ag8NPGp79INJFDCj/4QDLjwjnv7xDr1w4um
         tsDezcEoTt2pjJfQ5CTMsDg+qReQ4hI/KNDeVl/++awwn6HattPYToEoMDpCjIMzU64m
         +nN9GuLqpitcTLF3a9wq+WsJap0IjEfmKp0r9YBaiNkLzkUTEuA45E9HIqluF8tzn8Jq
         6ILHRFYMFrkBL1GCC7wbpCr4++viFPzXiuv0dgLwqDnjKxiPFuALRldHpGhsUNTBMRN/
         6SGw==
X-Gm-Message-State: AOAM531iSSAC9Qtl3NNQDOfZELIPhuwT9mJWvXkrOOwasTcUSmq06b0Z
        26Z/sRxlqo9rwQ5coPUgDHiF2w==
X-Google-Smtp-Source: ABdhPJxmZcP3uPA+KwWVlhYo+Ncc9k7aW3qiUqAaCVhFkVMH8Pg7XH8O3bU3BLt3FvogcLp6EMFGEQ==
X-Received: by 2002:a17:90a:3d48:: with SMTP id o8mr308131pjf.103.1606781027822;
        Mon, 30 Nov 2020 16:03:47 -0800 (PST)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id m73sm96645pfd.106.2020.11.30.16.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 16:03:46 -0800 (PST)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Yejune Deng <yejune.deng@gmail.com>, jbrunet@baylibre.com,
        p.zabel@pengutronix.de, narmstrong@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] soc: amlogic: replace devm_reset_control_array_get()
Date:   Mon, 30 Nov 2020 16:03:46 -0800
Message-Id: <160678102118.27831.17587037083495740823.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
References: <1605667700-16681-1-git-send-email-yejune.deng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Nov 2020 10:48:20 +0800, Yejune Deng wrote:
> devm_reset_control_array_get_exclusive() looks more readable

Applied, thanks!

[1/1] soc: amlogic: replace devm_reset_control_array_get()
      commit: 978d0dbb98c7ce9a5d6897744ac49ac5ff85831e

Best regards,
-- 
Kevin Hilman <khilman@baylibre.com>

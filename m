Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81F4E1D5A87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 May 2020 22:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgEOUHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 May 2020 16:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726197AbgEOUHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 16:07:42 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E88C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:41 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id p12so3045483qtn.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 13:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HV2Z0w13p41YlV1PvC+Btxht1RgUxPRUBThDnW8Rilk=;
        b=tySTlNNOFdrlQ7X8lUdPbVRVAAkq49DgEJKq1JHETgJA0sUy79K1jdFUuqw2FOejAb
         APFjO6yC3H0dh+VG8VhjTOXx2urEhTWwbaVhF4wBRPCwxi6Kl+v53JLnlAYXqOLTdTWQ
         OjpHGKDSxsdbdsbHt89L0sYCMy/NTWfEzm/r2kN5vBazrWO+sFFNqT+r/VfilFUEkBra
         B8Up407+X/J2s+kUWnB73WVbfxd5571HJ/3o3DC/Xx8EYU3sokOke3FC27CyD01oNHrG
         eI1jOUG4uQDx/DxF3cB/nQg4Kj3Z43paG+hwtwEzInFHAVT/DSxz5hBdPLMlLYa78SkZ
         hVbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HV2Z0w13p41YlV1PvC+Btxht1RgUxPRUBThDnW8Rilk=;
        b=dgl/ga93eSkNLufy2l3cOLL+u5Ic8+FL2+WgBrAAXsuAEKkJvLpnY/kiDwUe1nYwYJ
         0A7x88bunvblK0fHHwQ3UK4SCdM+4RZL08RNWSD0dlK3NNuzGOM7lqiBssnvCCUwIpYk
         XZXT3OO1wM7fKZtwcx/Rg2uUMJpE+SjKJ6uZ6ig8iwoblALQTcoYYA1I2nkZw9zJcL8a
         JXcpWnV8zTQBCf0K/5ERwvDxn7kPsGkC0R21lqdJr/sSsmEVTFLmeQZ12soAcBp3aWSJ
         6tfq7uZ4p5g151cJZmXhDdTb97kXpKKnsvoZnF97hHV0K3jGv6bZboMIQc0rqbtmvCpk
         JfHg==
X-Gm-Message-State: AOAM532hFgF8haNoVEvxmjSHdAB+LP83PQYRQrhgnsyXpr16aqF71MUL
        1EZ/l9rDI+VJvomiYCtUeySVCRRNc18=
X-Google-Smtp-Source: ABdhPJyaS4LCsptRgnlvksHXNohAxNn7oJ8szASf0bDCtnqcfUijK3s/ku9l5D3H/33gJSANF+hjog==
X-Received: by 2002:ac8:568b:: with SMTP id h11mr5358011qta.197.1589573260239;
        Fri, 15 May 2020 13:07:40 -0700 (PDT)
Received: from beast.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id 132sm2328246qkj.117.2020.05.15.13.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 13:07:39 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net
Cc:     evgreen@chromium.org.net, subashab@codeaurora.org,
        cpratapa@codeaurora.org, bjorn.andersson@linaro.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] net: ipa: sc7180 suspend/resume
Date:   Fri, 15 May 2020 15:07:29 -0500
Message-Id: <20200515200731.2931-1-elder@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series permits suspend/resume to work for the IPA driver
on the Qualcomm SC7180 SoC.  The IPA version on this SoC requires
interrupts to be enabled when the suspend and resume callbacks are
made, and the first patch moves away from using the noirq variants.
The second patch fixes a problem with resume that occurs because
pending interrupts were being cleared before starting a channel.

					-Alex

Alex Elder (2):
  net: ipa: don't use noirq suspend/resume callbacks
  net: ipa: do not clear interrupt in gsi_channel_start()

 drivers/net/ipa/gsi.c      | 11 +----------
 drivers/net/ipa/ipa_main.c |  4 ++--
 2 files changed, 3 insertions(+), 12 deletions(-)

-- 
2.20.1


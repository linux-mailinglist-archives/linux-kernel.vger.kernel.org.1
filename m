Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4647D2CD981
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730959AbgLCOod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:44:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgLCOoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:44:32 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D963C061A51
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:43:51 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id q8so2745798ljc.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKonHAzWScU6PiPc/DK529aH5VgAZfj3Pj1T+1htNxI=;
        b=Vec/zxkKCF/pLDv4KJLo2qXej9uAOcjIE2oZbVGbIcqS3/98akRIQU1HfFcOjSArc4
         0VrDfss+2Llv6L/tyj0Pk+GmB0nBRTLVYCAlwUztRiRbgW+zXJdoJbDAqQIKKFug8t/B
         yG8YvfUr4TNwrP+xu/pbtts2KP3Y7+o/Lz+9fPwqcj+SxglzxX42fg+Hm9quL+b1t3hL
         n7VQFhpw10dA+5EtsAGrENOPIZc18bJBPzrTq4v06xPY5cQZm4j7kkKog872rtta9LEZ
         HPoh5JllGy5SBW9e8IsLGyTTvH7u6cvnPxexRUOS2ImDXjlGfFA/ppFaX5bA+8OE3KC6
         bceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xKonHAzWScU6PiPc/DK529aH5VgAZfj3Pj1T+1htNxI=;
        b=Tq5q+gj2jaJlj2jZVsr0SF/mrspI7u7Pxm0Seao6DPyeokJgqgeSdeNT5ALF0ffzQV
         VB1aHQYVMoJqvD2SdBCkSKDBuAQxluoxZEQTMl5I44WOZr2O50fYI2PSvwJI4nhCjxfB
         Zy7k85vlc0BA3v2CM83p5efihXKeay+KBJt7/qTvVLtdMKcXXkkndgA2dqGzYyjELC/B
         kCJPFv6LO5TvnlB3KRDcIzJIOZBS21V7nXGmWq6PNlnjGoujJbp1PfFuEPnhXSBPqXX4
         +zQzzVdbNH4SzEbl+24WIC1jjwPqT1vOxJw4azDVrwE53e72wzFP4gcdK8nW4QH+3V+p
         cytA==
X-Gm-Message-State: AOAM530Q0+51rVy4WEbUrcRrE2FctSKaseMXh8o9WP7p4nHfkVXxqskk
        ScYc6U+bIENMdfxaYbLHjt/5/A==
X-Google-Smtp-Source: ABdhPJxO1kHlN8+cmD7BIg1253Rb6K2Ri8D79w/6n5WmNnVdf+uRYt3QNl5L+SixjQv0xifkg1um5A==
X-Received: by 2002:a2e:920a:: with SMTP id k10mr1314492ljg.260.1607006629599;
        Thu, 03 Dec 2020 06:43:49 -0800 (PST)
Received: from localhost (c-9b28e555.07-21-73746f28.bbcust.telenor.se. [85.229.40.155])
        by smtp.gmail.com with ESMTPSA id q11sm579011lfo.249.2020.12.03.06.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:43:49 -0800 (PST)
From:   Anders Roxell <anders.roxell@linaro.org>
To:     madalin.bucur@nxp.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
        john.fastabend@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] dpaa_eth: fix build errorr in dpaa_fq_init
Date:   Thu,  3 Dec 2020 15:43:43 +0100
Message-Id: <20201203144343.790719-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building FSL_DPAA_ETH the following build error shows up:

/tmp/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c: In function ‘dpaa_fq_init’:
/tmp/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:1135:9: error: too few arguments to function ‘xdp_rxq_info_reg’
 1135 |   err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
      |         ^~~~~~~~~~~~~~~~

Commit b02e5a0ebb17 ("xsk: Propagate napi_id to XDP socket Rx path")
added an extra argument to function xdp_rxq_info_reg and commit
d57e57d0cd04 ("dpaa_eth: add XDP_TX support") didn't know about that
extra argument.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---

I think this issue is seen since both patches went in at the same time
to bpf-next and net-next.

 drivers/net/ethernet/freescale/dpaa/dpaa_eth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 947b3d2f9c7e..6cc8c4e078de 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -1133,7 +1133,7 @@ static int dpaa_fq_init(struct dpaa_fq *dpaa_fq, bool td_enable)
 	if (dpaa_fq->fq_type == FQ_TYPE_RX_DEFAULT ||
 	    dpaa_fq->fq_type == FQ_TYPE_RX_PCD) {
 		err = xdp_rxq_info_reg(&dpaa_fq->xdp_rxq, dpaa_fq->net_dev,
-				       dpaa_fq->fqid);
+				       dpaa_fq->fqid, 0);
 		if (err) {
 			dev_err(dev, "xdp_rxq_info_reg() = %d\n", err);
 			return err;
-- 
2.29.2


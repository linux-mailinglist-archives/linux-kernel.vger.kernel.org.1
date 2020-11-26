Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0012C55EF
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389895AbgKZNjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Nov 2020 08:39:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390560AbgKZNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Nov 2020 08:39:10 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D2B3C0613D4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:39:10 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id l1so2176750wrb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Nov 2020 05:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRpAJlbq6+V+ePZQw5yqXL7428RUL9OWlsKS5RA6BKg=;
        b=CRjmklKzjv8jTVM8y5ehKKzL+Eel4+NeZfyvFpAJcJJCxkpaa/dQY/KI+1cxh1uKQ4
         x31XOW25cX4mFhG9B7f7Iq2OIMx1+YfwDvE8nsKg8nvngYAjmgAV1fdsiTKsLKsqr20d
         AVbJvZ+6JOoefJT03HN8cVZvAS/fcbeQr1wDFZHm80j3PrkvXxeRl91q4S97uqp5DDi6
         c8V8JkOpiN+wGrHi1sLekRUKouPglPzl1kSpPXorZqMDILV4Mo6Nd0z19ltIH1Hu0zoN
         wUZihn3nrw73DDDpfNkwdhmP6qJozeDF8vGvP60mgCrsT6gXef46skpBc28THKvD2tXQ
         6Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRpAJlbq6+V+ePZQw5yqXL7428RUL9OWlsKS5RA6BKg=;
        b=t26tGpa8zDq1v0vgBRkOhcHB7IcTm+DVcGN6LvsH4rKN65g9gjwwyGYJiTKRmAoxHa
         LmXqvnitEgdJTlHQDrKrboNCxxyHWpPnEKj8zPQdme6smZ6E258Uk0KS8hnb+2K2vbVO
         BjDFiQsI+s323BmAlbc8s8+LXq94cOG5vW2Un4xThhdznW45PCfX5beLvruqOHInBlNu
         SWew4cafPuQKtBuzPG7GDBrGzNPuN5tO3tfvdbaSJ7Dy+886CvEFHI2X67COdSliaZO0
         voQFsD9W4+wG9ZKXcSz2Dao3l/D5SweTjS2vNqve+DH5QB3vla1c2PyRTGhFvhGyAC9E
         KrWw==
X-Gm-Message-State: AOAM532UnIC2zimVAWePBj0oK8lCvOt+MqaSVNt+lJ8+vkYhU5hOL9Q1
        lC60tincsOm3bSAcHs45vV31fQ==
X-Google-Smtp-Source: ABdhPJyLZT0V4+zVqDNFo6SwnsBmTFtnBfv+6D8SII+64k4pMDJ9qNUY8G8xUyMfkpwcg4n/U1GplQ==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr3908174wrw.365.1606397949075;
        Thu, 26 Nov 2020 05:39:09 -0800 (PST)
Received: from dell.default ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id s133sm7035825wmf.38.2020.11.26.05.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 05:39:08 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Santiago Leon <santi_leon@yahoo.com>,
        Thomas Falcon <tlfalcon@linux.vnet.ibm.com>,
        John Allen <jallen@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org
Subject: [PATCH 8/8] net: ethernet: ibm: ibmvnic: Fix some kernel-doc issues
Date:   Thu, 26 Nov 2020 13:38:53 +0000
Message-Id: <20201126133853.3213268-9-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201126133853.3213268-1-lee.jones@linaro.org>
References: <20201126133853.3213268-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 from drivers/net/ethernet/ibm/ibmvnic.c:35:
 inlined from ‘handle_vpd_rsp’ at drivers/net/ethernet/ibm/ibmvnic.c:4124:3:
 drivers/net/ethernet/ibm/ibmvnic.c:1362: warning: Function parameter or member 'hdr_data' not described in 'build_hdr_data'
 drivers/net/ethernet/ibm/ibmvnic.c:1362: warning: Excess function parameter 'tot_len' description in 'build_hdr_data'
 drivers/net/ethernet/ibm/ibmvnic.c:1423: warning: Function parameter or member 'hdr_data' not described in 'create_hdr_descs'
 drivers/net/ethernet/ibm/ibmvnic.c:1423: warning: Excess function parameter 'data' description in 'create_hdr_descs'
 drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Function parameter or member 'txbuff' not described in 'build_hdr_descs_arr'
 drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Excess function parameter 'skb' description in 'build_hdr_descs_arr'
 drivers/net/ethernet/ibm/ibmvnic.c:1474: warning: Excess function parameter 'subcrq' description in 'build_hdr_descs_arr'

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Dany Madden <drt@linux.ibm.com>
Cc: Lijun Pan <ljp@linux.ibm.com>
Cc: Sukadev Bhattiprolu <sukadev@linux.ibm.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Santiago Leon <santi_leon@yahoo.com>
Cc: Thomas Falcon <tlfalcon@linux.vnet.ibm.com>
Cc: John Allen <jallen@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 36ea37721e3c8..0687f6cb0c7a2 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -1379,7 +1379,7 @@ static int ibmvnic_close(struct net_device *netdev)
  * @hdr_field: bitfield determining needed headers
  * @skb: socket buffer
  * @hdr_len: array of header lengths
- * @tot_len: total length of data
+ * @hdr_data: buffer to write the header to
  *
  * Reads hdr_field to determine which headers are needed by firmware.
  * Builds a buffer containing these headers.  Saves individual header
@@ -1437,7 +1437,7 @@ static int build_hdr_data(u8 hdr_field, struct sk_buff *skb,
 /**
  * create_hdr_descs - create header and header extension descriptors
  * @hdr_field: bitfield determining needed headers
- * @data: buffer containing header data
+ * @hdr_data: buffer containing header data
  * @len: length of data buffer
  * @hdr_len: array of individual header lengths
  * @scrq_arr: descriptor array
@@ -1488,9 +1488,8 @@ static int create_hdr_descs(u8 hdr_field, u8 *hdr_data, int len, int *hdr_len,
 
 /**
  * build_hdr_descs_arr - build a header descriptor array
- * @skb: socket buffer
+ * @txbuff: tx buffer
  * @num_entries: number of descriptors to be sent
- * @subcrq: first TX descriptor
  * @hdr_field: bit field determining which headers will be sent
  *
  * This function will build a TX descriptor array with applicable
-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F8D28A816
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 17:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgJKPzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 11:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59019 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730174AbgJKPyr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 11:54:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602431686;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=pR1M69yxrP9JSOS0Ie5ezAaQo49msGZptm8kNeSlSi4=;
        b=RnA8Q/+Wp2v9p6Ns6o4gZ+upo/MszJ1ShQDpQK5jFKPyD9YvqAiC+WqQWg9F9n91yq1kIm
        FNeQU+aDeVSlDMWmVMSKDXZ58Jnk9uKtzj2ze4NUzoMn5ZxETB9iU0kKGcS4mziBhnRADp
        3Vz5PZ976w6POx5rdDUmVvzPCmkI8RE=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-hpKR6ugBNm6DHwYJhcimhw-1; Sun, 11 Oct 2020 11:54:44 -0400
X-MC-Unique: hpKR6ugBNm6DHwYJhcimhw-1
Received: by mail-oo1-f72.google.com with SMTP id r6so5859457ooo.5
        for <linux-kernel@vger.kernel.org>; Sun, 11 Oct 2020 08:54:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pR1M69yxrP9JSOS0Ie5ezAaQo49msGZptm8kNeSlSi4=;
        b=fZbYW5A1gy7zMP9x+/nl6rlawIufiDA8aPqCpJIJBKVir+CK1Z7R/Bxx9j171UQBK1
         oH+DW9IrVJBc63BF4B6wkFXBgYIukqP1JlayW9spmhsJv/0OPKA/iUfO+jLUPw34DiB8
         s+//oF7up8huo8MX/OInFcIoStrbOZEpQtMzNOl5nz6cEBRfQxW7K3baCqZGh2JwHpsL
         VBXxUvUa11eJ7EncskdFmKDSQ0jVrAS3Rwre52iAIJdaM+mo4PT1WPzAtIdlZnLjxGyv
         1w5PdUtJL/eoJlx6EiyComUlBCieqFJhZyMPrKO2Yn2cfT2u4dsTMRgUa4ldgjCbGoEr
         cEZA==
X-Gm-Message-State: AOAM5331B/EJiBrmOOcbUgl6H79S3liwxOLTrVwEGhx/fb4F8qO4xMid
        hjlRu9374C0NyBCkEm2sOqxFVm1s/u9G5vtV+mNh2zsbT6033VTd0sylCbbD0rvj3yiIVg7rLrY
        LUCHw0+Wb4Zrcgqot4CQO+EB4
X-Received: by 2002:a4a:da53:: with SMTP id f19mr15863003oou.38.1602431684163;
        Sun, 11 Oct 2020 08:54:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPJ4u/OeZjHz4mlSxVIynu+KwH6mw6NHjvdnFA3ZLQHkWtrDgVgyM85WaG5gdk1n/GnBdINg==
X-Received: by 2002:a4a:da53:: with SMTP id f19mr15862992oou.38.1602431683974;
        Sun, 11 Oct 2020 08:54:43 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id t22sm7969499otk.24.2020.10.11.08.54.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2020 08:54:43 -0700 (PDT)
From:   trix@redhat.com
To:     yhchuang@realtek.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, natechancellor@gmail.com, ndesaulniers@google.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] rtw88: fix fw_fifo_addr check
Date:   Sun, 11 Oct 2020 08:54:38 -0700
Message-Id: <20201011155438.15892-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The clang build reports this warning

fw.c:1485:21: warning: address of array 'rtwdev->chip->fw_fifo_addr'
  will always evaluate to 'true'
        if (!rtwdev->chip->fw_fifo_addr) {

fw_fifo_addr is an array in rtw_chip_info so it is always
nonzero.  A better check is if the first element of the array is
nonzero.  In the cases where fw_fifo_addr is initialized by rtw88b
and rtw88c, the first array element is 0x780.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 042015bc8055..b2fd87834f23 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -1482,7 +1482,7 @@ static bool rtw_fw_dump_check_size(struct rtw_dev *rtwdev,
 int rtw_fw_dump_fifo(struct rtw_dev *rtwdev, u8 fifo_sel, u32 addr, u32 size,
 		     u32 *buffer)
 {
-	if (!rtwdev->chip->fw_fifo_addr) {
+	if (!rtwdev->chip->fw_fifo_addr[0]) {
 		rtw_dbg(rtwdev, RTW_DBG_FW, "chip not support dump fw fifo\n");
 		return -ENOTSUPP;
 	}
-- 
2.18.1


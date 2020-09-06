Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB47825F070
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Sep 2020 22:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgIFUGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Sep 2020 16:06:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36729 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726443AbgIFUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599422758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=22GEKdlDGamdrcCdfxHjJVYzr9HNsngs+YDvy62bHWk=;
        b=IswqyEf5QVzlKIejYq8RmT4IakKRV9IAQTH6WPLG2JV1XI9SvI9CsbmEBRK6dKwwcgpNJn
        Ooo5d9cp7HlUi6j7C+4rtYGejfE/Oi+X0RkkrreAlpDunysTsplGWG1Bet3q1DpE+4JvcX
        BCfW16+6W8nArMb+ddUzlC0lN590MxM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-328-Rn1kUAg6POyEiwOO0JX3Og-1; Sun, 06 Sep 2020 16:05:56 -0400
X-MC-Unique: Rn1kUAg6POyEiwOO0JX3Og-1
Received: by mail-qv1-f69.google.com with SMTP id ff20so6676259qvb.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=22GEKdlDGamdrcCdfxHjJVYzr9HNsngs+YDvy62bHWk=;
        b=HMse98UP9o4lLsNPOzFkdPWWVZYA3TdllMXoip27QodYYWLS3Jz+4qCMKgJvB4xICd
         OeDDB0zd3RK9IXJ6IGyZQebUXkVtLRWsmdx4s6Xy4zS1u46G2w25EDMWosdiUXKX1MKe
         UGqXFLhsmqq96F+cO5mFeB3W6WIDEAiDCNrXVLu0QSuSMT0GWySF3mbWcfs99Mnu6Q+K
         k28rv1l8PpprZUsNGvVf1roo2434L/UxKBvZW4IAX40S8AJHMOvjDE2U1gxIGTXl14tn
         VRxX3hgz6mTFgM7F1Y98lanCiJut9ekQmbj6IurANICL49K9oAZAzpAUptzJS7PdRYT2
         LPIw==
X-Gm-Message-State: AOAM532A+rRs+bHDBWN7tzn2e1jxQHvGLeDN77KO+dUckynrviKRVBFy
        ykLAts4gqNjZX9v96BOlbz9H5YBW/hMXzF20jrzqF++KF1zxGQVtT6W7IJq7/NeNaM1OjKs2V5j
        OVUbMt5Rx/rCkShI8PsdjB0YU
X-Received: by 2002:ac8:310c:: with SMTP id g12mr18097165qtb.281.1599422755465;
        Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUi6FjudeZbwzO+c/2NwD6TWr2lq6erqaKfWv9r02JiQWr5InA3Ycp5fEU/mKbzgvlBSRZsA==
X-Received: by 2002:ac8:310c:: with SMTP id g12mr18097140qtb.281.1599422755202;
        Sun, 06 Sep 2020 13:05:55 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id x3sm3727737qta.53.2020.09.06.13.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 13:05:54 -0700 (PDT)
From:   trix@redhat.com
To:     amitkarwar@gmail.com, ganapathi.bhat@nxp.com,
        huxinming820@gmail.com, kvalo@codeaurora.org, davem@davemloft.net,
        kuba@kernel.org, natechancellor@gmail.com, ndesaulniers@google.com,
        bzhao@marvell.com, dkiran@marvell.com, frankh@marvell.com,
        linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mwifiex: remove function pointer check
Date:   Sun,  6 Sep 2020 13:05:48 -0700
Message-Id: <20200906200548.18053-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

clang static analyzer reports this problem

init.c:739:8: warning: Called function pointer
  is null (null dereference)
        ret = adapter->if_ops.check_fw_status( ...
              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

In mwifiex_dnld_fw, there is an earlier check for check_fw_status(),
The check was introduced for usb support at the same time this
check in _mwifiex_fw_dpc() was made

	if (adapter->if_ops.dnld_fw) {
		ret = adapter->if_ops.dnld_fw(adapter, &fw);
	} else {
		ret = mwifiex_dnld_fw(adapter, &fw);
	}

And a dnld_fw function initialized as part the usb's
mwifiex_if_ops.

The other instances of mwifiex_if_ops for pci and sdio
both set check_fw_status.

So the first check is not needed and can be removed.

Fixes: 4daffe354366 ("mwifiex: add support for Marvell USB8797 chipset")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/marvell/mwifiex/init.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/init.c b/drivers/net/wireless/marvell/mwifiex/init.c
index 82d69bc3aaaf..f006a3d72b40 100644
--- a/drivers/net/wireless/marvell/mwifiex/init.c
+++ b/drivers/net/wireless/marvell/mwifiex/init.c
@@ -695,14 +695,12 @@ int mwifiex_dnld_fw(struct mwifiex_adapter *adapter,
 	int ret;
 	u32 poll_num = 1;
 
-	if (adapter->if_ops.check_fw_status) {
-		/* check if firmware is already running */
-		ret = adapter->if_ops.check_fw_status(adapter, poll_num);
-		if (!ret) {
-			mwifiex_dbg(adapter, MSG,
-				    "WLAN FW already running! Skip FW dnld\n");
-			return 0;
-		}
+	/* check if firmware is already running */
+	ret = adapter->if_ops.check_fw_status(adapter, poll_num);
+	if (!ret) {
+		mwifiex_dbg(adapter, MSG,
+			    "WLAN FW already running! Skip FW dnld\n");
+		return 0;
 	}
 
 	/* check if we are the winner for downloading FW */
-- 
2.18.1


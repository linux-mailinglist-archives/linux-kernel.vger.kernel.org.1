Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654922A6E15
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Nov 2020 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731458AbgKDTgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Nov 2020 14:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbgKDTgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Nov 2020 14:36:35 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7EC0613D3
        for <linux-kernel@vger.kernel.org>; Wed,  4 Nov 2020 11:36:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c16so3419464wmd.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Nov 2020 11:36:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k67WJZz91lYPQDLJYD2ErvYjtjdqGLDz97BE/78ozUc=;
        b=gEKJtBiRUROXA4IUzg/Us52REi29EsZS/mYjpcAuahOAR3QDWfedJt0H89DI9QqKAU
         8WSBelzkSFfKt3T154O9ouzayPkGZcKVFcbk9VSWYH/pvUotc14pIh0nabAnsKqElbOX
         5yWxpWzH5ls8SaNvktx87zqe6Z3va3I8jTycx+ACoKN6ciTGya3pbyEoBI/DOOB1pHs6
         r9VfNNVPKYxVBSAJZnHJyavaCB30SCilRJQcLKewgL7omQam8jwVNcz/fJcxp3MBbLEi
         j0kZ01rIkypl+LkJ850M5itCC567ZGmbTtyZfz1uXELD/68KA/DDkUv3ApA2wIzt2Xh0
         VT+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k67WJZz91lYPQDLJYD2ErvYjtjdqGLDz97BE/78ozUc=;
        b=LoXsG6VfRRVSSgtjJ6VJ2fnB+zHEq+TwYSyda6L5yXUEZ/0WxRctecu+TBRQa9q2iH
         O5qX74UC/yblSSTlhuu32xJw3FXELY/ZhL88K6oe4yy+eX1M9ursp6s4Wt+CJzYvaqZ1
         Y12SXcTLTuVSw0TRY7COk/azng7aLXxC56gRwnr4AigylAbEQFC1ExHbc7hzTlmTA0bY
         4Hjr/nuABs5+H/Wzz9LNRL2JHEppwut6xZTvp3agtNACz8CJXunv4lax4K6YSbcDhx+W
         t9zINRNBE2D254jdK81xu77mnND/3MbfpETDNq3WFaxGPOauV1FXeQR/lS8jnBI+Mqv2
         gj2w==
X-Gm-Message-State: AOAM532r/HBEGI+1vDMOBwcdNfwjt+l9U5AYfF6MOhWWGj740MPWlGq0
        rFNcRkYllz1HO+NyEuDKqJDUxTEaVwnSeZsB
X-Google-Smtp-Source: ABdhPJxcTGxjw4E+xVQJdsXU54HWiBzqI54InQGTNwZawpLtycJfFtOB37bU+3lVMegb2O93ds8ZlA==
X-Received: by 2002:a7b:c14f:: with SMTP id z15mr6502193wmi.174.1604518593918;
        Wed, 04 Nov 2020 11:36:33 -0800 (PST)
Received: from dell.default ([91.110.221.242])
        by smtp.gmail.com with ESMTPSA id x10sm4034444wrp.62.2020.11.04.11.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 11:36:33 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, paulkf@microgate.com
Subject: [PATCH 23/36] tty: synclink_gt: Demote one kernel-doc header and repair another
Date:   Wed,  4 Nov 2020 19:35:36 +0000
Message-Id: <20201104193549.4026187-24-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201104193549.4026187-1-lee.jones@linaro.org>
References: <20201104193549.4026187-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/tty/synclink_gt.c:633: warning: Function parameter or member 'tty' not described in 'ldisc_receive_buf'
 drivers/tty/synclink_gt.c:633: warning: Function parameter or member 'data' not described in 'ldisc_receive_buf'
 drivers/tty/synclink_gt.c:633: warning: Function parameter or member 'flags' not described in 'ldisc_receive_buf'
 drivers/tty/synclink_gt.c:633: warning: Function parameter or member 'count' not described in 'ldisc_receive_buf'
 drivers/tty/synclink_gt.c:1683: warning: Function parameter or member 'txqueue' not described in 'hdlcdev_tx_timeout'

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: paulkf@microgate.com
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/tty/synclink_gt.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index afa4cc52e48d7..c0b384e3ed4de 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -620,7 +620,7 @@ static inline int sanity_check(struct slgt_info *info, char *devname, const char
 	return 0;
 }
 
-/**
+/*
  * line discipline callback wrappers
  *
  * The wrappers maintain line discipline references
@@ -1678,6 +1678,7 @@ static int hdlcdev_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 /**
  * hdlcdev_tx_timeout - called by network layer when transmit timeout is detected
  * @dev: pointer to network device structure
+ * @txqueue: unused
  */
 static void hdlcdev_tx_timeout(struct net_device *dev, unsigned int txqueue)
 {
-- 
2.25.1


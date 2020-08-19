Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E2B24975E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 09:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgHSH3s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 03:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHSHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 03:24:19 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C89AC061359
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:15 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g8so1078959wmk.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 00:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JMy0Elzxv6D70JA3ki/IhZMZdSeQ2746f7kuidJvSJA=;
        b=KewUdkqIeiH999bep6LBPSowaQhIkhIKmDzotMinsOFwZ1b9eEVdgbQ9qhlSlP7ghz
         qrhJon7dBHxLHyOEhb8qunfpMt10g/1IiTwNonnepmwhPkvwRsVhqr5gxHsqLPmu9u9B
         FTbzj8uXY4h6oeAMuyz79Wdz6+pCzV3iG+CWq3JP0tw1o3Rwr/ardJlmASb6g0hct23x
         4hTE8OLmwQhyNMNwED1LgxnjwTa1qGiIi9ebfM5Dsk/R/QG0CU3qv/gYXzBwdXbgdruO
         w0pwhq/ldBbRfTuFUdlYHqmaDi8+YHJ0ECYagZNWZpfLIhVeLeD5w0iihdojw9T2uQRp
         ZzWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JMy0Elzxv6D70JA3ki/IhZMZdSeQ2746f7kuidJvSJA=;
        b=HrwaHhkhFDywo/2WEJ53RgBEinQ6arJG9IZhy8EFY2dCOd//cXPZL13N88IeEpioOE
         2pGgAOjAne0OKQ9e9IL3qiE+rqWw+4f0j2taHmHjVwpzuYxOWXEA90vH+bTzAUDjkhxI
         DnURjtG+0jo0MPX+0yMoAQVkI8qhZ4FoBFBSyJWmRPrrlmHcFNIlT3kir+dDJt5SazMy
         EZkolI5OtkVUMYREwDGxQuMRRo/b6B9DdX/c0GgUiwTmkJkIvmWhcucAUXCDLZADdXMP
         7IQETxlGUOaUOAG30VFI5soWXtUQSeQ3rVOr/5DBFViFJmmUA+cc87opiVUCjItFiiNP
         GGBg==
X-Gm-Message-State: AOAM5314q7gfCsRYa53hGhxLdTVATVqIaM7BFSrWLljnyuJ2CM/VznqT
        rQE7fWPsFVnUJUYv4mu9Y+SO8vj2+po9kA==
X-Google-Smtp-Source: ABdhPJx0sP8MG924kEf6+OIAY1Jj5GkNQ0h7vfu5QspVEITQS5Wui0ZSPoKkeGPnDpsYmB7w40HiPQ==
X-Received: by 2002:a1c:96d7:: with SMTP id y206mr3485361wmd.9.1597821853823;
        Wed, 19 Aug 2020 00:24:13 -0700 (PDT)
Received: from dell.default ([95.149.164.62])
        by smtp.gmail.com with ESMTPSA id c145sm3795808wmd.7.2020.08.19.00.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 00:24:13 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org, Lee Jones <lee.jones@linaro.org>
Subject: [PATCH 07/28] wireless: marvell: libertas_tf: Fix a bunch of function doc formatting issues
Date:   Wed, 19 Aug 2020 08:23:41 +0100
Message-Id: <20200819072402.3085022-8-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200819072402.3085022-1-lee.jones@linaro.org>
References: <20200819072402.3085022-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kerneldoc expects attributes/parameters to be in '@*.: ' format and
gets confused if the variable does not follow the type/attribute
definitions.

Also demote one stray non-kernel-doc header.

Fixes the following W=1 kernel build warning(s):

 drivers/net/wireless/marvell/libertas_tf/cmd.c:44: warning: Function parameter or member 'priv' not described in 'lbtf_cmd_copyback'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:44: warning: Function parameter or member 'extra' not described in 'lbtf_cmd_copyback'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:44: warning: Function parameter or member 'resp' not described in 'lbtf_cmd_copyback'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:80: warning: Function parameter or member 'priv' not described in 'lbtf_update_hw_spec'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:150: warning: Function parameter or member 'priv' not described in 'lbtf_set_channel'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:150: warning: Function parameter or member 'channel' not described in 'lbtf_set_channel'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:277: warning: Function parameter or member 'priv' not described in '__lbtf_cleanup_and_insert_cmd'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:277: warning: Function parameter or member 'cmdnode' not described in '__lbtf_cleanup_and_insert_cmd'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:442: warning: Function parameter or member 'priv' not described in 'lbtf_allocate_cmd_buffer'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:490: warning: Function parameter or member 'priv' not described in 'lbtf_free_cmd_buffer'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:527: warning: Function parameter or member 'priv' not described in 'lbtf_get_cmd_ctrl_node'
 drivers/net/wireless/marvell/libertas_tf/cmd.c:561: warning: Function parameter or member 'priv' not described in 'lbtf_execute_next_command'

Cc: Kalle Valo <kvalo@codeaurora.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: linux-wireless@vger.kernel.org
Cc: netdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 .../net/wireless/marvell/libertas_tf/cmd.c    | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas_tf/cmd.c b/drivers/net/wireless/marvell/libertas_tf/cmd.c
index a0b4c9debc11f..efb98304555ad 100644
--- a/drivers/net/wireless/marvell/libertas_tf/cmd.c
+++ b/drivers/net/wireless/marvell/libertas_tf/cmd.c
@@ -32,10 +32,10 @@ static struct cmd_ctrl_node *lbtf_get_cmd_ctrl_node(struct lbtf_private *priv);
 /**
  *  lbtf_cmd_copyback - Simple callback that copies response back into command
  *
- *  @priv	A pointer to struct lbtf_private structure
- *  @extra	A pointer to the original command structure for which
+ *  @priv:	A pointer to struct lbtf_private structure
+ *  @extra:	A pointer to the original command structure for which
  *		'resp' is a response
- *  @resp	A pointer to the command response
+ *  @resp:	A pointer to the command response
  *
  *  Returns: 0 on success, error on failure
  */
@@ -72,7 +72,7 @@ static void lbtf_geo_init(struct lbtf_private *priv)
 /**
  *  lbtf_update_hw_spec: Updates the hardware details.
  *
- *  @priv    	A pointer to struct lbtf_private structure
+ *  @priv:    	A pointer to struct lbtf_private structure
  *
  *  Returns: 0 on success, error on failure
  */
@@ -141,8 +141,8 @@ int lbtf_update_hw_spec(struct lbtf_private *priv)
 /**
  *  lbtf_set_channel: Set the radio channel
  *
- *  @priv	A pointer to struct lbtf_private structure
- *  @channel	The desired channel, or 0 to clear a locked channel
+ *  @priv:	A pointer to struct lbtf_private structure
+ *  @channel:	The desired channel, or 0 to clear a locked channel
  *
  *  Returns: 0 on success, error on failure
  */
@@ -268,7 +268,7 @@ static void lbtf_submit_command(struct lbtf_private *priv,
 	lbtf_deb_leave(LBTF_DEB_HOST);
 }
 
-/**
+/*
  *  This function inserts command node to cmdfreeq
  *  after cleans it. Requires priv->driver_lock held.
  */
@@ -434,7 +434,7 @@ void lbtf_set_mac_control(struct lbtf_private *priv)
 /**
  *  lbtf_allocate_cmd_buffer - Allocates cmd buffer, links it to free cmd queue
  *
- *  @priv	A pointer to struct lbtf_private structure
+ *  @priv:	A pointer to struct lbtf_private structure
  *
  *  Returns: 0 on success.
  */
@@ -482,7 +482,7 @@ int lbtf_allocate_cmd_buffer(struct lbtf_private *priv)
 /**
  *  lbtf_free_cmd_buffer - Frees the cmd buffer.
  *
- *  @priv	A pointer to struct lbtf_private structure
+ *  @priv:	A pointer to struct lbtf_private structure
  *
  *  Returns: 0
  */
@@ -519,7 +519,7 @@ int lbtf_free_cmd_buffer(struct lbtf_private *priv)
 /**
  *  lbtf_get_cmd_ctrl_node - Gets free cmd node from free cmd queue.
  *
- *  @priv		A pointer to struct lbtf_private structure
+ *  @priv:		A pointer to struct lbtf_private structure
  *
  *  Returns: pointer to a struct cmd_ctrl_node or NULL if none available.
  */
@@ -553,7 +553,7 @@ static struct cmd_ctrl_node *lbtf_get_cmd_ctrl_node(struct lbtf_private *priv)
 /**
  *  lbtf_execute_next_command: execute next command in cmd pending queue.
  *
- *  @priv     A pointer to struct lbtf_private structure
+ *  @priv:     A pointer to struct lbtf_private structure
  *
  *  Returns: 0 on success.
  */
-- 
2.25.1


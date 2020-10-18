Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13EF291711
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 13:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgJRLA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 07:00:56 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60291 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726486AbgJRLAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 07:00:55 -0400
X-Greylist: delayed 559 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 07:00:54 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A47285C00AD;
        Sun, 18 Oct 2020 06:51:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 18 Oct 2020 06:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=septs.email; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=VUJ7KcqLyyVQT8Y4XLEKdxU4S+
        5e7Lh6H2pYNF9gymU=; b=CcnyMy3QtPEQSDbgYc3zUBHGCaBKMq6p7ZBcjjGNk0
        aQV7niZfnEGXQN/NYGZkAlSD3tEXqfEvxO6SA1MAWbg1rapN58ZtLLKQJN4Zjgy+
        ewrpkgg6XRHjyPaEGwkZYJMxjkOlV9ik7QCkSDSN0f5IeHSwOI3SoAuPq/UEzixg
        SPmTfVsHl5+3GgKXJNonjjox++68g3DRaLcgjcd+Hl6xBR3NWnx5k48fnU5G96g4
        Hk/FuElH3g2B9Z4eZLOzvQYnzqS8iujgMhKAhuVeuDdtlu2CtA83z6cP6dEwhyfx
        UY8x0FQKS35/iVLWsF7vIY8uQMPNkmbPnlm4Zx7yOMPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=VUJ7KcqLyyVQT8Y4X
        LEKdxU4S+5e7Lh6H2pYNF9gymU=; b=Ucx9Uxw3r1uJ29JzT2L3r7FkzENqSC0Gm
        4Auz1eD9IEK24SoplbBRrCZKdRUs2PWcUdMtq7YlsCVby/aHpgW/JKevD3gwJAi7
        ORTyrHJhIWYhs3j8UgF/zf4bT42KvL9i8LIvZ+PT0XtcrI2RuiMMErsBbUqmmiI+
        N7EWo0yo9Mbvk+Ul4mhJODjj2Is8wLu4htpG6ezJgzkeGKPzd1+fY9uchLbVKSkA
        tOBmhla2cb/Dp1ZuytVAyvXluykdpYeZZuLzFxQ8BampiEura7mEeOKxyajompgP
        NysTGN2+rzCePgABotbj1GWcpC8xJSJShL6BsEbwdU48pLCoUuFYQ==
X-ME-Sender: <xms:Nh6MX1WmMt2Owu8bz69rlnGmfUovg2RjwOvn-fft2Dylyu0tKU30PQ>
    <xme:Nh6MX1lMUwSlsxIVIIffJeyACZVWW24Wcr1aUbcD9YANXVdpMhbmqI7yF6pPzKPFu
    uPnrIRDQvTKBVhPYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieelgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhephffvufffkffoggfgsedtkeertdertddtnecu
    hfhrohhmpehsvghpthhsuceojhhosgesshgvphhtshdrvghmrghilheqnecuggftrfgrth
    htvghrnhepjeetkeevkeffjefhtdegvdelieeifeetveegtdeggffgueeivdegveffueev
    vedunecukfhppeeiuddrudejfedrkedrudekudenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehjohgssehsvghpthhsrdgvmhgrihhl
X-ME-Proxy: <xmx:Nh6MXxbQezXrTh32ZNlmyG0whQxQ6QJMZklPyr9wpl3d9Iu64HMMCw>
    <xmx:Nh6MX4XJ1i-wZb3sUtmrQFeFdzZvCmQAexh632TKvwIpensbKkGzTA>
    <xmx:Nh6MX_kPYbDMByUmO7ksj6g9EBPSzzV243FAirN2l8CyDRgpKoAxrA>
    <xmx:Nh6MX0zDNrgjhUUj7y0wkdfrPTNl7GrN6OLPuWKRp3R0ewJ8hMd1Sg>
Received: from localhost.localdomain (unknown [61.173.8.181])
        by mail.messagingengine.com (Postfix) with ESMTPA id B349A306467D;
        Sun, 18 Oct 2020 06:51:24 -0400 (EDT)
From:   septs <job@septs.email>
To:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     septs <kernel@septs.pw>
Subject: [PATCH 1/1] usb: serial: option: add Quectel EC200T module support
Date:   Sun, 18 Oct 2020 18:51:11 +0800
Message-Id: <20201018105111.8727-1-kernel@septs.pw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb product id of the Quectel EC200T module.
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2a3bfd6f8..7e879233b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -250,6 +250,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
+#define QUECTEL_PRODUCT_EC200T			0x6026
 
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
@@ -1117,6 +1118,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
-- 
2.25.1


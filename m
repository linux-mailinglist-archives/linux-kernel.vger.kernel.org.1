Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC5F292B2A
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730596AbgJSQKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:10:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33567 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730390AbgJSQKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:10:01 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D99E95C01A5;
        Mon, 19 Oct 2020 12:09:59 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute4.internal (MEProxy); Mon, 19 Oct 2020 12:09:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=septs.pw; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm1; bh=4WHFq5lnrAVJsB5ruAH8StysG8+I2TxkYMI4/A1tq5Q=; b=lX8dOeQY
        LpLyVLAdvwHmw9qrpQyBVFbeiWekoSxFQpalzky+B4SpnT0YYj/gR5cBO/E0bTuN
        zxlA3+6EkYy6r3DJwt3KXVyrxjpE/hds3fNB8ELiTDwaK92pz5YguCFNN1IDbx/4
        GXorX8wCVI9jg84cq6fbCoFLqYMhTAK0TDuyG9MDkh4LCmA4ZGxTRPcOEwVD5jjb
        BtwZSBDv3OmOk4dSNszPl0J9lBYlg7Bl+Fjz4ElINroCsPiMeACysgkiI6VH69lq
        7+iZ89xE1eBfeSCcGvPNMX2V6sapPmAvDp+Gn++mUEe47bJEhu434qs+0g3riF5X
        OW6iFynZABB3Mw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm1; bh=4WHFq5lnrAVJsB5ruAH8StysG8+I2
        TxkYMI4/A1tq5Q=; b=iIi8UJ+hwN3GjR6CTenmpkrRLe3+HqAAufJtZ/XSoVGwl
        ZSLfFm0tgvzO4PDanno0IAnwDFjtjOoGs9PBJykCjW/Jx+/wZ3pScHDzrqqH+TZo
        gTSajmcuprAW8Zqmyz9VcgXreIsCiuihEL/qPoDzYrRXnqDFmVFgPvHQIwWxFT+u
        uAnx+dKx9vcUNEdFl5R4QX/GrJAyeZOT5NHpeRXIijhxmGYuUDXKWbJCzg5prCIa
        HOQFTv3YYmRPf1y+ENXFxIrMxqhRbLhC9BeUX9vRTpZpd28BRd6oxnQm/cVB/RbB
        4uOTixU5PqT1d9h2en5gtnaQ13wSYRBXm2Pkw9HfA==
X-ME-Sender: <xms:V7qNX3BQC_2_tVRXTjWyBdpQmaTNBW2XM4pIFYHUu1LNFJOWNotfqA>
    <xme:V7qNX9j7S3cvbD-ijIqCcVsRyCBX4e3Z1tDl1Wwh84kT7Migv91C0Q867DqQMB_CY
    bci53vg5xQqEKRRlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjedugdelkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepofgfggfkfffhvffutgesthdtredtreertden
    ucfhrhhomhepfdgkihihihcuvegrohdfuceokhgvrhhnvghlsehsvghpthhsrdhpfieqne
    cuggftrfgrthhtvghrnhepffejuedtueffueduudduiefgleduhefhleeklefhgfegtdfg
    feffieeiueehhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepkhgvrhhnvghlsehsvghpthhsrdhpfi
X-ME-Proxy: <xmx:V7qNXymjHoKYFA9RZqKYiAhSurotckVMAFY-_mC-0mcR6tKLTgt8ow>
    <xmx:V7qNX5y6USriLUCP2aHjhT-ushtF1BJzIVHhfv6utO0XnEP-pgoEFg>
    <xmx:V7qNX8RgiP4MaqX8rlyA2Es65lsaget4qxI4L1WTgO2cgb9snFAGAg>
    <xmx:V7qNX3L9Ui8g9v12-xUBjSFxeNkBgyPtyNX9qWiuNFN23ZZzQZlOEw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 71EFD20093; Mon, 19 Oct 2020 12:09:59 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-489-gf39678d-fm-20201011.001-gf39678d0
Mime-Version: 1.0
Message-Id: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
Date:   Tue, 20 Oct 2020 00:08:06 +0800
From:   "Ziyi Cao" <kernel@septs.pw>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Johan Hovold" <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: serial: option: add Quectel EC200T module support
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb product id of the Quectel EC200T module.

Signed-off-by: Ziyi Cao <kernel@septs.pw>
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

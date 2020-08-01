Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770623535C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Aug 2020 18:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgHAQ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Aug 2020 12:29:59 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44369 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725841AbgHAQ37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 12:29:59 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id F400B5C0073;
        Sat,  1 Aug 2020 12:29:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 01 Aug 2020 12:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=53Jxaj3NoHeE/kFuF4Ggf7Os2J
        Cj0STpNlmUixXXrgc=; b=RGpVdE6RgdbHMd8hiA7W9m/ow2qPINGWeYYQs9VWrt
        gSEjZ4HEu33hx36JMWxDB46Vt7J8T92XYF1CVoOhG3PaYIwfFUQS/y5InIabgTpF
        ZaMz0IMKuAChOSJWw7UfzbBqzU4DbrfAnYO7BZCPPsH3u7Sb6Zzj+efMDky/enh0
        6tKqdnuYlLAmRIGWYMThepHEhC74gsJ4CpI2Xtfaiqjle5kiYKjb/ntc2QbewKei
        6uf8KwQw6USi1nSnYbmrIHt1hw7zcHXiP0PGORfEGibNdYMzCttWt3eNKuZPWkdr
        UTCFwjeGmpTPoEJpiHFNBpzC6bjeMY28uQITgcC6O2Fg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=53Jxaj3NoHeE/kFuF
        4Ggf7Os2JCj0STpNlmUixXXrgc=; b=RaOPscq5J9gKRyrU9eXsuO48kqRwOcFV4
        erpZMPM0/Cb1DpJjtTYXVXgN7U27dNfAN5qCEhLofjPh8ZfRuMDuTX6LNaXUvQey
        L0BeoNnTNPwblCPXpCocM7WNuScNCcVIOxWTUaxEypiXf4NZr3KIhAxY7vamx+FS
        RhRBMYlL+SUS1+eWdxSpusAVrVjCX6KAkyUaoY12ypFbOeDJU8JR7vsAnmY88LOQ
        2JYDHF3gwJ78jNxtHkFKLrR5KSag0F5t3ZobItiSJS+7eTArB1zCHzf90u0C7R1z
        nbE6P8fqFbXbHsFEsplOq3Mh128JsbjMi8CciyYNSVrSgtCJ4RhRQ==
X-ME-Sender: <xms:hZglXxyHLUXTQYXFByO06rMs11fYPD2d7BOZUFNU8zR-1-cFU7We4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjedtgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeeiteekhfehuddugfeltddufeejjeefgeevheekueffhffhjeekheeiffdt
    vedtveenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdr
    ohhrgh
X-ME-Proxy: <xmx:hZglXxTLi3karcXXB8vvyrDtYpemTkk4X9k3DBz2KQGb9vWYNL9Cww>
    <xmx:hZglX7XHyd4PgqJqcrunWDDYAtZ8it5KYv0Dd-NeXVlXAbyr504fyQ>
    <xmx:hZglXzgSFnv50RyH19RxSbkAShXtuJK9s18pKSsS4W3B5xeestuX-g>
    <xmx:hZglX6OqhptTELDV0yFhlykH9_BpcZQSRub_GmYvQ6hCUIUyJOoTjw>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1E5D730600A3;
        Sat,  1 Aug 2020 12:29:57 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Gustavo Padovan <gustavo.padovan@collabora.co.uk>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 1/2] Bluetooth: hci_h5: Remove ignored flag HCI_UART_RESET_ON_INIT
Date:   Sat,  1 Aug 2020 11:29:55 -0500
Message-Id: <20200801162956.22610-1-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit cba736465e5c ("Bluetooth: hci_serdev: Remove setting of
HCI_QUIRK_RESET_ON_CLOSE."), this flag is ignored for hci_serdev users,
so let's remove setting it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/bluetooth/hci_h5.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h5.c b/drivers/bluetooth/hci_h5.c
index e41854e0d79a..981d96cc7695 100644
--- a/drivers/bluetooth/hci_h5.c
+++ b/drivers/bluetooth/hci_h5.c
@@ -793,8 +793,6 @@ static int h5_serdev_probe(struct serdev_device *serdev)
 	if (!h5)
 		return -ENOMEM;
 
-	set_bit(HCI_UART_RESET_ON_INIT, &h5->serdev_hu.hdev_flags);
-
 	h5->hu = &h5->serdev_hu;
 	h5->serdev_hu.serdev = serdev;
 	serdev_device_set_drvdata(serdev, h5);
-- 
2.26.2


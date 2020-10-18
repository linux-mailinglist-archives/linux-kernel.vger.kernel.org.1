Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E304291FAC
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 22:06:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgJRUGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 16:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgJRUGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 16:06:44 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E482C061755
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:06:44 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 23so4888229ljv.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Oct 2020 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/yIw3iAR/1P5k0So8EgvrDXUbc+1qYmRQGCO4NWl/w=;
        b=b69PazCEQHn7OPDdCs/gWBr8mjGJRM7gm6e07VMEpYBiGYaCSPVJiHlPxXRRGKoJiy
         NTv8hkJrp1Zqjj34xJtZnTsNh/CVAspSmOO+SOLxdo9UWudTCfQKTYskkg1BBRQ8HpTp
         hApFjixJXxApYqbYVhgmsV31broLa9pJhRIDdDXVyWoNPbALPLvwYGstE3fOJasPzg0s
         6xFodBWvZG7u2SG2IAL1u5/AXwhTOVmK9N7egCQs56PiXovVirJUU75LdpPOJCeWLyw9
         VaTeOQ50i9m2ZSO5moOFj7rMEdBj94Pbjsm6SmZSRmlCnmjFxA/2vUNCDVofXhYhDVjK
         aZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2/yIw3iAR/1P5k0So8EgvrDXUbc+1qYmRQGCO4NWl/w=;
        b=Bbf2QhA58Psl7LbsBYONiOZ9M/wmNVbHbGEeVkNA/aC8FcKZnToMZUlr4mecDTv2Cv
         KZlSvmrs22PO5odLwNWwLYNYZfWWO9PW4Ile6rHQC86me7svhguRb9YLauXib0V1Kp0n
         R4FIElDgztJzNojYpgv7WF3Z8oK5Hua6zyK+tSQDKiIJ92Oy/uUKoMYyekQycexbcA+c
         wSuuxu0WO1sY9wMqb/s2WN0akNHnerdjpR1RUgY4fapdug+REFHZKgPDeKKz1UzgebNd
         9qRiv9zkfFlajnyVbUh4XLS3qESLBa16L7/w6yeoLKCt+ss+R207v0rjuYmacR0ag1Nq
         xWJQ==
X-Gm-Message-State: AOAM532nHEBFqWRwyERxIrednGtsZgDSu8JLjXZfd/TPq0uhEBE6HPXH
        RlWi6brFvTdD4BC+nmjpYz97OZo+iFs=
X-Google-Smtp-Source: ABdhPJxI8070+K/ZJqjo/lQBAaeG9lXgtxCzHV5F0lo2CGbRsBaXz+7QXfe3Rlh7v9IYpYGTHXrcTg==
X-Received: by 2002:a2e:924d:: with SMTP id v13mr5477780ljg.375.1603051602303;
        Sun, 18 Oct 2020 13:06:42 -0700 (PDT)
Received: from alpha (10.177.smarthome.spb.ru. [109.71.177.10])
        by smtp.gmail.com with ESMTPSA id m19sm2878691lfl.38.2020.10.18.13.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:06:41 -0700 (PDT)
Received: (nullmailer pid 40529 invoked by uid 1000);
        Sun, 18 Oct 2020 20:12:07 -0000
From:   Ivan Safonov <insafonov@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Ivan Safonov <insafonov@gmail.com>
Subject: [PATCH] staging: r8188eu: inline rtw_init_netdev_name()
Date:   Sun, 18 Oct 2020 23:11:33 +0300
Message-Id: <20201018201132.40480-1-insafonov@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtw_init_netdev_name() is a small function
that is used once and does not encapsulate any logic.

Signed-off-by: Ivan Safonov <insafonov@gmail.com>
---
 drivers/staging/rtl8188eu/include/osdep_intf.h | 1 -
 drivers/staging/rtl8188eu/os_dep/os_intfs.c    | 9 ---------
 drivers/staging/rtl8188eu/os_dep/usb_intf.c    | 6 +++++-
 3 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/rtl8188eu/include/osdep_intf.h b/drivers/staging/rtl8188eu/include/osdep_intf.h
index 07c32768f649..5ee4ed995025 100644
--- a/drivers/staging/rtl8188eu/include/osdep_intf.h
+++ b/drivers/staging/rtl8188eu/include/osdep_intf.h
@@ -23,7 +23,6 @@ void rtw_cancel_all_timer(struct adapter *padapter);
 
 int rtw_ioctl(struct net_device *dev, struct ifreq *rq, int cmd);
 
-int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname);
 struct net_device *rtw_init_netdev(struct adapter *padapter);
 u16 rtw_recv_select_queue(struct sk_buff *skb);
 
diff --git a/drivers/staging/rtl8188eu/os_dep/os_intfs.c b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
index e291df87f620..c80d30f31869 100644
--- a/drivers/staging/rtl8188eu/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8188eu/os_dep/os_intfs.c
@@ -292,15 +292,6 @@ static const struct net_device_ops rtw_netdev_ops = {
 	.ndo_do_ioctl = rtw_ioctl,
 };
 
-int rtw_init_netdev_name(struct net_device *pnetdev, const char *ifname)
-{
-	if (dev_alloc_name(pnetdev, ifname) < 0)
-		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("dev_alloc_name, fail!\n"));
-
-	netif_carrier_off(pnetdev);
-	return 0;
-}
-
 static const struct device_type wlan_type = {
 	.name = "wlan",
 };
diff --git a/drivers/staging/rtl8188eu/os_dep/usb_intf.c b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
index 99bfc828672c..43ebd11b53fe 100644
--- a/drivers/staging/rtl8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/rtl8188eu/os_dep/usb_intf.c
@@ -390,7 +390,11 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		pr_debug("can't get autopm:\n");
 
 	/*  alloc dev name after read efuse. */
-	rtw_init_netdev_name(pnetdev, padapter->registrypriv.ifname);
+	if (dev_alloc_name(pnetdev, padapter->registrypriv.ifname) < 0)
+		RT_TRACE(_module_os_intfs_c_, _drv_err_, ("dev_alloc_name, fail!\n"));
+
+	netif_carrier_off(pnetdev);
+
 	rtw_macaddr_cfg(padapter->eeprompriv.mac_addr);
 	memcpy(pnetdev->dev_addr, padapter->eeprompriv.mac_addr, ETH_ALEN);
 	pr_debug("MAC Address from pnetdev->dev_addr =  %pM\n",
-- 
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D0292CA4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 19:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730624AbgJSR0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 13:26:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51551 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729556AbgJSR0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 13:26:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603128376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=aVNN1C4LAhUWrEh6nN2bC8yXuvzsPM7VbyNnh38X8Js=;
        b=WwI1tRhJrSPAfCCu1B0KAef9lvpUieFn0Ww0ibYB0j7Dl0916X/rtPcN52u2u09vbWdn8/
        lRmAB+MdNX/jhAoXyZ87IF1KDdvJrV5ow6uI5DDCLTeCh7jFFwDwRfsulckRqMfaxEgtxj
        /fyMa2aBmAe3x7fPKealSlF3HEkfiOk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-110-E7ucUsdOOxegjY6dDWxVlQ-1; Mon, 19 Oct 2020 13:26:14 -0400
X-MC-Unique: E7ucUsdOOxegjY6dDWxVlQ-1
Received: by mail-qt1-f200.google.com with SMTP id d1so399426qtq.12
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 10:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aVNN1C4LAhUWrEh6nN2bC8yXuvzsPM7VbyNnh38X8Js=;
        b=g8+UDgd2jlJqCzFDT7O26emr2F69yNSWHqUEHIcCvU1PlS5gB2K/T5icdXfyy33Hkh
         V2CE4XCN0hRRGZ9HzIxs8unPTHSvE7PV1ku8R/U4XqHb1bgL3uniKl+eimEqwYdsZ+1z
         43inRLHOXjDPIje+ch4ictjYWwVZY7lqc3LoRnEI0d+j0GjQweBq0ryYwo/J/grgI0/l
         nzXYHsAzODtx9Z7D2A7x2lfohFSoSEEJPpJXGdJgbn75ZcKKURtv96b/X/pjGoatRCMF
         9Gw8xRinzXEdhORqCzXlJBMHoXnWr0LgtBY+RoWREsyKC4DXmNY+mfvuRvys5HU65TT0
         bXlA==
X-Gm-Message-State: AOAM531SAxRd2CgIubQT1pId0zrxSzYdGlWC6d6q2uxGU+lbvRjsKL+W
        31yw3tJu1mtDb7mUPrkFouoktBgL8SQR8ws+UgLQxPc7KQNU7LNZVIOqvVfkq2CFwxV5LSVJAUd
        jUnzh1G6J/DbNKZSV9fCPohB6
X-Received: by 2002:a37:a251:: with SMTP id l78mr562660qke.291.1603128373874;
        Mon, 19 Oct 2020 10:26:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyJsKJNW3l1vaCdXKu71mlHfkWuJrWdzvbnm3fDmbdSsQlxEmc6RtS4ldJcTGmPfXxmIylQKw==
X-Received: by 2002:a37:a251:: with SMTP id l78mr562637qke.291.1603128373609;
        Mon, 19 Oct 2020 10:26:13 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id a21sm228385qtb.30.2020.10.19.10.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 10:26:12 -0700 (PDT)
From:   trix@redhat.com
To:     irusskikh@marvell.com, davem@davemloft.net, kuba@kernel.org,
        benve@cisco.com, _govind@gmx.com, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, bigeasy@linutronix.de,
        tglx@linutronix.de
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: remove unneeded break
Date:   Mon, 19 Oct 2020 10:26:07 -0700
Message-Id: <20201019172607.31622-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/aquantia/atlantic/aq_nic.c | 1 -
 drivers/net/ethernet/cisco/enic/enic_ethtool.c  | 1 -
 drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c   | 1 -
 drivers/net/wan/lmc/lmc_proto.c                 | 4 ----
 4 files changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
index 0f865daeb36d..bf5e0e9bd0e2 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_nic.c
@@ -1163,7 +1163,6 @@ int aq_nic_set_link_ksettings(struct aq_nic_s *self,
 		default:
 			err = -1;
 			goto err_exit;
-		break;
 		}
 		if (!(self->aq_nic_cfg.aq_hw_caps->link_speed_msk & rate)) {
 			err = -1;
diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index a4dd52bba2c3..1a9803f2073e 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -434,7 +434,6 @@ static int enic_grxclsrule(struct enic *enic, struct ethtool_rxnfc *cmd)
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	fsp->h_u.tcp_ip4_spec.ip4src = flow_get_u32_src(&n->keys);
diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
index de563cfd294d..4b93ba149ec5 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c
@@ -350,7 +350,6 @@ static s32 ixgbe_calc_eeprom_checksum_X540(struct ixgbe_hw *hw)
 		if (ixgbe_read_eerd_generic(hw, pointer, &length)) {
 			hw_dbg(hw, "EEPROM read failed\n");
 			return IXGBE_ERR_EEPROM;
-			break;
 		}
 
 		/* Skip pointer section if length is invalid. */
diff --git a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
index e8b0b902b424..4e9cc83b615a 100644
--- a/drivers/net/wan/lmc/lmc_proto.c
+++ b/drivers/net/wan/lmc/lmc_proto.c
@@ -89,17 +89,13 @@ __be16 lmc_proto_type(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
     switch(sc->if_type){
     case LMC_PPP:
 	    return hdlc_type_trans(skb, sc->lmc_device);
-	    break;
     case LMC_NET:
         return htons(ETH_P_802_2);
-        break;
     case LMC_RAW: /* Packet type for skbuff kind of useless */
         return htons(ETH_P_802_2);
-        break;
     default:
         printk(KERN_WARNING "%s: No protocol set for this interface, assuming 802.2 (which is wrong!!)\n", sc->name);
         return htons(ETH_P_802_2);
-        break;
     }
 }
 
-- 
2.18.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638C12C6B57
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 19:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbgK0SHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 13:07:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39878 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732038AbgK0SHU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 13:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606500438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=H7PcvPg+i5XoUPzJor4eQ+x6uH9OtzkraZC8rlH6KWc=;
        b=Sd6qm5sVs0pBC29sQ05iQg33dlr7sop+KCab0CrMRg9A3TRRZ+LGgq1GO8DOFRgqJsYShn
        0LPG7KY9KEfcAidQdlC7gdKXOhdmU8YEoCRyN+DO5aE/Hwf1tApRi7ghHoevKysYjz4lrL
        gy3J27PzTpx7IW3pKEEsya//LG3zgMY=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-E_vSySwHOaemTZLyRA1iJA-1; Fri, 27 Nov 2020 13:07:16 -0500
X-MC-Unique: E_vSySwHOaemTZLyRA1iJA-1
Received: by mail-qk1-f200.google.com with SMTP id q21so4135084qkq.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 10:07:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=H7PcvPg+i5XoUPzJor4eQ+x6uH9OtzkraZC8rlH6KWc=;
        b=UooqzqFvY6Bg2ru8T3QM31tq5Lu3dhzJaiGIHYQogTwRW3bOFN2gk7f1fa/7SqhCFh
         XkRzok3m/EBtAZKAkrQYBs25v3adeHTwVzN6ZZvF7vGtxpAL0++zIA7D3TUxaqmfUTSD
         th/UaDL5bb7+KVKHDbguaFbRJeWrSjgy2q4H0J++Wjb0r41fKk8hn1pgHLCwQJkw5+Ty
         oBlqMqGc92sEAQTMI/+vH3cnQ+eqfj0u8gkrPDb0hmWajHFcDjnQYdlov9XU2JydW7Of
         gsPv5P+xG4vOpOASSgLi6FHiXW4R6we+2sqRupWsEd7wR9SHKQuraokcN11QM0K3CQa3
         c+ig==
X-Gm-Message-State: AOAM530SYOyrFeLpkMAn/bKw7azPUES03Exjjk/rtHy8HPISlwxV/2SX
        KpfL1N+QRKb2d/+UiCTo8a9p/y/s1YjGqudBM34VrayWwIxL2dYx0quvGxX0VX3zQ4eOK65aQrF
        DREvBEQE2Mu/XIajx+MCG2VG4
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr9497611qta.364.1606500436290;
        Fri, 27 Nov 2020 10:07:16 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrczAlHXv6AxBn4va9GpnW6SljlzQRkczv7FkNfINZgV5uL21V1Nx739W7zcwEcXppYH5Pjg==
X-Received: by 2002:ac8:5ccc:: with SMTP id s12mr9497583qta.364.1606500436056;
        Fri, 27 Nov 2020 10:07:16 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id r127sm6740373qke.64.2020.11.27.10.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 10:07:15 -0800 (PST)
From:   trix@redhat.com
To:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com,
        kvalo@codeaurora.org, davem@davemloft.net, kuba@kernel.org,
        lee.jones@linaro.org
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] net: iwlwifi: remove trailing semicolon in macro definition
Date:   Fri, 27 Nov 2020 10:07:09 -0800
Message-Id: <20201127180709.2766925-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The macro use will already have a semicolon.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c      | 2 +-
 drivers/net/wireless/intel/iwlwifi/fw/api/coex.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
index 9d55ece05020..7b2f71e48c97 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/rx.c
@@ -318,7 +318,7 @@ iwlagn_accumulative_statistics(struct iwl_priv *priv,
 		    (__le32 *)&priv->delta_stats._name,		\
 		    (__le32 *)&priv->max_delta_stats._name,	\
 		    (__le32 *)&priv->accum_stats._name,		\
-		    sizeof(*_name));
+		    sizeof(*_name))
 
 	ACCUM(common);
 	ACCUM(rx_non_phy);
diff --git a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
index 68060085010f..8f7c9b7eeeac 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
+++ b/drivers/net/wireless/intel/iwlwifi/fw/api/coex.h
@@ -199,7 +199,7 @@ enum iwl_bt_mxbox_dw3 {
 					 "\t%s: %d%s",			    \
 					 #_field,			    \
 					 BT_MBOX_MSG(notif, _num, _field),  \
-					 true ? "\n" : ", ");
+					 true ? "\n" : ", ")
 enum iwl_bt_activity_grading {
 	BT_OFF			= 0,
 	BT_ON_NO_CONNECTION	= 1,
-- 
2.18.4


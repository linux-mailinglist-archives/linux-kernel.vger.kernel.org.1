Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CFC42D21C3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 05:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgLHEIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbgLHEIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:08:19 -0500
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07406C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 20:07:38 -0800 (PST)
Received: by mail-il1-x142.google.com with SMTP id j12so7196496ilk.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 20:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXnHiFhA62oVUcQ34nxEosBhVg1xsDqILWNASVrluOk=;
        b=CSwYIMWIqxqSQyY1CF+/zvtA3ng62R7i74zjhvLqY1OsxrfXDEBsOlQ5IQnPpL7Svi
         1kPP4nGCzCMa85Cs6B+Tc4TjOY/2l80uHFNO04mQbvQRvcdkm01P2AvXvXMvIrpuKLxX
         7ZPY4479tEY5hwjqwCFuffhCKfM2YFiFjOaiqcsoeu4Xoahv3RJmZpIDtxN4FuA3OXvU
         HRDPhNFSoLc/e8r3jq94M0t8BKTr2PnZRgOjvo/LyZH9x/TOp/JN5LOFhIX3RZdvrBvP
         T9PoLv4IJFODmNWyElhBca8uL4QYZs/5UZc0s8M/1AjsPqjWYdPqCBcc+Pixk20dUIld
         mP5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EXnHiFhA62oVUcQ34nxEosBhVg1xsDqILWNASVrluOk=;
        b=V3iMRuSzYBcdepsFDeSYqDh8YKHaXlXvwpf9YqQDP4pUoJUIUfbb0wYDeB7WpKJp/l
         gve9jnqgeAYDRz5VppN1i/5TLnj415EzljpPkAzCDgToSp7tm2UCqyrJfmPxXbqfiuGG
         rX+f/+iPNjvTwlV1ZiAEgAlDRbbIztUVO6RsZvqcrWQ5ARjELpk5NTEXgOPXAGL6zICe
         isyIYCXSVetNR9FcDJ2l5bs/+USCsZ6GUyRK0IvMIexJC39tDmj9OeMMHDYuIzp6F0ou
         g72DjrlJ4lU06LGJX8Del/9jzL1NDEzeCK0CWkB2nMKFmi3D4HRhquz2n3Ch4Sp+ZKvb
         RW3w==
X-Gm-Message-State: AOAM5334GPapVPB/fV4wviCX+aB+GshoPmhVWON56MyodEEf6aJbdlO4
        vDJjreu0Z/n6aeRR5jCXyBriIYKzQ0k=
X-Google-Smtp-Source: ABdhPJwm12RtvwYLO/AYypjmqK/prbrJWpme6ClHwTupI5C/j+MLckhML0/gLISD9w58SzCwmQ48KQ==
X-Received: by 2002:a92:8bcb:: with SMTP id i194mr24199798ild.200.1607400458333;
        Mon, 07 Dec 2020 20:07:38 -0800 (PST)
Received: from localhost.localdomain (c-73-242-81-227.hsd1.mn.comcast.net. [73.242.81.227])
        by smtp.gmail.com with ESMTPSA id g2sm8630390ilh.41.2020.12.07.20.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 20:07:37 -0800 (PST)
From:   Ross Schmidt <ross.schm.dev@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Ross Schmidt <ross.schm.dev@gmail.com>
Subject: [PATCH v2 00/21] replace unique macros and ELEMENT_ID
Date:   Mon,  7 Dec 2020 22:07:12 -0600
Message-Id: <20201208040733.379197-1-ross.schm.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set replaces many macros and the ELEMENT_ID enum with the
ieee80211_eid enum from linux/ieee80211.h. In several cases more than
one macro or constant is replaced by one constant. As suggested, each
constant replacement is separated into a distinct patch.

Changes in v2:
- Single patch divided into per-constant replacement patches

v1 can be found here:
https://lore.kernel.org/driverdev-devel/20201206034517.4276-10-ross.schm.dev@gmail.com/

Ross Schmidt (21):
  staging: rtl8723bs: use WLAN_EID_HT_CAPABILITY
  staging: rtl8723bs: use WLAN_EID_VENDOR_SPECIFIC
  staging: rtl8723bs: use WLAN_EID_RSN
  staging: rtl8723bs: use WLAN_EID_HT_OPERATION
  staging: rtl8723bs: replace WLAN_EID_VHT_OP_MODE_NOTIFY
  staging: rtl8723bs: replace _SSID_IE_
  staging: rtl8723bs: replace _SUPPORTEDRATES_IE_
  staging: rtl8723bs: replace _DSSET_IE_
  staging: rtl8723bs: replace _TIM_IE_
  staging: rtl8723bs: replace _IBSS_PARA_IE_
  staging: rtl8723bs: replace _COUNTRY_IE_
  staging: rtl8723bs: replace _CHLGETXT_IE_
  staging: rtl8723bs: replace _ERPINFO_IE_
  staging: rtl8723bs: replace _EXT_SUPPORTEDRATES_IE_
  staging: rtl8723bs: replace _WAPI_IE_
  staging: rtl8723bs: replace _MME_IE_
  staging: rtl8723bs: replace EID_BSSCoexistence
  staging: rtl8723bs: replace EID_BSSIntolerantChlReport
  staging: rtl8723bs: replace EID_EXTCapability
  staging: rtl8723bs: remove unused macros
  staging: rtl8723bs: remove ELEMENT_ID enum

 drivers/staging/rtl8723bs/core/rtw_ap.c       |  62 ++++----
 drivers/staging/rtl8723bs/core/rtw_cmd.c      |   4 +-
 .../staging/rtl8723bs/core/rtw_ieee80211.c    |  44 +++---
 drivers/staging/rtl8723bs/core/rtw_mlme.c     |  26 ++--
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 146 +++++++++---------
 drivers/staging/rtl8723bs/core/rtw_recv.c     |   4 +-
 drivers/staging/rtl8723bs/core/rtw_security.c |   2 +-
 .../staging/rtl8723bs/core/rtw_wlan_util.c    |  26 ++--
 drivers/staging/rtl8723bs/core/rtw_xmit.c     |  12 +-
 drivers/staging/rtl8723bs/hal/rtl8723b_cmd.c  |  20 +--
 drivers/staging/rtl8723bs/include/ieee80211.h |   8 -
 .../staging/rtl8723bs/include/rtw_security.h  |   3 -
 drivers/staging/rtl8723bs/include/wifi.h      | 108 -------------
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |   4 +-
 .../staging/rtl8723bs/os_dep/ioctl_linux.c    |  14 +-
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c |   2 +-
 16 files changed, 183 insertions(+), 302 deletions(-)

-- 
2.25.1


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 604E11A4D40
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Apr 2020 03:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgDKBep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 21:34:45 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:52379 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgDKBep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 21:34:45 -0400
Received: by mail-pj1-f54.google.com with SMTP id ng8so1400637pjb.2;
        Fri, 10 Apr 2020 18:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vXnmY4GE13NUJnVdfudjFEgcp4akceqh2aSAgwoRhs=;
        b=bTvMgCFnWZeWHXjUFWgncuseF/in8S/JaQ9DCc+Qb6IUbMATNI86dPex4TaZSiPgxX
         lG6q4g34Rv3jxbhxL7FPwUMnl7F/K/PziHdckNyAgZZ5pN8OkRRI/jX+cs7Zpq8ZYwTv
         FzY2KI0sS2gZs379kKgPijpvlsWjQtnVj8YyAZU6K46+ReDCs4IBBxLvYWkYc4lFEcud
         PuMGh36Wgw2DMuEMbrvrfzSg3DgczQx/Ze2ZUbZ5rczZYtehIV+PJ/xxksX0qmb7XFJI
         HbjfM1ULizim3GUPYEdbheYAa65HeBafuSj8E+ZbfI0+1NWZXQXcvrN3A025zSeOiRKI
         h1TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2vXnmY4GE13NUJnVdfudjFEgcp4akceqh2aSAgwoRhs=;
        b=YaUtGbYbYVzqJfucdtCeuClXDa5tYrazBkH4wWfXo4y0EhwX3n/+w1PydaKG7ZMjST
         hm7++R4d4w5G5dFP1KC829cCy0/y38lSAm+A4u1fTY5ddS22NEGfkaTmdNjka6fzv3qL
         aU5fWiKHG19TIGzNVyZ0G/7vLCjSLgJqX3mFTmLvGMB1+GG5KsBHWA7DGPd711Hsjo4U
         bWkNMgFBhq+I16KjSqv/DJIlYL0VACwhMmhigIPCE8EMdlmFeJfFjPgVfJrhY4jd5RQW
         YPHqeToDIVCWZqMfsM5s0wix847D2LIjTK3V4VBE3fSaa54WM7njn7Ip4DBOKPycuCE+
         pXFQ==
X-Gm-Message-State: AGi0Pua0sFLkuosn71APPLhf/iHhWRADxyX6zWUEHa4UTYkV0O8y6Ksk
        eA+reL0Do5ADRKO8OkYhl2Q+6lgEvzY=
X-Google-Smtp-Source: APiQypJXLOYqKf66FVVRwlr7CGclYwDFR1DjV2T1eGTrEr+hfP8WSZvncKCywIXTQF0ljfcgCaueHA==
X-Received: by 2002:a17:902:7582:: with SMTP id j2mr7036794pll.309.1586568884323;
        Fri, 10 Apr 2020 18:34:44 -0700 (PDT)
Received: from i7.zsun.org.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id mg20sm2808571pjb.12.2020.04.10.18.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 18:34:43 -0700 (PDT)
From:   sztsian@gmail.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org
Cc:     sztsian@gmail.com, linux-kernel@vger.kernel.org, icenowy@aosc.io
Subject: [PATCH v3 0/1] Bluetooth: btrtl: Add support for RTL8761B
Date:   Sat, 11 Apr 2020 09:34:26 +0800
Message-Id: <20200411013427.152103-1-sztsian@gmail.com>
X-Mailer: git-send-email 2.25.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ziqian SUN (Zamir) <sztsian@gmail.com>

This patch adds support for the RTL8761B USB Bluetooth dongle.

When I got the RTL8761B dongle, I see it is actually recognised as
RTL8761A in my system (5.5.15-200.fc31.x86_64 on Fedora). And the
userspace cannot detect bluetooth devices in such situation.

[34689.158047] Bluetooth: hci0: RTL: examining hci_ver=0a hci_rev=000b lmp_ver=0a lmp_subver=8761
[34689.159083] Bluetooth: hci0: RTL: rom_version status=0 version=1
[34689.159088] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_fw.bin
[34689.159498] Bluetooth: hci0: RTL: loading rtl_bt/rtl8761a_config.bin
[34689.159522] bluetooth hci0: Direct firmware load for rtl_bt/rtl8761a_config.bin failed with error -2
[34689.159529] Bluetooth: hci0: RTL: cfg_sz -2, total sz 20204
[34691.248484] Bluetooth: hci0: command 0xfc20 tx timeout

Icenowy Zheng offered great help by identifying the firmware
from the vendor-provided Windows driver. After applying this patch along
with the firmware I am able to use this dongle.

Note, I don't have RTL8761A device, so I would appreciate if someone 
can help test in case this patch breaks RTL8761A.
The RTL8761A information is from the following Github issue
https://github.com/lwfinger/rtlwifi_new/issues/58

[   41.468873] Bluetooth: hci0: rtl: examining hci_ver=06 hci_rev=000a lmp_ver=06 lmp_subver=8761

Ziqian SUN (Zamir) (1):
  Bluetooth: btrtl: Add support for RTL8761B

 drivers/bluetooth/btrtl.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

-- 
2.25.2


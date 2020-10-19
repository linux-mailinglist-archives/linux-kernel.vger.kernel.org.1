Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A99E293145
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 00:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388203AbgJSWdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 18:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729840AbgJSWdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 18:33:05 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD1C0613D0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:33:05 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 144so843400pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 15:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3pDJRE4+wryqRjDMM2DZbIxK8mVR/LvDREItkyhu3c=;
        b=UBf2JNQ8qZZWGiFCz4DdbRItgDEOnxjJ1IqT5QSGVjdE8O0d5QxAvIxtJIoOhGJfyg
         HFJfL2bmJ2Q9z6Kqvi1eCfc0uMMht40jTMjuCnp6z1AE0ow8nTEwwiuSFVKhrt62CaZE
         gWfMcjGNGTCfbOorCuydwY4pllCwcD55r8jWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M3pDJRE4+wryqRjDMM2DZbIxK8mVR/LvDREItkyhu3c=;
        b=ZaVsKif1jvrkOCLb/kG01DjNelaCC4PKIE9RTKUYcKitvZP6Pvdcoi1PSirg6T0T6o
         vfxHutoJq0A7Peix7uOXayAVUamNe56rc2mHNPFaaFDBBDvlnpe0r3RmplR7lmsqoD4+
         LaYYmIf7fMt55uhrlyangtHDFfsul3YCBQY5Uw/NHtSY5zP/Ch1UllnIqFNwT1Jw6TF0
         wny+JKOfaEFDdQ+NZOlterRAgAVSWA0+lxRxPOhovGegG6VBmnKF++oilXlH2lKKBiSV
         4TFcOg5nSposT3VL3aMRe5xztbzCOo2dsmIeweRKuvA2Uk4GltxYq/9rE0xrqi9t7wH4
         En4g==
X-Gm-Message-State: AOAM5316PrBl6s2anf+vEA1+ntuMoZr8Jh64ZhQLKkRevRaoSoi/bzN4
        ap7kX7aQXz9Tkr6Lv7A85EwyRA==
X-Google-Smtp-Source: ABdhPJwFqniR+AIdUaQ5iioCkV7/GfusHL4qANxuNb6SEty4PTA7gb2wviKQcDUZ8a/TQC85Z/6srA==
X-Received: by 2002:a63:d046:: with SMTP id s6mr68357pgi.76.1603146784827;
        Mon, 19 Oct 2020 15:33:04 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:7220:84ff:fe09:2b94])
        by smtp.gmail.com with ESMTPSA id s20sm10897pfu.112.2020.10.19.15.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 15:33:04 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael.j.wysocki@intel.com, swboyd@chromium.org,
        linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH 0/1] kobject: Don't emit change events if not in sysfs
Date:   Mon, 19 Oct 2020 15:32:56 -0700
Message-Id: <20201019223257.261223-1-abhishekpandit@chromium.org>
X-Mailer: git-send-email 2.29.0.rc1.297.gfa9743e501-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi maintainers,

A little while ago, I got a bug report of a regression caused by a patch
I submitted a45aca510b73b7 (PM: sleep: core: Emit changed uevent
on wakeup_sysfs_add/remove)

https://bugzilla.kernel.org/show_bug.cgi?id=209469

It seems possible for a "change" event to be sent before the device is
added to the sysfs (so when the rule runs, it can't access the device
path that emitted it). The bug report had the following log that made me
identify this is possible:
        > Use global config file: /etc/usb_modeswitch.conf
        > Use top device dir /sys/bus/usb/devices/2-3
        > Check class of first interface ...
        >  No access to first interface. Exit

I've added a patch to fix the former problem here and confirmed via
udevadm monitor that no CHANGE requests are seen for devices before they
emit the ADD event.

Thanks
Abhishek



Abhishek Pandit-Subedi (1):
  kobject: Don't emit change events if not in sysfs

 lib/kobject_uevent.c | 5 +++++
 1 file changed, 5 insertions(+)

-- 
2.29.0.rc1.297.gfa9743e501-goog


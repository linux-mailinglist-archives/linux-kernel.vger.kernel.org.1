Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28502F0564
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jan 2021 06:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbhAJFiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jan 2021 00:38:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbhAJFiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jan 2021 00:38:07 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA30FC061786
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jan 2021 21:37:26 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id y8so7799264plp.8
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jan 2021 21:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdt06KUNn6cE6U51anR3hbkSAymozcpTUJm370/WJdc=;
        b=Kcz/TqTHpsvsl9a0e3cOeL4Lw+7hm0keqPfbhoWUCwCEjAleUWsbFdTOg5xu3IV4W4
         jJrlieGFG4puNU5PdV7IwwI3i6hH13rgcIG79fjbX6jozP+RG33KA5FQluTkP900dfxC
         LyLaZoPPWRMH1GdjSrUSBnqpIiGVKaq6t4ZSP0J6kStCZFeDntttictI6b1K+uBOkZOV
         zbLOEPCfYtARTAanr3O9ORrOYcsmGAt2hemgET+EaZJxbIAl4Tu0tCbWBCkDJUN5+q0J
         XLqJKP0zNT6jCfgDIkIsoiBGKYlZcA4BW5MMrjy9/KAotpf0bB+f08lkO0LIdMs1GRV5
         v7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Pdt06KUNn6cE6U51anR3hbkSAymozcpTUJm370/WJdc=;
        b=IQMfEE9hB2f+yrX+CIawwOZLcH1kfYxYSQIW4hzPQmehLZ7dzfD9ode5UP2jCBx70O
         mAu+GJiflSB6JLRqt5ekpcEjU+V8McIukd7pcuXwN3pnnvs5UAgzmfFIFsGC96+xPUmf
         GivqiCBp0CyqXrrVARSGri+cPEXVBKhf80ayCNSKULbM2oh7QKlgsvae1/UIdvZUYxT0
         nQrHyV6jj8XcnG9TsRTMMfGiIf8L8cNqV00+mFKz3+RWU/yE/S+uV4yhTib/b8KheasC
         oYtgxajXhmZ5Nm9ih2FrvRON6HNBwjIocrxYeTDw0QLC05+kGoVWwWxHqv8b9CA+lKFb
         hGLA==
X-Gm-Message-State: AOAM532ku18AUqII6/A/Fi/q4rk1noA/USxcpAEHZbW2w96U7vGMOFV2
        4DZiszTLMMAsC/aOOmS4rIbYqA==
X-Google-Smtp-Source: ABdhPJzar2ddUE5xc3iNpYhRjI+RlHrgCptq7yrykiTSSivNxxxoS4KrK318k2VzLc5EvYMGGemTDg==
X-Received: by 2002:a17:90a:708b:: with SMTP id g11mr11309052pjk.23.1610257046129;
        Sat, 09 Jan 2021 21:37:26 -0800 (PST)
Received: from always-libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id q15sm14474013pgk.11.2021.01.09.21.37.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Jan 2021 21:37:25 -0800 (PST)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     pbonzini@redhat.com, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v4 0/2] misc: pvpanic: introduce capability & event attribute
Date:   Sun, 10 Jan 2021 13:37:17 +0800
Message-Id: <20210110053719.3038348-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 -> v4:
Use event sysfs attribute instead of module parameter.
Use driver dev_groups instead of creating files by sysfs_* API.

v2 -> v3:
Seperate the function to 2 parts:
    1, use sysfs to expose device capability.
    2, add a module parameter to set limitation by user.

v1 -> v2:
Remove device info log, use module parameter to expose capability.

v1:
The guest sides determines pvpanic capability by RDPT, before kicking
host side, check the event is supported or not.

zhenwei pi (2):
  misc: pvpanic: introduce device capability
  misc: pvpanic: introduce module parameter 'events'

 .../ABI/testing/sysfs-bus-pci-devices-pvpanic | 14 +++++
 drivers/misc/pvpanic.c                        | 58 +++++++++++++++++--
 2 files changed, 67 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-pci-devices-pvpanic

-- 
2.25.1


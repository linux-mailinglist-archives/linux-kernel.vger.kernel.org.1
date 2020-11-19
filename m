Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 728D32B989B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 17:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729173AbgKSQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 11:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbgKSQua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 11:50:30 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F0FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:29 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id t9so6538921edq.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Nov 2020 08:50:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rp5osBQU9fNsgA0FGJaDjaR1vXbIzT8IoRDwyKfRdP4=;
        b=XDQFKK85cGXFbVSyMpE+ObMfDt+XPn0gBBed6C8hIYQqDuUzz3uqb+eidtSI1uAFiB
         Ly72OHrcjFGtMG2Jkf//F2lFiDRPwRDR1oXKYQ13UlkBSNQ+FJ4vDwUIVJbdgh3+GL++
         yrLuSv2h42l/0eKSuLrKnJrxoJbZVg1TyhlQ/QO+7ElEQfTXDRr0ywV9Ems5qsh7lxHZ
         MUUsmKgOZUbo3V4AReBW2Vsy96KMgLL+fXTXedfUEJ9qVwUCuTHAzITfB1zBb4miJIGP
         PemF/8N4xkFizDUo7YCc0mtYSXdaMHsBbsb9F8Pn7sgL+YMGeCSmbVEe6NsNy6NTS+5S
         mQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rp5osBQU9fNsgA0FGJaDjaR1vXbIzT8IoRDwyKfRdP4=;
        b=uK45FJ7hJeOWsyLQzC6hkBJFxjjfA7i4g0gL4/8vAXaMoZL4co83zB8lZT+KSQdFab
         tv4xga/wVJgPMIvGzHyBvRKkkMPPqsOse/VvidA+FI0Wfvxrve+3ku8mgJnE7c9nbW4T
         B/TzDfe7nEVlop/k48cx+tAch+EioavBpzfQidNMhBttmugdn9Bo0EYfuWRwEF8/4Gpb
         SuvXc7pKdA+UDnzTTSpXHBTvRr6lh5pyYrThzTMXTjEc7xSt3XfDJarlgJ4gRpdTg7gC
         8mwUja17+nRCVlfcW9IDftMYxH4OQTvfEkG7711LqeiVfPhjvvugR1DhyHCfuMsv6M6j
         AFJw==
X-Gm-Message-State: AOAM530yeV3nGMOO4FKRRmbt/HSWiAhU2ajoOIEDExDRuovOB/vyfHwL
        JbidBDimequwF94S8mOtAlY=
X-Google-Smtp-Source: ABdhPJyPbWrrGEUiejiNb97E9u6oqgMQalJsaemAc6c82GMAvsearNOGrJBVm3sphx9SJfpJwvMGrQ==
X-Received: by 2002:a50:9ee8:: with SMTP id a95mr2904041edf.351.1605804628513;
        Thu, 19 Nov 2020 08:50:28 -0800 (PST)
Received: from yoga-910.localhost ([188.25.2.177])
        by smtp.gmail.com with ESMTPSA id s15sm2176edj.75.2020.11.19.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 08:50:27 -0800 (PST)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Cc:     Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 0/3] staging: dpaa2-switch: small updates and fixes
Date:   Thu, 19 Nov 2020 18:50:14 +0200
Message-Id: <20201119165017.806696-1-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

This patch set is just a small set of fixes and an update on the ethtool
counters exported by the dpaa2-switch driver.

Ioana Ciornei (2):
  staging: dpaa2-switch: make sure that the VLAN is not already
    configured
  staging: dpaa2-switch: pack the firmware command structures

Ionut-robert Aron (1):
  staging: dpaa2-switch: export the 'no buffer' counter in ethtool

 drivers/staging/fsl-dpaa2/ethsw/dpsw-cmd.h      | 10 +++++++---
 drivers/staging/fsl-dpaa2/ethsw/dpsw.h          |  6 ++++--
 drivers/staging/fsl-dpaa2/ethsw/ethsw-ethtool.c |  2 +-
 drivers/staging/fsl-dpaa2/ethsw/ethsw.c         |  9 ++++++++-
 4 files changed, 20 insertions(+), 7 deletions(-)

-- 
2.28.0


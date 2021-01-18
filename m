Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A62F972E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 02:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729936AbhARBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jan 2021 20:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730650AbhARBLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jan 2021 20:11:21 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de (mx-rz-1.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC4C061573
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jan 2021 17:10:40 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4DJty42hPnz8t29;
        Mon, 18 Jan 2021 02:10:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1610932236; bh=7IRriX93JC6O7u0yXJ+3MvNLYHJ0hIosx9xBU4of9YI=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=bjWtN8j1DrKf0qr62g8OeuW4TDonUhCHi9vsYj6Siu4XJNeNfB4qCc7vttnPeKu8k
         6lXRoscQTlQtRPetkgYUESQ24qCaMafMNsWMps0p33/XU7A36QqyOHyQkLF6LpSioD
         uKup9rLm210gg58OAdq43e+FFWeyqf2OF6WB8iftXgeRcbBhiRzsSTlMX41ItSJgtF
         QFtbAcRM3qaac9fkNRmVqBNFB3Gn3vG6rnZPtJ88Z524MR9SA+v53QaxIUE93f6wT1
         ahyGp1qxxgm2FDVtP+rGi7fz4jvSGeJqikQOX9PCP4QWqDiRJq84td9f8A0l9Vo60c
         8H/6pK4xnyhpg==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19b2:a701:a9ea:94f8:dbd1:5695
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19b2:a701:a9ea:94f8:dbd1:5695])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+zrOg9k8sHkhmgR1N2nNUoXl1wPude+F4=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4DJty15Q75z8spV;
        Mon, 18 Jan 2021 02:10:33 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     gregkh@linuxfoundation.org
Cc:     nicolai.fischer@fau.de, johannes.czekay@fau.de, jbwyatt4@gmail.com,
        rkovhaev@gmail.com, hqjagain@gmail.com, gustavo@embeddedor.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH 0/6] wlan-ng: checkpatch.pl cleanup series
Date:   Mon, 18 Jan 2021 02:09:50 +0100
Message-Id: <20210118010955.48663-1-johannes.czekay@fau.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series cleans up all the checkpatch.pl related warnings in the
wlan-ng module. I tried to resolve those issues in a sensible manner.

Johannes Czekay (6):
  wlan-ng: clean up line ending
  wlan-ng: clean up spinlock_t definition
  wlan-ng: rename macros
  wlan-ng: clean up line length
  wlan-ng: clean up alignment
  wlan-ng: clean up reused macros

 drivers/staging/wlan-ng/cfg80211.c         | 33 ++++++++-------
 drivers/staging/wlan-ng/hfa384x.h          |  2 +-
 drivers/staging/wlan-ng/p80211metadef.h    | 24 +++++------
 drivers/staging/wlan-ng/p80211metastruct.h | 18 +-------
 drivers/staging/wlan-ng/p80211netdev.c     |  2 +-
 drivers/staging/wlan-ng/p80211req.c        |  6 +--
 drivers/staging/wlan-ng/prism2mgmt.c       | 48 ++++++----------------
 drivers/staging/wlan-ng/prism2mib.c        | 18 ++++----
 8 files changed, 56 insertions(+), 95 deletions(-)

-- 
2.25.1


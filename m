Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E132E104C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 23:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgLVW35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 17:29:57 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de ([131.188.11.21]:35407 "EHLO
        mx-rz-2.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728114AbgLVW3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 17:29:37 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D0rRB50BxzPkVH;
        Tue, 22 Dec 2020 23:21:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608675702; bh=7IRriX93JC6O7u0yXJ+3MvNLYHJ0hIosx9xBU4of9YI=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=kXPm5xI5GNe56q/cqPwMKCSA1NJaCPrUhEKOukjdYz+yDt3CPdd5cYIK7TQb9s7s4
         abvJYxd6sg/Dspg7BxmRZlwR8GLgVTbHUu6RYQ7+xP7Nw0w6FPrrsCaOiYphM7pWle
         CGMC6vOWC2lqrQ6JMAWBjro3V1DWwpenJddKqu3FvJ0WalRXlX2JmgSUMmRgweq7Xp
         5b471g/IaeE7krQRaWQNzOa89bV+qBhxJpKswLjBXs4oSxlVBNcEB4thvo4GKbFk9f
         oNGVYoDrTqT/8L2iWdzXxjSOGUQXfZEqnUkHWihH5KOGQbPu0nN7etSA1q2vnL5I3t
         n9+zATWcf5qoA==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:a62:19fa:6f01:10d5:3d50:1797:6266
Received: from shaun-PC.fritz.box (unknown [IPv6:2001:a62:19fa:6f01:10d5:3d50:1797:6266])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/B2DRenqymDt3zis1uv1zOH/b7nXDFgT4=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D0rR809rfzPjnl;
        Tue, 22 Dec 2020 23:21:39 +0100 (CET)
From:   Johannes Czekay <johannes.czekay@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     johannes.czekay@fau.de, nicolai.fischer@fau.de,
        gustavo@embeddedor.com, hannes@cmpxchg.org, longman@redhat.com,
        mhocko@suse.com, adawesomeguy222@gmail.com,
        igormtorrente@gmail.com, sylphrenadin@gmail.com,
        izabela.bakollari@gmail.com, colin.king@canonical.com,
        steff.richards.the.third@gmail.com
Subject: [PATCH 0/6] wlan-ng: checkpatch.pl cleanup series
Date:   Tue, 22 Dec 2020 23:20:11 +0100
Message-Id: <20201222222015.20558-1-johannes.czekay@fau.de>
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


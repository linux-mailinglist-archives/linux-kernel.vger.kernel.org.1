Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27F32E8B4E
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 08:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbhACHvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 02:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbhACHve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 02:51:34 -0500
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B47C061573
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jan 2021 23:50:53 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D7rXn5QGWzPk2d;
        Sun,  3 Jan 2021 08:50:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1609660249; bh=K7aXi8ywRWadBGR9sM2TUjmpEiqxl+KPvGZqz3OUfxk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Y1KcHITU0vcvDJH8VT2B3wt4S53QFKG7xFw+Jt6Lns9BVd5DzmZrE/GvwuOwNwQUI
         rRsanOeZJ6tJM5GI+SuFzXuKdyzJW6DAGFDvjSuc5xaBAS2ZVpJmoRZUFadpCTsTnq
         JAVwlS1CNyglQGO7+zx1YhrQhp7i7go+Aw3Gnbra2bt8RgA+wYKfTLtTKrHIF5OZo3
         ji5/GJmvMUokqpbgLDM0FHLuXEVZYNcMo82cSR5uq6eMTCqXmE54REyemAElO43dtK
         6fB5AVJSwLYSl729swJlEKIc+qWLclsacu3V/ECBJLylJgEdzUbfpm6lGvkjBtRWai
         t6dXVfFE/mIow==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 172.17.10.69
Received: from localhost.localdomain (rat69.ratnet.stw.uni-erlangen.de [172.17.10.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX18lLeNofGSBd0tZkUihrp7t+Bk0j7OEkDk=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D7rXl3knjzPjlR;
        Sun,  3 Jan 2021 08:50:47 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     joe@perches.com, apw@canonical.com, akpm@linux-foundation.org,
        nicolai.fischer@fau.de, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de
Subject: [PATCH v3 0/5] update kconfig parsing
Date:   Sun,  3 Jan 2021 08:50:10 +0100
Message-Id: <20210103075015.23946-1-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20201226140511.662368-1-nicolai.fischer@fau.de>
References: <20201226140511.662368-1-nicolai.fischer@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the parsing of Kconfig files within checkpatch.pl
to the current state, as discussed previously.

Third iteration fixes patch 3 and adds one new patch.
Patch 5 adds a new waring regarding the indentation of a Kconfig block


Nicolai Fischer (5):
  checkpatch: kconfig: replace '---help---' with 'help'
  checkpatch: kconfig: add missing types to regex
  checkpatch: kconfig: enforce help text indentation
  checkpatch: kconfig: clarify warning for paragraph length
  checkpatch: kconfig: enforce block indentation

 scripts/checkpatch.pl | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

-- 
2.29.2




Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0452E2E4F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Dec 2020 15:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbgLZOHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Dec 2020 09:07:24 -0500
Received: from mx-rz-1.rrze.uni-erlangen.de ([131.188.11.20]:46367 "EHLO
        mx-rz-1.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgLZOHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Dec 2020 09:07:23 -0500
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-1.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4D35G91nCtz8spx;
        Sat, 26 Dec 2020 15:06:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1608991601; bh=NGO1ZDW21Kv8wQw7djDlCHIJZT2B1CvbEgMmK1u8ii8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From:To:CC:
         Subject;
        b=Y3hhkdz2NO2QUDvEwWi+bhtFzIBVJCmhoCSsWsondqcrRoyJ2mbYwRFpO1+7rEivX
         1B9KilG8kEL4kmcs/uCaHYH4+V0XK14XySDBwkJIzNECWV0wlcmqG3M/R5sPL1lWFY
         rvVdjbXIi1bF9oQRCrJN2dVOgKQiBDT1SwSVdXgNj0ysYSCmtmWj8RvZ1KCD0OqUb0
         IasVTcVajbOb7KQNIctn9O0jEC0/E0r+6qGBz8HvEPpcNAb4aPBrky6Kmn1DpQcRkm
         4es0EWVodIfjgvBYA1xURHNL91weo3qK/axei7RpF2cnlXewB7ceazhLuyn23wl115
         uj4kfeJ+L7rPA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2a02:810d:8080:2d9f::1276
Received: from x1.nicolai.tech (unknown [IPv6:2a02:810d:8080:2d9f::1276])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+rNg/HYEfCbfCxVoBAbcv5Pp/jo8YQq6Q=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4D35G66Nfhz8sYn;
        Sat, 26 Dec 2020 15:06:38 +0100 (CET)
From:   Nicolai Fischer <nicolai.fischer@fau.de>
To:     linux-kernel@vger.kernel.org
Cc:     apw@canonical.com, johannes.czekay@fau.de,
        linux-kernel@i4.cs.fau.de, joe@perches.com,
        akpm@linux-foundation.org
Subject: [PATCH v2 0/4] checkpatch: update kconfig parsing
Date:   Sat, 26 Dec 2020 15:05:07 +0100
Message-Id: <20201226140511.662368-1-nicolai.fischer@fau.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
References: <b1c83a13-204f-25ff-d08b-d08559e25a3b@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series updates the parsing of Kconfig files within checkpatch.pl
to the current state, as discussed previously.

The second iteration contains two more patches.
Patch 3 adds a new warning regarding the indentation as discussed.
Patch 4 aims to clarify the existing warning.

Nicolai Fischer (4):
  checkpatch: kconfig: replace '---help---' with 'help'
  checkpatch: kconfig: add missing types to regex
  checkpatch: kconfig: enforce help text indentation
  checkpatch: kconfig: clarify warning for paragraph length

 scripts/checkpatch.pl | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

-- 
2.29.2




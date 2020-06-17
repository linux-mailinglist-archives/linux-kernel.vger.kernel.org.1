Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77CD1FC66F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jun 2020 08:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgFQGxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Jun 2020 02:53:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:53812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725773AbgFQGxr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 02:53:47 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B04220739;
        Wed, 17 Jun 2020 06:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592376827;
        bh=PE3kchf8kiYl1Wb1bdz54L5LiupZgsP8/pQCraqZolA=;
        h=From:To:Cc:Subject:Date:From;
        b=jHWipKMsrpc2RaSLDXZvcVq7LusNAOEh3a4pfzidgpmPJyAtst2H3WPkj9kYbM7Uj
         nD8nGzh0ROrUA7GWKdkrPp9yZs3whkeGK2Pjsb+uc1jooS3v2lepkuB1CK40vreFRO
         sE9TINGKkwy/Dx/ZDmW9Ey7/jCZNeyFMkrnShc80=
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH 0/2] m68k: fixups for recent changes in memory initialization
Date:   Wed, 17 Jun 2020 09:53:39 +0300
Message-Id: <20200617065341.32160-1-rppt@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

Hi,

It's a followup to the Greg's [1] and Angelo's [2] reports of boot problems
caused by the recent rework of the memory initialization.

I'm resending Angelo's original patch for mcfmmu and my fix for the nommu
variant.

[1] https://lore.kernel.org/lkml/f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org
[2] https://lore.kernel.org/linux-m68k/20200614225119.777702-1-angelo.dureghello@timesys.com

Angelo Dureghello (1):
  m68k: mm: fix node memblock init

Mike Rapoport (1):
  m68k: nommu: register start of the memory with memblock

 arch/m68k/kernel/setup_no.c | 3 ++-
 arch/m68k/mm/mcfmmu.c       | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.26.2

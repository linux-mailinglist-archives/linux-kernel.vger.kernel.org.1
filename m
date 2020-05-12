Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80CC1CED16
	for <lists+linux-kernel@lfdr.de>; Tue, 12 May 2020 08:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbgELGhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 May 2020 02:37:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:41678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbgELGhe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 02:37:34 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45AD20714;
        Tue, 12 May 2020 06:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589265454;
        bh=9XCtK1rSBgjG98b7eHZ6C6kXPSCVAWf3F4PW5m4qkjE=;
        h=From:To:Cc:Subject:Date:From;
        b=sojiTnRVkj7AGP/a3JzZ0XpgQXjHYiT4dFCZi+cKPdYrfyuTtBU02LyFl91Wy/Ohr
         2v+amjOd3dH/U4VAxTYhkNe8gWdK+32JeWd++WHXDm8nrw+c9Sr+ChGWZXl1hF0rOf
         kLHXHyRlLNIa+ekUR6bmP3WO2ZKFOijRyv1UoCXw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <adech.fo@gmail.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Ingo Molnar <mingo@kernel.org>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Michal Marek <mmarek@suse.cz>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH rdma-next 0/2] Fix kasan compilation warnings
Date:   Tue, 12 May 2020 09:37:26 +0300
Message-Id: <20200512063728.17785-1-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Hi,

The following two fixes are adding missing function prototypes
declarations to internal kasan header in order to eliminate compilation
warnings.

Thanks

Leon Romanovsky (2):
  kasan: fix compilation warnings due to missing function prototypes
  kasan: add missing prototypes to fix compilation warnings

 mm/kasan/common.c |  3 ---
 mm/kasan/kasan.h  | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

--
2.26.2


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC3326E6E0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 22:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgIQUpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 16:45:18 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:39064 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726180AbgIQUpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 16:45:17 -0400
Received: by mail-vk1-f196.google.com with SMTP id m8so844847vka.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Sep 2020 13:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KOMGP0AY1AiXNwWcSEx/xdRLKkV1S0FOTpp6dxykL9Y=;
        b=s3sD8BIsC6AzJuGVDggDwQmTpmSovO5Z5YPsK1zsZrFUY7yZENZhFQeJ8nLMF5UfmW
         CrT8ZtRvt1I1/2Xzzd7D1XQjwnFi0Ulk70NZF/DDAoKRcxMyby9La+x8/VCIg8UdrcU+
         cv/qG5l45u3iTjsQGxqUuKA+1AfXBcQ4su5xAmRdvht5e5pG1MgmhdR+AnkHSoXWCJ7V
         SquEZudRLkV9IQPTaFNQYlvB7IVHwN3sQNMIc3tyxskau5G+sXkvIwewR/k3qUaikqa3
         Akx0Ckb4Ql5CuSlmkVft7Whh3QTPwD2RoEcn4DDmTGO7UP+3fqF7s94dG7GPXSRLGKAQ
         OFbg==
X-Gm-Message-State: AOAM531MO9X6Y5aGhCqvBYwuatk8ZuWDUBvafoSGrcoGh+uEWWahlAjy
        JJ6xE5KXis0u1Szw0cZusn7kBDhfaCY=
X-Google-Smtp-Source: ABdhPJwYAUf2rq4aE2OsG1ltzwEma/KF0vYji20g4gZxw4N3Gg5N0MH9ul1/KZQeXstl3K2RDpq18g==
X-Received: by 2002:a1f:a3cc:: with SMTP id m195mr10343933vke.16.1600375516558;
        Thu, 17 Sep 2020 13:45:16 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id 23sm163372vkw.25.2020.09.17.13.45.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2020 13:45:15 -0700 (PDT)
Date:   Thu, 17 Sep 2020 20:45:14 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu fix for v5.9-rc6
Message-ID: <20200917204514.GA2880159@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is a fix for the first chunk size calculation where the variable
length array incorrectly used # of longs instead of bytes of longs. This
came in as a code fix and not a bug report, so I don't think it was
widely problematic. I believe it worked out due to it being memblock
memory and alignment requirements working in our favor.

Thanks,
Dennis

The following changes since commit f75aef392f869018f78cfedf3c320a6b3fcfda6b:

  Linux 5.9-rc3 (2020-08-30 16:01:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.9-fixes

for you to fetch changes up to b3b33d3c43bbe0177d70653f4e889c78cc37f097:

  percpu: fix first chunk size calculation for populated bitmap (2020-09-17 17:34:39 +0000)

----------------------------------------------------------------
Sunghyun Jin (1):
      percpu: fix first chunk size calculation for populated bitmap

 mm/percpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index f4709629e6de..1ed1a349eab8 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1316,7 +1316,7 @@ static struct pcpu_chunk * __init pcpu_alloc_first_chunk(unsigned long tmp_addr,
 
 	/* allocate chunk */
 	alloc_size = sizeof(struct pcpu_chunk) +
-		BITS_TO_LONGS(region_size >> PAGE_SHIFT);
+		BITS_TO_LONGS(region_size >> PAGE_SHIFT) * sizeof(unsigned long);
 	chunk = memblock_alloc(alloc_size, SMP_CACHE_BYTES);
 	if (!chunk)
 		panic("%s: Failed to allocate %zu bytes\n", __func__,

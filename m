Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A3D2CE1CF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731904AbgLCWeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 17:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731896AbgLCWeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 17:34:15 -0500
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A22C094250
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 14:32:33 -0800 (PST)
Received: by mail-pj1-x1044.google.com with SMTP id f14so1914358pju.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 14:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=kWu6dOTpWM5OEhpvvxAmGbYOm4nAgVI2rftl3/PRnJw=;
        b=bb3TCC2gTuwqOzen2Ppu96SWrslPoHVYn9ghrkgyDWdZa8ILSfqc1wrojX1K3U73Vm
         /r50dYf+je7pw5TDPJsRRIofKlxMtnczpH8DEEMxc6f6su/Fyvrp7310ABwpwthtbxgE
         dh4dAzwHX13qe8zGtbSnnHi6cpCoUgASyqy3geEYFliW8AwCp60EvA42stwrZe0OTchB
         rezZqwJ7yndm/Mp1sQBTLVS9ar/3tS182u7HiIA9p8vP+QbSBWyQU6kQHLD0gAFo6uvX
         9eeQitIK+S2t+aMW9Zj+hkdgmLuAEnshhl1Xud18G3YOS6yU07NUYpNnGGRtmo3zQ5cZ
         GsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding:cc:from:to;
        bh=kWu6dOTpWM5OEhpvvxAmGbYOm4nAgVI2rftl3/PRnJw=;
        b=IVC9F+2ZAVpmdfo7z4ubq1gQwt8c5y73vpfz5T0D3WqQ7EuYkByKpIbUvCiZOke9nE
         BKiG1+U+2LvOyochClsmQ+ldTd17VS8xIrIV/GHe9dTUpQ3YsBiHkox4J4tV2KGMdN1O
         4mRGBgJxeusV7X5C3x4szuX+3HuEAywsrotZLgXKC8MZSk5CNKugKpidxd99RFwNoZWf
         0IUjiYsSq0runuLLM/EgpVwMRxVqgDtFfMPOsLft8nupyMmdFN1ZHpFAHxV1C2RlFvz1
         5/o7MKxNlw5XyMyU7iSsaxnWQF4fhqWW+Y+I77wqsFnzNA8S97ilN8bZMbdoCu/+rRpG
         fAgA==
X-Gm-Message-State: AOAM530CxEw2ENzN5vREJQ0ENcUOZGVbcWXXhDpLO+HMGmUVPsgnww9w
        A+OKY6SYkJP69CvU0FI8gin8RZ18sFAkASv/
X-Google-Smtp-Source: ABdhPJyss4HB0tRKuTdlmynwH8EalWY5UH5526iClcnKVeSXxYoDVLrUWDJ1cBtKdu4wdMbvN0OThQ==
X-Received: by 2002:a17:902:758c:b029:da:a6e1:e06 with SMTP id j12-20020a170902758cb02900daa6e10e06mr1222353pll.67.1607034752937;
        Thu, 03 Dec 2020 14:32:32 -0800 (PST)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id g6sm305006pjd.3.2020.12.03.14.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 14:32:32 -0800 (PST)
Subject: [PATCH v1 5/5] MAINTAINERS: Add myself as a dm-user maintainer
Date:   Thu,  3 Dec 2020 13:58:59 -0800
Message-Id: <20201203215859.2719888-6-palmer@dabbelt.com>
X-Mailer: git-send-email 2.29.2.454.gaff20da3a2-goog
In-Reply-To: <20201203215859.2719888-1-palmer@dabbelt.com>
References: <20201203215859.2719888-1-palmer@dabbelt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc:     corbet@lwn.net, song@kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>, shuah@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-raid@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kernel-team@android.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     dm-devel@redhat.com, agk@redhat.com, snitzer@redhat.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmerdabbelt@google.com>

I'm not sure this is big enough to warrant an entry in the MAINTAINERS file,
but I know it can be quite a bit of work to maintain something like this so I'm
happy to sign up if that helps.

Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2daa6ee673f7..ab9d7746cfb4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5198,6 +5198,13 @@ W:	http://sources.redhat.com/cluster/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/teigland/linux-dlm.git
 F:	fs/dlm/
 
+DM USER (Block Device in Userspace)
+M:	Palmer Dabbelt <palmerdabbelt@google.com>
+S:	Maintained
+F:	include/linux/dm-user.h
+F:	drivers/md/dm-user.c
+F:	tools/testing/selftests/dm-user/
+
 DMA BUFFER SHARING FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
 M:	Christian König <christian.koenig@amd.com>
-- 
2.29.2.454.gaff20da3a2-goog


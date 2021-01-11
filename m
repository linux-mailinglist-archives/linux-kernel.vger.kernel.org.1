Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62AFB2F2187
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 22:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389930AbhAKVHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 16:07:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728539AbhAKVHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 16:07:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610399157;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OkwN5vYCUrXN1gSw+5AUEXR+ndNOEnKeN2JIlRxKH3E=;
        b=Bx2IEbvbG6YoRYx07gVLovRlUTW1KeVo+WC0lJQr0m2FJ5/LQJymQy9JyhmIQKA7djNieX
        85jRjBKLhHFLPJ+D7h46TSE3eHYGUbC36ywqHnDokC9S4v5zs2MRy5afvN9sC9bpexsyvS
        lG6zoZOi5SU6thzwqIFU7wjyI1ClOYs=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-207-WDNa0I3ePF6r5RXZO-95TQ-1; Mon, 11 Jan 2021 16:05:55 -0500
X-MC-Unique: WDNa0I3ePF6r5RXZO-95TQ-1
Received: by mail-io1-f69.google.com with SMTP id b136so93354iof.19
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 13:05:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OkwN5vYCUrXN1gSw+5AUEXR+ndNOEnKeN2JIlRxKH3E=;
        b=bwLoZKpgkqYtf2WATEbL8pMxO5j3LUIG5kUeF3Z6YswWkw7tyrnF+Iwb/K8qR7ILEb
         sedmxbihOCiPhyp9DLiLd7lnEE7OyrTaNpZgD34pt30yZSjF21/f4iFgVE0A625Bv/fo
         fitYfmi7k9b8nspYmiS6B37q86q94XU/0xnRmaSM0/1kRvPDroeFwDzJ8K1Z5Mh5rUac
         dIR5N/mkpm7c53DC+fsQtrr5BXc0d/sfJ/GE/3lo/UJFJC5OydIyZTSX+w3m/iOsFCHV
         Z45kndBu3elZork0WZOgh3UFs8VFRDGz4HhpJyo3xi3IE4S9Od7yNOtYMSBCxdDVCDPU
         yiHw==
X-Gm-Message-State: AOAM533oYDfmpFY8ayKM+2kDhPQaq+ZtoQdUHJLR5T39Vz5LtrpuKMKD
        mwExJs/PF0JIyC4+zWwglusALmjhoOrGDACXxtttL5oA9a2hlcA+XJ9BBICH1oBquCnaKJwKGmN
        oKqmD5jiIyvmZv5IC/6F+xj5v
X-Received: by 2002:a05:6e02:10c3:: with SMTP id s3mr973993ilj.269.1610399154545;
        Mon, 11 Jan 2021 13:05:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw6Ev4z4M7iiQ4IWIhPmz+JCzu3mpjfTGAREfYqUmeQmNUT4RarijTDgpFFHOnVLiRQw5uChA==
X-Received: by 2002:a05:6e02:10c3:: with SMTP id s3mr973984ilj.269.1610399154354;
        Mon, 11 Jan 2021 13:05:54 -0800 (PST)
Received: from dev.jcline.org ([2605:a601:a63a:4d01:c440:5c61:43ba:350c])
        by smtp.gmail.com with ESMTPSA id k15sm711468ilp.10.2021.01.11.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 13:05:53 -0800 (PST)
From:   Jeremy Cline <jcline@redhat.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jeremy Cline <jcline@redhat.com>
Subject: [PATCH v2] drm/amdkfd: Fix out-of-bounds read in kdf_create_vcrat_image_cpu()
Date:   Mon, 11 Jan 2021 16:05:28 -0500
Message-Id: <20210111210528.734483-1-jcline@redhat.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210108163104.411442-1-jcline@redhat.com>
References: <20210108163104.411442-1-jcline@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KASAN reported a slab-out-of-bounds read of size 1 in
kdf_create_vcrat_image_cpu().

This occurs when, for example, when on an x86_64 with a single NUMA node
because kfd_fill_iolink_info_for_cpu() is a no-op, but afterwards the
sub_type_hdr->length, which is out-of-bounds, is read and multiplied by
entries. Fortunately, entries is 0 in this case so the overall
crat_table->length is still correct.

Check if there were any entries before de-referencing sub_type_hdr which
may be pointing to out-of-bounds memory.

Fixes: b7b6c38529c9 ("drm/amdkfd: Calculate CPU VCRAT size dynamically (v2)")
Suggested-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Jeremy Cline <jcline@redhat.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_crat.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
index 8cac497c2c45..a5640a6138cf 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_crat.c
@@ -1040,11 +1040,14 @@ static int kfd_create_vcrat_image_cpu(void *pcrat_image, size_t *size)
 				(struct crat_subtype_iolink *)sub_type_hdr);
 		if (ret < 0)
 			return ret;
-		crat_table->length += (sub_type_hdr->length * entries);
-		crat_table->total_entries += entries;
 
-		sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
-				sub_type_hdr->length * entries);
+		if (entries) {
+			crat_table->length += (sub_type_hdr->length * entries);
+			crat_table->total_entries += entries;
+
+			sub_type_hdr = (typeof(sub_type_hdr))((char *)sub_type_hdr +
+					sub_type_hdr->length * entries);
+		}
 #else
 		pr_info("IO link not available for non x86 platforms\n");
 #endif
-- 
2.29.2


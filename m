Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26D82C4910
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 21:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbgKYU1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 15:27:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47012 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729608AbgKYU1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 15:27:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606336056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=4HJ2v8f9kS+7OevKdt8lnBxNs8lmIy/EbT4vGg0ZhGU=;
        b=ZvjYhLBe7ippnV+dQX0AJNnuS5N6QQK6AXLt8ifievYmCMCK890QzQJqX3ROPYoAJt1RVK
        eyNCZnxO/sPpQyFLv6GPnVIKvE12UfBE/2L54d76YssPkHMXefcaaHDtFYOWh6ricHPNMn
        d4jKQoE+1rVKwBLX6upkpwm8qf9NPKQ=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-3_sm1ccTOFC4YJzjQAXouA-1; Wed, 25 Nov 2020 15:27:34 -0500
X-MC-Unique: 3_sm1ccTOFC4YJzjQAXouA-1
Received: by mail-qv1-f71.google.com with SMTP id s8so3213305qvr.20
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 12:27:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:user-agent:from:to:subject:date:message-id
         :mime-version;
        bh=4HJ2v8f9kS+7OevKdt8lnBxNs8lmIy/EbT4vGg0ZhGU=;
        b=MLZl7k22bNExbm1ra29aA0tDnncmtbtlV/z2k1ttFZCZiNf1JScckz3DctatRCtKJm
         j7rQHUT4SN3GcYVB1G4Azzb42oRpzxJpLMAtjpbtWFlpYXNBPndSta12jHTKPPS2uOg4
         e8z/lovr2Na5GhMj4PF5wk2nu0m4PSSGMV91CY2+LHiRnni91p2k3AHnNdgi8w3w5bIx
         Jz4gmG3UzZsJf80vdiA9NCx1SCFRrQI75T4oX9dg86r//n/zsiwFRF8XREcYdjww5/OT
         mwaEJLmF1aaGWN+2Eqs4scjLfNW8aNs7oFwjP9AQrPp3dOZIuSv+GsZkbNZ45rYXRt/n
         UmWQ==
X-Gm-Message-State: AOAM5327+QhrHikqR5P5XOA0ymIkYv5c/q2Oq2Fw/ruBAfqh86OYsZzg
        44UNG/rUfNJn+JkPcfu4PB9M9dmVGgxJ4dcDGp0E1KQk/dkVCFrEUHGWIu5MFsskpWckgYAe3hj
        2sA4Xcn6fDkGNB4KMmkOIr1hz
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr685414qtp.296.1606336053899;
        Wed, 25 Nov 2020 12:27:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxWFbZOwl0Conrxed5+2lAywJNEc3k82+XLXf8ktBVme0EYoDWjdb8pXB2rkats9/OyDEivzQ==
X-Received: by 2002:ac8:4e84:: with SMTP id 4mr685378qtp.296.1606336053632;
        Wed, 25 Nov 2020 12:27:33 -0800 (PST)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id b64sm447921qkg.19.2020.11.25.12.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 12:27:32 -0800 (PST)
User-agent: mu4e 1.4.10; emacs 27.1
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        stable@kernel.vger.org
Subject: Question about domain_init (v5.3-v5.7)
Date:   Wed, 25 Nov 2020 13:27:31 -0700
Message-ID: <87h7pd6v2k.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Is there a reason we check the requested guest address width against the
iommu's mgaw, instead of the agaw that we already know for the iommu?
I've run into a case with a new system where the mgaw reported is 57,
but if they set PAE to 46 instead of 52 in the bios, then sagaw reports
the highest supported agaw is 48 and the domain_init code fails here. In
other places like prepare_domain_attach_device, the dmar domain agaw
gets adjusted down to the iommu agaw. The agaw of the iommu gets
determined based off what is reported for sagaw. I'm wondering if it
can't instead do:

---
 drivers/iommu/intel-iommu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6ca5c92ef2e5..a8e41ec36d9e 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1862,8 +1862,8 @@ static int domain_init(struct dmar_domain *domain, struct intel_iommu *iommu,
 	domain_reserve_special_ranges(domain);

 	/* calculate AGAW */
-	if (guest_width > cap_mgaw(iommu->cap))
-	        guest_width = cap_mgaw(iommu->cap);
+	if (guest_width > agaw_to_width(iommu->agaw))
+	        guest_width = agaw_to_width(iommu->agaw);
 	domain->gaw = guest_width;
 	adjust_width = guestwidth_to_adjustwidth(guest_width);
 	agaw = width_to_agaw(adjust_width);
--
2.27.0


Thoughts? With the former code the ehci device for the ilo fails when
trying to get a private domain.

Thanks,
Jerry


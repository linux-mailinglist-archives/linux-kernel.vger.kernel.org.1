Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C668F292BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgJSQvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:51:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43250 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730538AbgJSQvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603126279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=cBZ9UFopWvddrponmuXiWqW0rfQhlFg5Q+4GTd5bmAo=;
        b=h9LlzMd9EZe/miwVLLBkoaJY85lcAHKe3y0CT/nuBtW4yaQO8BJnW30GVeyFwKFgKKqVhR
        gUYsKCwswRoJGALNwop5L+NCYRDi0Gf/lrGcR+bjB35PP0/cyd9LbpvuuMXuCQZ8JgBZTY
        BLoUIpmE4u6KbVm8oi517eV4Pfc6MH4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-I_ECc6MkPJyjyFsmAvIfSg-1; Mon, 19 Oct 2020 12:51:18 -0400
X-MC-Unique: I_ECc6MkPJyjyFsmAvIfSg-1
Received: by mail-qt1-f197.google.com with SMTP id z22so336165qtn.15
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:51:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cBZ9UFopWvddrponmuXiWqW0rfQhlFg5Q+4GTd5bmAo=;
        b=UH8qwiimbxKAS9oUSgr+ANkZjYX0x2oONVJ++YJSRk982SaLc9u5yCQHBzrlKjvTzM
         A2Z9Hz4LAAdFEIE4KdWUn8Rdynj82EZThTBd7y82XsbEraXzMsByzkIg9a1GrF2J0Qpv
         DsOCQopMjErfg5qvYzZ34FwvEc8fnYv+ZatC3XaAkeT+qsWSuRI4GB3rPndRpVf3tA51
         jceCT1u75c54qkfv9QqVOMsf1hnKAv/SnYTejx3wKAgusdKuBOsy0z01AOXrf6gf8hFm
         mwf4Z29ypCjjHzzbX5uh8/WDOAN6OnoNwpzoNVwY5zNr0GAuX6uS0BB8ZU/vMvf5MBIj
         2vWQ==
X-Gm-Message-State: AOAM531C/PfVozZoTBcpXfJlButBYw/TPhTycezZWVvXZ+c6MeshcA3f
        tanAtB/6XpG4DuMZKs0A5eKiE1H/a8AyQ4fZAABWX36joTnII2S4z7BRLYF/qSMqLGi/xG3pQYk
        xZMA3uKIa+JxJgxRHOJYTOxD5
X-Received: by 2002:a05:622a:104:: with SMTP id u4mr315299qtw.163.1603126277740;
        Mon, 19 Oct 2020 09:51:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbhcgQbY1OZQlcVsbQuE3XX8qH7dztlppht2P4xC4jw0d8uYlcSYrjBYxCxD+5Nytdis8Tqw==
X-Received: by 2002:a05:622a:104:: with SMTP id u4mr315280qtw.163.1603126277499;
        Mon, 19 Oct 2020 09:51:17 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id s17sm171788qta.26.2020.10.19.09.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:51:16 -0700 (PDT)
From:   trix@redhat.com
To:     martyn@welchs.me.uk, manohar.vanga@gmail.com,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] vme: remove unneeded break
Date:   Mon, 19 Oct 2020 09:51:12 -0700
Message-Id: <20201019165112.29091-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return or goto

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/vme/bridges/vme_tsi148.c | 7 -------
 drivers/vme/vme.c                | 9 ---------
 2 files changed, 16 deletions(-)

diff --git a/drivers/vme/bridges/vme_tsi148.c b/drivers/vme/bridges/vme_tsi148.c
index 50ae26977a02..1227ea937059 100644
--- a/drivers/vme/bridges/vme_tsi148.c
+++ b/drivers/vme/bridges/vme_tsi148.c
@@ -506,7 +506,6 @@ static int tsi148_slave_set(struct vme_slave_resource *image, int enabled,
 	default:
 		dev_err(tsi148_bridge->parent, "Invalid address space\n");
 		return -EINVAL;
-		break;
 	}
 
 	/* Convert 64-bit variables to 2x 32-bit variables */
@@ -995,7 +994,6 @@ static int tsi148_master_set(struct vme_master_resource *image, int enabled,
 		dev_err(tsi148_bridge->parent, "Invalid address space\n");
 		retval = -EINVAL;
 		goto err_aspace;
-		break;
 	}
 
 	temp_ctl &= ~(3<<4);
@@ -1503,7 +1501,6 @@ static int tsi148_dma_set_vme_src_attributes(struct device *dev, __be32 *attr,
 	default:
 		dev_err(dev, "Invalid address space\n");
 		return -EINVAL;
-		break;
 	}
 
 	if (cycle & VME_SUPER)
@@ -1603,7 +1600,6 @@ static int tsi148_dma_set_vme_dest_attributes(struct device *dev, __be32 *attr,
 	default:
 		dev_err(dev, "Invalid address space\n");
 		return -EINVAL;
-		break;
 	}
 
 	if (cycle & VME_SUPER)
@@ -1701,7 +1697,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		dev_err(tsi148_bridge->parent, "Invalid source type\n");
 		retval = -EINVAL;
 		goto err_source;
-		break;
 	}
 
 	/* Assume last link - this will be over-written by adding another */
@@ -1738,7 +1733,6 @@ static int tsi148_dma_list_add(struct vme_dma_list *list,
 		dev_err(tsi148_bridge->parent, "Invalid destination type\n");
 		retval = -EINVAL;
 		goto err_dest;
-		break;
 	}
 
 	/* Fill out count */
@@ -1964,7 +1958,6 @@ static int tsi148_lm_set(struct vme_lm_resource *lm, unsigned long long lm_base,
 		mutex_unlock(&lm->mtx);
 		dev_err(tsi148_bridge->parent, "Invalid address space\n");
 		return -EINVAL;
-		break;
 	}
 
 	if (cycle & VME_SUPER)
diff --git a/drivers/vme/vme.c b/drivers/vme/vme.c
index b398293980b6..e1a940e43327 100644
--- a/drivers/vme/vme.c
+++ b/drivers/vme/vme.c
@@ -52,23 +52,18 @@ static struct vme_bridge *find_bridge(struct vme_resource *resource)
 	case VME_MASTER:
 		return list_entry(resource->entry, struct vme_master_resource,
 			list)->parent;
-		break;
 	case VME_SLAVE:
 		return list_entry(resource->entry, struct vme_slave_resource,
 			list)->parent;
-		break;
 	case VME_DMA:
 		return list_entry(resource->entry, struct vme_dma_resource,
 			list)->parent;
-		break;
 	case VME_LM:
 		return list_entry(resource->entry, struct vme_lm_resource,
 			list)->parent;
-		break;
 	default:
 		printk(KERN_ERR "Unknown resource type\n");
 		return NULL;
-		break;
 	}
 }
 
@@ -179,7 +174,6 @@ size_t vme_get_size(struct vme_resource *resource)
 			return 0;
 
 		return size;
-		break;
 	case VME_SLAVE:
 		retval = vme_slave_get(resource, &enabled, &base, &size,
 			&buf_base, &aspace, &cycle);
@@ -187,14 +181,11 @@ size_t vme_get_size(struct vme_resource *resource)
 			return 0;
 
 		return size;
-		break;
 	case VME_DMA:
 		return 0;
-		break;
 	default:
 		printk(KERN_ERR "Unknown resource type\n");
 		return 0;
-		break;
 	}
 }
 EXPORT_SYMBOL(vme_get_size);
-- 
2.18.1


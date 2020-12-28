Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0872E6B3D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Dec 2020 00:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgL1W4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 17:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgL1Vyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 16:54:46 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F15AC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:54:06 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w5so12564322wrm.11
        for <linux-kernel@vger.kernel.org>; Mon, 28 Dec 2020 13:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=qK9dczXsxwTfV8Fe+wr4SUDYJYRTch6fQ7DE1kC7eMU=;
        b=X8n55ZyRLKGh62oQ9UKZtTWcPgM5P2wEu3mRo18KNDbeUaVfxQnPEgwlNohCnv/7eB
         xg++zNseHeKXHNoY4iTmz7jVpfHzZn74cgc0dvUjRap4pFWS5GFjMRMo9QK/ijKNmf4M
         E272H4ec2xSsqkKQLAM8v95MjoxdIGgCIQF3tD9+9SQkl0Te/Y/b0y+w2dxKW1+5Gfb1
         m+XoD8+TWCHFRK5vxm93Z5SiLSKCtghQKYVZcdOLsW/iHz68OvQWqClWe24EuEVocVV+
         KXxk4qCjoIXdGQh7b+xR3Iwe2vrX9LN1DlHKDZwY+Ylp2bHomy2fbO4N4UzSdIumgPu+
         5Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qK9dczXsxwTfV8Fe+wr4SUDYJYRTch6fQ7DE1kC7eMU=;
        b=fDewHTp5iwyKp6JGdCHtTzVjj80tfZG2QaX8DsIJDRXy9AYNjVIUWaDM7kI22/2HMb
         1MSSHAZ1iDrbHLGX2yPYfjBc9YVJXAEmEc6cY8//1U988m3JTpgCbT84mvJVLYCWuZvg
         hq2nMRIhQblfb9bHI+8CCrFKy2w2H3h6SxJwfLfGIXmYDAlOBx4gL6L37XHsSxvFL2HA
         23/63pWmop8zC7u4SryCHwPILC+6yY8SV8CwKTEO/90no7zCVi7Ck6kNszUm1FFsL5me
         eL6WJwRu6UuHEWdcl33xueLck42V4dHCXXcuF7/l3nEBWj1bZ7F92HQ8b5E0ANaR5FhP
         kzLw==
X-Gm-Message-State: AOAM531aUsKHndqs+KHloamh1eV5pKG0UdvY0XxOAItjDNCFtwMdq28S
        ppltkFHVUtAYz+0PxjP0Nw==
X-Google-Smtp-Source: ABdhPJz7K+GfEbHWlcUOYRoN/1m8HWtJHJjy3m9D1JhSoq084Y94fJecUk62GNn6NWTMDPMr74ZNLw==
X-Received: by 2002:a5d:6a05:: with SMTP id m5mr52133603wru.96.1609192444868;
        Mon, 28 Dec 2020 13:54:04 -0800 (PST)
Received: from localhost.localdomain ([46.53.251.87])
        by smtp.gmail.com with ESMTPSA id q143sm773105wme.28.2020.12.28.13.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 13:54:04 -0800 (PST)
Date:   Tue, 29 Dec 2020 00:54:02 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, avagin@gmail.com
Subject: [PATCH] timens: delete no-op time_ns_init()
Message-ID: <20201228215402.GA572900@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/time/namespace.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -465,9 +465,3 @@ struct time_namespace init_time_ns = {
 	.ns.ops		= &timens_operations,
 	.frozen_offsets	= true,
 };
-
-static int __init time_ns_init(void)
-{
-	return 0;
-}
-subsys_initcall(time_ns_init);

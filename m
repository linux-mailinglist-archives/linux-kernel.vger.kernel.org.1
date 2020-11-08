Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE042AAC41
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 17:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbgKHQhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 11:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgKHQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 11:37:20 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C5AC0613CF
        for <linux-kernel@vger.kernel.org>; Sun,  8 Nov 2020 08:37:18 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id r7so5853509qkf.3
        for <linux-kernel@vger.kernel.org>; Sun, 08 Nov 2020 08:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=3G7FVwYQRunIazmBCUpjweHyHC3Fn2vVsZDow8nM3EI=;
        b=TydhePctclCrzDNbwTETc656ZHJ3OUFBj9ASriIZJeeHKTC0lUA+jd5TVgAmSL2BgO
         ykmNdtIJXt2Mu//14yXvuiyLWgLv1C9MWDWcGlOjwOzb2Hhuz19k3p20inmbUfZTg8rk
         xDoQSjFrol1Dko2JvDlW1SWIrdcHhOSy/7fQlLcrwgMqEXkmxuotgljqdn8iKyybFy0R
         3jIAB+baH/yC8LDx6D53hx41EsZqc+x8N3QS0hJOYer1z/1Cj4QknbwztlcuLzYkmqYt
         z0ODjf/ZXb4LpwhY0DEwD/tK2MrZ99dfnM1UoVLxlDjnLyEJPRLOiNJFauASm6aVSKBx
         TM4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=3G7FVwYQRunIazmBCUpjweHyHC3Fn2vVsZDow8nM3EI=;
        b=VrZr+cEEtdxSgs/8sQmyBKCGrOcUIENRAGUCChteXYYCRoZmreYvshBHBHiXXUwyD4
         dO/w4bKMZienbNvhlpEo2aludTjGqJEKDHNSPMIyswl49qLzThxrBvH0XKTtK9wHVF1y
         hv2Op8LKcWzjj9kAyd61/RaD2UlQPdWRf8/m9MRRrUGdenXABJOLWOnviBjtiL9EO2rw
         cmqypFjYzGqxorMKFXGeuDeUbguDWlsBI1p4rOep+6eEncYOvRQlMtB2NUFCUDcjqSjy
         MpVIO4ZmmRLifRPlNrmNexyIKXtygYSYZVOkBsbxdpZa6ufJh+u9bfonOBO4lBcQZbdW
         sEVQ==
X-Gm-Message-State: AOAM532nfxX+MmfVN/e1krSm/C1fu1cwhnjDkZmsdnqZsqLvJwqYWaBt
        r6uT//SLJL2DKaCL6wx1p5s=
X-Google-Smtp-Source: ABdhPJyZXCLml0vlBMtqXjRgoqXfONs04IJSNajKihKyk0bo6ylsQKRbLltSntkKWfQ8uMBqDteZpw==
X-Received: by 2002:a37:dc02:: with SMTP id v2mr391128qki.181.1604853437836;
        Sun, 08 Nov 2020 08:37:17 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id u16sm4404250qth.42.2020.11.08.08.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 08:37:16 -0800 (PST)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 8 Nov 2020 11:37:15 -0500
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Definition of PMD_FLAGS_DEC_WP in arch/x86/mm/mem_encrypt_identity.c
Message-ID: <20201108163715.GA206902@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I have a question about this definition in
arch/x86/mm/mem_encrypt_identity.c:

	#define PMD_FLAGS_LARGE         (__PAGE_KERNEL_LARGE_EXEC & ~_PAGE_GLOBAL)

	#define PMD_FLAGS_DEC           PMD_FLAGS_LARGE
	#define PMD_FLAGS_DEC_WP        ((PMD_FLAGS_DEC & ~_PAGE_CACHE_MASK) | \
					 (_PAGE_PAT | _PAGE_PWT))

_PAGE_CACHE_MASK and _PAGE_PAT are for 4k pages, not 2M pages. The
definition of PMD_FLAGS_DEC_WP clears the PSE bit by masking out
_PAGE_CACHE_MASK, and sets it again by setting _PAGE_PAT, resulting in
PMD_FLAGS_DEC_WP actually being write-through, not write-protected,
using PAT index 1.

Shouldn't the definition be

	#define PMD_FLAGS_DEC_WP	(PMD_FLAGS_DEC | _PAGE_PAT_LARGE | _PAGE_PWT)

for write-protected using PAT index 5?

I guess the difference doesn't actually matter for encrypt-in-place? But
mem_encrypt_boot.S takes pains to initialize PA5 to be write-protected,
and it looks like it won't actually be used.

Thanks.

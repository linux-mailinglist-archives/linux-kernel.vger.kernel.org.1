Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A37A22FC9D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jul 2020 01:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgG0XIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 19:08:05 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:35034 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgG0XIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 19:08:04 -0400
Received: by mail-qt1-f196.google.com with SMTP id b25so13591388qto.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 16:08:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S8I1Kaf/LJR4Y2Bet9OYDl+rhIGtV8E+QzPTHozOKCg=;
        b=A35PtSRVDxMx4Jq4p02ftwEcyCcr1+pe29UjivWiVnYIlSiB5Z92cKmJs+DeIwcQXe
         nGmOWNt7yKr72aFEU0HTjOr3RPIXHuo2CN8xqcXxqwksvrhyE2YMZTIUj/XA3NWi+JIP
         HBWV3oqcyhzFeLfAxOWd10l+sAgE8vV+rbW+saJU1Hl1auX+2ZWr04ZCSAwlqNIPHG7s
         k1fmBEARxLR4zzUIJzKjTPJsMtbnNlgGL73OA0AJFsW8nXeI+NettqcVyqeu6W0BX/fi
         oR+WhdL3dDkY3j0g0+dhY9tOy69dfV7weN/+SalZVd4JYgJ739eSbbWsx3b0zEabiw6L
         IuSg==
X-Gm-Message-State: AOAM533ZQDjkn7Kvz5j2OC0dYiv1+9vhVml8kU1CG9AD9sUIgRDfC1hb
        uD7D+jmGbVbFLdGHUm0oJ8s=
X-Google-Smtp-Source: ABdhPJxw+vDsMqIkXyqNp1yfZ+5/7GQ8e393lN1cnzbxP+t5nnYR1A/ddGwAZBVg5a7w1R0q8F6OMA==
X-Received: by 2002:ac8:f73:: with SMTP id l48mr24198737qtk.296.1595891282983;
        Mon, 27 Jul 2020 16:08:02 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id j61sm8216984qtd.52.2020.07.27.16.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 16:08:02 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/8] x86/kaslr: Cleanup and small bugfixes
Date:   Mon, 27 Jul 2020 19:07:53 -0400
Message-Id: <20200727230801.3468620-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200727215047.3341098-1-nivedita@alum.mit.edu>
References: <20200727215047.3341098-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first 7 patches are cleanup and minor bugfixes on the x86 KASLR
code.

The last one is a bit of an RFC. The memory regions used for KASLR are
stored as 64-bit even on a 32-bit kernel. However there are still a few
local variables that are 32-bit, but should be ok as far as I can see
because they are assigned values that have been already limited to
32-bit. It does make it a little harder to verify that the code is
correct. Since KASLR cannot actually use 64-bit regions for the 32-bit
kernel, the patch reduces regions to their below-4G segment when
creating them, making the actual variables 32-bit. Alternatively, the
few local variables could be upgraded to 64-bit.

v1->v2:
- Fix a bug in the bugfix 5/8: overlap.start can be smaller than
  region.start, so shouldn't subtract before comparing.

Arvind Sankar (8):
  x86/kaslr: Make command line handling safer
  x86/kaslr: Remove bogus warning and unnecessary goto
  x86/kaslr: Fix process_efi_entries comment
  x86/kaslr: Initialize mem_limit to the real maximum address
  x86/kaslr: Simplify __process_mem_region
  x86/kaslr: Simplify process_gb_huge_pages
  x86/kaslr: Clean up slot handling
  x86/kaslr: Don't use 64-bit mem_vector for 32-bit kernel

 arch/x86/boot/compressed/acpi.c  |   7 +-
 arch/x86/boot/compressed/kaslr.c | 228 ++++++++++++-------------------
 arch/x86/boot/compressed/misc.h  |  19 ++-
 3 files changed, 111 insertions(+), 143 deletions(-)

-- 
2.26.2


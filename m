Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B418222FBA4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 23:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgG0Vuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 17:50:51 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46639 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726110AbgG0Vuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 17:50:50 -0400
Received: by mail-qv1-f67.google.com with SMTP id j10so1557968qvo.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 14:50:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=c5nWJ6DStWaAwLBBJDt4epCRA3xXREXZG+dLKv9/lT4=;
        b=VaO2TjW+i4K0l53fSFs6KqbubNkZnHsxbN7MAW1tHvZ0Lpn278dX7vp9IS86320Qst
         ZGbaq6ceYus0E+g0IWKQR07rkjRCmAkMhC6/v9jA1YUe+6SzFEVJpFu5PYMLm23kiwkW
         UhLzVHhEzU9XvGT+TxqCJqOV+FeUQwDTbWOFkw5eYv/PJbv+nGq5JoC0GX4VWefn1iRs
         El9TYQuT787GezO30qZsDbltJzc6W0mASo1W6CSpSG8llYgdo8fVJHx5XtSaLj9TQZfx
         5tjg6rTTlDs3QhAcAXYUfrUPmGfd+Nm6e0deS4049ES5LFR2oiVDPKHbhFNDfePw2+Bf
         jdBw==
X-Gm-Message-State: AOAM530dMla0TMiMUeBu79Uple8tb3o+Yv4nrjc+X8F3vQwbUpraDA/v
        Q7RI9oxVDm5fgXZy/OrOGc8=
X-Google-Smtp-Source: ABdhPJzFB44eBD2XPbrHnPQMDfQf5n3tEzOf39AtdsWbUywdx0/MCGH1J5nTiM2J1jzVKbKS4pvANA==
X-Received: by 2002:a0c:ec86:: with SMTP id u6mr11266941qvo.58.1595886649564;
        Mon, 27 Jul 2020 14:50:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n90sm15629338qte.21.2020.07.27.14.50.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 14:50:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Kees Cook <keescook@chromium.org>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 0/8] x86/kaslr: Cleanup and small bugfixes
Date:   Mon, 27 Jul 2020 17:50:39 -0400
Message-Id: <20200727215047.3341098-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
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


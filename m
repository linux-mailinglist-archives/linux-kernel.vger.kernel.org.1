Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB13297FA7
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 02:58:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1765960AbgJYAmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 20:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1765953AbgJYAmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 20:42:04 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F667C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 17:42:04 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id e6so4265570qtw.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Oct 2020 17:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Dkng1c4V914RnOVccjvJdnUPbvSpX23hYUBeNu/xFag=;
        b=qfOSLBJTymt8BVCSPd9gQcA2Ne6fLJPxMHdgFGeOrhshTniUJ24YWVu8IQ6zbQ2A67
         am401wefa9Qawv59JEyrWqGveRD0+w1kjSRq2oMAm/amsbvAh0huNMnF7K7ckuPf4Une
         n7p42Y72WFPSQ+6UB8JJxVlSz+x4BUygdhpS+25PtbMaTLX5S6S9m4JO7qVf7Da+OxkA
         g7yv8WqwjyK6UgF3IlClRGl1ZhAlYi4TjUf+2Vb7I4O1nmDS2fwCqoEXm7eqNnY3xx/S
         kuqj0nmDEvNgFrMJ2fMOc9iV7zKkSUkcI1XFD/OKq2AXVWNGGe/lH0QYm+8Fhp4nGRV/
         sL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=Dkng1c4V914RnOVccjvJdnUPbvSpX23hYUBeNu/xFag=;
        b=O/iU3JPrwN+N+ypyuAjOtWHprje6yh1AgLjrInKtCak/ruvFJIVlI+mTTw8JM/ZQau
         EetKhaUOBex2Ego/6DDItRg13xAL5sSKblSIoKA+0SZ+anC4c90XOaovr1AjjuqgFVIw
         R3nI9u6buef2eyUapZLe7336IbfU6xUeJHKRWTzn3ZCtITvMk1uQh+z4bUBQWDY+H06Y
         KJx/2rWsiH+j2ABQF+TJh/dTcFBEMEXkgt85oyoFuLYm9UMP2bdcM2/YtmHMzeDXVaRQ
         zzyv0UE4FeYEToLveVYjoRnK1BhFLD1TOmbKyORut3RkdahFMHh4y23Zj9McOLRGbA/S
         YV1A==
X-Gm-Message-State: AOAM530HkWqIhNkuO+V/sod2Ja8tlfXTqAjpqZ6C99Obe7vYgydW6IRJ
        Rh76HpKX+2WsCfTVxJLehvd5gEdDItU9Yw==
X-Google-Smtp-Source: ABdhPJxOoLfBQMpOha6KGrVdAB7uNAg7leGXtAgoYtIqSMVLjoWS1BPBM4EmAX4DHSBYCmIyc7RxOw==
X-Received: by 2002:ac8:4d03:: with SMTP id w3mr10251441qtv.360.1603586521783;
        Sat, 24 Oct 2020 17:42:01 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l29sm1464004qtb.38.2020.10.24.17.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 17:42:00 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 24 Oct 2020 20:41:58 -0400
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: RFC x86/boot/64: BOOT_PGT_SIZE definition for compressed kernel
Message-ID: <20201025004158.GA767345@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I think the definition of BOOT_PGT_SIZE in
arch/x86/include/asm/boot.h is insufficient, especially after
  ca0e22d4f011 ("x86/boot/compressed/64: Always switch to own page table")

Currently, it allocates 6 pages if KASLR is disabled, and either 17 or
19 pages depending on X86_VERBOSE_BOOTUP if KASLR is enabled.

- The X86_VERBOSE_BOOTUP test shouldn't be done: that only disables
  debug messages, but warnings/errors are always output to VGA memory,
  so the two extra pages for mapping video RAM are always needed.

- The calculation wasn't updated for X86_5LEVEL, which requires at least
  one more page for the P4D level, and in theory could require two extra
  pages for each of the 4 mappings (compressed kernel, output kernel,
  boot_params and command line), though that would require a system with
  truly ginormous amounts of RAM.

- If KASLR is disabled, there are only 6 pages, but now that we're
  always setting up our own page table, we need 1+(2+2)*3 (one PGD, and
  two PUD and two PMD pages for kernel, boot_params and command line),
  and 2 more pages for the video RAM, and more for 5-level. Even for
  !RELOCATABLE, 13 pages might be needed.

- SEV-ES needs one more page because it needs to do a PTE-level mapping
  for the GHCB page.

- The static calculation is also busted because
  boot/compressed/{kaslr.c,acpi.c} can scan the setup data, EFI
  configuration tables and the EFI memmap, and none of these are
  accounted for. They used to be scanned while still on the
  firmware/bootloader page tables, but now our page tables have to cover
  them as well. Trying to add up the worst case for all of these, and
  anything else the compressed kernel might potentially access seems
  like a lost cause.

We could do something similar to what the main kernel does with
early_dynamic_pgts: map the compressed kernel at a fixed virtual
address (in negative address space, say); recycle all the other mappings
until we're done with decompression, and then map the output,
boot_params and command line. The number of pages needed for this can be
statically calculated, for 4-level paging we'd need 2 pages for the
fixed mapping, 12 pages for the other three, and one PGD page.

Thoughts?

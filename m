Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED65F293080
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 23:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733060AbgJSVbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 17:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733039AbgJSVbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 17:31:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C19C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:31:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h21so1612669iob.10
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 14:31:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5HQDPp61VlIDBA99n2DDMcqn8RjH02azIK7wCa+Vpvs=;
        b=ompDr4Acqi/JOvPERY/PMWDN491zGOYZ4ITSt7QVR5fXydcluEDpyeQyTC7NYmOWos
         HgbsE1GP+kTI+xL2MLuUJ7noS6cXSKbHHX/fOYk9y5FrO10y7httfuQBnXUYP3tQv2HA
         r26SymfgWt67bukJvkrq6BRdZZZpeMxMY6CqAOELoWbz+tvTs8kHO2Qcmp1DBWQHA5vV
         USB3Fyksw65+dxisqL0cagh5Cx5h2WlhDTDFf9eZM1L5sK6FJNpm2PET1EAPH25dOQRq
         F6LqHrK+vj3Pk6Bq5eztKXoCtnatJJee30vCjZIuEjK5d/jhYgtJw5A0pgy0UsNVKx21
         27bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5HQDPp61VlIDBA99n2DDMcqn8RjH02azIK7wCa+Vpvs=;
        b=t1nsAucKNwRPZecq96mCdzzVA+B9z4SzqN7+vz/PA3KQrwT+9eQmLPyy3OyZEyysQG
         lxu0IxLE6sLtIfoD+QZBQeOvg3VpdY44scs8aLYrhLONjdD89eStcKJFI0ttCcXgt1fY
         V6J2Ku13UvGLDpfF998S2FQjXhVmO2E3/OBxhjgGeySo75/J0xT+5q1SzFj7urDBpEwN
         iHJQ7L0KpyrCC0Zhq5Y7400D1bgMwK/q2U5xQJE7bVwPd2JqEzQYLZTPKypjBwwxN4sX
         2fxEeUzU0W3QZrHoa0hSS/jyPKeeAsJTuL8S4kiMAcG7tJj5KubkFJUkRp/kFBV2W9rx
         b4/A==
X-Gm-Message-State: AOAM5303S5EbgjC9yQf1eAITmqIhakLsmBKFSYF2VwlO/1p5oEiO5ygM
        F/721i9yCovjMpWM4e6wv5U=
X-Google-Smtp-Source: ABdhPJxAlYxgkH+5pE3pkI+Vg3CXGTyAfuAee1u82ZDJBub3srvTlGUxpx2f3q4AmmyDnDvxc6iOIQ==
X-Received: by 2002:a6b:144e:: with SMTP id 75mr1212777iou.39.1603143069222;
        Mon, 19 Oct 2020 14:31:09 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p198sm936465iod.15.2020.10.19.14.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 14:31:08 -0700 (PDT)
Sender: Arvind Sankar <niveditas98@gmail.com>
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 19 Oct 2020 17:31:06 -0400
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>, x86@kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Martin Radev <martin.b.radev@gmail.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] x86/boot/compressed/64: Check SEV encryption in
 64-bit boot-path
Message-ID: <20201019213106.GB2815942@rani.riverdale.lan>
References: <20201019151121.826-1-joro@8bytes.org>
 <20201019151121.826-4-joro@8bytes.org>
 <20201019170008.GA2701355@rani.riverdale.lan>
 <20201019175447.GA2720155@rani.riverdale.lan>
 <20201019203935.GG3635@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201019203935.GG3635@8bytes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 19, 2020 at 10:39:35PM +0200, Joerg Roedel wrote:
> On Mon, Oct 19, 2020 at 01:54:47PM -0400, Arvind Sankar wrote:
> > Also, isn't it possible that the initial page tables we're running on
> > have already been messed with and have the C-bit in the wrong location,
> > so that this write happens decrypted?
> 
> The code assumes that the page-table it is running on has the correct C
> bit position set and that the code which set it up verified that it is
> correct. For the kernel itself this is true, at least, but when booting
> via UEFI the check also needs to happen in the firmware.
> 
> Note that the possibilies are limited when the hypervisor reports the
> wrong C bit position because code fetches always assume encryption, even
> when the C bit is cleared in the page-table. So a wrong C bit position
> in the decompression stub would write the kernel image to memory
> unencrypted and executing it would not be possible.

Is it possible to take advantage of this to make the check independent
of the original page tables? i.e. switch to the new pagetables, then
write into .data or .bss the opcodes for a function that does
	movabs	$imm64, %rax
	jmp	*%rdi	// avoid using stack for the return
filling in the imm64 with the RDRAND value, and then try to execute it.
If the C-bit value is wrong, this will probably crash, and at any rate
shouldn't return with the correct value in %rax.

> 
> Regards,
> 
> 	Joerg
> 

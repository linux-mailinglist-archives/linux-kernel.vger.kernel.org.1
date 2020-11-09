Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BF22AC28D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Nov 2020 18:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbgKIRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Nov 2020 12:39:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:41252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730330AbgKIRjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Nov 2020 12:39:10 -0500
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4123F20578
        for <linux-kernel@vger.kernel.org>; Mon,  9 Nov 2020 17:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604943549;
        bh=hlWU5zGloECZNFrwjneLZv9TFr5kKDDNTOdv4sM4WJw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C2vyZAXthtKbVejAYfokMEHzLWrY0mx5+BZ2K1LjjVWYpnSnEQixeBH0De+uzqubk
         urQlv1X32ne2iNWEZilSz11T1bBDZEfup7TNmrMMIAkpFJIZ2EroqLWkhYNOCU/J/d
         jqG/vymsRjO82JnnIowbYRYuW19EMdtY2PKgzYZA=
Received: by mail-wr1-f50.google.com with SMTP id 23so9634896wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 09 Nov 2020 09:39:09 -0800 (PST)
X-Gm-Message-State: AOAM531Q9zqCDcP1x6cPFr1sFLyN/N+YeOj7vMsKgJqrnrCJvAOy3MZJ
        T9XKU5D0p4BrAdmUcBdi4yH2NCfLpu7VAlszPTTBJQ==
X-Google-Smtp-Source: ABdhPJw64Ik7b4CF8w3NkV+aIFZGT1v2JwzOiiqcpzuWWwR9CmmTYAALTFHkV0kT+S/fvdde9zvhLIO76HO3rStWkKo=
X-Received: by 2002:adf:f0c2:: with SMTP id x2mr12660274wro.184.1604943547814;
 Mon, 09 Nov 2020 09:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20201109112319.264511-1-alexandre.chartre@oracle.com> <20201109112319.264511-9-alexandre.chartre@oracle.com>
In-Reply-To: <20201109112319.264511-9-alexandre.chartre@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 9 Nov 2020 09:38:56 -0800
X-Gmail-Original-Message-ID: <CALCETrXtqC9w5gAa=UcF=B4z7vKuUL2sutsCJOjaSCK4CX4q0Q@mail.gmail.com>
Message-ID: <CALCETrXtqC9w5gAa=UcF=B4z7vKuUL2sutsCJOjaSCK4CX4q0Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 08/24] x86/entry: Add C version of SWAPGS and SWAPGS_UNSAFE_STACK
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 9, 2020 at 3:22 AM Alexandre Chartre
<alexandre.chartre@oracle.com> wrote:
>
> SWAPGS and SWAPGS_UNSAFE_STACK are assembly macros. Add C versions
> of these macros (swapgs() and swapgs_unsafe_stack()).

This needs a very good justification.  It also needs some kind of
static verification that these helpers are only used by noinstr code,
and they need to be __always_inline.  And I cannot fathom how C code
could possibly use SWAPGS_UNSAFE_STACK in a meaningful way.

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B314D1D19CD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 May 2020 17:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389198AbgEMPrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 May 2020 11:47:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:43238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbgEMPrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:47:00 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A718B20659
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 15:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589384820;
        bh=nzgdwqBNsrP+73eJCjx0UH7nQXREgSbxf60tXOz/1mA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=uTYkcqcoqoyksVZUKhSa9PcQZ7U0QNWOs1Pb5AAKeEs6RhzLiVRCQ3Qpw8+nTE929
         dcX1cFwFqWckgbCKSoP/FhIojh8qUM1IBjDwUFkLg5JvwihgMuOsf/OjJ3hVXx56J1
         SC7asO2sZ0gMpAwWAQ2cRb6o8vQIppMko+5EBOf8=
Received: by mail-wm1-f46.google.com with SMTP id w19so14302103wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 08:47:00 -0700 (PDT)
X-Gm-Message-State: AGi0PuavGKMsvOXnZabloNZCMytXFNNx/0n4NdcTGsNKs/NLVqbAlZcY
        NEulQOGHlF+5lI8L0PNIuf8D+5wd+M8XqGt6aBg+iw==
X-Google-Smtp-Source: APiQypKuUOoHroqVE1Q2xSEZ5CJAKVmZYRRug6GQ131e/OlvUQIzVUtZ4lvV/wUI+iagtz1aPdU6tH9xKFo/pnQ17qg=
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr22837779wmf.138.1589384818895;
 Wed, 13 May 2020 08:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200513152137.32426-1-joro@8bytes.org> <20200513152137.32426-8-joro@8bytes.org>
In-Reply-To: <20200513152137.32426-8-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 08:46:47 -0700
X-Gmail-Original-Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Message-ID: <CALCETrUq=-huvWXJpVLvPRNwTiniQg8DP6R__J33gE8iSoEGAg@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] x86/mm: Remove vmalloc faulting
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 8:21 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Remove fault handling on vmalloc areas, as the vmalloc code now takes
> care of synchronizing changes to all page-tables in the system.

You should also remove sync_current_stack_to_mm().

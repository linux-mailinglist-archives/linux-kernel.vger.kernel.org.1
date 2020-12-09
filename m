Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBB6B2D4EB3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 00:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbgLIXXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 18:23:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:53580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLIXWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 18:22:51 -0500
Date:   Wed, 9 Dec 2020 15:22:09 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1607556131;
        bh=MaYUEPvPTBBzMVc3qfNPLeNSrF7PTzU/js45QJeEGPc=;
        h=From:To:Cc:Subject:In-Reply-To:References:From;
        b=UQ705txGjuzhwt5CDJ0nlYUXtNvic6KqPLjAtrMtjEl5UP+OPSwJANkpabEypQvdB
         YglIg/sncIkn16WDYCh5A87hVldqLukKAU7fyhA1tJUKu4lYt60ptOhV07hDnxASm0
         15s4lUy7zeNWoQRONHB/8JYoBC+WWnd0LaONbcT4=
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Marco Elver <elver@google.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH mm 2/2] Revert
 "kasan, arm64: don't allow SW_TAGS with ARM64_MTE"
Message-Id: <20201209152209.7af1e9fbe1bf523483d29539@linux-foundation.org>
In-Reply-To: <CANpmjNM9suHQY-uQN9g5h=Vdv2wotDKNdcnHM=-RTtEb2sCZTA@mail.gmail.com>
References: <cover.1607537948.git.andreyknvl@google.com>
        <a6287f2b9836ba88132341766d85810096e27b8e.1607537948.git.andreyknvl@google.com>
        <CANpmjNM9suHQY-uQN9g5h=Vdv2wotDKNdcnHM=-RTtEb2sCZTA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Dec 2020 19:51:05 +0100 Marco Elver <elver@google.com> wrote:

> > This is no logner the case: in-kernel MTE is never enabled unless the
> > CONFIG_KASAN_HW_TAGS is enabled, so there are no more conflicts with
> > CONFIG_KASAN_SW_TAGS.
> >
> > Allow CONFIG_KASAN_SW_TAGS to be enabled even when CONFIG_ARM64_MTE is
> > enabled.
> >
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> Reviewed-by: Marco Elver <elver@google.com>

Thanks.  I simply dropped
kasan-arm64-dont-allow-sw_tags-with-arm64_mte.patch.

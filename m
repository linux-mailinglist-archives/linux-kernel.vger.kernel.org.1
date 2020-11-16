Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D78A32B4641
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 15:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730443AbgKPOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 09:47:14 -0500
Received: from foss.arm.com ([217.140.110.172]:40762 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730290AbgKPOrN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:47:13 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D3E9831B;
        Mon, 16 Nov 2020 06:47:12 -0800 (PST)
Received: from [10.37.12.42] (unknown [10.37.12.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CDD253F718;
        Mon, 16 Nov 2020 06:47:09 -0800 (PST)
Subject: Re: [PATCH RFC v2 04/21] kasan: unpoison stack only with
 CONFIG_KASAN_STACK
To:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will.deacon@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Serban Constantinescu <serbanc@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <cover.1603372719.git.andreyknvl@google.com>
 <ded454eeff88f631dc08eef76f0ad9f2daff0085.1603372719.git.andreyknvl@google.com>
 <CACT4Y+Zys3+VUsO6GDWQEcjCS6Wx16W_+B6aNy-fyhPcir7eeA@mail.gmail.com>
 <CAAeHK+xvGZNwTtvkzNnU7Hh7iUiPKFNDKDpKT8UPcqQk6Ah3yQ@mail.gmail.com>
 <CACT4Y+Z3UCwAY2Mm1KiQMBXVhc2Bobi-YrdiNYtToNgMRjOE4g@mail.gmail.com>
 <CANpmjNPNqHsOfcw7Wh+XQ_pPT1610-+B9By171t7KMS3aB2sBg@mail.gmail.com>
 <X7Jthb9D5Ekq93sS@trantor>
 <CACT4Y+ZubLBEiGZOVyptB4RPf=3Qr570GN+JBpSmaeEvHWQB5g@mail.gmail.com>
 <9d4156e6-ec4f-a742-a44e-f38bf7fa9ba9@arm.com>
 <CAAeHK+xb4w1XSe_cXeV77d3VkHq6ABAKkKuEaFN-uFVY457-Ww@mail.gmail.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <ea105e7f-44a6-b6e3-fac4-73f057e9226f@arm.com>
Date:   Mon, 16 Nov 2020 14:50:17 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAAeHK+xb4w1XSe_cXeV77d3VkHq6ABAKkKuEaFN-uFVY457-Ww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/20 1:50 PM, Andrey Konovalov wrote:
> Fixing this sounds like a good idea, but perhaps not as a part of this
> series, to not overinflate it even further.
> 
> I've filed a bug for this: https://bugzilla.kernel.org/show_bug.cgi?id=210221

Fine by me.

-- 
Regards,
Vincenzo

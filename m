Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7EC2FA8F3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407694AbhARSez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 13:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:60956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407652AbhARSch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 13:32:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBFEA22CA1;
        Mon, 18 Jan 2021 18:31:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH v3 0/2] kasan: fixes for 5.11-rc
Date:   Mon, 18 Jan 2021 18:31:52 +0000
Message-Id: <161099467077.3190.11574628584185482983.b4-ty@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1610731872.git.andreyknvl@google.com>
References: <cover.1610731872.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jan 2021 18:41:51 +0100, Andrey Konovalov wrote:
> Changes v2->v3:
> - Fix up kernel pointer tag in do_tag_check_fault() instead of
>   report_tag_fault().
> 
> Andrey Konovalov (2):
>   kasan, mm: fix conflicts with init_on_alloc/free
>   kasan, arm64: fix pointer tags in KASAN reports
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[2/2] kasan, arm64: fix pointer tags in KASAN reports
      https://git.kernel.org/arm64/c/3ed86b9a7140

-- 
Catalin


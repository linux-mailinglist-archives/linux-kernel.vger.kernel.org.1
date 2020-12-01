Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 183B82CA949
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 18:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392185AbgLARFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 12:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387407AbgLARFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 12:05:15 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF266C0613D4
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 09:04:28 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id g185so6991751wmf.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 09:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cfFW7KVHwuHqdHc+004sCc3ASvBne4aoSX6rv8lR7RE=;
        b=oK6znZpPwwhbE2BPTUWTO4R4ZY6gUVUwxEoMjJqNM8/dua63rEmgnEJ1GiQJ2Zcn9w
         X/EN6kJ8NWRxEc1lvRv5MVwBpxVMyjWZgeC6tJIPnzYXCiR851bqXnZlyEgb761BWzva
         A1aJVgpoflPp0A8sfgHJVeiYPKNmYnfH0AP9UpAkcn8zcoPY2IXSaRKGkxHOIvWlePPu
         MbLKbtgDg5UO9KL4i0y3KjEXATRi+JirSYLG50+y11lk9I8Bi3sqFTrAKQ5DiXIjiKe/
         AOG3hcAf65/cQ8MT0B6vMCk/NLI34JeQGbTedH3IhGrjw9yyA/AQ3Hsw/5zab/xfb9ie
         esPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cfFW7KVHwuHqdHc+004sCc3ASvBne4aoSX6rv8lR7RE=;
        b=ea/Grnxy+Tj4xRQF1vns+nHEL0Fpooy0zq2YRiUbkCdU6yeNHjpZQ8cNVzp5W8cuvg
         OBq+Bwq3QnBczL8aO9PpPWFOVpPbu+olwcTKExbBfmAg/EMhwhNqkmZHtWbYhHeqbuOg
         w9OOkYnjkW07BmXaUx+dwCnb5HxB2HSd0QI6w2r/ITYfkdwvZxNhMnuwPmrAkhb2h8uV
         upfzEUF6QeIeYjAxGrJZujJzgVgcZpfYHmZpZHPol8LkLWOHtlcHg5Z5I3JwV+4NSMxX
         2dcRDWAOZf/GVJ6Q9fwYa4HL42DuB4rx4F+ie0XwVqvjDhv7UmUmyAENAdHboDQwR5vk
         WANA==
X-Gm-Message-State: AOAM530k8vBggofRW9U9BWllqrxhailbYn8ceR8QOE0QKY7fLsxKNnKk
        0efGKDsx9BKPT2O03DZj70JGWsKM3NzLsA==
X-Google-Smtp-Source: ABdhPJxhFee60WH/yHrTItDBzVamyCh03lCtUkLlKBeXIhYtL3sDVjHF4KdhMXPNOT2FXBB7+FCRdw==
X-Received: by 2002:a7b:cc94:: with SMTP id p20mr1352007wma.22.1606842267471;
        Tue, 01 Dec 2020 09:04:27 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:f693:9fff:fef4:2449])
        by smtp.gmail.com with ESMTPSA id e14sm222016wrm.84.2020.12.01.09.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 09:04:26 -0800 (PST)
Date:   Tue, 1 Dec 2020 18:04:21 +0100
From:   Marco Elver <elver@google.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        masahiroy@kernel.org, ndesaulniers@google.com, joe@perches.com
Subject: Re: [PATCH] genksyms: Ignore module scoped _Static_assert()
Message-ID: <20201201170421.GA3609680@elver.google.com>
References: <20201201152017.3576951-1-elver@google.com>
 <20201201161414.GA10881@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201161414.GA10881@infradead.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 01, 2020 at 04:14PM +0000, Christoph Hellwig wrote:
> Why not use the kernels own BUILD_BUG_ON instead of this idiom?

BUILD_BUG_ON() was conceived before there was builtin compiler-support
in the form of _Static_assert() (static_assert()), which has several
advantages (compile-time performance, optional message) but most
importantly, that it can be used at module/global scope (which
BUILD_BUG_ON() cannot).

From include/linux/build_bug:

	/**
	 * static_assert - check integer constant expression at build time
	 *
	 [...]
	 *
	 * Contrary to BUILD_BUG_ON(), static_assert() can be used at global
	 * scope, but requires the expression to be an integer constant
	 * expression (i.e., it is not enough that __builtin_constant_p() is
	 * true for expr).
	 [...]

.. and there are plenty of global/module scoped users of it already.

Thanks,
-- Marco

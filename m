Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B300A2F1820
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388517AbhAKOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731452AbhAKOYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:24:39 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2709DC061786
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:23:59 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u25so17201388lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jan 2021 06:23:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AUnHjmoZBMPPrCWzaTempqIXz+G+HPhuggI2H5BxADg=;
        b=NYTw7WWk1Zf7aSea06TGNnxIUYEc7qq9AW/lldbVIlJWFwcFfjUZfoog7LIDmbomQT
         4Ji/pCiUBy/Pvci3hJLsfml51b/4OYHgCYH4usuGLc9BYLPBS8Y+4CYEzlI+KLerC4mo
         euxtuBpAYikzhBtptV3Xzt0M8bEon0shmqoSYFufDnj8HNvqVXDrVTpmig6MMDU8p2jx
         25RftUJXI7+SCtdFIWtP4yxlAtQoYFXLf8D+XQUUs5oU1AuI7YWugV2r114YA9HR46kM
         cf7/Xcv8oKNI1EpyOw6GOwJwUXCAvwi6v0reLfn4RacXEr4OCuBK5zxbX6JYIJSbxoza
         +lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUnHjmoZBMPPrCWzaTempqIXz+G+HPhuggI2H5BxADg=;
        b=rpSF4ml4W6NN5D012iSVWQVQ9ym+CfytS/LbFQsKfSxbvimKx01P+sJRTXtXSNIC/R
         z6N0ybxlaUNU715/5U37CLXJuBObGDWCwf08IxDFFDRfYbEGWkAqH8hiqgHIuKgd16zG
         l5ywJnrUXLx5ZE2HqPevrXcROFsdNEY8MpcMzAq8kmVqCLXnF3SBeCDkWCj8fSIyaXGh
         webPk9AsjVNjDtWICSo5CSgXUiEMDjJ7tEyEjBjogsmG2n27c3/Ol1/qazs5NY9AX/Gx
         R+N32ZorX9xCJGpT62qpIfXK6bI6NCTqI0sf4SDraDSTHfcusoevFqpNvrdZ6PcUzQN3
         d80w==
X-Gm-Message-State: AOAM532gjZJlVKk+6X5SqkFHaTkD8SklEUP/3uP8iozERTEVTialxHkb
        ptciZAWgbamp9F/EPDUz45RB3w==
X-Google-Smtp-Source: ABdhPJymqRDS7aCC5+LCmHPbk12XaMGmyO8JI869mpSwvL1L+s3a8s0ee2CPCpojY5XXzdU39KLClA==
X-Received: by 2002:a05:6512:2f7:: with SMTP id m23mr6896463lfq.517.1610375037710;
        Mon, 11 Jan 2021 06:23:57 -0800 (PST)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id w23sm2310181lff.84.2021.01.11.06.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Jan 2021 06:23:57 -0800 (PST)
Received: by box.localdomain (Postfix, from userid 1000)
        id 3623C102238; Mon, 11 Jan 2021 17:24:02 +0300 (+03)
Date:   Mon, 11 Jan 2021 17:24:02 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jan Kara <jack@suse.cz>, Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Hugh Dickins <hughd@google.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v2 0/3] Create 'old' ptes for faultaround mappings on
 arm64 with hardware access flag
Message-ID: <20210111142402.6euyktmcnpemanf7@box>
References: <20210108171517.5290-1-will@kernel.org>
 <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg3UkUdiTbqWFx3zBLXv9VJHuNZAa5QyDvXiSmD4gX94A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 08, 2021 at 11:34:08AM -0800, Linus Torvalds wrote:
> I still dislike how we basically randomly modify the information in
> that 'vmf' thing.

I wounder if it would be acceptable to pass down to faultaround a copy
of vmf, so it mess with it without risking to corrupt the original one?

We would need to transfer back prealloc_pte, but the rest can be safely
discarded, I believe.

But it's somewhat wasteful of stack. sizeof(vmf) == 96 on x86-64.

-- 
 Kirill A. Shutemov

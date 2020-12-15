Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64B4D2DB543
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbgLOUip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:38:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbgLOUhz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:37:55 -0500
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B97C0617A6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:37:15 -0800 (PST)
Received: by mail-pf1-x442.google.com with SMTP id w6so15228271pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lNcnCO+DxIilm3yznDYW+rmw4EGxoZ3x7gThBV5GQKU=;
        b=O5HFZ2q2LVS0n+J77C2bqh6+lY7S8rIaIcgGeaOKyssiAN0bIu5lKrvExf/CHa9oUn
         W3F1vBnkL+o1bai6sf3GuCJgfR0Ns4pWkyn41ch95+UvZH6FJ6EkF95KE5QK+Z9iG5Ey
         2NEUZjj2N5DZiHZqozc47bccwK1Ggkz/87/y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lNcnCO+DxIilm3yznDYW+rmw4EGxoZ3x7gThBV5GQKU=;
        b=BN2FLECUUMywlaltuHXFKpe/TmuK3wNDODgrgEG7EsNR7v35hE7tCJ0VpgdrSdTME2
         GBzOSOeLBmRQ53qYUCQQIoZMDIiKttitzXskQGemMPP/IwwTP5HeyHaR7OZhgHQ1dlDx
         HfqSKF8JRS70fqvHkEUFFvtkmeX+lBiGI16Z1/0yCHIo59CE+LnznZKGYhozkglmIM49
         O9vS/hPUU7QpQviFx0POGbING5zyIAjDhaz1As6eoSfYFosEw44bLuf/c6qZ8nHJWVtP
         VYdgkoB1cPMDcKbSB8Yt6ZmYxHrfZHsdvNJecEHlgRJFfP+yfXD7+R3jJ6bJeOd15QU7
         IaYw==
X-Gm-Message-State: AOAM532jc0GsmcQKOV46Yx+1lNO7cJpP7GMgdGQyR0y+6U3j4sczm/MH
        NHN9a2XbO4KVGANr7NiDTfStQZORvv6loA==
X-Google-Smtp-Source: ABdhPJxUdz4fVyUdjV01hTRGpWBC6iKKiKGko3KEQfhJtCzu47uzHPlJFX6Ohy6850ab3mytBTGbiA==
X-Received: by 2002:a63:784a:: with SMTP id t71mr29865460pgc.87.1608064635005;
        Tue, 15 Dec 2020 12:37:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b2sm17592646pfo.164.2020.12.15.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:37:13 -0800 (PST)
Date:   Tue, 15 Dec 2020 12:37:12 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [EXT] Re: [PATCH 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202012151232.843EB2CB49@keescook>
References: <20201207115753.21728-1-bbudiredla@marvell.com>
 <20201207115753.21728-2-bbudiredla@marvell.com>
 <CAPDyKFqQwvG6vkwqPZutXjdV0hVrKp3MiqRRMZZ4C8Zr2Of9rg@mail.gmail.com>
 <CY4PR1801MB2070FD9FB1AB7166651198D1DEC60@CY4PR1801MB2070.namprd18.prod.outlook.com>
 <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFqMsMdqw=Uwzby0tNNvPieRT2i6PAmHu_9XRRVy1MykuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 15, 2020 at 12:42:58PM +0100, Ulf Hansson wrote:
> In principle, for non atomic path, I would rather see that the pstore
> file system should be able to be mounted on top of any generic block
> device partition - without requiring the block device driver to
> implement specific pstore ops.
> [...]
> Exactly. That's why I wonder if it's really worth it to support the
> panic writes at all.

pstore/blk already provides the generic hooking -- but it can't do
the panic write part (which that's very device/driver-specific). The
design was for individual backing devices to provide that directly
(which would needed read/write support too). And for those that don't
have panic/read/write support, they could still use the generic hooks
but they wouldn't be able to reliably (or at all?) catch panics (just
console writes, ftrace, pmsg, etc).

-- 
Kees Cook

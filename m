Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBB32FC040
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 20:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbhASTmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 14:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391827AbhASTbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 14:31:23 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5743FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:30:43 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id n25so13611406pgb.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jan 2021 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2a+AJpXRCTfZyczQuEB9u8BkJxf/cNBjjXi4k4TlSWw=;
        b=e1M94iUqOKU+aAyCpeYRdv6GdAW8k4BKNsScVlx4Vdhw7LYfoIN7biO6tmrLfIIdvD
         0EGUqvCdo36mugVbNLgC8uuoCkz9bugEBDAC05tTf8br6QRIEOG00zQI1LHzQClGOJNl
         LBFd5gRfieCIjLr8Be6aMd6pRuGd8ont4Rhd4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2a+AJpXRCTfZyczQuEB9u8BkJxf/cNBjjXi4k4TlSWw=;
        b=lo3RgKNxlTk+ofmZm/GfNLR7DCotPGb7JLemspH901bBAiAcRlALx1N0RgvwB8OUOi
         87PcHU6T7LqN+4jLzr85xb6fewboXoCOjdl7QuSwayUCT0qhB6VnWiu5ZCwtdJJW2swY
         jZ3OPvF7L37UkZ4in1cIVDSjsaoTFF/A7BxQUqoqBU4RUmFUDXvCB4rrF0p/kJiyF4Iv
         Yfv5gVJsLbYz49F7qySzzoJbuUulYJd3hoRTyPZvBIl4cdp9N0gkqEaMCTGaCNovoODK
         nZ35Me/PL4bEC+UTjgTSgHBPS1Na0Ago8Ykzje9f3TiqUfZB7RGRR6OkaXizLLcfvYqh
         j2mQ==
X-Gm-Message-State: AOAM533H8VySDHnpjvNoGZxzYKUbrxZqG91IavlQAtdZ+NUG4OB/RVIU
        Dp4kvm/aMVEfddAMK49G0dbtw/eNS4K71A==
X-Google-Smtp-Source: ABdhPJyUvkfLSXjqHOEq8OgTC+xZiHsy62DRudN423jP+qTtj/pWPVamzTtU3XbQzUKSYlRFrfZXew==
X-Received: by 2002:a62:65c7:0:b029:1b8:5c05:820b with SMTP id z190-20020a6265c70000b02901b85c05820bmr5673986pfb.48.1611084642828;
        Tue, 19 Jan 2021 11:30:42 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a18sm19634412pfg.107.2021.01.19.11.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 11:30:42 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:30:41 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH v4 1/2] mmc: Support kmsg dumper based on
 pstore/blk
Message-ID: <202101191130.4A8EC5F9@keescook>
References: <20201223144033.32571-1-bbudiredla@marvell.com>
 <20201223144033.32571-2-bbudiredla@marvell.com>
 <CAPDyKFq41CQ8JbyAS0+k26=Cyf=KcOpdeD+VmY1AZxbh4D6f9w@mail.gmail.com>
 <CY4PR1801MB207022E70C53D0DA87EB3F22DEA31@CY4PR1801MB2070.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR1801MB207022E70C53D0DA87EB3F22DEA31@CY4PR1801MB2070.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 04:11:31AM +0000, Bhaskara Budiredla wrote:
> Do you see any issues to ACK this if the mmc pstore
> registration is through register_pstore_blk()?
> As Uffe said, eMMC would need to go through
> psblk_generic_blk_read()/write() instead of
> mmcpstore_read()/write().

I would be fine with that; yes.

-- 
Kees Cook

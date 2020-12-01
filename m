Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93592CAD56
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 21:30:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730825AbgLAU3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Dec 2020 15:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730263AbgLAU3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Dec 2020 15:29:15 -0500
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFEAC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Dec 2020 12:28:29 -0800 (PST)
Received: by mail-pj1-x1041.google.com with SMTP id l23so2033680pjg.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Dec 2020 12:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ko75/Fr8d3GQsTIDa9DCUIlQClom7hRVgJtFr4EDnzY=;
        b=LBPU5BSDN0oDG6xd5T5rIAfXyh1S2b3z4horMexwrFdoZVeZL07exx80fudC45Hh3N
         mTroJtIjz3zOyniqGquKBzOLMqfDQ8r0k+i/vHSjXnexe4UcgfgGVNJAZragtVCeh8HD
         DjKQKEWIJwvboLsdEQhezvb0N//K3PSbJR6U0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ko75/Fr8d3GQsTIDa9DCUIlQClom7hRVgJtFr4EDnzY=;
        b=fodTs8KhAVF/O/jCkAHCERN0tjIOL5/RsfxZqczndPB1VOWtC/s6zTyVKPTl9IxOqD
         VfRitR4SYUR7T2J2ib2kkw+AVD2LGlVLznFVIESdh3/PRwzMmn/FmsTb+JJxk9TaayR9
         eJmmTPfqCr7YNSUuYHagMS9v+BlP+v4qtRnL11OGRJ+clWJ618Gb4Zm5xbqrYeYlAPBq
         nVwzPwe/cnotT3L09FttHbSQ7+y+9xgIXKZJMg+ic0wj1ESwHUXNNLFhG0+q02Voq5ly
         pYblz5bU+4PWXdByhnfgtsSWsdaysQM0FbiCVLCxKhlVfI/WqTVDQO42+jTQmnUsjx3v
         UVsA==
X-Gm-Message-State: AOAM53172b/Oq74gpN/a5S2tw4umLXqyF8yuX3X8pEF0DnuyfF4eDOyg
        bowuHXalNk201CRUOOOIjeKWqA==
X-Google-Smtp-Source: ABdhPJxk5B/5wh8+G1DWpNRfD5ZuGlXNVzdiMlkNVAZmHCpsZsmib6h50CiXAzeESoe16zt0B05Wvw==
X-Received: by 2002:a17:90a:f211:: with SMTP id bs17mr4583319pjb.144.1606854509121;
        Tue, 01 Dec 2020 12:28:29 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i3sm438891pgq.12.2020.12.01.12.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 12:28:27 -0800 (PST)
Date:   Tue, 1 Dec 2020 12:28:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Bhaskara Budiredla <bbudiredla@marvell.com>,
        ulf.hansson@linaro.org, ccross@android.com, tony.luck@intel.com,
        sgoutham@marvell.com, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mmc: Support kmsg dumper based on pstore/blk
Message-ID: <202012011226.94027EB5E@keescook>
References: <20201123111925.28999-1-bbudiredla@marvell.com>
 <20201124113720.GA30440@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201124113720.GA30440@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 11:37:20AM +0000, Christoph Hellwig wrote:
> Please hold this off for now.  I have a major rewrite of the pstore/blk
> interface pending..

I'm fine with taking these patches -- they're using the pstore "device"
interface, not the pstore "blk" interface, and I don't expect to be
making big changes to the existing structures.

With feedback on patch 1 addressed, I'd be happy to Ack this going via
the mmc tree.

-- 
Kees Cook

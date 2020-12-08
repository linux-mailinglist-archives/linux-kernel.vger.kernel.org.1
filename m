Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 028D82D2544
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 09:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbgLHH7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 02:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgLHH7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 02:59:07 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EF3C061749
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 23:58:21 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 131so13137361pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 23:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=KnZfQqoZzWUzBKCvzyfIcJ91Cd0y5N1mgzIqVdR3rMA=;
        b=SZ3nsZ1SIFBJZO136kSq0uCuUCrrUag/yRqo2T6IXzYAOKkNGwHkq5FT/ZbQaf+S3s
         VNJwR4J+GlDgwOVF8prxwnp0+VCWLO72sbP/r/CNz6Lire9I0tcZvxq5pGNTwDFZv+C5
         BocQj2AgD2NsDFou1cd7OELbYzn38BIcAsUMHcPADmG5rYxZzfr4l2IyCAOX04fLxEix
         VUvfPiKQEgBAzgXiclItdiapR+kDVHFglRb6IXas8PYW9Yphq7ZPr41RQjC4mBZE88L4
         D2hQAoX/MgEsCUgtSsnBNmnNYv7qcFjllXng8O+XpJPNmUDocP3sIk0FuSEEkxnOXDz/
         e7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=KnZfQqoZzWUzBKCvzyfIcJ91Cd0y5N1mgzIqVdR3rMA=;
        b=b4YgTBjsJDDps/1YkZKyCHuhbqy1yGhU0Gg2TpKZLR0wohS1MNauMZdSi6P8skjJUT
         ksbajI2bItvi2C2BbFSppBim0bub2qZ3A5BJ0wlWAKzvtCcdkvO2pap9EuJuo8+X6TtW
         kow2uNxv3ecpvYCZPNZ5subLX70SZxlhz0LTQsI1p0OqDtH5TKH35p0Z/OIiEqhXAz+p
         DJhGE+7wECQIk7hEP7Sc70HJog3zRcJVy8AAONDshCFcAJnA87ys7Bv2d+VFFaxDa4Fz
         dVZFdfqB4yCnCmjA9KWWop3uYZhvno8kYyyFNk4UDkWErRLUjK5aiUF4zU3M+08WHZLo
         Ec7g==
X-Gm-Message-State: AOAM532qRmX3rsaowBfHqbZs1tyjCQzCA85xYyed9FN82rwQNRt7+OCw
        zTk688+PP9UX/6GetJeUVqqxy/Amd1jJRw==
X-Google-Smtp-Source: ABdhPJxRVcpJfQBIqL9F/mg6nvL8LrdGgEQtsnzFjb0uImmFA3ZvkN4UJ46V1gqpLQ/GfBriYRq+Hg==
X-Received: by 2002:a17:90a:f288:: with SMTP id fs8mr3016334pjb.184.1607414301322;
        Mon, 07 Dec 2020 23:58:21 -0800 (PST)
Received: from laputa (p73a20c63.tkyea130.ap.so-net.ne.jp. [115.162.12.99])
        by smtp.gmail.com with ESMTPSA id x7sm16000357pfb.96.2020.12.07.23.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Dec 2020 23:58:20 -0800 (PST)
Date:   Tue, 8 Dec 2020 16:58:15 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     ulf.hansson@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben.chuang@genesyslogic.com.tw,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
Message-ID: <20201208075815.GC31973@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <c8f7e9ad-3e8d-01cc-edeb-5be364bfcc36@intel.com>
 <20201201030937.GE43403@laputa>
 <523f9ed9-318e-7121-d58d-c3843d9b9b7c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <523f9ed9-318e-7121-d58d-c3843d9b9b7c@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian,

On Thu, Dec 03, 2020 at 11:55:23AM +0200, Adrian Hunter wrote:
> On 1/12/20 5:09 am, AKASHI Takahiro wrote:
> > Adrian,
> > 
> > Thank you for your review comments.
> > 
> > On Thu, Nov 26, 2020 at 10:18:55AM +0200, Adrian Hunter wrote:
> >> On 25/11/20 9:41 am, AKASHI Takahiro wrote:
> >>> Gentle ping;
> >>>
> >>> On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> >>>> This is an interim snapshot of our next version, v4, for enabling
> >>>> UHS-II on MMC/SD.
> >>>>
> >>>> It is focused on 'sdhci' side to address Adrian's comments regarding
> >>>> "modularising" sdhci-uhs2.c.
> >>>> The whole aim of this version is to get early feedback from Adrian (and
> >>>> others) on this issue. Without any consensus about the code structure,
> >>>
> >>> Any comments so far?
> >>>
> >>
> >> Overall, I like this approach of separating UHS2 from legacy sdhci as much
> >> as possible.  The only major change, is to drop support for legacy quirks
> >> and features that you do not need.  The reason for that, is that there may
> >> be few drivers that end up with UHS-II support (opting instead for SD
> >> Express), so there is no point going to a lot of trouble to support things
> >> that never get used.
> >>
> >> From what I have seen that looks like it includes:
> >> 	- any quirks
> > 
> > GLI driver (gl9755) needs
> >   * SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC
> >   * SDHCI_QUIRK2_BROKEN_DDR50
> > but they are managed in sdhci code.
> > 
> >> 	- SDHCI LED support
> >> 	- external DMA support
> > 
> > Should we add 'depends on !SDHCI_UHS2' to MMC_SDHCI_EXTERNAL_DMA?
> > 
> >> In this regard, the important thing is to have a comment somewhere that
> >> lists what is not supported.
> >>
> >> I have only looked at SDHCI patches so far, and only up to about patch 20,
> >> but maybe that gives you enough to go on for a while.
> > 
> > Well, I have almost done.
> > Can I expect your comments on the patches #21-#27 as well soon?
> 
> I have made some more comments and that is all for now, except for anything
> more you wish to discuss.

Thank you.
I assume that you don't have any objection against adding extra hooks
to sdhci_ops in patch#23 and #25, do you?

If so, since we don't have any critical issues to discuss,
I hope that my changes will be contained in the new version
where a major rework will be done on the core side by Ben.

-Takahiro Akashi

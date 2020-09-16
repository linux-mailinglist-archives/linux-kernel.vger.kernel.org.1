Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58CF826BB41
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 06:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgIPEHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 00:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbgIPEHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 00:07:42 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9707C06178A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:07:40 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id bd2so2472875plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Sep 2020 21:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dwWRnwsGGp42nHyvHYAmDpO5pglBD8pM8+TllXGj8yw=;
        b=azE3P0AgP3hJEcsTJJpcq0kIrViiGK//UpvP9mqGA6o40Im531SZGBXDNgnQdFS3PB
         wBCQl6lf/X1c/KmzDFSGjQhPvl+ui4vi1DTHra//aKQqCOMx8rU4ZI2IcpNPGy5hJh1s
         oolKtRnBa+gwzgRn2I9Fk8M92A3huwHa60D59WywFue23XD3CbogiTSRJB5lM1HAF7HC
         PIuQd07NRFHwCY0YohAqIBDoJS6l38o4j18aL6BqCj5n04A2ExKWKIcmud0lQSHTYLK+
         dfwV5huTCPPK4WMt25naEXT7bSYfyZ3JpWQeZPyP/M9Bm5r150kgss0Edr7XTPH6nKn9
         2pJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dwWRnwsGGp42nHyvHYAmDpO5pglBD8pM8+TllXGj8yw=;
        b=QwHzdvt28kI846rekhSvOL97D9DP+U4wA++pADQzvjoClev0ENu6vV/7si/U+tzkQn
         bIVCgXI93wlFpvdwTBbRhyVbrcBXS96rGNvwOtA6O/G2sUh+QsRDTwutzIYOrai71Urf
         f0TgWAVbg4+BccY7dyXSmQagtGraOwXLvik9AnlOrXwpq4l7VxJibaMMFivhp7wKEiB8
         w0gwZ/GxKG1qlXdCv4ifkE6pHTtPX/tAqip/m9U8cTdVzT4vP/2n/xPFRtk9b7Pvrqm3
         S+7PcWH8fvRMGrNEzFfqnmyYVGWtDQA/LG7VEq5+zppu+QxWIsM9W5FDfwtY7qvROM4B
         mqKg==
X-Gm-Message-State: AOAM531taEmbP9XGrDHLAZqNiUIXd+PUG4dffaGFRO1d2OoF+os9QZ5h
        cXvIZl0SZo3p0nSx7PsVQ8ZL
X-Google-Smtp-Source: ABdhPJxWtRMMr2pHjJ+1V7e9unODZq5jgqDHwWcJ1/MX6MPAFMT/ZxHjurIf9f4zyw22ZxVRjrPxYQ==
X-Received: by 2002:a17:90b:3241:: with SMTP id jy1mr2307220pjb.10.1600229259610;
        Tue, 15 Sep 2020 21:07:39 -0700 (PDT)
Received: from linux ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id 131sm15062480pfc.20.2020.09.15.21.07.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 15 Sep 2020 21:07:38 -0700 (PDT)
Date:   Wed, 16 Sep 2020 09:37:32 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     wg@grandegger.com, mkl@pengutronix.de, robh+dt@kernel.org,
        linux-can@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, o.rempel@pengutronix.de
Subject: Re: [PATCH 0/6] Add support for MCP25XXFD SPI-CAN Network driver
Message-ID: <20200916040732.GA4281@linux>
References: <20200910133806.25077-1-manivannan.sadhasivam@linaro.org>
 <20200915161925.GA5660@linux>
 <20200915175838.GA12860@x1.vandijck-laurijssen.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915175838.GA12860@x1.vandijck-laurijssen.be>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 15, 2020 at 07:58:38PM +0200, Kurt Van Dijck wrote:
> On di, 15 sep 2020 21:49:25 +0530, Manivannan Sadhasivam wrote:
> > Hi,
> > 
> > On Thu, Sep 10, 2020 at 07:08:00PM +0530, Manivannan Sadhasivam wrote:
> > > Hello,
> > 
> > Just a quick question: I don't see any activity on this specific driver for
> > sometime (back in Martin days itself). Is it due to lack of reviewers or
> > it is due to the patch size (lines of code) so that nobody is interested
> > in reviewing?
> 
> If you look around, there are currently several versions of mcp251x
> driver around, shipped by hardware vendors who glue the chip on there
> SOM etc.
> Until something more-or-less clean becomes mainline, the effort remains
> spread.
> 
> A problem to import a complete driver is that ... its complete.
> There was an suggestion to split into several patches, but that does not
> really affect the review work.
> 
> The original driver failed to initialize under a loaded CAN bus, on my
> desk. The current driver is more cleanly written than the original
> and it seems to survive more than 1 use case (although I have a MAB overflow
> report pending to investigate).
> So, this is a good candidate for mainline.
> 

I just saw that you've pushed these patches to your testing branch. Does this
mean that you're going to include it in v5.10 PR?

Thanks,
Mani

> Kind regards,
> Kurt

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0962C4BC8
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Nov 2020 01:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgKZAGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 19:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgKZAGv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 19:06:51 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31F0C061A4F
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:06:50 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id n137so1179pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 16:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=3NQ3wtA4MBw7H9ENpDbNl6UnCj99yYqE7sfkNlQV7eE=;
        b=usNarmQPin3VDizPkcmlfmbwneHIL3EeRbi4gk1ze61Z/zBAlQVhJ6v58duGy+V7DB
         Dt/AjB1GTXegac5tPWOdxulgpKgXIgt0roT7mCInCkzTOs/Ht3qpLNjtne4hgE2Nnye7
         tlaCBD4653nADezPOJa0x6ysKPcXiv9RsMg07afG2cM8L8pEcJTiTWXZvId9G8eXblX1
         zXnMzl9NouOKtPA4dlBIXhyrfrltIRJTqkpX5+IZG/SsakXjmC+8pEmQ/n0CnRV6/VBV
         kVjrvQ4PARiLW9bwEcNqw72jI1KTwso+OWo4SGIHFZ9x5H53h4wQJWE88DW7jleWidkl
         vK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=3NQ3wtA4MBw7H9ENpDbNl6UnCj99yYqE7sfkNlQV7eE=;
        b=nuMrNI/pkwfayDmMhx8DuCYzShqFCz6bsHKuJu60sc2qcQBGLqXtws9G3Pbm3S/pSk
         A1dWQsk5ZYY3X4KWWDfRDo0x3YiinbGPd27tbeMugfvWTEvumgnx12bbDh4r+evApwrb
         6QYM8EGFktaddoLAbL5ImCwCrxDrPStY+YrctI1G4OcY96Y0Sfo9qMD1RO56ONzqijxi
         SvhZRRq7gEaCmwrWc2eMPVT4YI7fGkKx3ssNoJhn6Kym3IgHwSl2q6fBVB3x/QNIXG3U
         6vgJexvUehLLzEZ/Itw2CWIqV4fqZFDqg0Ibz2lYHVSEMooyKcB9xFbhtjXK4hiCa6SO
         brWQ==
X-Gm-Message-State: AOAM530JvwMP8sMviUoYpglQEmfYBINvicIs6X+x5pSLGNiUMMtMP4md
        nnr2l9zFzQ0E/Yv0p3liSh5Plw==
X-Google-Smtp-Source: ABdhPJyz+8WuEITK2opyP1MAyT8G9kd0dpqAPhmXCCXyHAVL6gpKEOwgXzg3KPv93QJdGlwevBtt0A==
X-Received: by 2002:a63:b05:: with SMTP id 5mr311632pgl.267.1606349210325;
        Wed, 25 Nov 2020 16:06:50 -0800 (PST)
Received: from laputa (p784a5642.tkyea130.ap.so-net.ne.jp. [120.74.86.66])
        by smtp.gmail.com with ESMTPSA id n68sm2872706pfn.161.2020.11.25.16.06.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 16:06:49 -0800 (PST)
Date:   Thu, 26 Nov 2020 09:06:45 +0900
From:   AKASHI Takahiro <takahiro.akashi@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
Subject: Re: [RFC PATCH v3.1 00/27] Add support UHS-II for GL9755
Message-ID: <20201126000645.GA14078@laputa>
Mail-Followup-To: AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        greg.tu@genesyslogic.com.tw
References: <20201106022726.19831-1-takahiro.akashi@linaro.org>
 <20201125074125.GC62993@laputa>
 <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFo_DjqTzaPhhBCKEj7axDU-4hMBnd1sw_hwP8nmp8xmTg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:43:18AM +0100, Ulf Hansson wrote:
> On Wed, 25 Nov 2020 at 08:41, AKASHI Takahiro
> <takahiro.akashi@linaro.org> wrote:
> >
> > Gentle ping;
> >
> > On Fri, Nov 06, 2020 at 11:26:59AM +0900, AKASHI Takahiro wrote:
> > > This is an interim snapshot of our next version, v4, for enabling
> > > UHS-II on MMC/SD.
> > >
> > > It is focused on 'sdhci' side to address Adrian's comments regarding
> > > "modularising" sdhci-uhs2.c.
> > > The whole aim of this version is to get early feedback from Adrian (and
> > > others) on this issue. Without any consensus about the code structure,
> >
> > Any comments so far?
> 
> I haven't been able to look at sdhci parts (I will try to), but as you
> know, I am relying on Adrian's help with this.

Yeah, I understand.

> When it comes to the core part, I am planning to help to put some of
> the foundation in place for the mmc core changes. Although,
> unfortunately I haven't been able to post patches, yet. I will keep
> you in the loop, when I get to it.

I think Ben has some idea on the topic.

-Takahiro Akashi


> [...]
> 
> Kind regards
> Uffe

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62075282E06
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 00:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgJDWOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Oct 2020 18:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726745AbgJDWO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Oct 2020 18:14:28 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5CBC0613CE;
        Sun,  4 Oct 2020 15:14:28 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id gm14so4423373pjb.2;
        Sun, 04 Oct 2020 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=t9W1RzmizWeCwBcYpakzTx6FYovueP73ElzCFRmABT8=;
        b=DH/iZhPkp/SdkIc0Fg3xf7KBcnb3LPPWkCJA/yu/jKcsTV/hCsNnw1Mop59QL7n661
         ahtzLWTKQoflFATRY5mClO6mpybiHX7Et9KzAaRLN6fE/Bkz6VY5jo09Yb1LMHMhWWev
         yUSRANmnU3JPgSY9tu7Avsm1cZmRj0sBonQ8czsMAoE1X0GP6b5W5kBFOeqYch052Hpr
         Tm2AnbIdZ4n3koIgnc+AalznLukLf32GLPNbMo62CiLKAvcihoplTeJrtshX0vgoCvFg
         yFFTUw/WneDy9ic0F5vAomRFNPgqpkqTJLOZ/OfUFrN3v++CMMzRRfVER65gZG1kGA5a
         g3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=t9W1RzmizWeCwBcYpakzTx6FYovueP73ElzCFRmABT8=;
        b=psw2528yMwP42uRS+Uw97AgvA9G2Lp7WIoeMrf79cjdHCXmOGygP8ApqsqRy1rFzAV
         K63C3bC4Er5GE5B2JlpQBzYIrHhVYP5t/JpvR5yeQIblkoOpQF+LPNGyGNAKoqe4em9Y
         C6LZZH7GemPI26OgHgA3XcVgetORUBwhHXhrx/GFZLu/uAekvC8VboT4Nvx9qCCbCIMG
         uxaclBK3jEkBial4JQlsrOZ0Cp950aQqZDJrc8zTJ2o78UorVfzZCI6kyrPDdigZGOOn
         esQ3SUg06nk26jWqYNubBoslZSPcYxRBuah8fwgdP1DlnZnMSTKVH4hZ43JXCfErCRKM
         rhmQ==
X-Gm-Message-State: AOAM531yTKUAMd5DbVNGCXb47iEuSNEg27t71VR3mDURikG3sDYlgulK
        WBQm8mIVX1iXfVBsOfBorfM=
X-Google-Smtp-Source: ABdhPJzLRV/ERzVRE2GX2LnZKQYMmKld3PsAVlA9FYquXZiXzIlgOFrIPvC2/eufW1it39x7s4bFdA==
X-Received: by 2002:a17:90b:118d:: with SMTP id gk13mr8139580pjb.57.1601849668165;
        Sun, 04 Oct 2020 15:14:28 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id f12sm9139290pjm.5.2020.10.04.15.14.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Oct 2020 15:14:27 -0700 (PDT)
Date:   Sun, 4 Oct 2020 15:08:08 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     thierry.reding@gmail.com, joro@8bytes.org, vdumpa@nvidia.com,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20201004220807.GC21420@Asurada-Nvidia>
References: <20201003065947.18671-1-nicoleotsuka@gmail.com>
 <20201003065947.18671-4-nicoleotsuka@gmail.com>
 <8b028e6a-de6a-6ca1-79c7-5b9c6e86c021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b028e6a-de6a-6ca1-79c7-5b9c6e86c021@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 03, 2020 at 05:16:20PM +0300, Dmitry Osipenko wrote:
> 03.10.2020 09:59, Nicolin Chen пишет:
> > This patch simply adds support for PCI devices.
> > 
> > Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
> > Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Small nit: yours s-b tag always should be the last line of the commit
> message because you're "signing up" words that were written by you.
> 
> Tested-by: Dmitry Osipenko <digetx@gmail.com>

OK. Thanks for testing, btw.

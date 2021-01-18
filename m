Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0282FA526
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 16:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405996AbhARPuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 10:50:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405973AbhARPdJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 10:33:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1689C22C7E;
        Mon, 18 Jan 2021 15:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610983947;
        bh=7uZs9pF/t9m+cAWUrEQPaLEWyNNr57zs99L3UB18ecw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IijNMuDuF77zj4RjcHFWz5/wSBg7Y3rHgqLkAecBWlrWY6nJGzyY+p8d2V17wFObr
         v8QnhLtS3SyUaNcm0PiDMGFCu56DO1D2Wp6kQrkY/A7CqHGVoD0wxB+DvHkwi47tx9
         dgAbVWqOvzCL5il39pkKf2PJiI8FYet7A4ExxYXpSurphhbyX+6MMPuNU5WFYRc2Kk
         mGdbdFupq33rur8RaOpQV09C9dy2bRbEo5jHn8jYWCmlaN97VabATT4zgJzm45nGO+
         pF8DAfEHDG34PN0X8opWBJqhVclNZo+PixRvTP/cD6U5DYCivi1+/mez0SkKHrl0fy
         hrhpHYVcZEhcQ==
Date:   Mon, 18 Jan 2021 16:32:22 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 10/13] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <20210118163222.6161f9a2@coco.lan>
In-Reply-To: <20210118151227.GF4903@dell>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
        <8a152819ef89c73dd6afb5c2deb5441402fcd2fa.1610975633.git.mchehab+huawei@kernel.org>
        <20210118151227.GF4903@dell>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 18 Jan 2021 15:12:27 +0000
Lee Jones <lee.jones@linaro.org> escreveu:

> On Mon, 18 Jan 2021, Mauro Carvalho Chehab wrote:
> 
> > This driver is ready for mainstream. So, move it out of staging.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  .../mfd/hisilicon,hi6421-spmi-pmic.yaml       | 133 +++++++
> >  MAINTAINERS                                   |   7 +
> >  drivers/mfd/Kconfig                           |  15 +
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/hi6421-spmi-pmic.c                | 342 ++++++++++++++++++
> >  drivers/staging/hikey9xx/Kconfig              |  16 -
> >  drivers/staging/hikey9xx/Makefile             |   1 -
> >  drivers/staging/hikey9xx/hi6421-spmi-pmic.c   | 342 ------------------
> >  .../hikey9xx/hisilicon,hi6421-spmi-pmic.yaml  | 133 -------
> >  9 files changed, 498 insertions(+), 492 deletions(-)  
> 
> Could you please resubmit this will the correct flags.
> 
> I believe it's the `git format-patch` -M flag that you want.

As explained at patch 00/13, this was intentionally generated with
--no-merges, in order to allow reviewers to view the entire source
code at the patch. 

Anyway, I'll re-send the series with -M, as it makes easier to merge,
if everything is ok.

Thanks,
Mauro

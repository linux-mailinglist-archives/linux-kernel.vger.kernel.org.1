Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDDED2D09CE
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 05:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgLGEsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 23:48:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:50620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726284AbgLGEsf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 23:48:35 -0500
Date:   Mon, 7 Dec 2020 10:17:49 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607316474;
        bh=5otoU6/da4hgylLuMnGsUNNL1B0DYmpjUcWY8/EgrDc=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=vPqiunthY0LQw3w1KvSIVuc8zsJ1S4nrixVfmV83/bVVME1pS3lMrVn92PtZPmlax
         RA/tdKEuJK5+iUXLN5SW18yyDBmflxyliyqGNndcJKo0ZO5Y1v0exWDF7Um8Ruw8ZX
         YG1ZY37BT5Qzlu3HEAXpHJCQQo55Xni2Y67t3YxtF3k06pK1TUmVcUl3QHt9jpi0u9
         M0p5iXpeqG4JpDdPDD//QbkiL5gyKnfSVGz00RC55FywtLcex/tW/kIF+fG/+8y63K
         Ev0myUc4n0Qgp5VV5wPoqQ/zIzSyY7UyCP937XCSKHvS0fUNZdGsIZfh07ouJ+MaSm
         Ou3o+73FxE92Q==
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        linux-kernel@vger.kernel.org, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        sanyog.r.kale@intel.com, rander.wang@linux.intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 5/7] regmap: sdw: use no_pm routines for SoundWire 1.2 MBQ
Message-ID: <20201207044749.GB8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-6-yung-chuan.liao@linux.intel.com>
 <20201205074630.GS8403@vkoul-mobl>
 <e4e3d7ea-0825-2c8c-4182-6d1b578200a3@linux.intel.com>
 <X8u147aZbdrj6qN7@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <X8u147aZbdrj6qN7@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-20, 17:31, Greg KH wrote:
> On Sat, Dec 05, 2020 at 08:52:50AM -0600, Pierre-Louis Bossart wrote:
> > 
> > > >   MODULE_DESCRIPTION("Regmap SoundWire MBQ Module");
> > > > -MODULE_LICENSE("GPL v2");
> > > > +MODULE_LICENSE("GPL");
> > > 
> > > Why do you want to change this ?
> > 
> > We only use MODULE_LICENSE("GPL") for new contributions since 'GPL v2' does
> > not bring any information on the license, is equivalent to 'GPL' and only
> > exists for 'historical reasons', see
> > 
> > https://www.kernel.org/doc/html/latest/process/license-rules.html
> > 
> > 
> > “GPL”	Module is licensed under GPL version 2. This does not express any
> > distinction between GPL-2.0-only or GPL-2.0-or-later. The exact license
> > information can only be determined via the license information in the
> > corresponding source files.
> > 
> > “GPL v2”	Same as “GPL”. It exists for historic reasons.
> > 
> > We should have used 'GPL' in the initial regmap MBQ patch but didn't for
> > some reason, this change just realigns with what we intended.
> > 
> > That said, this is unrelated to this no_pm patch so could be in a separate
> > one if you preferred it that way.
> 
> It should be separate as it does not have anything to do with the real
> reason this patch was submitted.

Precisely, this should be a separate patch explaining the motivation
behind this change.

-- 
~Vinod

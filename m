Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C082D228B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 06:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgLHE4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 23:56:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:52386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgLHE4o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 23:56:44 -0500
Date:   Tue, 8 Dec 2020 10:26:00 +0530
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607403364;
        bh=1RiFaYT5sszcYT3rzZ7wK33h9vZoHSV5GWfAX84nrpk=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=JsaVxd5iO6il066W28gWU1l0+3OyFChdHtmkgNKsV/SRsoHYAr+W9iqN3k6/BsuwY
         MuEGN2cmbukxDF56bNvz94mtXuOCLuzlwe9eE5k25W0xYyE0NYvFKK6EWuodyfiATb
         Ua0qLLzG7O4GstPtpxslD6vSnZ3AbvXkraNeglweCzSA4IE6v4/fNl1wrwkEHNjuy+
         SvkiabnoRnfF8/S2usqxo4/3XEcJanoL3UQZyDxYj8OjinAs236rccCpdzsgittcZ0
         9XL6SitN1HnpfwQqaqEQ96C9zhNTWIcOdtSt7/LshVRMFE/OFpsmawixJ1bTpIfvWG
         VAuytt2F626lA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
Subject: Re: [PATCH 1/7] soundwire: bus: use sdw_update_no_pm when
 initializing a device
Message-ID: <20201208045600.GE8403@vkoul-mobl>
References: <20201202204645.23891-1-yung-chuan.liao@linux.intel.com>
 <20201202204645.23891-2-yung-chuan.liao@linux.intel.com>
 <20201205074508.GQ8403@vkoul-mobl>
 <1db93c2e-3c87-bc5e-ddeb-56424870b897@linux.intel.com>
 <20201207044334.GA8403@vkoul-mobl>
 <668b4d5c-d9eb-0256-ce26-df38e32cc520@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <668b4d5c-d9eb-0256-ce26-df38e32cc520@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-12-20, 09:31, Pierre-Louis Bossart wrote:
> On 12/6/20 10:43 PM, Vinod Koul wrote:
> > On 05-12-20, 08:59, Pierre-Louis Bossart wrote:
> > > Thanks for the review Vinod.
> > > 
> > > On 12/5/20 1:45 AM, Vinod Koul wrote:
> > > > On 03-12-20, 04:46, Bard Liao wrote:
> > > > > From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> > > > > 
> > > > > When a Slave device is resumed, it may resume the bus and restart the
> > > > > enumeration. During that process, we absolutely don't want to call
> > > > > regular read/write routines which will wait for the resume to
> > > > > complete, otherwise a deadlock occurs.
> > > > > 
> > > > > Fixes: 60ee9be25571 ('soundwire: bus: add PM/no-PM versions of read/write functions')
> > > > 
> > > > Change looks okay, but not sure why this is a fix for adding no pm
> > > > version?
> > > 
> > > when we added the no_pm version, we missed the two cases below where
> > > sdw_update() was used and that creates a deadlock. To me that's a conceptual
> > > bug, we didn't fully use the no_pm versions, hence the Fixes tag.
> > 
> > Documentation says:
> > "A Fixes: tag indicates that the patch fixes an issue in a previous commit. It
> > is used to make it easy to determine where a bug originated, which can help
> > review a bug fix. This tag also assists the stable kernel team in determining
> > which stable kernel versions should receive your fix. This is the preferred
> > method for indicating a bug fixed by the patch. See :ref:`describe_changes`
> > for more details."
> > 
> > I do not this this helps here as this does not help distros etc
> > I would say this is incremental development which improved a case not
> > done properly earlier, unless you would like this to be backported.. In
> > that case it helps folks...
> 
> IMHO the changes in the series are absolutely required to have a reliable
> suspend-resume operation and will need to be back-ported. When I said
> 'conceptual bug', I didn't mean a hypothetical case, I really meant that a
> proven race condition and timeouts will occur. That's not good... We will
> provide the list of this patches to distros that are known to support
> SoundWire as a 'must apply'.
> 
> If you look at the series, we provided Fixes tags for all patches except
> 'cosmetic' ones which don't fundamentally change the behavior (Patch 3,
> patch 7) or when the code has not reached Linus' tree (patch 5).
> 
> That said, 5.10 was the first release where SoundWire started to be
> functional so there's no need to apply these patches to earlier versions of
> the stable tree.
> 
> Does this help?

Yes, that helps, thanks

-- 
~Vinod

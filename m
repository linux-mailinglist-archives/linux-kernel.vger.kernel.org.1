Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 278001D990C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 May 2020 16:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgESOKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 May 2020 10:10:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:52700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728609AbgESOKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:10:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3E472065F;
        Tue, 19 May 2020 14:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589897416;
        bh=JYwdbAEvDvQlKjkqjM1FAAVeUY4eLELMMyAO2apEp98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lk2TW4a8TfpQpfvd56OBDl2FmL++QIDwKZgTl0RO+IIy2muyP8IxycpZnB0WgmGYq
         LPh1b1/OUOQjy6FSkEENQFftoZ2S4IplY0RAWDRdx74zBaywjFOw4ebcP+rSUi3Kjh
         vx+omNI9L6WaTFkTnTf2K2/hvH7c4KN55wAijfuQ=
Date:   Tue, 19 May 2020 16:10:14 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, vkoul@kernel.org,
        vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
Subject: Re: [PATCH 3/3] soundwire: add Slave sysfs support
Message-ID: <20200519141014.GA535881@kroah.com>
References: <20200518203551.2053-1-yung-chuan.liao@linux.intel.com>
 <20200518203551.2053-4-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518203551.2053-4-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 04:35:51AM +0800, Bard Liao wrote:
> From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> 
> Expose MIPI DisCo Slave properties in sysfs.
> 
> For Slave properties and Data Port 0, the attributes are managed with
> simple devm_ support.
> 
> A Slave Device may have more than one Data Port (DPN), and each Data
> Port can be sink or source. The attributes are created dynamically
> using pre-canned macros, but still use devm_ with a name attribute
> group to avoid creating kobjects - as requested by GregKH. In the
> _show function, we use container_of() to retrieve port number and
> direction required to extract the information.
> 
> Audio modes are not supported for now. Depending on the discussions
> the SoundWire Device Class, we may add it later as is or follow the
> new specification.
> 
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2091BB701
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Apr 2020 08:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgD1Gt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Apr 2020 02:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:53816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgD1Gt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:49:56 -0400
Received: from localhost (unknown [106.51.110.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C9E1206B8;
        Tue, 28 Apr 2020 06:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588056596;
        bh=fxHe2iijiSX4RUxeMIFUBkO8/lPNIwZYjBa2OpC513U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ykf8YCjeuJhlAs0v/lXtsGJmb0M2yCS9qGj3oLTFJQS0JRJFpmEt2e0DbrhXVXKhg
         JI9CD1EsvzZwsRUFlhdy/W8NOq7Qh+n4X+J7EjweAG09dvETazDpiSQujAiU8mpQCI
         7xy+AaelGx4PuKwdbOsmgjCfDQDa0xFzCvwxEQ8Y=
Date:   Tue, 28 Apr 2020 12:19:51 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Bard Liao <yung-chuan.liao@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com
Subject: Re: [RFC 1/5] soundwire: bus_type: add sdw_master_device support
Message-ID: <20200428064951.GA56386@vkoul-mobl.Dlink>
References: <20200416205524.2043-1-yung-chuan.liao@linux.intel.com>
 <20200416205524.2043-2-yung-chuan.liao@linux.intel.com>
 <20200420072631.GW72691@vkoul-mobl>
 <20200423142451.GA4181720@kroah.com>
 <20200428043144.GU56386@vkoul-mobl.Dlink>
 <20200428063736.GB990431@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428063736.GB990431@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-20, 08:37, Greg KH wrote:
> On Tue, Apr 28, 2020 at 10:01:44AM +0530, Vinod Koul wrote:
> > > > That is not true for everyone, it is only true for Intel, pls call that
> > > > out as well...
> > > 
> > > Why is it not true for everyone?  How else do you get the pm stuff back
> > > to your hardware?
> > 
> > The rest of the world would do using the real controller device. For
> > example the soundwire controller on Qualcomm devices is enumerated as a
> > DT device and is using these...
> > 
> > If Intel had a standalone controller or enumerated as individual
> > functions, it would have been a PCI device and would manage as such
> 
> If it is not a standalone controller, what exactly is it?  I thought it
> was an acpi device, am I mistaken?
> 
> What is the device that the proper soundwire controller driver binds to
> on an Intel-based system?

The HDA controller which is a PCI device. The device represent HDA
function, DSP and Soundwire controller instances (yes it is typically
more than one instance)

Thanks
-- 
~Vinod

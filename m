Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5B6228522
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 18:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbgGUQOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 12:14:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:57547 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1730090AbgGUQOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:14:45 -0400
Received: (qmail 1279461 invoked by uid 1000); 21 Jul 2020 12:14:44 -0400
Date:   Tue, 21 Jul 2020 12:14:44 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: kworker/0:3+pm hogging CPU
Message-ID: <20200721161444.GE1272082@rowland.harvard.edu>
References: <20200720151255.GE1228057@rowland.harvard.edu>
 <20200720163355.GA4061@dhcp22.suse.cz>
 <20200720173807.GJ1228057@rowland.harvard.edu>
 <20200720174530.GB4061@dhcp22.suse.cz>
 <20200720174812.GK1228057@rowland.harvard.edu>
 <20200720181605.GC4061@dhcp22.suse.cz>
 <20200720200243.GA1244989@rowland.harvard.edu>
 <20200721055917.GD4061@dhcp22.suse.cz>
 <20200721143325.GB1272082@rowland.harvard.edu>
 <20200721160025.GP4061@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721160025.GP4061@dhcp22.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 06:00:25PM +0200, Michal Hocko wrote:
> On Tue 21-07-20 10:33:25, Alan Stern wrote:
> [...]
> 
> Thanks a lot for your analysis. The laptop is slowly dying so this can
> be related.
> 
> > So yes, this looks like a hardware design error.  Turning off 
> > autosuspend by writing to the sysfs power/control file is probably the 
> > best way to handle the problem.
> 
> I can use that workaround. But it seems that this also prevents me from
> suspending the maching into RAM with
> PM: Some devices failed to suspend, or early wake event detected
> 
> :/
> 
> If there is any workaround for that then I would be really happy but
> considering the overal state of the machine I suspect this is not the
> case.

As far as I know there is no workaround.

Of course, you could build your own personal kernel with the 
over-current test removed from the driver.  But keeping that up-to-date 
would be a nuisance.

> Thanks again for your great help!

You're welcome.

Alan Stern

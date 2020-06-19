Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8ED2007BE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgFSL0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 07:26:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:58706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729509AbgFSL0m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 07:26:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id A2AFDAF1F;
        Fri, 19 Jun 2020 11:26:39 +0000 (UTC)
Date:   Fri, 19 Jun 2020 13:26:39 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org
Subject: Re: [PATCH v1 0/6] console: unify return codes from ->setup() hook
Message-ID: <20200619112638.GL3617@alley>
References: <20200618164751.56828-1-andriy.shevchenko@linux.intel.com>
 <20200619093917.GK3617@alley>
 <20200619094726.GD2428291@smile.fi.intel.com>
 <20200619102132.GB310968@jagdpanzerIV.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619102132.GB310968@jagdpanzerIV.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-06-19 19:21:32, Sergey Senozhatsky wrote:
> On (20/06/19 12:47), Andy Shevchenko wrote:
> > On Fri, Jun 19, 2020 at 11:39:18AM +0200, Petr Mladek wrote:
> > > On Thu 2020-06-18 19:47:45, Andy Shevchenko wrote:
> [..]
> > > I am going to push it the following week via printk tree unless
> > > anybody complains.
> > 
> > Thanks, Petr, I guess you may also incorporate Sergey's patch
> > he proposed. Sergey, are you going to submit it officially?
> 
> I can send a patch, unless Petr has objections.

Go ahead :-)

Best Regards,
Petr

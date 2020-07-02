Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2FE212363
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jul 2020 14:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728988AbgGBMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jul 2020 08:34:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbgGBMd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 08:33:59 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A6A20836;
        Thu,  2 Jul 2020 12:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593693238;
        bh=FR7gQI0JtDDU8HzfE1z90MM9ea8ghQIPgiGtlWFQUYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y1J6G/OMYpCJV4JjWF9eu6XnlyheeAkFYIv+qy1KHruLldpkRV4ecXaWqZbsfB7sp
         /w4WsxmcLy3aOhtt+a89rrLfx5WUOkuIdW35iJEiSkOx5YDNmciQb5qi0W6YX+gex3
         pR9oghru9fKNvYqS1PzHyrXD0SW2uEDAoKB4Oa9k=
Date:   Thu, 2 Jul 2020 14:34:02 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        John Warthog9 Hawley <warthog9@kernel.org>
Subject: Re: [for-next][PATCH 8/8] ktest.pl: Add MAIL_MAX_SIZE to limit the
 amount of log emailed
Message-ID: <20200702123402.GA1773770@kroah.com>
References: <20200701231717.757834010@goodmis.org>
 <20200701231756.790637968@goodmis.org>
 <20200702074103.GA1076415@kroah.com>
 <20200702081949.2bfd2417@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702081949.2bfd2417@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 08:19:49AM -0400, Steven Rostedt wrote:
> On Thu, 2 Jul 2020 09:41:03 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Wed, Jul 01, 2020 at 07:17:25PM -0400, Steven Rostedt wrote:
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > Add the ktest config option MAIL_MAX_SIZE that will limit the size of the
> > > log file that is placed into the email on failure.
> > > 
> > > Cc: Greg KH <gregkh@linuxfoundation.org>
> > > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > > ---
> > >  tools/testing/ktest/ktest.pl    | 12 +++++++++++-
> > >  tools/testing/ktest/sample.conf | 13 +++++++++++++
> > >  2 files changed, 24 insertions(+), 1 deletion(-)  
> > 
> > Interesting, but I like full log files for my reports :)
> 
> I can add an option to do that if you want. My full logs end up being a
> few hundred megabytes. Perhaps I could add a compress option too.

It's fine, the default should be good enough for me for now.  If not,
I'll just bump the value, or add compression.

thanks,

greg k-h-

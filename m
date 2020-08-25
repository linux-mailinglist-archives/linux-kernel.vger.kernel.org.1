Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4A1F250DBA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 02:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgHYAgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 20:36:35 -0400
Received: from netrider.rowland.org ([192.131.102.5]:33071 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726090AbgHYAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 20:36:34 -0400
Received: (qmail 350852 invoked by uid 1000); 24 Aug 2020 20:36:33 -0400
Date:   Mon, 24 Aug 2020 20:36:33 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Tom Rix <trix@redhat.com>
Cc:     Vito Caputo <vcaputo@pengaru.com>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: storage: initialize variable
Message-ID: <20200825003633.GB350601@rowland.harvard.edu>
References: <20200824211027.11543-1-trix@redhat.com>
 <20200824211839.6c7m7yhgd7ffq3g3@shells.gnugeneration.com>
 <c9c4fca2-d04a-1bf9-e90e-9476392c1662@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9c4fca2-d04a-1bf9-e90e-9476392c1662@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 02:31:01PM -0700, Tom Rix wrote:
> 
> On 8/24/20 2:18 PM, Vito Caputo wrote:
> > On Mon, Aug 24, 2020 at 02:10:27PM -0700, trix@redhat.com wrote:
> >> From: Tom Rix <trix@redhat.com>
> >>
> >> clang static analysis reports this representative problem
> >>
> >> transport.c:495:15: warning: Assigned value is garbage or
> >>   undefined
> >>         length_left -= partial;
> >>                    ^  ~~~~~~~
> >> partial is set only when usb_stor_bulk_transfer_sglist()
> >> is successful.
> >>
> >> So set partial on entry to 0.
> >>
> >> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> >> Signed-off-by: Tom Rix <trix@redhat.com>
> >> ---
> >>  drivers/usb/storage/transport.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
> >> index 238a8088e17f..044429717dcc 100644
> >> --- a/drivers/usb/storage/transport.c
> >> +++ b/drivers/usb/storage/transport.c
> >> @@ -414,6 +414,9 @@ static int usb_stor_bulk_transfer_sglist(struct us_data *us, unsigned int pipe,
> >>  {
> >>  	int result;
> >>  
> >> +	if (act_len)
> >> +		*act_len = 0;
> >> +
> >>  	/* don't submit s-g requests during abort processing */
> >>  	if (test_bit(US_FLIDX_ABORTING, &us->dflags))
> >>  		return USB_STOR_XFER_ERROR;
> > At a glance this seems odd to me.  If the caller insists on ignoring
> > the return value, shouldn't it just initialize partial to zero?
> >
> > In my experience it's generally frowned upon for functions to store
> > results in error paths.
> 
> Then maybe v1 is more appropriate.
> 
> Else i can spin a v3.
> 
> My preference is v1 as it doesn't add any runtime if-checks.

If you really want to get rid of the runtime check (both the one you 
added and the one already present), you can audit all the callers of 
this routine to make certain that none of them pass a NULL pointer for 
act_len.

Alan Stern

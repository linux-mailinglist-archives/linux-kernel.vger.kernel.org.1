Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8F6285147
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 19:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgJFR6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 13:58:46 -0400
Received: from netrider.rowland.org ([192.131.102.5]:41705 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1726197AbgJFR6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 13:58:46 -0400
Received: (qmail 426512 invoked by uid 1000); 6 Oct 2020 13:58:45 -0400
Date:   Tue, 6 Oct 2020 13:58:45 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     "Harley A.W. Lorenzo" <hl1998@protonmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci-sched: avoid possible NULL dereference
Message-ID: <20201006175845.GC423499@rowland.harvard.edu>
References: <20201005213149.12332-1-sudipm.mukherjee@gmail.com>
 <brWYeL8miTAikvEPYFNe2Kpe05OBtiD6yuS6jRg1VCX-lt7ANc1B2y7AM6ECEoG9AJwZP5_5qoGO7POvK0MtruvqG8q8kHbyHiOUIZ72Klk=@protonmail.com>
 <20201006012544.GB399825@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006012544.GB399825@rowland.harvard.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 09:25:44PM -0400, stern@rowland.harvard.edu wrote:
> On Mon, Oct 05, 2020 at 11:19:02PM +0000, Harley A.W. Lorenzo wrote:
> > On Monday, October 5, 2020 5:31 PM, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> > 
> > > find_tt() can return NULL or the error value in ERR_PTR() and
> > > dereferencing the return value without checking for the error can
> > > lead to a possible dereference of NULL pointer or ERR_PTR().
> > 
> > Looks fine to me. There is in fact no checks of the return value
> > before a dereference here, and this solves that.
> > 
> > Reviewed-by: Harley A.W. Lorenzo <hl1998@protonmail.com
> 
> No, this patch is wrong.  In fact, these calls to find_tt() cannot 
> return NULL or an ERR_PTR value.

Sudip, if you would prefer to submit a patch that adds comments to those 
call sites explaining that find_tt() will not return NULL or an error, 
that would be okay.

Alan Stern

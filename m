Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 275A92843CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 03:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgJFBZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 21:25:45 -0400
Received: from netrider.rowland.org ([192.131.102.5]:58837 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1725901AbgJFBZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 21:25:45 -0400
Received: (qmail 399975 invoked by uid 1000); 5 Oct 2020 21:25:44 -0400
Date:   Mon, 5 Oct 2020 21:25:44 -0400
From:   "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>
To:     "Harley A.W. Lorenzo" <hl1998@protonmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-safety@lists.elisa.tech" <linux-safety@lists.elisa.tech>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
Subject: Re: [PATCH] usb: host: ehci-sched: avoid possible NULL dereference
Message-ID: <20201006012544.GB399825@rowland.harvard.edu>
References: <20201005213149.12332-1-sudipm.mukherjee@gmail.com>
 <brWYeL8miTAikvEPYFNe2Kpe05OBtiD6yuS6jRg1VCX-lt7ANc1B2y7AM6ECEoG9AJwZP5_5qoGO7POvK0MtruvqG8q8kHbyHiOUIZ72Klk=@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <brWYeL8miTAikvEPYFNe2Kpe05OBtiD6yuS6jRg1VCX-lt7ANc1B2y7AM6ECEoG9AJwZP5_5qoGO7POvK0MtruvqG8q8kHbyHiOUIZ72Klk=@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 05, 2020 at 11:19:02PM +0000, Harley A.W. Lorenzo wrote:
> On Monday, October 5, 2020 5:31 PM, Sudip Mukherjee <sudipm.mukherjee@gmail.com> wrote:
> 
> > find_tt() can return NULL or the error value in ERR_PTR() and
> > dereferencing the return value without checking for the error can
> > lead to a possible dereference of NULL pointer or ERR_PTR().
> 
> Looks fine to me. There is in fact no checks of the return value
> before a dereference here, and this solves that.
> 
> Reviewed-by: Harley A.W. Lorenzo <hl1998@protonmail.com

No, this patch is wrong.  In fact, these calls to find_tt() cannot 
return NULL or an ERR_PTR value.

Alan Stern

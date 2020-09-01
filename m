Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF0259918
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgIAQgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 12:36:19 -0400
Received: from netrider.rowland.org ([192.131.102.5]:59193 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1731658AbgIAQgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:36:03 -0400
Received: (qmail 592735 invoked by uid 1000); 1 Sep 2020 12:36:02 -0400
Date:   Tue, 1 Sep 2020 12:36:02 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     gregkh@linuxfoundation.org, erkka.talvitie@vincit.fi,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC RESEND PATCH 0/1] USB EHCI: repeated resets on full and low
 speed devices
Message-ID: <20200901163602.GG587030@rowland.harvard.edu>
References: <cover.1598887346.git.khalid@gonehiking.org>
 <20200901023117.GD571008@rowland.harvard.edu>
 <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <608418fa-b0ce-c2a4-ad79-fe505c842587@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 09:15:46AM -0700, Khalid Aziz wrote:
> On 8/31/20 8:31 PM, Alan Stern wrote:
> > Can you collect a usbmon trace showing an example of this problem?
> > 
> 
> I have attached usbmon traces for when USB hub with keyboards and mouse
> is plugged into USB 2.0 port and when it is plugged into the NEC USB 3.0
> port.

The usbmon traces show lots of errors, but no Clear-TT events.  The 
large number of errors suggests that you've got a hardware problem; 
either a bad hub or bad USB connections.

Alan Stern

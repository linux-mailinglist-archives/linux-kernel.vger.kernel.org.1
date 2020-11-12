Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562352B0DFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 20:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgKLTZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 14:25:27 -0500
Received: from netrider.rowland.org ([192.131.102.5]:46225 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727022AbgKLTZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 14:25:25 -0500
Received: (qmail 288074 invoked by uid 1000); 12 Nov 2020 14:25:24 -0500
Date:   Thu, 12 Nov 2020 14:25:24 -0500
From:   Alan Stern <stern@rowland.harvard.edu>
To:     John Boero <boeroboy@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: core: Null deref in kernel with USB webcams.
Message-ID: <20201112192524.GB287229@rowland.harvard.edu>
References: <CAO5W59jOWuRKizngF8vv9jb-zr_HnLC2eNxKqi3AYwg8KLwKoA@mail.gmail.com>
 <X61rce8GANHW1ysh@kroah.com>
 <CAO5W59iGm3kN-HhA_g78iJH9cV3fHzjQORM_b3xqo1Mg+XEi2g@mail.gmail.com>
 <X613chtPVIg8kquH@kroah.com>
 <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO5W59jZdDgSBE3Tr79u7TuCrdsirhisFxKH6aCH5oE4soOz1g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 12, 2020 at 06:15:08PM +0000, John Boero wrote:
> Then why does line 278 right below it check for NULL?

Are you asking about line 278 in drivers/usb/core/usb.c?  The statement 
which says:

	if (!config)
		return NULL;

This is because it is perfectly valid for config to be NULL at this 
point.  But it is not valid for dev to be NULL.  If dev is NULL then 
there is a bug in the caller.

Alan Stern

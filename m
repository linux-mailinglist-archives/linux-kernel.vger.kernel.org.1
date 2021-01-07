Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0662ED3EE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbhAGQH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 11:07:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:38942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbhAGQH0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 11:07:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA32320857;
        Thu,  7 Jan 2021 16:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610035606;
        bh=fW+sRFKewTD0s/v+Y64IXrNHVY3Unyxxgp8l2VjsJTQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TbGgU040iHiKoqeLSD+pvmPndijFejtLPf/NcOt1K8K/SljvZd+YA3Mb1d2WoVdQN
         NDx80LNefEOh74FsSUQei9DdjVC4jXiT+45m38ekExZcVEkYy4yQd1WnJbuG15AWKc
         AN8x2hAjRkGFfl6JMtab75Qr4mxV0KxW/8KhMSqM=
Date:   Thu, 7 Jan 2021 17:08:06 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Subject: Re: [PATCH v2] kcov, usb: hide in_serving_softirq checks in
 __usb_hcd_giveback_urb
Message-ID: <X/cx5tjAODS6PFTO@kroah.com>
References: <04978189d40307e979be61c458f4944b61134198.1610035117.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04978189d40307e979be61c458f4944b61134198.1610035117.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 05:01:44PM +0100, Andrey Konovalov wrote:
> Done opencode in_serving_softirq() checks in __usb_hcd_giveback_urb() to
> avoid cluttering the code, hide them in kcov helpers instead.
> 
> Fixes: aee9ddb1d371 ("kcov, usb: only collect coverage from __usb_hcd_giveback_urb in softirq")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
> 
> Changes v1->v2:
> - Fix a typo in the commit description and in a comment in the patch.

I can't drop the previous one, so can you just make a follow-on patch
please?

thanks,

greg k-h

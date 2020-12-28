Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28CCB2E4074
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 15:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505373AbgL1OwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 09:52:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:51092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727085AbgL1OwI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 09:52:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4B2A2084D;
        Mon, 28 Dec 2020 14:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609167088;
        bh=odTKooUE1YbyrBjjpDjD4r0zjZEcvPiR1tfvSqIE2UY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AUMwak0p6vcVE1k3Gz6DJgbtEKg4wrXpTqFBHcXTndBMiMNhF/lkleEM+pCEezohe
         nqUKEhtrJXzNXIm/ovexKsqjm2IiHWaIK/6D+LqJ6AACWRxcSMuIdhcjaPe07sFcgi
         JGgX8wB8yt+rwyiIOFCLmQAtZVWaYnQ9PyY7AVRk=
Date:   Mon, 28 Dec 2020 15:52:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, Dmitry Vyukov <dvyukov@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Nazime Hande Harputluoglu <handeharput@gmail.com>
Subject: Re: [PATCH v5] kcov, usb: only collect coverage from
 __usb_hcd_giveback_urb in softirq
Message-ID: <X+nxQo7q2n4dGzoy@kroah.com>
References: <d7035335fdfe7493067fbf7d677db57807a42d5d.1606175031.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7035335fdfe7493067fbf7d677db57807a42d5d.1606175031.git.andreyknvl@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:47:25AM +0100, Andrey Konovalov wrote:
> Currently there's a kcov remote coverage collection section in
> __usb_hcd_giveback_urb(). Initially that section was added based on the
> assumption that usb_hcd_giveback_urb() can only be called in interrupt
> context as indicated by a comment before it. This is what happens when
> syzkaller is fuzzing the USB stack via the dummy_hcd driver.
> 
> As it turns out, it's actually valid to call usb_hcd_giveback_urb() in task
> context, provided that the caller turned off the interrupts; USB/IP does
> exactly that. This can lead to a nested KCOV remote coverage collection
> sections both trying to collect coverage in task context. This isn't
> supported by kcov, and leads to a WARNING.
> 
> Change __usb_hcd_giveback_urb() to only call kcov_remote_*() callbacks
> when it's being executed in a softirq. To avoid calling
> in_serving_softirq() directly in the driver code, add a couple of new kcov
> wrappers.
> 
> As the result of this change, the coverage from USB/IP related
> usb_hcd_giveback_urb() calls won't be collected, but the WARNING is fixed.
> 
> A potential future improvement would be to support nested remote coverage
> collection sections, but this patch doesn't address that.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Acked-by: Marco Elver <elver@google.com>
> ---
> 
> Changes in v5:
> - Don't call in_serving_softirq() in USB driver code directly, do that
>   via kcov wrappers.

Does not apply to 5.11-rc1 :(

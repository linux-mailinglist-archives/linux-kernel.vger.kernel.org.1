Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83132E413C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 16:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503193AbgL1PEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 10:04:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:55480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439428AbgL1PEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 10:04:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id B71B82245C;
        Mon, 28 Dec 2020 15:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609167806;
        bh=AOnnYG3XR1IF+z/MkKKYJpkcTe9k4sA4eKFM/MrcxNs=;
        h=Date:From:To:Cc:Subject:From;
        b=cJXamOP3FMXS7i2k9EHpON6U14/Z648NK41w8bh1eNjovaj+FH3WmOz5iHNH90jlc
         35Z64zwCCQiaFYnrIoYNjA3Vn7ah+Eu4sM2D/5h+qZuFWq5cdVORMrBTcUdvLEarhf
         36wQ343X7u3XX64KCC0VJreajZP52USVhRDi2/Lg=
Date:   Mon, 28 Dec 2020 16:04:47 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org
Cc:     Felipe Balbi <balbi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Caught up on USB pending patches, gadget included
Message-ID: <X+n0D9h5YEs+5GjD@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Due to the holidays and various real-world stuff, I'll be handling the
USB gadget patches and other stuff that Felipe maintains for a month or
so as I have the spare cycles.

Right now I think I've caught up with all that has been submitted, but I
know I have missed some older ones as my archives didn't stretch back
that far.

So, if you have submitted a patch against drivers/usb/* recently, and
not gotten an email from my patch-scripts saying it was applied, or that
it was rejected, please consider it lost and resend.

thanks,

greg k-h

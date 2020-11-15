Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B6652B39D1
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgKOWQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgKOWQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:16:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ABCC0613D1
        for <linux-kernel@vger.kernel.org>; Sun, 15 Nov 2020 14:15:52 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605478549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=pmS3aJYHTau12b5keDQ9tyWMjsdSSJpMHpZkn7j1uo0=;
        b=EEJLtcrgcS2u10ehOTJA1njalVCwlZDfiQd71obRiYRig707vLQkyRaPAZvEPOokUw27Bw
        cVPorraq5SSKTjd8WvfhwM26J0mnQia5RaLBvc0avHehxKoa4fl0O1+wsvAGv+0kt619QL
        Q0O+2ZsbdOqTd2GhTWPy7z2TXYTN7VkWpAbrlzuH2rf+0rgAmZ68up6UukLAjjJNna42/a
        EGnlBKqQk79HjJmLLINJQ1AFQkjViHdmE3U+cSCyzJKsN13QWDU6qivphdNpO6N78AMYFJ
        Q6yDzlWzlEF/4qJ2PHJFI7xR+R6WbNDBj1FwtzepcmI0oM/n/vNyr4pHNQJ7lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605478549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to; bh=pmS3aJYHTau12b5keDQ9tyWMjsdSSJpMHpZkn7j1uo0=;
        b=vaoRFPAMYSNos68ZJAGgR/YnCRNhzLEtGFVnUSDAYjG1T6wvyT5J+2HjAztNRyjHzHdV1P
        twr98JT9R92Yp+DQ==
To:     Alex Shi <alex.shi@linux.alibaba.com>, john.stultz@linaro.org
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] timekeeping: fix kernel-doc mark issue on read_persistent_clock64
In-Reply-To: <1605252275-63652-6-git-send-email-alex.shi@linux.alibaba.com>
Date:   Sun, 15 Nov 2020 23:15:49 +0100
Message-ID: <874klq5kru.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 13 2020 at 15:24, Alex Shi wrote:
> Fix the kernel-doc markup:
> kernel/time/timekeeping.c:1563: warning: Function parameter or member
> 'wall_time' not described in 'read_persistent_wall_and_boot_offset'
> kernel/time/timekeeping.c:1563: warning: Function parameter or member
> 'boot_offset' not described in 'read_persistent_wall_and_boot_offset'

How is the subject related to the actual problem ?

Thanks,

        tglx

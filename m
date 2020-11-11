Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 616AE2AEDEF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgKKJhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:37:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:33072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725912AbgKKJhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:37:45 -0500
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E49DB206D9;
        Wed, 11 Nov 2020 09:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605087464;
        bh=u4oI8akQtycIQ1Xqcemww5azjG8IkNdslx5h41epaP4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Cvx5O29QZC+AuIXemq0yVCbtzrtqtssfYXKiRvBToLCz/6WPI0ELTefhiwmV3Eozb
         K/YjT+7Hz50ouvJ53rpdoJT3vTtRIFaZC8zUHJUa9u4T8whmJ0HVlPt7sJIu0xz7Qs
         ZX47XTuBc1nBnx8KsX8Cvqw2k/qZ4UIs2S2tb2j8=
Date:   Wed, 11 Nov 2020 18:37:42 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: bootconfig length parse error in kernel
Message-Id: <20201111183742.e7c90597216343d9d2ffcb4e@kernel.org>
In-Reply-To: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
References: <CADjb_WSwW4jrNvLp91YHu-qimU1P1itPU_gZ5juQRWER_vGWAA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On Tue, 10 Nov 2020 23:39:53 +0800
Chen Yu <yu.chen.surf@gmail.com> wrote:

> Hi Masami,
> Thanks for writing bootconfig and it is useful for boot up trace event
> debugging.

Thanks for testing!

> However it was found that on 5.10-rc2 the bootconfig does not work and it shows
> "'bootconfig' found on command line, but no bootconfig found"
> And the reason for this is the kernel found the magic number to be incorrect.
> I've added some hack in kernel to dump the first 12 bytes, it shows:
> "OTCONFIG". So printed more content ahead we can find
> "#BOOTCONFIG" ahead. So it looks that there is some alignment during
> initrd load, and get_boot_config_from_initrd() might also deal with it. That is
> to say:
> data = (char *)initrd_end - BOOTCONFIG_MAGIC_LEN;
> might do some alignment?

Hrm, interesting. So initrd_end might be aligned. Could you print out the
actuall address of initrd_end? And could you tell me which platform are
you tested?

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>

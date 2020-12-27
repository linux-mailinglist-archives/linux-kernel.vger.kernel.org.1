Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD732E31A2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Dec 2020 16:03:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbgL0PAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Dec 2020 10:00:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:54388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgL0PAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Dec 2020 10:00:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 60E9020867;
        Sun, 27 Dec 2020 14:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1609081181;
        bh=ZrFLsZfNoljHxg18KYAT61yF3cWJKpnoQLwPfqWvqTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mP0X1/5Wz0ylJ43FfrIDN84YO1BWuS7NCnGiJPtx2/9yhwpU7vXQQWtT3k73hui+K
         I2CZyWej+sOnWw5NVxCL2129QT+vFNSzmhiRVbbLmJMVk5dBngQmzZJ8AQw2ulLyFg
         FjMoml6ShEj/YnrXQW7evdBDNq/msJ6f/qwTlKPk=
Date:   Sun, 27 Dec 2020 16:01:05 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Defang Bo <bodefang@126.com>
Cc:     jason.wessel@windriver.com, daniel.thompson@linaro.org,
        arnd@arndb.de, dianders@chromium.org,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kgdbts: Passing ekgdbts to command line causes panic
Message-ID: <X+ihsSzr3R6YB7vP@kroah.com>
References: <1609076585-4010725-1-git-send-email-bodefang@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1609076585-4010725-1-git-send-email-bodefang@126.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 27, 2020 at 09:43:05PM +0800, Defang Bo wrote:
> Similar to commit<1bd54d85>,kgdbts_option_setup does not check input argument
> before passing it to strlen. The argument would be a NULL pointer.
> 

As per the documentation, you should write commits out as 1bd54d851f50
("kgdboc: Passing ekgdboc to command line causes panic").

Can you fix that up and resend this?

thanks,

greg k-h

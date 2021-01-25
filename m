Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E242930294F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 18:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731189AbhAYRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 12:50:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730369AbhAYRt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 12:49:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6AC7522D04;
        Mon, 25 Jan 2021 17:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611596926;
        bh=wguYbFwsG5kqXZUAq1WIqcUQptP2XZLVdDd7/mVRf0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KvNHBoingr45YxtO9x/FFHmTWu3ezEs2z03GA99K9d+8whAclw7TB4w0IcZLCRWbT
         F5kd6EDsSAb9+tv1FKa8FXy87ATbN+9b1i7hYJiU6ycQ3okmFY6e65aP7DLGPbTkql
         K1MV0kPZZG84L+p+pLztG5mAT55YczY8ontuNlGI=
Date:   Mon, 25 Jan 2021 18:48:43 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Desmond Yan <desmond.yan@broadcom.com>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v9 00/13] Add Broadcom VK driver
Message-ID: <YA8Ee2QpeMPTtTg5@kroah.com>
References: <20210120175827.14820-1-scott.branden@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120175827.14820-1-scott.branden@broadcom.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 09:58:14AM -0800, Scott Branden wrote:
> This patch series drops previous patches in [1]
> that were incorporated by Kees Cook into patch series
> "Introduce partial kernel_read_file() support" [2].
> 
> Remaining patches are contained in this series to add Broadcom VK driver.
> (which depends on request_firmware_into_buf API addition which has
> now been accepted into the upstream kernel as of v5.10-rc1).

Wow, it's been a long time for this patch series, thanks for sticking
with it.  All are now queued up in my tree, and will show up in
linux-next in a day or so.  Now the real work starts :)

thanks,

greg k-h

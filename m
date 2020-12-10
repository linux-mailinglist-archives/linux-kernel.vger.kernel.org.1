Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A602D5B00
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 13:55:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388397AbgLJMzC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 07:55:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:46566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbgLJMzC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 07:55:02 -0500
Date:   Thu, 10 Dec 2020 13:55:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1607604861;
        bh=KcwKvGKRWej3wjBdyOKtL4xEYVhJHIpgdWBDVoUDJec=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=0HyDI+NfW5JFwV4agXDxW+ZshOKLzuJrth8kpM+GcKPtWs/sn6mlh9CxUIxyQxGex
         FCk9vKUS8G4zIHhGkGvZCeQ9uSiPs3Jwzk3d9Wmwy8V1SuTwlKdkJmpHIsYHsR1m1F
         Zh56903Z5j/2D9CIyjoyi2DsfMV/JR1Guim+orKc=
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?J=F3zsef_Horv=E1th?= <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] Staging: silabs si4455 serial driver
Message-ID: <X9IayHu9E1HbnvJt@kroah.com>
References: <20201210122001.GA31758@dincontrollerdev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201210122001.GA31758@dincontrollerdev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 10, 2020 at 12:20:10PM +0000, József Horváth wrote:
> I send this again, because my original mail content was corrupted.
> 
> This is a serial port driver for
> Silicon Labs Si4455 Sub-GHz transciver.
> 
> Signed-off-by: József Horváth <info@ministro.hu>
> ---
>  .../bindings/staging/serial/silabs,si4455.txt |   39 +
>  drivers/staging/Kconfig                       |    2 +
>  drivers/staging/Makefile                      |    1 +
>  drivers/staging/si4455/Kconfig                |    8 +
>  drivers/staging/si4455/Makefile               |    2 +
>  drivers/staging/si4455/TODO                   |    3 +
>  drivers/staging/si4455/si4455.c               | 1465 +++++++++++++++++

I said I wasn't going to take this into drivers/staging/ so why is this
still here?

confused,

greg k-h

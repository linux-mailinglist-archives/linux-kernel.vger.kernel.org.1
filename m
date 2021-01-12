Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8402F2CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 11:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405061AbhALK1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 05:27:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbhALK1j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:27:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D38C206F1;
        Tue, 12 Jan 2021 10:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610447219;
        bh=pD6HIKMO/7X4+1WOjiY3dlACys/7FN0D3TQds/58JRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EjeDLQCISFa3lGzgu0UdpK6uH+2fkMjE7MuAI04Ry0UABpmoss7HVJN9ekT+Ims1I
         PXBa1nMUO1i4QME4MhXGPn4ae5ihuUEGBbtCd9ei6YMxNZPqSXRYhfrQA9AZ+19+Rv
         6Z8AyFeU8YLcsZdoe9XSPCfUlkgGEbf/kUd+6wAY=
Date:   Tue, 12 Jan 2021 11:28:08 +0100
From:   'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
To:     Jozsef Horvath <info@ministro.hu>
Cc:     'Rob Herring' <robh+dt@kernel.org>,
        'Jiri Slaby' <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 1/2] Serial: silabs si4455 serial driver
Message-ID: <X/15uOstG/7bj2Lm@kroah.com>
References: <20210112101831.GA12483@dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112101831.GA12483@dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:18:33AM +0000, Jozsef Horvath wrote:
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -279,4 +279,7 @@
>  /* Freescale LINFlexD UART */
>  #define PORT_LINFLEXUART	122
>  
> +/* Silicon Labs SI4455 */
> +#define PORT_SI4455     123

What userspace tool is going to need this value?

thanks,

greg k-h

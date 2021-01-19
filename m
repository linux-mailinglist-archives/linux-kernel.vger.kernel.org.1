Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAA442FB751
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404364AbhASKez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 05:34:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389369AbhASKX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 05:23:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D4E7323117;
        Tue, 19 Jan 2021 10:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611051766;
        bh=ZCWD/b7A3OwSWmg8JXwsE+BsDPVkRktwRfyNPO6lUdg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UR8Jsg+mtUefwVHLkFSOyOYRGJOn/FgSapdFW7e+NAyIxOesltcdss4GA/ncuPXH1
         Iq+lN2DMdA7/4RmShHjcaMGDRxQAhU4tua2Mauvf8YntfgBpSLPAd+UJ1wz3pooc+P
         n7NoWJytThrmgGbwLYaloNtXMc+8P4137vFR9DAs=
Date:   Tue, 19 Jan 2021 11:22:43 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Howard Yen <howardyen@google.com>
Cc:     robh+dt@kernel.org, mathias.nyman@intel.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: usb: usb-xhci: add USB offload support
Message-ID: <YAay83Ze47hNu5Ii@kroah.com>
References: <20210119101044.1637023-1-howardyen@google.com>
 <20210119101044.1637023-5-howardyen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210119101044.1637023-5-howardyen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 06:10:44PM +0800, Howard Yen wrote:
> Document USB offload support for usb-xhci.
> 
> For example:
> 
> &usbdrd_dwc3 {
> 	...
> 	/* support usb offloading, 0: disabled, 1: audio */
> 	offload = <1>;
> 	...
> };
> 
> Signed-off-by: Howard Yen <howardyen@google.com>
> ---
>  Documentation/devicetree/bindings/usb/usb-xhci.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/usb-xhci.txt b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> index b120dd6612a2..aab1fd499f15 100644
> --- a/Documentation/devicetree/bindings/usb/usb-xhci.txt
> +++ b/Documentation/devicetree/bindings/usb/usb-xhci.txt
> @@ -46,6 +46,7 @@ Optional properties:
>    - quirk-broken-port-ped: set if the controller has broken port disable mechanism
>    - imod-interval-ns: default interrupt moderation interval is 5000ns
>    - phys : see usb-hcd.yaml in the current directory
> +  - offload: supporting USB offload feature, 0: disabled, 1: audio

Why does the "type" of offload matter, shouldn't it just be:
	0: disabled, 1: enabled
?

And in thinking about it some more, why does this need to be a binding
at all, shouldn't this just be an issue if the platform-specific ops are
available or not, meaning no DT change should be needed at all?

thanks,

greg k-h

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87D295061
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 18:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502771AbgJUQGR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 12:06:17 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52203 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502762AbgJUQGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 12:06:17 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 1171A5C0227;
        Wed, 21 Oct 2020 12:06:16 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute4.internal (MEProxy); Wed, 21 Oct 2020 12:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=septs.pw; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm1; bh=7iRL84+Ugv9Vl9dV9rOTDR1uJK/G0lb
        YzOiNJlNesBs=; b=lMAYadK9oedM3ADQN3HgvxQupxAGq+sjvh8fTrQ+ErpWZTt
        7N0Srt9VuD1HfNbu5zpmv525bgR6jVCmNqOBLksveuWa+VNyQP1T/8puMU4xk4XM
        JRfjIGsdffiXnGpg/SGGQZYnDkoPiPktEzwPQUdf3boKmt3yjhN8B6cyHaZaBLBJ
        x9e6bmy0bXy6b7l1uiHEXDv3wjxiGRRh24lovzCp7wju8SsauIFFSMKFw1MpSMIG
        a6wwsovuopN2PTJkmfJU+7mHqLc4eP2aqq8cNHsHR3uxHJlVEIj9LG5QWidl8ipC
        UbxOomOSdhfd3rVxTGKrhOwf0GEqPti/jvJ+LUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=7iRL84
        +Ugv9Vl9dV9rOTDR1uJK/G0lbYzOiNJlNesBs=; b=Vi2VixV6tcSH2dRgDgw2f6
        hE6OzcweT9Wi3khf9uxE2/uS1c0wAB7LsUIp/35xX1gWPzCMduDk0LlLsEDAlinR
        Y2ATQoqA7a69iYQZmHog7ds4GLcej7q66Arz2cZpxOEVneKp3Kc4eT7GfQvVoRfV
        C+bBBoJp746W49SkWQq5rayNN2x5eeTsB9RgLeMgEQfTSpnNAbXuEWZQlTJ3xykL
        t4dK/DG2NrXs3sTMsC4MBH3KD65JUepIpxbPhHPGsVboG4+mwUWaMbgDViNDhHUz
        REp6MpIIWKnooYnOo6eBQjlNzXjExvX/RzIoseHeWXsi2N59xsyrGWpM/r1etmeA
        ==
X-ME-Sender: <xms:d1yQXyAeNmAQMErFfo3rbtIrJxDySO1GNY91082lEimpcobRoJOYQA>
    <xme:d1yQX8ivkWOaXCb-K3MDRxHhfYsRjV0kuKtk9bHXRhqBsjra9QYjea9txxHuz2zBS
    rdzhLt3Vd95Hqk3mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrjeehgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdduhedmnecujfgurhepofgfggfkjghffffhvffutgesthdtredtreer
    jeenucfhrhhomhepfdgkihihihcuvegrohdfuceokhgvrhhnvghlsehsvghpthhsrdhpfi
    eqnecuggftrfgrthhtvghrnhepkeeihefgjeefleetveefudeihffgkeejgfejkedttdej
    feegkeduleekueegveelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepkhgvrhhnvghlsehsvghpthhsrdhpfi
X-ME-Proxy: <xmx:d1yQX1ngtbz8nI3sxYTgnpo23ombql6sox5k2IBwxDw8JhtNcU5zIQ>
    <xmx:d1yQXwzo7wXhqZ2prtmphbkpnW-Fq8JIG1XJf3f94XzTaYZBq_NP_g>
    <xmx:d1yQX3RZ9KCkMaLArZIhCWvhfdQVFnragcBYIxn6Mz1AWuuVhL77sw>
    <xmx:eFyQX-JoH96LZO9gOnnKOw6rtOk6o5ESMovi5hDS6_s0CgwA8V3WxQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AF5D120075; Wed, 21 Oct 2020 12:06:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-502-gfef6c88-fm-20201019.001-gfef6c888
Mime-Version: 1.0
Message-Id: <209b0a93-ff0e-4e1a-b180-92e8f6214fb2@www.fastmail.com>
In-Reply-To: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
References: <17f8a2a3-ce0f-4be7-8544-8fdf286907d0@www.fastmail.com>
Date:   Thu, 22 Oct 2020 00:05:55 +0800
From:   "Ziyi Cao" <kernel@septs.pw>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Johan Hovold" <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?UTF-8?Q?Re:_[PATCH_1/1]_usb:_serial:_option:_add_Quectel_EC200T_module?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Request to accept this patch, thanks.

On Tue, Oct 20, 2020, at 00:08, Ziyi Cao wrote:
> Add usb product id of the Quectel EC200T module.
> 
> Signed-off-by: Ziyi Cao <kernel@septs.pw>
> ---
>  drivers/usb/serial/option.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index 2a3bfd6f8..7e879233b 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -250,6 +250,7 @@ static void option_instat_callback(struct urb *urb);
>  #define QUECTEL_PRODUCT_EP06			0x0306
>  #define QUECTEL_PRODUCT_EM12			0x0512
>  #define QUECTEL_PRODUCT_RM500Q			0x0800
> +#define QUECTEL_PRODUCT_EC200T			0x6026
>  
>  #define CMOTECH_VENDOR_ID			0x16d8
>  #define CMOTECH_PRODUCT_6001			0x6001
> @@ -1117,6 +1118,7 @@ static const struct usb_device_id option_ids[] = {
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 
> QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
>  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 
> QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
>  	  .driver_info = ZLP },
> +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, 
> QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
>  
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
>  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
> -- 
> 2.25.1
>

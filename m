Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E22D291878
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 19:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgJRRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 13:07:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53465 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726357AbgJRRHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 13:07:33 -0400
X-Greylist: delayed 22557 seconds by postgrey-1.27 at vger.kernel.org; Sun, 18 Oct 2020 13:07:32 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id AD2485C00D1;
        Sun, 18 Oct 2020 13:07:31 -0400 (EDT)
Received: from imap10 ([10.202.2.60])
  by compute1.internal (MEProxy); Sun, 18 Oct 2020 13:07:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=septs.email; h=
        mime-version:message-id:in-reply-to:references:date:from
        :reply-to:to:cc:subject:content-type; s=fm1; bh=6DhcgOcHEVqq33I2
        DoK+ENro/bLG+q83HoYgbx14A+8=; b=19BffJAGeluDW0IwBRXZlHWew7AUaH7j
        Brp1gr8+2qH/L7/BmtiP3q9gqELNKoYDzdLjcUUkwPTxQZ62P3SjV1a0YVS2j3gY
        vvLaq5bNE9vyCiUy0imx62zAAbWf6bDge8phpcmU5t3SGSZDshLt8JmBSYVgGwJS
        ZjU4Pc2FxymEmMCqocHOLj8S1v1xLHzApaJNMtY8quhdJvRkDPIkwHEzkldP/X5J
        bdTPf786KL/YVhEsrGVKLRfEcRsOxlBf4lm4k0Q/NLJqwXUKz/xo4nH9LdJlFTMc
        SjFIwZTZGsk7iMCSBtcXlp9PcRGZCqUllpY4I49rduLXTqfK01aF3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:reply-to:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=6DhcgOcHEVqq33I2DoK+ENro/bLG+q83HoYgbx14A+8=; b=OxPH9h5C
        FG5Xkyi1gVN1ApNJ9t6dMyoDmsu7+tkU18mWy7LcKSXIGSGM8HUt1L4v6JL0qbyV
        OYXQcppEPEhjisZNCcwSQaR2oKDukBtIC2S7PSFoWMur3SfV15NHkm5tFHAPXhhF
        6MCwtTxT1VMjatfBvNRnidzTX6eGjQLdE2Kk9vxd6Gd+e/ZxzNIJ2otJBiFKyayF
        q67yuVPVl28knPGvRy8m1CBRhnoH7PPi4zG73xIU43LuERRed+y3+nF66812phk3
        H0GNMY+2Ft+uCcPwmUOdSF67ay0iWfFbygZY7IidLCe8tFUdthWLT1z0vAp6+0Jx
        28GVge6psfJ8LQ==
X-ME-Sender: <xms:U3aMXyhNnKhxojVUwe9DISSxuRKixa35DyOSLCxi0aihGMclifOV5Q>
    <xme:U3aMXzDmtFAPuEALvrx8GJbM_z0mnknv8u1vIB85zD1zt264rLAq-eW8bwNeD2K_7
    GRTxqZysrYuO49gIA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieelgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdluddtmdenucfjughrpefofgggkfgjfhffhfhrvffutgesthdtredt
    reerjeenucfhrhhomhepshgvphhtshcuoehjohgssehsvghpthhsrdgvmhgrihhlqeenuc
    ggtffrrghtthgvrhhnpeegtdetuddttedvieekuefhledutdevgeevtdekkeevteeiffef
    gfelfffgtedujeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehjohgssehsvghpthhsrdgvmhgrihhl
X-ME-Proxy: <xmx:U3aMX6F6da_NV4ggf_Of9Vx57M66OvDSYKechIkXgCyaY7_sy8ciZw>
    <xmx:U3aMX7RIgTCtZjZFV_mNhelBHzNxaDe5bNCe31mRBKbX4E9gFI-QCQ>
    <xmx:U3aMX_xwkSjnwo3BqOkttmAS0b9JCsyW343dv5DbAvlByoJMViEeTw>
    <xmx:U3aMX68hIyWGqr0tQeFSNxV1gc86JrD4iSHySszudDoZ90HFVxSGkA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 34E6A202A1; Sun, 18 Oct 2020 13:07:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.3.0-489-gf39678d-fm-20201011.001-gf39678d0
Mime-Version: 1.0
Message-Id: <e51b0a3c-43ee-4b75-b32d-65ee2d43afb6@www.fastmail.com>
In-Reply-To: <20201018124937.GA3133964@kroah.com>
References: <20201018105111.8727-1-kernel@septs.pw>
 <20201018124937.GA3133964@kroah.com>
Date:   Mon, 19 Oct 2020 01:07:10 +0800
From:   septs <job@septs.email>
Reply-To: job@septs.email
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     "Johan Hovold" <johan@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, septs <kernel@septs.pw>
Subject: =?UTF-8?Q?Re:_[PATCH_1/1]_usb:_serial:_option:_add_Quectel_EC200T_module?=
 =?UTF-8?Q?_support?=
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add usb product id of the Quectel EC200T module.

Signed-off-by: septs <kernel@septs.pw>
---
 drivers/usb/serial/option.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index 2a3bfd6f8..7e879233b 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -250,6 +250,7 @@ static void option_instat_callback(struct urb *urb);
 #define QUECTEL_PRODUCT_EP06			0x0306
 #define QUECTEL_PRODUCT_EM12			0x0512
 #define QUECTEL_PRODUCT_RM500Q			0x0800
+#define QUECTEL_PRODUCT_EC200T			0x6026
 
 #define CMOTECH_VENDOR_ID			0x16d8
 #define CMOTECH_PRODUCT_6001			0x6001
@@ -1117,6 +1118,7 @@ static const struct usb_device_id option_ids[] = {
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
 	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
 	  .driver_info = ZLP },
+	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
 
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
 	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
-- 
2.25.1


On Sun, Oct 18, 2020, at 20:49, Greg Kroah-Hartman wrote:
> On Sun, Oct 18, 2020 at 06:51:11PM +0800, septs wrote:
> > Add usb product id of the Quectel EC200T module.
> > ---
> >  drivers/usb/serial/option.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> > index 2a3bfd6f8..7e879233b 100644
> > --- a/drivers/usb/serial/option.c
> > +++ b/drivers/usb/serial/option.c
> > @@ -250,6 +250,7 @@ static void option_instat_callback(struct urb *urb);
> >  #define QUECTEL_PRODUCT_EP06			0x0306
> >  #define QUECTEL_PRODUCT_EM12			0x0512
> >  #define QUECTEL_PRODUCT_RM500Q			0x0800
> > +#define QUECTEL_PRODUCT_EC200T			0x6026
> >  
> >  #define CMOTECH_VENDOR_ID			0x16d8
> >  #define CMOTECH_PRODUCT_6001			0x6001
> > @@ -1117,6 +1118,7 @@ static const struct usb_device_id option_ids[] = {
> >  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0, 0) },
> >  	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_RM500Q, 0xff, 0xff, 0x10),
> >  	  .driver_info = ZLP },
> > +	{ USB_DEVICE_AND_INTERFACE_INFO(QUECTEL_VENDOR_ID, QUECTEL_PRODUCT_EC200T, 0xff, 0, 0) },
> >  
> >  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_6001) },
> >  	{ USB_DEVICE(CMOTECH_VENDOR_ID, CMOTECH_PRODUCT_CMU_300) },
> > -- 
> > 2.25.1
> > 
> 
> Hi,
> 
> This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
> a patch that has triggered this response.  He used to manually respond
> to these common problems, but in order to save his sanity (he kept
> writing the same thing over and over, yet to different people), I was
> created.  Hopefully you will not take offence and will fix the problem
> in your patch and resubmit it so that it can be accepted into the Linux
> kernel tree.
> 
> You are receiving this message because of the following common error(s)
> as indicated below:
> 
> - Your patch does not have a Signed-off-by: line.  Please read the
>   kernel file, Documentation/SubmittingPatches and resend it after
>   adding that line.  Note, the line needs to be in the body of the
>   email, before the patch, not at the bottom of the patch or in the
>   email signature.
> 
> 
> - It looks like you did not use your "real" name for the patch on either
>   the Signed-off-by: line, or the From: line (both of which have to
>   match).  Please read the kernel file, Documentation/SubmittingPatches
>   for how to do this correctly.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot
>

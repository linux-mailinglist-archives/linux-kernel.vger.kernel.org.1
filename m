Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A382FB80F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 15:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390653AbhASLyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 06:54:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:55104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388948AbhASLnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 06:43:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB2422573;
        Tue, 19 Jan 2021 11:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611056580;
        bh=nXV0L98DqMMdZDiMXKaC4qTdrOLPEU1R7MhihaGIiis=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X0TMFWjZFdRxCqqMeqwvYfcelqZknutsZav9d6DehFRsM+HBnj4rnWsC74Ztrki36
         oJy48Blg/8ReAhgmTes0UMjH71pd7Uma0w95hQUAk9ikTpVwUNUsnQZ+svoNw6umH/
         xefUKVLc/6VWCOBV4fDLxHxcr3ED7qBi005yqFaJYf5ie9SDqJ+719nNFlqoLTMxt1
         GD8r6+UI4xO/Z1I4Vj+Qn9V4rRCtR/HEDlLGQx9nhi+z7jGvtVHU9k7OSVVRn5wfLz
         mmDnt8xRd8ShKHuHtFqYJ94GlyDTL8YqjXNDyBiAql7ZiIYcLsHty/tFelLMI794Lz
         breDpxDLgI2Jg==
Received: from johan by xi.lan with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1l1pPh-0001sv-Ml; Tue, 19 Jan 2021 12:43:09 +0100
Date:   Tue, 19 Jan 2021 12:43:09 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Pho Tran <Pho.Tran@silabs.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "johan@kernel.org" <johan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Hung Nguyen <Hung.Nguyen@silabs.com>,
        Tung Pham <Tung.Pham@silabs.com>
Subject: Re: [PATCH] USB: serial: cp210x: Fix error 32 when hardware flow
 control is enabled.
Message-ID: <YAbFzYfD7bbr04EM@hovoldconsulting.com>
References: <EFED51C2-797F-49CD-9B05-923993641BDE@silabs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <EFED51C2-797F-49CD-9B05-923993641BDE@silabs.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 19, 2021 at 10:42:33AM +0000, Pho Tran wrote:
> Fix error 32 returned by CP210X_SET_MHS when hardware flow control is enabled.
> 
> The root cause of error 32 is that user application (CoolTerm, linux-serial-test)
> opened cp210x device with hardware flow control then attempt to control RTS/DTR pins.
> In hardware flow control, RTS/DTR pins will be controlled by hardware only,
> any attempt to control those pins will cause error 32 from the device.
> This fix will block MHS command(command to control RTS/DTR pins) to the device
> if hardware flow control is being used.

Ok, thanks for adding some background.

> Signed-off-by: Pho Tran <pho.tran@silabs.com>
> ---

Always include a changelog here (after "---") when updating a patch so
we know what changed.

Also include the patch revision in the Subject (e.g. "[PATCH v3] USB:
...").

>  drivers/usb/serial/cp210x.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index fbb10dfc56e3..3694b7c62290 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -1211,6 +1211,12 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  		unsigned int set, unsigned int clear)
>  {
>  	u16 control = 0;
> +	struct cp210x_flow_ctl flow_ctl;
> +	u32 ctl_hs = 0;
> +	u32 flow_repl = 0;
> +	bool auto_dtr = false;
> +	bool auto_rts = false;
> +	int ret;
>  
>  	if (set & TIOCM_RTS) {
>  		control |= CONTROL_RTS;
> @@ -1231,6 +1237,27 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
>  
>  	dev_dbg(&port->dev, "%s - control = 0x%.4x\n", __func__, control);
>  
> +	// Don't send MHS command if device in hardware flowcontrol mode

Please don't use // comments.

> +	ret = cp210x_read_reg_block(port, CP210X_GET_FLOW, &flow_ctl, sizeof(flow_ctl));
> +	if (ret)
> +		return ret;

We should just add a flag to the port data structure to reflect the
hardware flow control setting (which is set in the new function
cp210x_set_flow_control()). There's no need to query the device here
just to determine if flow control is enabled.

> +
> +	ctl_hs = le32_to_cpu(flow_ctl.ulControlHandshake);
> +	flow_repl = le32_to_cpu(flow_ctl.ulFlowReplace);
> +
> +	if (CP210X_SERIAL_DTR_SHIFT(CP210X_SERIAL_DTR_FLOW_CTL) == (ctl_hs & CP210X_SERIAL_DTR_MASK))
> +		auto_dtr = true;
> +	else
> +		auto_dtr = false;

We don't use DTR flow control (and always disable it) so no need to
check this either.

> +
> +	if (CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL) == (flow_repl & CP210X_SERIAL_RTS_MASK))
> +		auto_rts = true;
> +	else
> +		auto_rts = false;
> +
> +	if (auto_dtr || auto_rts)
> +		return 0;

So this makes userspace think that a request to TIOCMSET succeeded, when
in fact it did not.

Eventually, we should instead manage the hardware flow control setting
also from tiocmset() so that a request to deassert DTR/RTS always does
just that, that is, also when hw flow control is enabled. Similarly,
reasserting RTS should re-enable flow control.

> +
>  	return cp210x_write_u16_reg(port, CP210X_SET_MHS, control);
>  }

I think we should leave TIOCMSET for now and only suppress the error at
port open and close.

I've implemented what I've outline above as the patch below.

Johan



From decd365c4368c95804388f684d411845fc8e1d6b Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Tue, 19 Jan 2021 12:17:34 +0100
Subject: [PATCH] USB: serial: cp210x: suppress modem-control error on open and
 close

The CP210X_SET_MHS request cannot be used to control DTR/RTS when
hardware flow control is enabled and instead returns an error which is
currently logged as:

	cp210x ttyUSB0: failed set request 0x7 status: -32

Add a crtscts flag to keep track of the hardware flow-control setting
and use it to suppress the request in dtr_rts().

Note that both lines are still deasserted when disabling the UART as
part of close().

Also note that TIOCMSET is left unchanged and will continue to return an
error to user-space when flow control is enabled (i.e. instead of
disabling and re-enabling auto-RTS when RTS is deasserted and
re-asserted).

Reported-by: Pho Tran <pho.tran@silabs.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/cp210x.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index d813a052738f..ac1e5cbe61dd 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -264,7 +264,8 @@ struct cp210x_port_private {
 	u8			bInterfaceNumber;
 	bool			event_mode;
 	enum cp210x_event_state event_state;
-	u8 lsr;
+	u8			lsr;
+	bool			crtscts;
 };
 
 static struct usb_serial_driver cp210x_device = {
@@ -1117,6 +1118,7 @@ static bool cp210x_termios_change(const struct ktermios *a, const struct ktermio
 static void cp210x_set_flow_control(struct tty_struct *tty,
 		struct usb_serial_port *port, struct ktermios *old_termios)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
 	struct cp210x_special_chars chars;
 	struct cp210x_flow_ctl flow_ctl;
 	u32 flow_repl;
@@ -1161,10 +1163,12 @@ static void cp210x_set_flow_control(struct tty_struct *tty,
 		ctl_hs |= CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_FLOW_CTL);
+		port_priv->crtscts = true;
 	} else {
 		ctl_hs &= ~CP210X_SERIAL_CTS_HANDSHAKE;
 		flow_repl &= ~CP210X_SERIAL_RTS_MASK;
 		flow_repl |= CP210X_SERIAL_RTS_SHIFT(CP210X_SERIAL_RTS_ACTIVE);
+		port_priv->crtscts = false;
 	}
 
 	if (I_IXOFF(tty))
@@ -1298,6 +1302,16 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 
 static void cp210x_dtr_rts(struct usb_serial_port *port, int on)
 {
+	struct cp210x_port_private *port_priv = usb_get_serial_port_data(port);
+
+	/*
+	 * CP210X_SET_MHS cannot be used to control DTR/RTS when hardware flow
+	 * control is enabled. Note that both lines are still deasserted when
+	 * disabling the UART.
+	 */
+	if (port_priv->crtscts)
+		return;
+
 	if (on)
 		cp210x_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
-- 
2.26.2



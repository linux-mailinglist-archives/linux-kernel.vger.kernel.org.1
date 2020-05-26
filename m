Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24F51A7603
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 10:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436789AbgDNI0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 04:26:54 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:39633 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436780AbgDNI0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 04:26:39 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOGtw-0007Pr-8X; Tue, 14 Apr 2020 10:26:36 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1jOGtv-0000m7-JI; Tue, 14 Apr 2020 10:26:35 +0200
Date:   Tue, 14 Apr 2020 10:26:35 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     peng.fan@nxp.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        jassisinghbrar@gmail.com, o.rempel@pengutronix.de,
        leonard.crestez@nxp.com, aisheng.dong@nxp.com, Anson.Huang@nxp.com,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] mailbox: imx-mailbox: fix scu msg header size check
Message-ID: <20200414082635.jo5yljonh5xgnujd@pengutronix.de>
References: <1586851826-16596-1-git-send-email-peng.fan@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586851826-16596-1-git-send-email-peng.fan@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 04:10:26PM +0800, peng.fan@nxp.com wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> The i.MX8 SCU message header size is the number of "u32" elements,
> not "u8", so fix the check.
> 
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1461658 ("Memory - corruptions")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
> 
> V2:
>  I not include the fixes tag, since this patch still in next tree.
> 
>  drivers/mailbox/imx-mailbox.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
> index 7906624a731c..c2398cb63ea0 100644
> --- a/drivers/mailbox/imx-mailbox.c
> +++ b/drivers/mailbox/imx-mailbox.c
> @@ -154,12 +154,12 @@ static int imx_mu_scu_tx(struct imx_mu_priv *priv,
>  
>  	switch (cp->type) {
>  	case IMX_MU_TYPE_TX:
> -		if (msg->hdr.size > sizeof(*msg)) {
> +		if (msg->hdr.size > (sizeof(*msg) / 4)) {

No need for the parenthesis. Maybe a comment would be helpful here,
something like:

	/*
	 * msg->hdr.size specifies the number of u32 words while sizeof
	 * yields bytes.
	 */

>  			/*
>  			 * The real message size can be different to
>  			 * struct imx_sc_rpc_msg_max size
>  			 */
> -			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", sizeof(*msg), msg->hdr.size);
> +			dev_err(priv->dev, "Exceed max msg size (%zu) on TX, got: %i\n", sizeof(*msg) / 4, msg->hdr.size);

The unit here is also "number of u32 words", maybe bytes is more
natural? And I suggesting specifying the unit in the error message.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K�nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471142107C3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jul 2020 11:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgGAJLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jul 2020 05:11:09 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:43078 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726129AbgGAJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 05:11:07 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 2DCAE2A0D02
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_rpmsg: Document missing struct
 parameters
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org
References: <20200625170300.224906-1-enric.balletbo@collabora.com>
Message-ID: <59fcc7cf-99de-ba6d-1391-9f4f1fcba26f@collabora.com>
Date:   Wed, 1 Jul 2020 11:11:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625170300.224906-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gwendal,

Thank you for your review.

On 25/6/20 19:03, Enric Balletbo i Serra wrote:
> Kerneldoc expects all kernel structure member to be documented.
> 
> Fixes the following W=1 level warnings:
> 
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'ept' not described in 'cros_ec_rpmsg'
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'has_pending_host_event' not described in 'cros_ec_rpmsg'
>   cros_ec_rpmsg.c:49: warning: Function parameter or member 'probe_done' not described in 'cros_ec_rpmsg'
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied for 5.9

> ---
> 
>  drivers/platform/chrome/cros_ec_rpmsg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/platform/chrome/cros_ec_rpmsg.c b/drivers/platform/chrome/cros_ec_rpmsg.c
> index ff08c3d12873a..ad0a30afd7423 100644
> --- a/drivers/platform/chrome/cros_ec_rpmsg.c
> +++ b/drivers/platform/chrome/cros_ec_rpmsg.c
> @@ -38,6 +38,9 @@ struct cros_ec_rpmsg_response {
>   * @rpdev:	rpmsg device we are connected to
>   * @xfer_ack:	completion for host command transfer.
>   * @host_event_work:	Work struct for pending host event.
> + * @ept: The rpmsg endpoint of this channel.
> + * @has_pending_host_event: Boolean used to check if there is a pending event.
> + * @probe_done: Flag to indicate that probe is done.
>   */
>  struct cros_ec_rpmsg {
>  	struct rpmsg_device *rpdev;
> 

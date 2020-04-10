Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3F11A44FF
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 12:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgDJKIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 06:08:04 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47994 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgDJKIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 06:08:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id A98152A0160
Subject: Re: [PATCH v3 0/3] platform/chrome: typec: Add port partner
 registration
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@linux.intel.com,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <20200410002316.202107-1-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <85643207-bb30-55d4-1a10-d3c9a6266269@collabora.com>
Date:   Fri, 10 Apr 2020 12:08:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200410002316.202107-1-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

Thanks for your patches.

On 10/4/20 2:23, Prashant Malani wrote:
> The following series adds port-partner registration when
> connects/disconnects are detected. In order to do that, we also register
> a listener for the cros-usbpd-notifier, which will inform the driver of
> EC PD events. While we are here, separate out the Type C port data
> objects into a separate struct.
> 
> v2: https://lkml.org/lkml/2020/4/9/861
> v1: https://lkml.org/lkml/2020/4/6/1155
> 
> Changes in v3:
> - Fixed trivial Kconfig dependency ordering error.
> 
> Prashant Malani (3):
>   platform/chrome: typec: Use notifier for updates
>   platform/chrome: typec: Add struct for port data
>   platform/chrome: typec: Register port partner
> 
>  drivers/platform/chrome/Kconfig         |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 119 ++++++++++++++++++++----
>  2 files changed, 103 insertions(+), 17 deletions(-)
> 

Would be nice have the Heikki review on those.

Thanks,
 Enric

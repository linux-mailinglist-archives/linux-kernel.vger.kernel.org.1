Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB7C52E8B11
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 07:04:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbhACGEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 01:04:41 -0500
Received: from vps5.brixit.nl ([192.81.221.234]:55780 "EHLO vps5.brixit.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbhACGEl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 01:04:41 -0500
X-Greylist: delayed 588 seconds by postgrey-1.27 at vger.kernel.org; Sun, 03 Jan 2021 01:04:40 EST
Received: from [192.168.20.102] (unknown [77.239.252.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vps5.brixit.nl (Postfix) with ESMTPSA id A552A60811;
        Sun,  3 Jan 2021 05:54:09 +0000 (UTC)
Subject: Re: [PATCH 2/2] drm/panel: simple: add samsung,s6e3fa2 panel
To:     Iskren Chernev <iskren.chernev@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Samuel Pascua <pascua.samuel.14@gmail.com>
References: <20201230151711.3619846-1-iskren.chernev@gmail.com>
 <20201230151711.3619846-2-iskren.chernev@gmail.com>
From:   Alexey Minnekhanov <alexeymin@postmarketos.org>
Message-ID: <2873cf16-899a-27ab-c7cc-57e3e7aab11b@postmarketos.org>
Date:   Sun, 3 Jan 2021 08:54:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20201230151711.3619846-2-iskren.chernev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested this on Samsung Galaxy S5 along with other patches that enable 
GPU support on this device.

Tested-by: Alexey Minnekhanov <alexeymin@postmarketos.org>

On 12/30/20 6:17 PM, Iskren Chernev wrote:
> From: Samuel Pascua <pascua.samuel.14@gmail.com>
> 
> This panel is used on the Samsung Galaxy S5 (klte).
> 
> Signed-off-by: Samuel Pascua <pascua.samuel.14@gmail.com>
> ---
>   drivers/gpu/drm/panel/panel-simple.c | 30 ++++++++++++++++++++++++++++
>   1 file changed, 30 insertions(+)
> 


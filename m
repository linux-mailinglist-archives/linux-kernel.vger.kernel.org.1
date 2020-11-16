Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B622B42D1
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 12:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbgKPL20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 06:28:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34592 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgKPL20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 06:28:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1kecgK-0000QM-Ro; Mon, 16 Nov 2020 11:28:24 +0000
Subject: Re: [PATCH][next] drm/atomic: avoid null pointer dereference on
 pointer crtc
To:     Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20201116110316.269934-1-colin.king@canonical.com>
 <Gsgkd1PRlRQd3tlZ0nZROZwVfLvE7QmJdeOA8wkeVyE9ewGIj89RZAixoLltsvvgqB-Ica_sfpcNbwdtRCjDx16tYykgs61QOJRYm9Eumys=@emersion.fr>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <af3a63a2-573b-2f72-501a-0bbc7c6a9686@canonical.com>
Date:   Mon, 16 Nov 2020 11:28:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <Gsgkd1PRlRQd3tlZ0nZROZwVfLvE7QmJdeOA8wkeVyE9ewGIj89RZAixoLltsvvgqB-Ica_sfpcNbwdtRCjDx16tYykgs61QOJRYm9Eumys=@emersion.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2020 11:08, Simon Ser wrote:
> On Monday, November 16, 2020 12:03 PM, Colin King <colin.king@canonical.com> wrote:
> 
>> From: Colin Ian King colin.king@canonical.com
>>
>> Since moving to the new debug helper functions we now have a debug message
>> that dereferences crtc to print a kernel debug message when crtc is null
>> and so this debug message will now cause a null pointer dereference. Since
>> this is a debug message it probably is just simplest to fix this by just
>> removing the debug message altogether.
> 
> NACK. This removes the log altogether instead of fixing it.
> 
> A fix has already been pushed to drm-misc-next: 0003b687ee6d ("drm: fix
> oops in drm_atomic_set_crtc_for_connector").
> 
Good to see this has already been fixed. Thanks.

Colin


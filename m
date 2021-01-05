Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C052F2EB3EC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 21:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbhAEUI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 15:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbhAEUI2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 15:08:28 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6BFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 12:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qA9BU8HaFo0a9vJcnVVWjH72JR8Hikgs6SJAj6tITNk=; b=grDSenLtnhXnDoxe9CPaBsTTqa
        hyV0MQBUhmv7g5fEqBfms+SyjkTbTGAx3GaMtr7615NcF+E45GTtmJ5YT5aF9DqLdhkXAeKOHPxcH
        tkRf/WxQcV9cvnpqQgdSVKkfhAUuLwj8ysunioCeq1ou8YpkEczlTUoAxSoTSoNeP9EtLHQHubr4H
        mJKtBoN7eWZC9AgGgICLEUXlpSbM04cv2xhwz+riMGYdfCozcrh55N683yDf9ViOleHVZGhPXd92I
        NklGHlPMbKWixEKMlQlS8KulEXELa8UUjvoKDdpxBlvWc6zB3jxxa+OrjQ0A0ErrQBezg6jjCvM4T
        vpCFSV/g==;
Received: from [2601:1c0:6280:3f0::64ea]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwscJ-0003Ku-TR; Tue, 05 Jan 2021 20:07:44 +0000
Subject: Re: [PATCH] drm/agpsupport: Fix warning in functions documentation
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20210105123905.90330-1-benjamin.gaignard@collabora.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <24a3b8de-495c-2c85-c6fe-5a3be813e62b@infradead.org>
Date:   Tue, 5 Jan 2021 12:07:38 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20210105123905.90330-1-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/5/21 4:39 AM, Benjamin Gaignard wrote:
> Fix the warnings reported in functions documentation when compiling with W=1
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  drivers/gpu/drm/drm_agpsupport.c | 111 ++++++++++++++++---------------
>  1 file changed, 59 insertions(+), 52 deletions(-)
> 

LGTM. Thanks.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

-- 
~Randy

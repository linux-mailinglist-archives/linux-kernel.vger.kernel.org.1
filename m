Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 088992B3E2D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 08:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgKPH4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 02:56:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727812AbgKPH4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 02:56:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605513413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/vIAOmfvFNMPmf8CjkNMglbCHByAHwkTLNsLVL8lU0U=;
        b=QCTLVUZ+IOF+rH+1t9Z7s9rRiEg3/5p0PlpCX/7ynzA9voAPVSHpHWwYtoyzXD3GZHE/IJ
        i8QdVHLKSxNOU1uyEjJ1MSSW271/nPGaoPDEHouHhhXAve2cv+Yn0Ysd82CFaBgStZ1ieU
        LBDycZyRblYYVJxjAlw4/lAFSkB5C9E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-ilGDvEEHN3WJ_8GVhbQS1Q-1; Mon, 16 Nov 2020 02:56:48 -0500
X-MC-Unique: ilGDvEEHN3WJ_8GVhbQS1Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8A7945F9C0;
        Mon, 16 Nov 2020 07:56:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-65.ams2.redhat.com [10.36.112.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D1D035B4CC;
        Mon, 16 Nov 2020 07:56:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id C017916E31; Mon, 16 Nov 2020 08:56:44 +0100 (CET)
Date:   Mon, 16 Nov 2020 08:56:44 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Zou Wei <zou_wei@huawei.com>
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/virtio: Make virtgpu_dmabuf_ops with static
 keyword
Message-ID: <20201116075644.2kubdpmlowbevo3p@sirius.home.kraxel.org>
References: <1605338173-22100-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1605338173-22100-1-git-send-email-zou_wei@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 14, 2020 at 03:16:13PM +0800, Zou Wei wrote:
> Fix the following sparse warning:
> 
> ./virtgpu_prime.c:46:33: warning: symbol 'virtgpu_dmabuf_ops' was not declared. Should it be static?

Pushed to drm-misc-next.

thanks,
  Gerd


Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B31D2A9130
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 09:24:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgKFIYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 03:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47228 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725616AbgKFIYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 03:24:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604651087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=29qfegGrh7AruURuvpgC8HtdchFL+7zQsPXILi0X3v4=;
        b=YPH2/oAlqvoc5NHN/oy92a2TlYwJ2voYeGwHuI/0RJ2VFp7bVGhgChIWB/eVdwbCoyTlXM
        tPy+q0n6VyQkb5GSHLBJaPxveQfakZHOTnwWG8nYTLLoGMSNBNn0snVT4vGqLVbxm+aFWE
        KlhXc0xRG/6LuQ8SIxNlNu/BT4BSzWE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-ah-6QZFOO9-4DqOVgv1XMw-1; Fri, 06 Nov 2020 03:24:46 -0500
X-MC-Unique: ah-6QZFOO9-4DqOVgv1XMw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A301B1009E39;
        Fri,  6 Nov 2020 08:24:44 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-114-66.ams2.redhat.com [10.36.114.66])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 055505578B;
        Fri,  6 Nov 2020 08:24:42 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id D5F6A11AB5; Fri,  6 Nov 2020 09:24:41 +0100 (CET)
Date:   Fri, 6 Nov 2020 09:24:41 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Deepak R Varma <mh12gx2825@gmail.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/qxl: replace idr_init() by idr_init_base()
Message-ID: <20201106082441.x2e5mmycikwd22pj@sirius.home.kraxel.org>
References: <20201105185016.GA71797@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105185016.GA71797@localhost>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 06, 2020 at 12:20:16AM +0530, Deepak R Varma wrote:
> idr_init() uses base 0 which is an invalid identifier for this driver.
> The idr_alloc for this driver uses 1 as start value for ID range. The
> new function idr_init_base allows IDR to set the ID lookup from base 1.
> This avoids all lookups that otherwise starts from 0 since 0 is always
> unused / available.
> 
> References: commit 6ce711f27500 ("idr: Make 1-based IDRs more efficient")
> 
> Signed-off-by: Deepak R Varma <mh12gx2825@gmail.com>

Pushed to drm-misc-next.

thanks,
  Gerd


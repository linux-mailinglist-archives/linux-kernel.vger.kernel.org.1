Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77B727C14F
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgI2Jca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45786 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727864AbgI2Jca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:32:30 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601371949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LiEgRgilrtM/nzZfi6JlygGzcq6lLUMwcnD3ohkUPPc=;
        b=V0ul40K5vcOw4UxiG7CEjgVC5EMNXzfkqX2nkkkVeWg5BdnHsmzBMbDvUUlNT+cbQfIxVJ
        orRHJwgnYASv7APhPt/DKP4FC8l00M0ujGeWl//kDOd/ozYvlM3mL0vdkCNGRbzjpGYJ0Y
        Zv7VDFx9j9PdeUaErjHk+15OeqX46YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-lHto500SOc2Jx9pUas_Pvg-1; Tue, 29 Sep 2020 05:32:27 -0400
X-MC-Unique: lHto500SOc2Jx9pUas_Pvg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 019D9801AE3;
        Tue, 29 Sep 2020 09:32:26 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-56.ams2.redhat.com [10.36.112.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A253260BF1;
        Tue, 29 Sep 2020 09:32:25 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 9D0481750A; Tue, 29 Sep 2020 11:32:24 +0200 (CEST)
Date:   Tue, 29 Sep 2020 11:32:24 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Dave Airlie <airlied@redhat.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        virtualization@lists.linux-foundation.org,
        spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] drm/qxl: simplify the return expression of
 qxl_plane_prepare_fb()
Message-ID: <20200929093224.2x4x72i5pwmfe5aa@sirius.home.kraxel.org>
References: <20200921131022.91649-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200921131022.91649-1-miaoqinglang@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 21, 2020 at 09:10:22PM +0800, Qinglang Miao wrote:
> Simplify the return expression.

Pushed to drm-misc-next.

thanks,
  Gerd


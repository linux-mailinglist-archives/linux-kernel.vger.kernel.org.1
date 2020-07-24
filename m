Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5C5022C240
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jul 2020 11:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgGXJ2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jul 2020 05:28:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47421 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727951AbgGXJ2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:28:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595582926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QiAVsRp3Ef2fGhlvABn6vT7+u/FrQ38NAfFM57p6aBA=;
        b=izpWiBx2RG92/kIaQ20YTD4PJ5mfHXurxLNSGNHxp0IG7w9Wc4652nAE+xGF2rHwAykaXV
        b3AAJdSSkpz3AhSaIcX8vZ7oLi6uYdr1Q8rwdmAqN3BMBtQtsOxMnOb8WPr5gzUKbsCi9/
        tYLSAZP0Hz2EQyd4hkYeqROOLA1AeQ8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-452-5CHS9T3UM4uXAaqrqW46Dg-1; Fri, 24 Jul 2020 05:28:44 -0400
X-MC-Unique: 5CHS9T3UM4uXAaqrqW46Dg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9349080046B;
        Fri, 24 Jul 2020 09:28:41 +0000 (UTC)
Received: from gondolin (ovpn-112-188.ams2.redhat.com [10.36.112.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 589E51C4;
        Fri, 24 Jul 2020 09:28:35 +0000 (UTC)
Date:   Fri, 24 Jul 2020 11:28:32 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     alex.williamson@redhat.com, herbert@gondor.apana.org.au,
        nhorman@redhat.com, vdronov@redhat.com, bhelgaas@google.com,
        mark.a.chambers@intel.com, gordon.mcfadden@intel.com,
        ahsan.atta@intel.com, fiona.trahe@intel.com, qat-linux@intel.com,
        kvm@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] vfio/pci: Add device denylist
Message-ID: <20200724112832.395f076b.cohuck@redhat.com>
In-Reply-To: <20200724084800.6136-3-giovanni.cabiddu@intel.com>
References: <20200724084800.6136-1-giovanni.cabiddu@intel.com>
        <20200724084800.6136-3-giovanni.cabiddu@intel.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 09:47:57 +0100
Giovanni Cabiddu <giovanni.cabiddu@intel.com> wrote:

> Add denylist of devices that by default are not probed by vfio-pci.
> Devices in this list may be susceptible to untrusted application, even
> if the IOMMU is enabled. To be accessed via vfio-pci, the user has to
> explicitly disable the denylist.
> 
> The denylist can be disabled via the module parameter disable_denylist.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


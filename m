Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61223BC8B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Aug 2020 16:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728956AbgHDOqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Aug 2020 10:46:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25315 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgHDOql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:46:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596552399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R+FgxaorZ7uPYWq2DHZXXUp7MwR/+bLKotOJjd2wC8Q=;
        b=LDdtdrvDIUcOzf3l4V77gE17/pIgaDbgELJGPBtXD4LR1Cr5LAeCiCZIAVAn7mJaxyX2nN
        lAU8OXJ5T7vu1iqCTY0bkm5GtLMHqLBO3LVW+OGt7xfz+NYhD2j8fMI/xsS16yfPLvYc7V
        nj7O2kPGEMlIlsl0IFIpb4F6+VGrGUE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-189-BJPqgE1oOVSXx6ExzvxKig-1; Tue, 04 Aug 2020 10:46:34 -0400
X-MC-Unique: BJPqgE1oOVSXx6ExzvxKig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E7110CE796;
        Tue,  4 Aug 2020 14:46:33 +0000 (UTC)
Received: from gondolin (ovpn-112-169.ams2.redhat.com [10.36.112.169])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB1BA709E1;
        Tue,  4 Aug 2020 14:46:29 +0000 (UTC)
Date:   Tue, 4 Aug 2020 16:46:26 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v2 15/24] virtio_pmem: correct tags for config space
 fields
Message-ID: <20200804164626.7d166c2b.cohuck@redhat.com>
In-Reply-To: <20200803205814.540410-16-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
        <20200803205814.540410-16-mst@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 3 Aug 2020 16:59:41 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> Since this is a modern-only device,
> tag config space fields as having little endian-ness.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  include/uapi/linux/virtio_pmem.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>


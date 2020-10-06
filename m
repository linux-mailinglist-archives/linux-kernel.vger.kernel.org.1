Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C17BD284EE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgJFPZA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48748 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgJFPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601997899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f+g/7D43QuwHAkfXKPNpc0Kb6jrG+FbW0jRAxNnLbmU=;
        b=gh7YRBfrUCouwTU8TsAzTSROrAsjPQ6LATdUFWY7KqJm2PWqUr8G+qG6fhuPUqdJVgosz4
        5GsahgHWPH0cFIZqCq/NSSmCwNI4Vpx4NZtYQypAGPK6Nx9CxR+WBC1WWKP0h/tNz0o9IQ
        TL96K5tD1zYQLVIV9BnWyFv41OCvepY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-3Wv_BLmNOBKqFPwvBRyHpg-1; Tue, 06 Oct 2020 11:24:54 -0400
X-MC-Unique: 3Wv_BLmNOBKqFPwvBRyHpg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6B3104D3E0;
        Tue,  6 Oct 2020 15:24:52 +0000 (UTC)
Received: from gondolin (ovpn-112-156.ams2.redhat.com [10.36.112.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5E43F6115F;
        Tue,  6 Oct 2020 15:24:47 +0000 (UTC)
Date:   Tue, 6 Oct 2020 17:24:44 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Matthew Rosato <mjrosato@linux.ibm.com>
Cc:     alex.williamson@redhat.com, schnelle@linux.ibm.com,
        pmorel@linux.ibm.com, borntraeger@de.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] s390/pci: track whether util_str is valid in the
 zpci_dev
Message-ID: <20201006172444.1c07ee02.cohuck@redhat.com>
In-Reply-To: <1601668844-5798-3-git-send-email-mjrosato@linux.ibm.com>
References: <1601668844-5798-1-git-send-email-mjrosato@linux.ibm.com>
        <1601668844-5798-3-git-send-email-mjrosato@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  2 Oct 2020 16:00:41 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> We'll need to keep track of whether or not the byte string in util_str is
> valid and thus needs to be passed to a vfio-pci passthrough device.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/include/asm/pci.h | 3 ++-
>  arch/s390/pci/pci_clp.c     | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)

FWIW:

Acked-by: Cornelia Huck <cohuck@redhat.com>


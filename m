Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 797641BF4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 12:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgD3KIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 06:08:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20554 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgD3KID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:08:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588241282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4neCHXAikGnDrEWLfrOwLMssDcW49SbEXywLj9zmi5k=;
        b=AehAW+v5Lb9A714OFCyIktZSISlm+vfy9O/sMuri4G8EFymfPLvuI7EChzWA+YaFhfzf+2
        WjQJBBsR0/Ls/6viXOAGjGZuAY1tK/0OTtZiVlVCQpgoUJycUzU3hzGJnNrsTinv7eay4L
        X8DJAcSID+Qqs/Vm22KDp2WKqvGPr2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-M9aPJGHCNIOTi5RtydCAAg-1; Thu, 30 Apr 2020 06:08:01 -0400
X-MC-Unique: M9aPJGHCNIOTi5RtydCAAg-1
Received: by mail-wm1-f71.google.com with SMTP id u11so389426wmc.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 03:08:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4neCHXAikGnDrEWLfrOwLMssDcW49SbEXywLj9zmi5k=;
        b=VenQw8e+c5XY+2I6DCgO/VLA4rvHzbl0ZafOidTb3sPx4wH4LjSXPMHKuimP8c9k/s
         GSNieXDPG37ZkiiLR+wCHYW+dxymCUE5qu0pmrNmlKTHl6enOXEovrEFB4M36kaCQnBh
         okM+KMPtIyM7Z6BikyFSxFkFz5mtD2Nuhr4fKNRWiJPWwBj/d9uK3l680xVQf4F6dgG0
         WabPDtCEJxizLp2/z4SnjV1lbXZjZt+xTY2nlEk+X3cdWdcR5OT0t9cOmgZWq5AncjCI
         SzIdKD1L8avtuFariGrs+361duLXHp3zXMdGIzrMPJYY6HJId63dqZz+pzMeCuS+b+1v
         7DRQ==
X-Gm-Message-State: AGi0PuYVH/KQXxcvTMF1lNzlKrSxjjpNtu9ORN/m8Z/hXgssH4LkL88i
        E/C8tloeFHEPxEus/tp2GbNIShA74mvIi8FM1z1lCJb6s039ryYosecPsrIRCYKUOWyulmzPQyw
        r78LogMjLcGmAybgvegryVak0
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr2145465wmt.153.1588241280183;
        Thu, 30 Apr 2020 03:08:00 -0700 (PDT)
X-Google-Smtp-Source: APiQypLHlrCbfCYrZ88o6DhjV70fA6mpNnqgpx+WR9c06xN4peVmevPZw2FufGVhiRy6EDg6FWX7OQ==
X-Received: by 2002:a1c:2d0e:: with SMTP id t14mr2145451wmt.153.1588241279982;
        Thu, 30 Apr 2020 03:07:59 -0700 (PDT)
Received: from redhat.com (bzq-109-66-7-121.red.bezeqint.net. [109.66.7.121])
        by smtp.gmail.com with ESMTPSA id u30sm3470829wru.13.2020.04.30.03.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 03:07:59 -0700 (PDT)
Date:   Thu, 30 Apr 2020 06:07:56 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, will@kernel.org,
        stefano.stabellini@xilinx.com, iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 0/1] virtio_mmio: hypervisor specific interfaces for
 MMIO
Message-ID: <20200430060653-mutt-send-email-mst@kernel.org>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:32:55PM +0530, Srivatsa Vaddagiri wrote:
> The Type-1 hypervisor we are dealing with does not allow for MMIO transport. 

How about PCI then?

-- 
MST


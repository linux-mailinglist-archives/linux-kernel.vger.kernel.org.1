Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CA44260DA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Sep 2020 10:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730115AbgIHIfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Sep 2020 04:35:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:30114 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729778AbgIHIfh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:35:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599554136;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
        b=KYobp+izMjIsLYbetyGO8qyRENFEdEg4kk9uSq/1MtELgCj+boPgqz/TgJzDv51kOTqt/X
        6p20QeGLhZrKJ2AN8czM8Cprxm3dVsdpvU6aEdR4FgOT4yDCqNd0SpC4xFCcNMk8E32a0p
        UKqGxhlU3dFs60xRABAVMb80lChMzv8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-Y-SwH1G5MZ6FGfnsOgxzFA-1; Tue, 08 Sep 2020 04:35:34 -0400
X-MC-Unique: Y-SwH1G5MZ6FGfnsOgxzFA-1
Received: by mail-wr1-f72.google.com with SMTP id o6so6559568wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 01:35:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+MY+j0iaLoq2hQdX3yS+SdSeiGMuMtARblbd8qJTfIk=;
        b=TIjA+ASuDaFx9bKi40ONUVJJFvTFT9ovr/65qg6QZJqYViKHZEcw4QC2mNVsAOmBKI
         r/XLynkZG8UX/9eqbcH3NWFK8M0i7jgtY5FPXMqh9QmF62e5LsedCKw7DcNjxE4qrXm8
         HNV+oNpk+YMiLIn6636zWIrORKOgaLYWenan5gHuIDF++AvogwQUc613hlnQ4lMuAcrH
         q2dTruQJSjRSxB7+LcMIWCRwSJ5UsELNL/SVYGjuWbW+NU3WdZpY80u/40ejFTxoNxpq
         lCh2zCQs14jkC+bEqdo4noyTnUmJz1zS1KOAqdIHbXs4YsA479GWHr2dhYCMV7DAgJnO
         qeEg==
X-Gm-Message-State: AOAM53309QvPR9ylp4M7X1y5HmVTTkR1qSpKEQppBdC88yEkxaL+nbe1
        lYRgCgnoFH/k3ld8ycnVqMzcf5l+raC5thRVPWKjWJYka9PyK6HNxrmll4OYovwzKFyo75LuH5+
        Y1UPBlJ/aLGIpcAKkrs9B/VnA
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173537wmc.103.1599554133719;
        Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxI7qjqWRvqDDMKuSEyexs2ZtKt48S7kwb/PYSoSmDiwm5Mm57vBJ7GtHojpCcdWEA5RCWEdA==
X-Received: by 2002:a7b:c059:: with SMTP id u25mr3173527wmc.103.1599554133531;
        Tue, 08 Sep 2020 01:35:33 -0700 (PDT)
Received: from redhat.com ([147.161.15.98])
        by smtp.gmail.com with ESMTPSA id z203sm34774917wmc.31.2020.09.08.01.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 01:35:32 -0700 (PDT)
Date:   Tue, 8 Sep 2020 04:35:25 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-kernel@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, jasowang@redhat.com, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org,
        virtualization@lists.linux-foundation.org, thomas.lendacky@amd.com,
        david@gibson.dropbear.id.au, linuxram@us.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com
Subject: Re: [PATCH v11 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200908043503-mutt-send-email-mst@kernel.org>
References: <1599471547-28631-1-git-send-email-pmorel@linux.ibm.com>
 <20200908003951.233e47f3.pasic@linux.ibm.com>
 <20200908085521.4db22680.cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908085521.4db22680.cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 08, 2020 at 08:55:21AM +0200, Cornelia Huck wrote:
> On Tue, 8 Sep 2020 00:39:51 +0200
> Halil Pasic <pasic@linux.ibm.com> wrote:
> 
> > On Mon,  7 Sep 2020 11:39:05 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:
> > 
> > > Hi all,
> > > 
> > > The goal of the series is to give a chance to the architecture
> > > to validate VIRTIO device features.  
> > 
> > Michael, is this going in via your tree?
> > 
> 
> I believe Michael's tree is the right place for this, but I can also
> queue it if I get an ack on patch 1.

I think Halil pointed out some minor issues, so a new version is in
order.

-- 
MST


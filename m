Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BBF2C4990
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 22:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgKYVIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 16:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35550 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729981AbgKYVIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 16:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606338510;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=psNc8LzBcxw8kUam3kKQdVItytHGI1GRkmJuwrDi98U=;
        b=YLLaq3eiXVjVNwf01LpZZPP2rE7VpEO9sQACaCRRk/aBt+a/crb08JOv1HpoHWoyIkZlZc
        9ynKSYX88JdYpVw/W2acQ00RYRrB0Q65DzK79zrE3GlQsrHz3JRQ9lwSttMq3rKN3HcYiQ
        HpD2nbKV32QgaKeK+H1A2B+Xo99npL0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-437-prrUQzLKOIW5f4c6EILLSg-1; Wed, 25 Nov 2020 16:08:28 -0500
X-MC-Unique: prrUQzLKOIW5f4c6EILLSg-1
Received: by mail-wr1-f70.google.com with SMTP id h13so1222725wrr.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 13:08:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=psNc8LzBcxw8kUam3kKQdVItytHGI1GRkmJuwrDi98U=;
        b=l81zN5rFOFP8oMPCDS0ho0XmOJ77NzRQltMqU7XoNunGfMviYFoSlgiMAMYUxDexks
         oaBx2WKTqkzpHPar7922+6e6uMGV3xGdprEIHnuZz9eDTSB114i0ZPEOSFRA3upmNQb6
         4v6Fk1i3GQtebxXRTEpqaN9LgEuyEeYSl45XDtolrztGkIG6YalpN7cNmyBDPM++DMB6
         12/vF5aBnqAnEUPybNhzD0dM8Id1CKRa/j/IG+km8fEvpv8wH4EAA706DoH5Da4r9+fr
         VQ2tSQdPvsfvVHpPLvOikZDIFF3DAoJ1ynb+F2qiRYBWyGnHe+S2q7gYCKFGV7VsXxP+
         nHlw==
X-Gm-Message-State: AOAM530ZYp5gGxQ0yj9W9qTJZsxnEgjDpz80zc0ZZtLIC+QVs+lk1zi6
        nVbXPj2EfR1gv3GjTyQUzWZOk7X3Bj1OJ8m9PpRYBuJBb1BDU/50fAvyszIYmRnOEN0LBvQ1QSx
        JQCplBVlCg1i3zXxaxFRWk2nX
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr6081619wmm.8.1606338507767;
        Wed, 25 Nov 2020 13:08:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyJJV4yT5PMAKTeWWZqlzp3GeCHFDP+pqbxlJx5ZIsbRlvWhLEYqihrea4dY+OqIZkl+1a5Ew==
X-Received: by 2002:a05:600c:4153:: with SMTP id h19mr6081603wmm.8.1606338507561;
        Wed, 25 Nov 2020 13:08:27 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
        by smtp.gmail.com with ESMTPSA id h2sm6215789wrv.76.2020.11.25.13.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 13:08:26 -0800 (PST)
Date:   Wed, 25 Nov 2020 16:08:23 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tomas Winkler <tomas.winkler@intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Usyskin <alexander.usyskin@intel.com>,
        linux-kernel@vger.kernel.org, Wang Yu <yu1.wang@intel.com>,
        Liu Shuo <shuo.a.liu@intel.com>,
        virtio-dev@lists.oasis-open.org
Subject: Re: [char-misc-next 13/13] mei: virtio: virtualization frontend
 driver
Message-ID: <20201125160326-mutt-send-email-mst@kernel.org>
References: <20200818115147.2567012-1-tomas.winkler@intel.com>
 <20200818115147.2567012-14-tomas.winkler@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818115147.2567012-14-tomas.winkler@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 02:51:47PM +0300, Tomas Winkler wrote:
> +#ifndef VIRTIO_ID_MEI
> +#define VIRTIO_ID_MEI 0xFFFE /* virtio mei */
> +#endif

Just noticed now that this driver landed upstream.  Can I ask that you
guys please register IDs with the virtio TC and not just pick a number
at random? In particular this is way outside allowed range.

IDs should also be listed in include/uapi/linux/virtio_ids.h

If people just pick random numbers like this collistions are unavoidable.

List of IDs is part of virtio spec, chapter "Device Types".

Please do this change now before this goes out to production!

Thanks!

-- 
MST


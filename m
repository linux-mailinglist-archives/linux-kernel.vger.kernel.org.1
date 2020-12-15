Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47C802DB551
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Dec 2020 21:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbgLOUlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Dec 2020 15:41:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28458 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726129AbgLOUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Dec 2020 15:41:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608064805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Rfof1yBngjXTM8IWJLEFvkYpkqv5EiGTTEd+6Z7T+IU=;
        b=PYmdR8irXHcUzuLgz0KgKBAFAkTc54AXvDBq+lXNcWBRvg+CQCfDQ3A7ySawNMvv4dlsVT
        oF1vZfQvvg7pdPWBzgL1voPEAMUdGy2rYBFTN8cWVDMARtDfhyo6gXGfNbFyoYhprcYkDq
        vP2YUwbxMhY3RqpLmraMaBFgKhZjuIE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-iSQoOMypMl6YaYqiBz-Ykw-1; Tue, 15 Dec 2020 15:40:02 -0500
X-MC-Unique: iSQoOMypMl6YaYqiBz-Ykw-1
Received: by mail-qv1-f70.google.com with SMTP id bp20so6572745qvb.20
        for <linux-kernel@vger.kernel.org>; Tue, 15 Dec 2020 12:40:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rfof1yBngjXTM8IWJLEFvkYpkqv5EiGTTEd+6Z7T+IU=;
        b=jEpw5a/ZkhmiyyLU7FQ92yqDNK24edIgJ/AT0nYLw9wbr1PgJWdel+NsrlBCWbUHNT
         5/s4g5drb84oAbLee4/TIcNqTkkluGY4ONAENseSyGkZgHx5QIp+l/S3N6yjA/DTT7JK
         I+v2dpzALLx9xO5nL7pvVH/PG4YqhAokerzr33+GNmN7ErFyJNzIF7Bn2upsbFD6AtFD
         q4DpC2SgX9YhLhidj5I+asHT8kTmA81qIF4NAw9e9O17bJzLvJ/we8oCA7wpiTD5W9xJ
         J2cXnCybakKYmUoUIwDdfPNZ4EL4myb5/XT9sqDekvbnfgAPSoWVDDyQ4dSBhfZ3dbnw
         rqgg==
X-Gm-Message-State: AOAM531N/yRh3VKtatD7O5MEDSY1tmdLjeUlSzwEr1xU7CgSFC17+2Be
        /SoOQSHWEaNiD+URszl0+Vs2aViY08fNnoStOUVkmcF0Z7MNHZqCgRh5QfQfPqmIMP6gStBt3DW
        1RlLVuE/g+bBML/Artp/O0KbXCn74OYFCmseukBpCTGiXPrxrVJy44/H+OrjJUleWcPvDPIISUA
        ==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr38431250qkb.115.1608064801760;
        Tue, 15 Dec 2020 12:40:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy3S0auNn53tYpzoFwWavgdVduLCuEtAJb6gHU73w8ANl8gRG0ZINVF7OoEDyI1ZgvOYMIgEA==
X-Received: by 2002:a37:58c1:: with SMTP id m184mr38431216qkb.115.1608064801431;
        Tue, 15 Dec 2020 12:40:01 -0800 (PST)
Received: from xz-x1 ([142.126.83.202])
        by smtp.gmail.com with ESMTPSA id h16sm17922420qko.135.2020.12.15.12.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 12:40:00 -0800 (PST)
Date:   Tue, 15 Dec 2020 15:39:59 -0500
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/3] mm: Some rework on zap_details
Message-ID: <20201215203959.GA6519@xz-x1>
References: <20201208025022.8234-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201208025022.8234-1-peterx@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:50:19PM -0500, Peter Xu wrote:
> Posted this small series out to rework zap_details a bit, before adding
> something new in.  Hopefully it makes things slighly clearer.
> 
> Smoke test only.  Please have a look, thanks.
> 
> Peter Xu (3):
>   mm: Drop first_index/last_index in zap_details
>   mm: Introduce zap_details.zap_flags
>   mm: Introduce ZAP_FLAG_SKIP_SWAP

Some more information on "before adding something new in" - the new flag as a
reference but not yet posted anywhere...

https://github.com/xzpeter/linux/commit/102790511a1a25b7be841fb2059a8c8d8f1a87b2

I still think this small series worths to be reviewed/merged even before that
new flag, because patch 1 should definitely be something good to have, patch 2
prepares for patch 3 and the new bit (which can be seen as optional), but patch
3 should help make things clearer rather than using non-null "details" pointer
to show "whether we should skip swap entries", which can be easily misused IMHO
when someone accidentally replaced one "details==NULL" with some valid pointer.

Of course I can repost these series with the larger one when time comes too,
but I'd still like to at least get a NO early if there is...

Thanks,

-- 
Peter Xu


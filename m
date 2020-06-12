Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEA61F7DA6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 21:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgFLTd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 15:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgFLTd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 15:33:29 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A257C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:33:29 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j32so7986764qte.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 12:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ilDpfLP00UQ/R2Qf9P0wZzkKtgSCxD5QrqZdUMpKWYs=;
        b=VkvjODgqREAtawgDZeQ7ZsFwjPhZbKTzE41/I2eqftpq3JrrVwIJnCV9Ij9Z9dEbWv
         wZngzt8TgRLvNgmGoEursjurAb4GIey9Qli78XcfmSbv4An3zgYWOAE7gU+kVWpsNdfB
         3TLWhxtly/QipREUrKW7WpRPc5FSdbLrEfCKScTQUFGYM3BTSfsKha91Stq9nVqle70A
         Jpi/iaIVWzjqmHHk16CryrsMxa0OQg330KDohiM9Sru85yOL+lb1c9Q4nYcqZCUDSpJ2
         SB+6t4p6BnFEZ3tFke9b22zLdzKbUfRmnImiuxfrLS328RETUS4AJ18dwwkycqz1tPoa
         RveA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ilDpfLP00UQ/R2Qf9P0wZzkKtgSCxD5QrqZdUMpKWYs=;
        b=kpIqIqykHId92oprv0ao8VGKj2trip9Dds5ou28ws6A5xPIaUGZ0KRBJCE9Kog3LWP
         Wga5zwcv7KRWiB5oF11cB7otq+jNm/y4h5+wxEMS1hMv6XfIEsOT4pvSGdgiRpMvyLZD
         /Sj0jxVAxAe00Z0nYmCNE0YObSiEEvQC2PkYW2lWMp0TlUxTc0BKgNPe1zjFA2apAm8Y
         AzecFw790HhrCVr3r+zoQwsUo5Gc6lRVH7hIghNjnbrIgck5xeTBii7xsKjmzNeOZxt9
         B6HqZH2fOwGKZZoKNIiATla98rhqnrj6241PVjqVeyy4wpukB/zJA7LVRQIQMh8xSHZM
         16kQ==
X-Gm-Message-State: AOAM5332GLfwOsxmI3Pjxv60wtHLg/XzR8Z8KQD9xNEVCHl5ySLExNcu
        EQ8uVm/YTK5BGrrq4MmBAAP2aF0gBGc=
X-Google-Smtp-Source: ABdhPJwMPxIjibTfvRe4j2ZYdS9q7vrAFVO+GODVRtFzo2l2ZrQQbsPBX7fWPrzGPBv99zpT3+EDfQ==
X-Received: by 2002:ac8:2bba:: with SMTP id m55mr4587204qtm.171.1591990408530;
        Fri, 12 Jun 2020 12:33:28 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w94sm5260212qte.19.2020.06.12.12.33.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 12:33:27 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.93)
        (envelope-from <jgg@ziepe.ca>)
        id 1jjpQd-006lke-CN; Fri, 12 Jun 2020 16:33:27 -0300
Date:   Fri, 12 Jun 2020 16:33:27 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Ralph Campbell <rcampbell@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm/hmm: remove redundant check non_swap_entry()
Message-ID: <20200612193327.GZ6578@ziepe.ca>
References: <20200612192618.32579-1-rcampbell@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612192618.32579-1-rcampbell@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 12:26:18PM -0700, Ralph Campbell wrote:
> In zap_pte_range(), the check for non_swap_entry() and
> is_device_private_entry() is redundant since the latter is a subset of the
> former. Remove the redundant check to simplify the code and for clarity.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> 
> This is based on the current linux tree and is intended for Andrew's mm
> tree. There is no rush so it could go into 5.9 but I think it is safe
> enough to go into an rc after the patch is reviewed.

Probably shouldn't mark it as mm/hmm if Andrew is going to pick it

Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>

Jason

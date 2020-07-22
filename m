Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAFE22A26E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jul 2020 00:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732919AbgGVWf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 18:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726447AbgGVWfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 18:35:55 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6729CC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:35:55 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id h7so3637164qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 15:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IhNGI/vefCUNAfGzfX3ewpvDJYe2LrOiMX29xiUrGJc=;
        b=N01ONQS/4zclZekgvot0Yp1ETViAnVH1jD+D1f2UEb841mhu10XyFyBgULkoGBFSHZ
         LN1gp3SJ8ttov0OjYNfUBozyGunzD1hz5/Eiu1hrr22q1IJZcE0dSqjo2uA5iQJAsg6j
         +t8c7OxqTvWJ4vHlqQlF8KD6faKA7k6fAJIAgf7ZL8TBSIdBC6Uf4zXlImi71Afc+HjQ
         lkEG+KzmKKraAH0yabmUx3cS8ZXe3kuWOp30VBMmVBX4/pdZab7IwSk9b7njnA/+EuYS
         vMjwduanWcLYb70DmRABhyhK+vG1AAONKc5ZGFkEMyoi2AjD8XexcMmCjZQk/oDRbPEq
         zh+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IhNGI/vefCUNAfGzfX3ewpvDJYe2LrOiMX29xiUrGJc=;
        b=flRPG0UWziVBwjxTOBcNhzHcr+TEMiEh6mLM4qlpygvIZJTZbCG0U3OfIw0nagnyEN
         5Izxsjq5JfW3NY/01XFLtTCAdj4nfQtSNDE4NFcOyqiM9t6sWQNE+lRnWS1m+jd+zoCL
         pAZ7+jZOg/Z63XS61Ef622dzB/YZ1SDwaP2l5es7QzPwRRiRG/VZf8Utv8tSmFBQqHBz
         EuGwF4hAG2SYAv2m01bOhWo1RUcBEoyx3/NP710O/3L2LBmbQaFnhK6RmH7vSB54KpIf
         TghDm+9J7xenYBJaNOi1QmoNzublPvRB5Ll7dPDcIqlzEP9/nD8sJP0y2bHd0v1WGBBk
         t7ig==
X-Gm-Message-State: AOAM530KBnvzlFlBnls4vPYXcKIvRbyJSXX+O524bImlhTVWtrWIcVTa
        Zntlaq/A9twsbMD2OlIC0DQOqA==
X-Google-Smtp-Source: ABdhPJymY0pjFiYFmtBSynjwEf1B841wDAKehivuxXUJzUqRKu7Abm8XcMEBA3UVvqqMrxDbZSS14g==
X-Received: by 2002:a37:8283:: with SMTP id e125mr2255480qkd.175.1595457354602;
        Wed, 22 Jul 2020 15:35:54 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id w28sm982143qkw.92.2020.07.22.15.35.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 15:35:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1jyNL7-00E6VI-3d; Wed, 22 Jul 2020 19:35:53 -0300
Date:   Wed, 22 Jul 2020 19:35:53 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alexander Lobakin <alobakin@marvell.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Igor Russkikh <irusskikh@marvell.com>,
        Michal Kalderon <michal.kalderon@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        Denis Bolotin <denis.bolotin@marvell.com>,
        Doug Ledford <dledford@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        KP Singh <kpsingh@chromium.org>,
        GR-everest-linux-l2@marvell.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 00/15] qed, qede: improve chain API and add
 XDP_REDIRECT support
Message-ID: <20200722223553.GL25301@ziepe.ca>
References: <20200722221045.5436-1-alobakin@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200722221045.5436-1-alobakin@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 01:10:30AM +0300, Alexander Lobakin wrote:
> Netdev folks, could you please take the entire series through your tree
> after the necessary acks and reviews? Patches 8-9 also touch qedr driver
> under rdma tree, but these changes can't be separated as it would break
> incremental buildability and bisecting.

There is nothing significant in the rdma changes, just be wary to not
submit patches to the rdma tree that would cause conflicts

Thanks
Jason

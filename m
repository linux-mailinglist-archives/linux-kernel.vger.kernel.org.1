Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9801E4280
	for <lists+linux-kernel@lfdr.de>; Wed, 27 May 2020 14:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730141AbgE0Mip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 May 2020 08:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbgE0Mio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:38:44 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 531D4C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:38:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f5so2876576wmh.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 05:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7YJa5saMRdpmvcQWiah99cBIMoG1Tkr+u26njxMEKnA=;
        b=k/tiHg8auqdYOndajzxN9gTWTghLMBY1djKWtYEk3Xs2loSyC6tNGpBNzsi1V1e5Q0
         sXy0IbM/e69LS16IJmi8Ef8kB/l2kNim+cB6791xU3ax7Eiy31LOofzXlMGIwi2jktfo
         2RxazoKHTEtqEyOaqbjd/lW1f4FMzrKfhxl+I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7YJa5saMRdpmvcQWiah99cBIMoG1Tkr+u26njxMEKnA=;
        b=fpCJX2b8cywOWxaPvQlIUuj7ZNqdMeLKAviCf60Fr+p6X4Mpq70Y9GmmoIPHABapkh
         gyHzXIyxrIXQYBAVlAsEYXzpB1axK/y2lxFedKbwJjJN1an+K0hYOHzIERHI6l1kSy7r
         WDyUUxKBogv78ByI+cyFwWAzcmv6cCTO5Y43CgVakV3Scq6bD90MpkkKR+TMwOrzGOEn
         sT4UG2KPCsl1ErZ8NyQBPzo7JAwYX8CwlnV6AfuA7NcPoiYCYTt2PfvYwK6f6MIU4E/p
         BHMH38VFLsYGEen+xnJoEbz3Vu4P7Ovpjxi4Vua7J/vwQfElLLidD9Z4M0K+uUydrCRu
         57/g==
X-Gm-Message-State: AOAM532vaFZ5VqmI+Q+Y0wzklIipYomCYqa9MtLYRA1SnnAJVsBXYeuq
        GqXi+hnvNcfQl8dMGNOgCkAJNw==
X-Google-Smtp-Source: ABdhPJyZus2cqz3FbuHL3S4pu8h2PwjCMQgsrova7d9Wd6xAkdssWBPq4mBOJe+ZXxfozuXgSPeeYg==
X-Received: by 2002:a05:600c:2c4e:: with SMTP id r14mr4358980wmg.118.1590583122956;
        Wed, 27 May 2020 05:38:42 -0700 (PDT)
Received: from google.com ([81.6.44.51])
        by smtp.gmail.com with ESMTPSA id h74sm2831566wrh.76.2020.05.27.05.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 05:38:42 -0700 (PDT)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Wed, 27 May 2020 14:38:40 +0200
To:     Christoph Hellwig <hch@infradead.org>
Cc:     KP Singh <kpsingh@chromium.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        James Morris <jmorris@namei.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Martin KaFai Lau <kafai@fb.com>,
        Florent Revest <revest@chromium.org>
Subject: Re: [PATCH bpf-next 2/4] bpf: Implement bpf_local_storage for inodes
Message-ID: <20200527123840.GA12958@google.com>
References: <20200526163336.63653-1-kpsingh@chromium.org>
 <20200526163336.63653-3-kpsingh@chromium.org>
 <20200527050823.GA31860@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527050823.GA31860@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-May 22:08, Christoph Hellwig wrote:
> On Tue, May 26, 2020 at 06:33:34PM +0200, KP Singh wrote:
> > From: KP Singh <kpsingh@google.com>
> > 
> > Similar to bpf_local_storage for sockets, add local storage for inodes.
> > The life-cycle of storage is managed with the life-cycle of the inode.
> > i.e. the storage is destroyed along with the owning inode.
> > 
> > Since, the intention is to use this in LSM programs, the destruction is
> > done after security_inode_free in __destroy_inode.
> 
> NAK onbloating the inode structure.  Please find an out of line way
> to store your information.

The other alternative is to use lbs_inode (security blobs) and we can
do this without adding fields to struct inode.

Here is a rough diff (only illustrative, won't apply cleanly) of the
changes needed to this patch:

 https://gist.github.com/sinkap/1d213d17fb82a5e8ffdc3f320ec37d79

Once tracing has gets a whitelist based access to inode storage, I
guess it, too, can use bpf_local_storage for inodes if CONFIG_BPF_LSM
is enabled. Does this sound reasonable to the BPF folks?

- KP



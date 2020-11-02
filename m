Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6152A312D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 18:16:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgKBRQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 12:16:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727388AbgKBRQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 12:16:41 -0500
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8EC061A47
        for <linux-kernel@vger.kernel.org>; Mon,  2 Nov 2020 09:16:41 -0800 (PST)
Received: by mail-qk1-x744.google.com with SMTP id k9so12129311qki.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Nov 2020 09:16:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nOooqOL2HAfCzA3WbZS617x/HCXK3f8ujSR4To+U+xs=;
        b=OzpU9SvL4LQMiSZU+/wC8SOY7Kd5nwVlGSTQjG9d88TeMJ4WpFyipjmaUdp1TxOYVn
         7vidwyiSRCZj33RSLCqu0pXEDxMU/dAAoukKMfQfZuIAjtLdwwP4N2zY3W8B92Z6AwFE
         OTED+BMjliDXrbRWrDsPovc1pCXjBe20TOvquBC1aoMM7tLd9pJLJZOtf/olLrbdulv4
         wmYRU9+3HhHbwX4F5ELPi2SPcx5nfQMbB/P20GVamTcL6w1vdCvhRKxx/L/E22ILoMnS
         rmp9SSiTbFRAYQDj9HHFQ8bEOTeAHdVsxV9Tfe2mGZkEyeAYsnLrRuqy6EC2kl3h/BMa
         5ZGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nOooqOL2HAfCzA3WbZS617x/HCXK3f8ujSR4To+U+xs=;
        b=BhtvTS1Ni/w0yOcnAiNLtvCBbIGevCTB4Fcsu3g69bEcCr/PWzP8/8xNtXMXgnpPB/
         DSqULGBwVr9uCrcD4FSW7U6fD1sEwf6mnC3GLs5lnR3YRddhagof+oo5Uoq7vtSF4jdG
         JlE33F/5uoqb3O3Sw1mSHkX2lAoWSTT+k+R3i7DPWChES6un7QCry5P3Yx1b9De0k/hl
         su7M2XCR5MqJm6VJ60Kkkmpw9bEgOPXmcO96Vf+0qykt1Lz9bHmfdpdKYIjYpHi7HrWH
         ePvdbnNF01EpYVGk7HFC7yZLH9UDxQW4b6x1jkcQQxMB7N65kOGE3/hD2Rbn6S9er/kQ
         9LKg==
X-Gm-Message-State: AOAM532Po0OrA66DJ9+g7PkCfm5KXJaCUwUZVYxrXxa1CqWDYM+MlA3O
        8Dca6EDd+ER1fIvfxAdymV4yIA==
X-Google-Smtp-Source: ABdhPJzKAXEdRCm0W3ToJIDRDSewKlEjp6I2L8WD4tRBCiFlVxj0ALakWiSn3a8Exau8avpdo4ShfA==
X-Received: by 2002:a37:f503:: with SMTP id l3mr6457698qkk.160.1604337400730;
        Mon, 02 Nov 2020 09:16:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id c76sm8677260qkb.20.2020.11.02.09.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 09:16:40 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kZdRf-00FI9F-Az; Mon, 02 Nov 2020 13:16:39 -0400
Date:   Mon, 2 Nov 2020 13:16:39 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Christoph Hellwig <hch@infradead.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        J??r??me Glisse <jglisse@redhat.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v5 08/15] mm: Add unsafe_follow_pfn
Message-ID: <20201102171639.GH36674@ziepe.ca>
References: <20201030100815.2269-1-daniel.vetter@ffwll.ch>
 <20201030100815.2269-9-daniel.vetter@ffwll.ch>
 <20201102072931.GA16419@infradead.org>
 <CAKMK7uEe5FQuukYU7RhL90ttC9XyWw6wvdQrZ2JpP0jpbYTO6g@mail.gmail.com>
 <20201102130115.GC36674@ziepe.ca>
 <CAKMK7uHeL=w7GoBaY4XrbRcpJabR9UWnP+oQ9Fg51OzL7=KxiA@mail.gmail.com>
 <20201102155256.GG36674@ziepe.ca>
 <CAKMK7uFqkieBAXEmoeoBfnJBXcuHaNwrsaVyPsLQaXnrJo=scg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uFqkieBAXEmoeoBfnJBXcuHaNwrsaVyPsLQaXnrJo=scg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 02, 2020 at 05:42:20PM +0100, Daniel Vetter wrote:
> > Need to hold the lock to check that and there are two ways to register
> > notifiers these days, so it feels to expensive to me.
> 
> Uh I mixed stuff up all along, struct mmu_notifier *subcription that
> all the mmu notifier users use has the ->mm pointer we want right
> there. That's good enough I think.

Yah, if you can pass in one of those instead of the raw mm it would be
fine

Jason

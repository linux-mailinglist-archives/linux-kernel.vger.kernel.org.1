Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C71727E85C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 14:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgI3MUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 08:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3MUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 08:20:17 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBA4C061755
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:20:16 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 16so1113755qkf.4
        for <linux-kernel@vger.kernel.org>; Wed, 30 Sep 2020 05:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=a/ihWnKV+oV5XAtuuw5DACc3ncxXKguwA9r9mRzB0hc=;
        b=iHHnjk1VOSBJQ3iFruljNrZ+Wpeifr4x3pYrbU6YTfkITTkzAOPUmL0zBAdNDco0gs
         we7QqaU8lyo4ZSJvcqco4CEhvKaaBhPWurYSHiGAjJE0PNzSuJQXDQdNwt0zbWZwY/c7
         7PR7ZBOPQduYF++bFnMoht+ADdKnBCMLvcU5pm9/9gLM1NG70jPc9My2cpXKB9Ho35He
         GV/kuMJtlI04kj3P8M09bI1uxV94D2xeh20XwTMAOn2Cyh8NFLkGn5qYkZgsbc0Dlpqb
         IUP2gakEhglI1oIWR6jWymCtocoXuh9IXxJtYHYY6+zdbPSeaPT9uWqpHdjsvwqWgOoU
         A2GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a/ihWnKV+oV5XAtuuw5DACc3ncxXKguwA9r9mRzB0hc=;
        b=CQv4RnRo0KBu8fWsAnP5s5v7HEtjdF5pDz5wcLdZeQxuVCRTEcP63rPzS/tnfN08K9
         sRFX6bDDZmGk4VbnK6mggl+323ydaW9eEMdpiqWAHTUiNEaI9kEEHQ5l2iZd4gweUWd2
         YvI1rCnhXFMph59a7ZiLd9PHloMzlcWR9H3janeLtULPQi8BmWLxO8bATxRr72eLYC6E
         /FauXa3UmAVbx5xVEln62Qd7OjNlNFIrRsq7k5TpJRubZao7shz9saQ8nFY8veTKMG/b
         AlUkPuDewu7RzySc1pAWSQGQpd7uEypOzg70xY5XPyC1p3Wb+Xu5v0W9F5JuvzNJ865C
         FNOg==
X-Gm-Message-State: AOAM530A5fnoxS3erjqTS6Pxlp8wZKeIMcxsx6ucKqfcnyDTFg/T7iVp
        3z7QGjSMBvPVPTjXNppY7ieHswgvdDYQM3Zr
X-Google-Smtp-Source: ABdhPJwTRKRuWNsiDoXCyh1dXAKtzwNc6iFUgkI2e5VPtC4P/rXfuilDJCA6ONGo/slpu0AhW297gw==
X-Received: by 2002:a37:658b:: with SMTP id z133mr2033278qkb.221.1601468416016;
        Wed, 30 Sep 2020 05:20:16 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id h199sm1858005qke.112.2020.09.30.05.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2020 05:20:15 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kNb5i-003vuI-Ng; Wed, 30 Sep 2020 09:20:14 -0300
Date:   Wed, 30 Sep 2020 09:20:14 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jann Horn <jannh@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Michel Lespinasse <walken@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH 1/4] mm/gup_benchmark: Take the mmap lock around GUP
Message-ID: <20200930122014.GB9916@ziepe.ca>
References: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3SG6ngZLtasxJ6LABpOnqCz5-QHqb0B4k44TQ8F9n6+w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 29, 2020 at 06:19:59PM -0700, Jann Horn wrote:
> To be safe against concurrent changes to the VMA tree, we must take the
> mmap lock around GUP operations (excluding the GUP-fast family of
> operations, which will take the mmap lock by themselves if necessary).
> 
> This code is only for testing, and it's only reachable by root through
> debugfs, so this doesn't really have any impact; however, if we want to add
> lockdep asserts into the GUP path, we need to have clean locking here.
> 
> Signed-off-by: Jann Horn <jannh@google.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
